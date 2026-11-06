package qnactr.GUI;

import java.awt.BasicStroke;
import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Window;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.Arc2D;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Path2D;
import java.awt.geom.RoundRectangle2D;
import java.util.ArrayList;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Comparator;
import java.util.Deque;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;
import javax.swing.Timer;
import javax.swing.ToolTipManager;

import qnactr.objectDesigner.Chunk;
import qnactr.objectDesigner.Audio_Module;
import qnactr.objectDesigner.Aural_Buffer;
import qnactr.objectDesigner.Aural_Location_Buffer;
import qnactr.objectDesigner.Declarative_Module;
import qnactr.objectDesigner.Imaginal_Buffer;
import qnactr.objectDesigner.Imaginary_Module;
import qnactr.objectDesigner.Manual_Buffer;
import qnactr.objectDesigner.Motor_Module;
import qnactr.objectDesigner.Retrieval_Buffer;
import qnactr.objectDesigner.Speech_Module;
import qnactr.objectDesigner.Temporal_Buffer;
import qnactr.objectDesigner.Visual_Buffer;
import qnactr.objectDesigner.Visual_Location_Buffer;
import qnactr.objectDesigner.Vision_Module;
import qnactr.objectDesigner.Vocal_Buffer;

/** Swing rendering of the 700 x 800 ACT-R diagram. */
public class ActrLiveDiagram extends JPanel {
  private static final int DESIGN_WIDTH = 985;
  private static final int HEAD_OFFSET = 84;
  private static final int DESIGN_HEIGHT = 900 + HEAD_OFFSET;
  private static final long TRAIL_LIFETIME_NANOS = 5_000_000_000L;
  private static final long WORD_INTERVAL_NANOS = 220_000_000L;
  private static final int EYE_RADIUS = 70;
  private static final double MIN_PUPIL_RADIUS = 5.0;
  private static final double MAX_PUPIL_RADIUS = 20.0;
  private static final Color BACKGROUND = new Color(0xEDEDED);
  private static final Color MODULE = new Color(0xD9D9D9);
  private static final Color OUTLINE = Color.BLACK;
  private static final Color MATCH_OUTLINE = Color.RED;
  private static final Font LABEL_FONT = new Font(Font.SANS_SERIF, Font.PLAIN, 9);
  private static final Font TITLE_FONT = new Font(Font.SANS_SERIF, Font.PLAIN, 12);
  private static final Font DETAIL_FONT = new Font(Font.MONOSPACED, Font.PLAIN, 8);
  private static final Font BUFFER_FONT = new Font(Font.MONOSPACED, Font.PLAIN, 10);
  private static final Font BILLBOARD_FONT = new Font(Font.MONOSPACED, Font.BOLD, 11);
  private static final Font COUNTER_FONT = new Font(Font.MONOSPACED, Font.BOLD, 12);
  private static final Font THOUGHT_FONT = new Font(Font.SANS_SERIF, Font.BOLD, 15);
  private static final Color BILLBOARD_BACKGROUND = new Color(0xF5F5F5);
  private static final Area THOUGHT_CLOUD = createThoughtCloud();
  private final LiveBufferDisplay imaginal = new LiveBufferDisplay("IMAGINAL", "FREE");
  private final LiveBufferDisplay retrieval = new LiveBufferDisplay("RETRIEVAL", "FREE");
  private final LiveBufferDisplay goal1 = new LiveBufferDisplay("GOAL-1", null);
  private final LiveBufferDisplay goal2 = new LiveBufferDisplay("GOAL-2", null);
  private final LiveBufferDisplay temporal = new LiveBufferDisplay("TEMPORAL", null);
  private final LiveBufferDisplay auralLocation = new LiveBufferDisplay("AURAL-LOCATION", "FREE");
  private final LiveBufferDisplay aural = new LiveBufferDisplay("AURAL", "FREE");
  private final LiveBufferDisplay visual = new LiveBufferDisplay("VISUAL", "FREE");
  private final LiveBufferDisplay visualLocation = new LiveBufferDisplay("VISUAL-LOCATION", "FREE");
  private final OutputDisplay vocal = new OutputDisplay("VOCAL");
  private final OutputDisplay manual = new OutputDisplay("MANUAL");
  private final AtomicReference<GoalPairSnapshot> pendingGoals = new AtomicReference<GoalPairSnapshot>();
  private final AtomicBoolean goalUpdateQueued = new AtomicBoolean();
  private final AtomicReference<AudioPairSnapshot> pendingAudio = new AtomicReference<AudioPairSnapshot>();
  private final AtomicBoolean audioUpdateQueued = new AtomicBoolean();
  private final AtomicReference<VisualPairSnapshot> pendingVisual = new AtomicReference<VisualPairSnapshot>();
  private final AtomicBoolean visualUpdateQueued = new AtomicBoolean();
  private final AtomicReference<ProceduralSnapshot> pendingProcedural = new AtomicReference<ProceduralSnapshot>();
  private final AtomicBoolean proceduralUpdateQueued = new AtomicBoolean();
  private ProceduralSnapshot procedural = new ProceduralSnapshot("IDLE", Collections.emptyList(),
      Collections.emptyList(), Collections.emptyList(), "");
  private JDialog proceduralDetails;
  private JTextArea proceduralDetailsText;
  private int goalShade1;
  private int goalShade2;
  private final Deque<ThoughtWord> visibleThoughts = new ArrayDeque<>();
  private final Deque<ThoughtWord> pendingThoughts = new ArrayDeque<>();
  private final Deque<ThoughtWord> visibleSpeech = new ArrayDeque<>();
  private final Deque<ThoughtWord> pendingSpeech = new ArrayDeque<>();
  private final Deque<ThoughtWord> visibleHearing = new ArrayDeque<>();
  private final Deque<ThoughtWord> pendingHearing = new ArrayDeque<>();
  private final Timer thoughtTimer = new Timer(50, event -> advanceThoughts());
  private long nextThoughtNanos;
  private long nextSpeechNanos;
  private long nextHearingNanos;
  private boolean vocalSpeaking;
  private boolean audioEncoding;
  private long lastHeardNanos;
  private String lastHeardChunkName = "";
  private String lastLocationChunkName = "";
  private ThoughtWord lastAuralLocation;
  private final Deque<GazePoint> gazeTrail = new ArrayDeque<>();
  private double gazeX;
  private double gazeY;
  private double pupilRadius = MIN_PUPIL_RADIUS;
  private double targetPupilRadius = MIN_PUPIL_RADIUS;
  private final Deque<HandPhase> pendingHandPhases = new ArrayDeque<>();
  private HandPhase handPhase = HandPhase.IDLE;
  private double handExtension;
  private double handOpenness;
  private double handPress;
  private long handFinishNanos;
  private long handPhaseSinceNanos;

  public ActrLiveDiagram() {
    setBackground(Color.WHITE);
    setPreferredSize(new Dimension(DESIGN_WIDTH, DESIGN_HEIGHT));
    ToolTipManager.sharedInstance().registerComponent(this);
    addMouseListener(new MouseAdapter() {
      @Override
      public void mouseClicked(MouseEvent event) {
        switch (hitBuffer(event)) {
          case 1: imaginal.showDetails(); break;
          case 2: retrieval.showDetails(); break;
          case 3: goal1.showDetails(); break;
          case 4: goal2.showDetails(); break;
          case 5: temporal.showDetails(); break;
          case 6: auralLocation.showDetails(); break;
          case 7: aural.showDetails(); break;
          case 8: visualLocation.showDetails(); break;
          case 9: visual.showDetails(); break;
          case 10: vocal.showDetails(); break;
          case 11: manual.showDetails(); break;
          case 12: showProceduralDetails(); break;
          default: break;
        }
      }
    });
  }

  @Override
  public String getToolTipText(MouseEvent event) {
    int buffer = hitBuffer(event);
    if (buffer == 5) return "Click for the full temporal buffer";
    if (buffer == 10 || buffer == 11) {
      return "P=preparation, R=processor, E=execution; F=free, B=busy. Click for command details";
    }
    if (buffer == 12) return "Redder means higher base utility; red buffer outlines mark selected-rule LHS tests. Click for details";
    return buffer == 0 ? null : "Click for all buffer slots";
  }

  private int hitBuffer(MouseEvent event) {
    double scale = Math.min((double) getWidth() / DESIGN_WIDTH,
                            (double) getHeight() / DESIGN_HEIGHT);
    if (scale <= 0) return 0;
    double x = (event.getX() - (getWidth() - DESIGN_WIDTH * scale) / 2.0) / scale;
    double y = (event.getY() - (getHeight() - DESIGN_HEIGHT * scale) / 2.0) / scale - HEAD_OFFSET;
    if (y >= 40 && y <= 210) {
      if (x >= 60 && x <= 220) return 1;
      if (x >= 480 && x <= 640) return 2;
      if (x >= 250 && x <= 450) {
        if (y <= 110) return 3;
        if (y >= 120 && y <= 190) return 4;
      }
    }
    if (x >= 580 && x <= 670 && y >= 221 && y <= 285) return 5;
    if (y >= 295 && y <= 460) {
      if (x >= 0 && x <= 90) return 6;
      if (x >= 610 && x <= 700) return 7;
    }
    if (y >= 240 && y <= 330) {
      if (x >= 180 && x <= 270) return 8;
      if (x >= 430 && x <= 520) return 9;
    }
    if (x >= 235 && x <= 465 && y >= 590 && y <= 660) return 10;
    if (x >= 286 && x <= 516 && y >= 723 && y <= 793) return 11;
    if (x >= 150 && x <= 550 && y >= 375 && y <= 545) return 12;
    return 0;
  }

  /** Immutable utility values are captured by the simulation before this EDT update. */
  public void updateProcedural(String stage, List<ProceduralCandidate> candidates,
                               List<ProceduralCandidate> selected, List<String> executing,
                               String lastExecuted) {
    pendingProcedural.set(new ProceduralSnapshot(stage, candidates, selected, executing, lastExecuted));
    queueProceduralUpdate();
  }

  private void queueProceduralUpdate() {
    if (!proceduralUpdateQueued.compareAndSet(false, true)) return;
    SwingUtilities.invokeLater(() -> {
      ProceduralSnapshot latest = pendingProcedural.getAndSet(null);
      if (latest != null) {
        procedural = latest;
        if (proceduralDetailsText != null && proceduralDetails != null && proceduralDetails.isDisplayable()) {
          proceduralDetailsText.setText(latest.fullText());
        }
        repaint();
      }
      proceduralUpdateQueued.set(false);
      if (pendingProcedural.get() != null) queueProceduralUpdate();
    });
  }

  private void showProceduralDetails() {
    if (proceduralDetails == null || !proceduralDetails.isDisplayable()) {
      Window owner = SwingUtilities.getWindowAncestor(this);
      proceduralDetails = new JDialog(owner, "Procedural details", JDialog.ModalityType.MODELESS);
      proceduralDetailsText = new JTextArea(20, 60);
      proceduralDetailsText.setEditable(false);
      proceduralDetailsText.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
      proceduralDetails.add(new JScrollPane(proceduralDetailsText));
      proceduralDetails.pack();
      proceduralDetails.setLocationRelativeTo(this);
    }
    proceduralDetailsText.setText(procedural.fullText());
    proceduralDetails.setVisible(true);
  }

  public static final class ProceduralCandidate {
    public final String name;
    public final String goalReference;
    public final double baseUtility;
    public final double finalUtility;
    public final List<String> lhsBuffers;

    public ProceduralCandidate(String name, String goalReference, double baseUtility,
                               double finalUtility, List<String> lhsBuffers) {
      this.name = name;
      this.goalReference = goalReference;
      this.baseUtility = baseUtility;
      this.finalUtility = finalUtility;
      this.lhsBuffers = Collections.unmodifiableList(new ArrayList<String>(lhsBuffers));
    }

    String label() {
      return goalReference.isEmpty() ? name : name + " [" + goalReference + "]";
    }
  }

  private static final class ProceduralSnapshot {
    final String stage;
    final List<ProceduralCandidate> candidates;
    final List<ProceduralCandidate> selected;
    final List<String> executing;
    final String lastExecuted;

    ProceduralSnapshot(String stage, List<ProceduralCandidate> candidates,
                       List<ProceduralCandidate> selected, List<String> executing, String lastExecuted) {
      this.stage = stage;
      this.candidates = Collections.unmodifiableList(new ArrayList<ProceduralCandidate>(candidates));
      this.selected = Collections.unmodifiableList(new ArrayList<ProceduralCandidate>(selected));
      this.executing = Collections.unmodifiableList(new ArrayList<String>(executing));
      this.lastExecuted = lastExecuted;
    }

    String fullText() {
      StringBuilder text = new StringBuilder("Stage: ").append(stage).append('\n');
      text.append("Matched rules (base utility; final selection score):\n");
      if (candidates.isEmpty()) text.append("  None\n");
      for (ProceduralCandidate candidate : candidates) {
        text.append("  ").append(candidate.label()).append("  base=")
            .append(utilityText(candidate.baseUtility)).append("  final=")
            .append(utilityText(candidate.finalUtility)).append('\n');
      }
      text.append("Selected:\n");
      if (selected.isEmpty()) text.append("  None\n");
      for (ProceduralCandidate candidate : selected) {
        text.append("  ").append(candidate.label()).append("  final=")
            .append(utilityText(candidate.finalUtility)).append("  LHS buffers=")
            .append(candidate.lhsBuffers.isEmpty() ? "none" : String.join(", ", candidate.lhsBuffers))
            .append('\n');
      }
      text.append("Executing: ").append(executing.isEmpty() ? "None" : String.join(", ", executing)).append('\n');
      text.append("Last executed: ").append(lastExecuted.isEmpty() ? "None" : lastExecuted).append('\n');
      return text.toString();
    }

    boolean usesBuffer(String bufferName) {
      for (ProceduralCandidate candidate : selected) {
        if (candidate.lhsBuffers.contains(bufferName)) return true;
      }
      return false;
    }
  }

  private static String utilityText(double value) {
    return Double.isFinite(value) ? Double.toString(value) : "?";
  }

  /** Capture the mutable simulation objects on the simulation thread, then publish on the EDT. */
  public void updateImaginal(Imaginal_Buffer buffer, Imaginary_Module module, boolean cleared) {
    imaginal.update(
        module.State_Error ? "ERROR" : module.State_Free ? "FREE" : "BUSY",
        buffer.Empty, cleared, buffer.Imaginal_Buffer_Chunk);
  }

  public void updateRetrieval(Retrieval_Buffer buffer, Declarative_Module module, boolean cleared) {
    retrieval.update(
        module.State_Error ? "ERROR" : module.State_Free ? "FREE" : "BUSY",
        buffer.Empty, cleared, buffer.Retrieval_Buffer_Chunk);
  }

  public void updateTemporal(Temporal_Buffer buffer, boolean cleared) {
    temporal.update(null, buffer.Empty, cleared, buffer.Temporal_Buffer_Chunk);
  }

  /** Keep the two audio buffers and their shared module state in one event-time snapshot. */
  public void updateAudio(Aural_Buffer buffer, Aural_Location_Buffer location,
                          Audio_Module module, boolean auralCleared, boolean locationCleared) {
    String state = module.State_Error ? "ERROR" : !module.State_Preparation_Free ? "PREP BUSY"
        : module.State_Free ? "FREE" : "BUSY";
    Chunk auralChunk = buffer.Aural_Buffer_Chunk;
    BufferSnapshot heard = BufferSnapshot.capture(state, goalEmpty(auralChunk), auralCleared, auralChunk);
    BufferSnapshot located = BufferSnapshot.capture(state, location.Empty, locationCleared,
                                                    location.Aural_Location_Buffer_Chunk);
    pendingAudio.set(new AudioPairSnapshot(heard, located));
    if (!heard.empty) SwingUtilities.invokeLater(() -> enqueueHeard(heard));
    if (!located.empty) SwingUtilities.invokeLater(() -> registerLocation(located));
    queueAudioUpdate();
  }

  private void registerLocation(BufferSnapshot located) {
    if (located.name.equals(lastLocationChunkName)) return;
    lastLocationChunkName = located.name;
    String value = located.slotValues.get("location");
    if (value == null || value.isEmpty() || "nil".equalsIgnoreCase(value)) return;
    lastAuralLocation = new ThoughtWord(value.replace('"', ' ').trim(), System.nanoTime());
    if (!thoughtTimer.isRunning()) thoughtTimer.start();
    repaint();
  }

  private void enqueueHeard(BufferSnapshot heard) {
    if ("internal".equalsIgnoreCase(heard.slotValues.get("location"))) return;
    if (heard.name.equals(lastHeardChunkName)) return;
    lastHeardChunkName = heard.name;
    lastHeardNanos = System.nanoTime();
    String content = heard.slotValues.get("content");
    if (content == null || content.isEmpty() || "nil".equalsIgnoreCase(content)) {
      content = heard.slotValues.get("value");
    }
    String kind = heard.slotValues.get("kind");
    if ("tone".equals(kind)) {
      content = content == null || content.isEmpty() ? "tone" : "tone " + content + " Hz";
    } else if (content == null || content.isEmpty()) {
      content = kind == null || kind.isEmpty() ? heard.type : kind;
    }
    enqueueWords(content, pendingHearing, 2);
  }

  public void resetAudioTrails() {
    SwingUtilities.invokeLater(() -> {
      visibleHearing.clear();
      pendingHearing.clear();
      lastHeardChunkName = "";
      lastLocationChunkName = "";
      lastAuralLocation = null;
      nextHearingNanos = 0L;
      lastHeardNanos = 0L;
      audioEncoding = false;
      repaint();
    });
  }

  private void queueAudioUpdate() {
    if (!audioUpdateQueued.compareAndSet(false, true)) return;
    SwingUtilities.invokeLater(() -> {
      AudioPairSnapshot latest = pendingAudio.getAndSet(null);
      if (latest != null) {
        aural.apply(latest.aural);
        auralLocation.apply(latest.location);
        audioEncoding = "BUSY".equals(latest.aural.state);
        if (audioEncoding && !thoughtTimer.isRunning()) thoughtTimer.start();
        repaint();
      }
      audioUpdateQueued.set(false);
      if (pendingAudio.get() != null) queueAudioUpdate();
    });
  }

  private static final class AudioPairSnapshot {
    final BufferSnapshot aural;
    final BufferSnapshot location;

    AudioPairSnapshot(BufferSnapshot aural, BufferSnapshot location) {
      this.aural = aural;
      this.location = location;
    }
  }

  /** Capture the two visual buffers together; location has its own status and request origin. */
  public void updateVisual(Visual_Buffer buffer, Visual_Location_Buffer location,
                           Vision_Module module, boolean visualCleared, boolean locationCleared) {
    String visualState = module.State_Error ? "ERROR" : !module.State_Preparation_Free ? "PREP BUSY"
        : module.State_Free ? "FREE" : "BUSY";
    String locationState = location.State_Error ? "ERROR" : location.State_Free ? "FREE" : "BUSY";
    String origin = location.State_Error && location.Empty ? "FIND FAILED"
        : location.Empty ? null : location.Requested ? "REQUESTED"
        : location.Unrequested ? "STUFFED" : "UNKNOWN";
    Chunk visualChunk = buffer.Visual_Buffer_Chunk;
    pendingVisual.set(new VisualPairSnapshot(
        BufferSnapshot.capture(visualState, goalEmpty(visualChunk), visualCleared, visualChunk),
        BufferSnapshot.capture(locationState, location.Empty, locationCleared,
                               location.Visual_Location_Buffer_Chunk, origin)));
    queueVisualUpdate();
  }

  public void updateGaze(String screenX, String screenY, int screenWidth, int screenHeight) {
    if (screenX == null || screenY == null || screenWidth <= 0 || screenHeight <= 0) return;
    try {
      double x = Double.parseDouble(screenX);
      double y = Double.parseDouble(screenY);
      if (!Double.isFinite(x) || !Double.isFinite(y)) return;
      double mirroredX = clamp(1.0 - 2.0 * x / screenWidth);
      double normalizedY = clamp(2.0 * y / screenHeight - 1.0);
      SwingUtilities.invokeLater(() -> moveGaze(mirroredX, normalizedY));
    } catch (NumberFormatException ignored) {
      // World-space attention targets have no screen coordinates to draw.
    }
  }

  public void resetGaze() {
    SwingUtilities.invokeLater(() -> {
      gazeTrail.clear();
      gazeX = 0.0;
      gazeY = 0.0;
      pupilRadius = MIN_PUPIL_RADIUS;
      targetPupilRadius = MIN_PUPIL_RADIUS;
      repaint();
    });
  }

  public void updateOverallUtilization(double utilization) {
    if (!Double.isFinite(utilization)) return;
    double normalized = Math.max(0.0, Math.min(1.0, utilization));
    SwingUtilities.invokeLater(() -> {
      targetPupilRadius = MIN_PUPIL_RADIUS
          + normalized * (MAX_PUPIL_RADIUS - MIN_PUPIL_RADIUS);
      if (!thoughtTimer.isRunning()) thoughtTimer.start();
    });
  }

  private void moveGaze(double x, double y) {
    if (x == gazeX && y == gazeY) return;
    gazeTrail.addLast(new GazePoint(gazeX, gazeY, System.nanoTime()));
    gazeX = x;
    gazeY = y;
    if (!thoughtTimer.isRunning()) thoughtTimer.start();
    repaint();
  }

  private static double clamp(double value) {
    return Math.max(-1.0, Math.min(1.0, value));
  }

  private static final class GazePoint {
    final double x;
    final double y;
    final long timeNanos;

    GazePoint(double x, double y, long timeNanos) {
      this.x = x;
      this.y = y;
      this.timeNanos = timeNanos;
    }
  }

  private void queueVisualUpdate() {
    if (!visualUpdateQueued.compareAndSet(false, true)) return;
    SwingUtilities.invokeLater(() -> {
      VisualPairSnapshot latest = pendingVisual.getAndSet(null);
      if (latest != null) {
        visual.apply(latest.visual);
        visualLocation.apply(latest.location);
        repaint();
      }
      visualUpdateQueued.set(false);
      if (pendingVisual.get() != null) queueVisualUpdate();
    });
  }

  private static final class VisualPairSnapshot {
    final BufferSnapshot visual;
    final BufferSnapshot location;

    VisualPairSnapshot(BufferSnapshot visual, BufferSnapshot location) {
      this.visual = visual;
      this.location = location;
    }
  }

  public void updateVocal(String stage, Chunk command, Vocal_Buffer buffer, Speech_Module module) {
    vocal.update(OutputSnapshot.capture(stage, command, buffer.Vocal_Buffer_Chunk,
        module.State_Free, module.Preparation_Free, module.Processor_Free, module.Execution_Free));
    boolean speaking = "EXECUTION".equals(stage) && command != null
        && "speak".equals(command.Chunk_Type);
    SwingUtilities.invokeLater(() -> {
      vocalSpeaking = speaking;
      if (speaking && !thoughtTimer.isRunning()) thoughtTimer.start();
      repaint();
    });
    if ("QUEUED".equals(stage) && command != null) {
      String phrase = command.Slot.get("string");
      if (phrase != null && "subvocalize".equals(command.Chunk_Type)) {
        SwingUtilities.invokeLater(() -> enqueueWords(phrase, pendingThoughts, 0));
      } else if (phrase != null && "speak".equals(command.Chunk_Type)) {
        SwingUtilities.invokeLater(() -> enqueueWords(phrase, pendingSpeech, 1));
      }
    }
  }

  private void enqueueWords(String phrase, Deque<ThoughtWord> pending, int channel) {
    String normalized = phrase.replace('"', ' ').trim();
    if (normalized.isEmpty()) return;
    long now = System.nanoTime();
    long next = Math.max(now, channel == 0 ? nextThoughtNanos
        : channel == 1 ? nextSpeechNanos : nextHearingNanos);
    for (String word : normalized.split("[\\s-]+")) {
      if (word.isEmpty()) continue;
      pending.addLast(new ThoughtWord(word, next));
      next += WORD_INTERVAL_NANOS;
    }
    if (channel == 0) nextThoughtNanos = next;
    else if (channel == 1) nextSpeechNanos = next;
    else nextHearingNanos = next;
    if (!thoughtTimer.isRunning()) thoughtTimer.start();
    advanceThoughts();
  }

  private void advanceThoughts() {
    long now = System.nanoTime();
    pupilRadius = Math.abs(pupilRadius - targetPupilRadius) < 0.02
        ? targetPupilRadius : pupilRadius + (targetPupilRadius - pupilRadius) * 0.28;
    advanceWords(pendingThoughts, visibleThoughts, now);
    advanceWords(pendingSpeech, visibleSpeech, now);
    advanceWords(pendingHearing, visibleHearing, now);
    advanceHands(now);
    while (!gazeTrail.isEmpty()
        && now - gazeTrail.peekFirst().timeNanos >= TRAIL_LIFETIME_NANOS) {
      gazeTrail.removeFirst();
    }
    if (lastAuralLocation != null
        && now - lastAuralLocation.timeNanos >= TRAIL_LIFETIME_NANOS) lastAuralLocation = null;
    if (visibleThoughts.isEmpty() && pendingThoughts.isEmpty()
        && visibleSpeech.isEmpty() && pendingSpeech.isEmpty()
        && visibleHearing.isEmpty() && pendingHearing.isEmpty()
        && !vocalSpeaking
        && !audioEncoding
        && lastAuralLocation == null && gazeTrail.isEmpty()
        && pendingHandPhases.isEmpty() && handPhase != HandPhase.EXECUTION
        && handPhase != HandPhase.FINISH && handsAtTarget()
        && pupilRadius == targetPupilRadius) thoughtTimer.stop();
    repaint();
  }

  private void advanceHands(long now) {
    boolean showPress = handPhase == HandPhase.EXECUTION
        && now - handPhaseSinceNanos < 100_000_000L;
    if (!pendingHandPhases.isEmpty() && !showPress) {
      handPhase = pendingHandPhases.removeFirst();
      handPhaseSinceNanos = now;
      if (handPhase == HandPhase.FINISH) handFinishNanos = now;
      if (handPhase == HandPhase.EXECUTION) {
        handExtension = targetExtension();
        handOpenness = targetOpenness();
        handPress = 1.0;
      }
    } else if (handPhase == HandPhase.FINISH && now - handFinishNanos >= 300_000_000L) {
      handPhase = HandPhase.IDLE;
    }
    handExtension = approach(handExtension, targetExtension());
    handOpenness = approach(handOpenness, targetOpenness());
    handPress = approach(handPress, handPhase == HandPhase.EXECUTION ? 1.0 : 0.0);
  }

  private double targetExtension() {
    switch (handPhase) {
      case INITIATION: return 100;
      case EXECUTION: return 170;
      default: return 0;
    }
  }

  private double targetOpenness() {
    switch (handPhase) {
      case PREPARATION:
      case INITIATION: return 1;
      case EXECUTION: return 0.35;
      case FINISH: return 0.15;
      default: return 0;
    }
  }

  private boolean handsAtTarget() {
    return Math.abs(handExtension - targetExtension()) < 0.05
        && Math.abs(handOpenness - targetOpenness()) < 0.01
        && Math.abs(handPress - (handPhase == HandPhase.EXECUTION ? 1.0 : 0.0)) < 0.01;
  }

  private static double approach(double current, double target) {
    return Math.abs(current - target) < 0.01 ? target : current + (target - current) * 0.42;
  }

  private static void advanceWords(Deque<ThoughtWord> pending, Deque<ThoughtWord> visible, long now) {
    while (!pending.isEmpty() && pending.peekFirst().timeNanos <= now) {
      visible.addLast(pending.removeFirst());
    }
    while (!visible.isEmpty()
        && now - visible.peekFirst().timeNanos >= TRAIL_LIFETIME_NANOS) {
      visible.removeFirst();
    }
  }

  private static final class ThoughtWord {
    final String text;
    final long timeNanos;

    ThoughtWord(String text, long timeNanos) {
      this.text = text;
      this.timeNanos = timeNanos;
    }
  }

  public void updateManual(String stage, Chunk command, Manual_Buffer buffer, Motor_Module module) {
    manual.update(OutputSnapshot.capture(stage, command, buffer.Manual_Buffer_Chunk,
        module.State_Free, module.Preparation_Free, module.Processor_Free, module.Execution_Free));
    HandPhase phase = HandPhase.fromStage(stage);
    if (phase != null) SwingUtilities.invokeLater(() -> enqueueHandPhase(phase));
  }

  private void enqueueHandPhase(HandPhase phase) {
    if (phase == HandPhase.IDLE) {
      pendingHandPhases.clear();
      handPhase = phase;
      handExtension = 0;
      handOpenness = 0;
      handPress = 0;
      repaint();
      return;
    }
    if (pendingHandPhases.size() >= 12) pendingHandPhases.removeFirst();
    pendingHandPhases.addLast(phase);
    if (!thoughtTimer.isRunning()) thoughtTimer.start();
  }

  private enum HandPhase {
    IDLE, PREPARATION, INITIATION, EXECUTION, FINISH;

    static HandPhase fromStage(String stage) {
      if (stage == null) return null;
      switch (stage) {
        case "IDLE": return IDLE;
        case "PREPARATION": return PREPARATION;
        case "INITIATION": return INITIATION;
        case "EXECUTION": return EXECUTION;
        case "COMPLETED": return FINISH;
        default: return null;
      }
    }
  }

  /** Capture both goal buffers and their recency shading as one event-time snapshot. */
  public void updateGoals(Chunk chunk1, Chunk chunk2, boolean cleared1, boolean cleared2,
                          int shade1, int shade2) {
    pendingGoals.set(new GoalPairSnapshot(
        BufferSnapshot.capture(null, goalEmpty(chunk1), cleared1, chunk1),
        BufferSnapshot.capture(null, goalEmpty(chunk2), cleared2, chunk2), shade1, shade2));
    queueGoalUpdate();
  }

  private static boolean goalEmpty(Chunk chunk) {
    return chunk == null || (chunk.Chunk_Name.isEmpty() && chunk.Chunk_Type.isEmpty());
  }

  private void queueGoalUpdate() {
    if (!goalUpdateQueued.compareAndSet(false, true)) return;
    SwingUtilities.invokeLater(() -> {
      GoalPairSnapshot latest = pendingGoals.getAndSet(null);
      if (latest != null) {
        goal1.apply(latest.goal1);
        goal2.apply(latest.goal2);
        goalShade1 = latest.shade1;
        goalShade2 = latest.shade2;
        repaint();
      }
      goalUpdateQueued.set(false);
      if (pendingGoals.get() != null) queueGoalUpdate();
    });
  }

  private static final class GoalPairSnapshot {
    final BufferSnapshot goal1;
    final BufferSnapshot goal2;
    final int shade1;
    final int shade2;

    GoalPairSnapshot(BufferSnapshot goal1, BufferSnapshot goal2, int shade1, int shade2) {
      this.goal1 = goal1;
      this.goal2 = goal2;
      this.shade1 = shade1;
      this.shade2 = shade2;
    }
  }

  private final class LiveBufferDisplay {
    final String label;
    BufferSnapshot snapshot;
    final AtomicReference<BufferSnapshot> pending = new AtomicReference<BufferSnapshot>();
    final AtomicBoolean updateQueued = new AtomicBoolean();
    JDialog details;
    JTextArea detailsText;

    LiveBufferDisplay(String label, String initialState) {
      this.label = label;
      snapshot = new BufferSnapshot(initialState, true, false, "", "", Collections.emptyMap());
    }

    void update(String state, boolean empty, boolean cleared, Chunk chunk) {
      pending.set(BufferSnapshot.capture(state, empty, cleared, chunk));
      queueUpdate();
    }

    void apply(BufferSnapshot latest) {
      snapshot = latest;
      if (detailsText != null && details != null && details.isDisplayable()) {
        detailsText.setText(latest.fullText());
      }
    }

    void queueUpdate() {
      if (!updateQueued.compareAndSet(false, true)) return;
      SwingUtilities.invokeLater(() -> {
        BufferSnapshot latest = pending.getAndSet(null);
        if (latest != null) {
          apply(latest);
          repaint();
        }
        updateQueued.set(false);
        if (pending.get() != null) queueUpdate();
      });
    }

    void showDetails() {
      if (details == null || !details.isDisplayable()) {
        Window owner = SwingUtilities.getWindowAncestor(ActrLiveDiagram.this);
        details = new JDialog(owner, label + " details", JDialog.ModalityType.MODELESS);
        detailsText = new JTextArea(18, 48);
        detailsText.setEditable(false);
        detailsText.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
        detailsText.setLineWrap(true);
        detailsText.setWrapStyleWord(true);
        details.add(new JScrollPane(detailsText));
        details.pack();
        details.setLocationRelativeTo(ActrLiveDiagram.this);
      }
      detailsText.setText(snapshot.fullText());
      details.setVisible(true);
    }
  }

  private final class OutputDisplay {
    final String label;
    OutputSnapshot snapshot = OutputSnapshot.capture("IDLE", null, null, true, true, true, true);
    final AtomicReference<OutputSnapshot> pending = new AtomicReference<OutputSnapshot>();
    final AtomicBoolean updateQueued = new AtomicBoolean();
    JDialog details;
    JTextArea detailsText;

    OutputDisplay(String label) {
      this.label = label;
    }

    void update(OutputSnapshot latest) {
      pending.set(latest);
      queueUpdate();
    }

    void queueUpdate() {
      if (!updateQueued.compareAndSet(false, true)) return;
      SwingUtilities.invokeLater(() -> {
        OutputSnapshot latest = pending.getAndSet(null);
        if (latest != null) {
          snapshot = latest;
          if (detailsText != null && details != null && details.isDisplayable()) {
            detailsText.setText(latest.fullText());
          }
          repaint();
        }
        updateQueued.set(false);
        if (pending.get() != null) queueUpdate();
      });
    }

    void showDetails() {
      if (details == null || !details.isDisplayable()) {
        Window owner = SwingUtilities.getWindowAncestor(ActrLiveDiagram.this);
        details = new JDialog(owner, label + " details", JDialog.ModalityType.MODELESS);
        detailsText = new JTextArea(18, 48);
        detailsText.setEditable(false);
        detailsText.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
        detailsText.setLineWrap(true);
        detailsText.setWrapStyleWord(true);
        details.add(new JScrollPane(detailsText));
        details.pack();
        details.setLocationRelativeTo(ActrLiveDiagram.this);
      }
      detailsText.setText(snapshot.fullText());
      details.setVisible(true);
    }
  }

  private static final class OutputSnapshot {
    final String stage;
    final boolean stateFree;
    final boolean preparationFree;
    final boolean processorFree;
    final boolean executionFree;
    final BufferSnapshot command;
    final BufferSnapshot buffer;

    static OutputSnapshot capture(String stage, Chunk command, Chunk buffer, boolean stateFree,
                                  boolean preparationFree, boolean processorFree, boolean executionFree) {
      return new OutputSnapshot(stage, stateFree, preparationFree, processorFree, executionFree,
          BufferSnapshot.capture(null, goalEmpty(command), false, command),
          BufferSnapshot.capture(null, goalEmpty(buffer), false, buffer));
    }

    OutputSnapshot(String stage, boolean stateFree, boolean preparationFree, boolean processorFree,
                   boolean executionFree, BufferSnapshot command, BufferSnapshot buffer) {
      this.stage = stage;
      this.stateFree = stateFree;
      this.preparationFree = preparationFree;
      this.processorFree = processorFree;
      this.executionFree = executionFree;
      this.command = command;
      this.buffer = buffer;
    }

    String preview() {
      for (String key : new String[] {"string", "key", "name", "target", "screen-pos", "hand", "finger"}) {
        String value = command.slotValues.get(key);
        if (value != null) return key + ": " + value;
      }
      return command.slots.isEmpty() ? "" : command.slots.get(0);
    }

    String fullText() {
      StringBuilder text = new StringBuilder();
      text.append("Stage: ").append(stage).append('\n');
      text.append("Module: ").append(stateFree ? "FREE" : "BUSY").append('\n');
      text.append("Preparation: ").append(preparationFree ? "FREE" : "BUSY").append('\n');
      text.append("Processor: ").append(processorFree ? "FREE" : "BUSY").append('\n');
      text.append("Execution: ").append(executionFree ? "FREE" : "BUSY").append('\n');
      text.append("Buffer: ").append(buffer.empty ? "EMPTY (request-only)" : "OCCUPIED").append('\n');
      if (!buffer.empty) {
        text.append("Buffer chunk: ").append(buffer.name).append(" (" ).append(buffer.type).append(")\n");
        for (String slot : buffer.slots) text.append(slot).append('\n');
      }
      if (!command.empty) {
        text.append("Command: ").append(command.type).append('\n');
        text.append("Command chunk: ").append(command.name).append('\n');
        for (String slot : command.slots) text.append(slot).append('\n');
      }
      return text.toString();
    }
  }

  private static final class BufferSnapshot {
    final String state;
    final boolean empty;
    final boolean cleared;
    final String name;
    final String type;
    final String context;
    final Map<String, String> slotValues;
    final List<String> slots;

    static BufferSnapshot capture(String state, boolean empty, boolean cleared, Chunk chunk) {
      return capture(state, empty, cleared, chunk, null);
    }

    static BufferSnapshot capture(String state, boolean empty, boolean cleared, Chunk chunk,
                                  String context) {
      Map<String, String> slots = new LinkedHashMap<String, String>();
      if (!empty && chunk != null) {
        for (String name : chunk.Slot_Names_In_Order) {
          if (chunk.Slot.containsKey(name)) slots.put(name, chunk.Slot.get(name));
        }
        for (String name : new TreeSet<String>(chunk.Slot.keySet())) {
          if (!slots.containsKey(name)) slots.put(name, chunk.Slot.get(name));
        }
      }
      return new BufferSnapshot(state, empty, cleared && empty,
          empty || chunk == null ? "" : chunk.Chunk_Name,
          empty || chunk == null ? "" : chunk.Chunk_Type, slots, context);
    }

    BufferSnapshot(String state, boolean empty, boolean cleared, String name, String type,
                   Map<String, String> slotValues) {
      this(state, empty, cleared, name, type, slotValues, null);
    }

    BufferSnapshot(String state, boolean empty, boolean cleared, String name, String type,
                   Map<String, String> slotValues, String context) {
      this.state = state;
      this.empty = empty;
      this.cleared = cleared;
      this.name = name;
      this.type = type;
      this.context = context;
      this.slotValues = Collections.unmodifiableMap(new LinkedHashMap<String, String>(slotValues));
      List<String> values = new ArrayList<String>();
      for (Map.Entry<String, String> entry : this.slotValues.entrySet()) {
        values.add(entry.getKey() + ": " + entry.getValue());
      }
      slots = Collections.unmodifiableList(values);
    }

    String fullText() {
      StringBuilder text = new StringBuilder();
      if (state != null) text.append("State: ").append(state).append('\n');
      text.append("Buffer: ").append(empty ? cleared ? "CLEARED" : "EMPTY" : "OCCUPIED").append('\n');
      if (context != null) text.append("Source: ").append(context).append('\n');
      if (!empty) {
        text.append("Chunk: ").append(name).append('\n');
        text.append("Type: ").append(type).append('\n');
        for (String slot : slots) text.append(slot).append('\n');
      }
      return text.toString();
    }
  }

  @Override
  protected void paintComponent(Graphics graphics) {
    super.paintComponent(graphics);
    if (getWidth() <= 0 || getHeight() <= 0) return;

    Graphics2D g = (Graphics2D) graphics.create();
    try {
      double scale = Math.min((double) getWidth() / DESIGN_WIDTH,
                              (double) getHeight() / DESIGN_HEIGHT);
      g.translate((getWidth() - DESIGN_WIDTH * scale) / 2.0,
                  (getHeight() - DESIGN_HEIGHT * scale) / 2.0);
      g.scale(scale, scale);
      g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
      g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

      g.translate(0, HEAD_OFFSET);
      drawBackground(g);
      Graphics2D headText = (Graphics2D) g.create();
      try {
        headText.translate(0, -HEAD_OFFSET);
        drawThoughts(headText);
      } finally {
        headText.dispose();
      }
      drawEyes(g);
      drawConnections(g);
      drawBuffers(g);
      drawPupils(g);
      drawConflictResolution(g);
      drawOutputs(g);
    } finally {
      g.dispose();
    }
  }

  private void drawThoughts(Graphics2D g) {
    g.setColor(new Color(0xF7F4E9));
    g.fill(THOUGHT_CLOUD);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.8f));
    g.draw(THOUGHT_CLOUD);
    g.setFont(LABEL_FONT);
    g.drawString("SUBVOCALIZE", 86, 29);

    Graphics2D words = (Graphics2D) g.create();
    try {
      words.clipRect(86, 36, 528, 32);
      words.setFont(THOUGHT_FONT);
      FontMetrics metrics = words.getFontMetrics();
      List<ThoughtWord> current = new ArrayList<>(visibleThoughts);
      int width = 0;
      for (ThoughtWord word : current) width += metrics.stringWidth(word.text) + 12;
      int x = Math.min(86, 614 - width);
      long now = System.nanoTime();
      for (ThoughtWord word : current) {
        float opacity = Math.max(0f, 1f - (float) (now - word.timeNanos) / TRAIL_LIFETIME_NANOS);
        words.setComposite(AlphaComposite.SrcOver.derive(opacity));
        words.setColor(new Color(0x343040));
        words.drawString(word.text, x, 58);
        x += metrics.stringWidth(word.text) + 12;
      }
    } finally {
      words.dispose();
    }
  }

  private static Area createThoughtCloud() {
    Area cloud = new Area(new RoundRectangle2D.Double(74, 18, 552, 52, 30, 30));
    for (int i = 0; i < 10; i++) {
      int x = 76 + i * 52;
      cloud.add(new Area(new Ellipse2D.Double(x, 8 + (i % 2) * 2, 70, 35)));
      cloud.add(new Area(new Ellipse2D.Double(x, 51 - (i % 2) * 2, 70, 30)));
    }
    cloud.add(new Area(new Ellipse2D.Double(65, 23, 36, 45)));
    cloud.add(new Area(new Ellipse2D.Double(600, 21, 37, 48)));
    return cloud;
  }

  private void drawBackground(Graphics2D g) {
    g.setColor(BACKGROUND);
    g.fill(new RoundRectangle2D.Double(0.25, 0.25 - HEAD_OFFSET,
        699.5, 699.5 + HEAD_OFFSET, 180, 180));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.draw(new RoundRectangle2D.Double(0.25, 0.25 - HEAD_OFFSET,
        699.5, 699.5 + HEAD_OFFSET, 180, 180));

    Path2D lowerPanel = new Path2D.Double();
    lowerPanel.moveTo(350, 700);
    lowerPanel.lineTo(699.75, 742.45);
    lowerPanel.lineTo(699.75, 799.75);
    lowerPanel.lineTo(0.25, 799.75);
    lowerPanel.lineTo(0.25, 742.45);
    lowerPanel.closePath();
    g.setColor(BACKGROUND);
    g.fill(lowerPanel);
    g.setColor(OUTLINE);
    g.draw(lowerPanel);
  }

  private void drawConnections(Graphics2D g) {
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(1.0f));
    arrow(g, true, true, 140, 375, 140, 340, 140, 210);
    arrow(g, true, true, 350, 375, 350, 197);
    arrow(g, true, true, 560, 375, 560, 340, 560, 210);
    arrow(g, true, true, 225, 375, 225, 330);
    arrow(g, true, true, 475, 375, 475, 330);
    arrow(g, true, true, 160, 375, 160, 360, 90, 360);
    arrow(g, true, true, 540, 375, 540, 360, 610, 360);
    arrow(g, true, true, 520, 375, 520, 350, 590, 350, 590, 285);
    arrow(g, false, true, 350, 545, 350, 590);
    arrow(g, false, true, 350, 660, 350, 723);
    arrow(g, false, true, 490, 723, 490, 680, 490, 545);
  }

  private void drawEyes(Graphics2D g) {
    drawEye(g, 225, 285);
    drawEye(g, 475, 285);
  }

  private void drawEye(Graphics2D g, int centerX, int centerY) {
    g.setColor(new Color(0xF7F4E9));
    g.fill(new Ellipse2D.Double(centerX - EYE_RADIUS, centerY - EYE_RADIUS,
        EYE_RADIUS * 2, EYE_RADIUS * 2));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(1.2f));
    g.draw(new Ellipse2D.Double(centerX - EYE_RADIUS, centerY - EYE_RADIUS,
        EYE_RADIUS * 2, EYE_RADIUS * 2));
  }

  private void drawPupils(Graphics2D g) {
    drawPupil(g, 225, 285);
    drawPupil(g, 475, 285);
  }

  private void drawPupil(Graphics2D g, int centerX, int centerY) {
    Graphics2D marks = (Graphics2D) g.create();
    try {
      marks.setStroke(new BasicStroke(2f));
      List<GazePoint> previous = new ArrayList<>(gazeTrail);
      long now = System.nanoTime();
      for (int i = 0; i < previous.size(); i++) {
        GazePoint point = previous.get(i);
        double nextX = i + 1 < previous.size() ? previous.get(i + 1).x : gazeX;
        double nextY = i + 1 < previous.size() ? previous.get(i + 1).y : gazeY;
        double nextRadius = i + 1 < previous.size() ? 5 : pupilRadius;
        float opacity = Math.max(0f, 1f - (float) (now - point.timeNanos)
            / TRAIL_LIFETIME_NANOS);
        marks.setComposite(AlphaComposite.SrcOver.derive(0.45f * opacity));
        marks.setColor(Color.BLACK);
        marks.drawLine(pupilX(centerX, point.x, point.y, 5),
            pupilY(centerY, point.x, point.y, 5),
            pupilX(centerX, nextX, nextY, nextRadius),
            pupilY(centerY, nextX, nextY, nextRadius));
        int oldX = pupilX(centerX, point.x, point.y, 5);
        int oldY = pupilY(centerY, point.x, point.y, 5);
        marks.fill(new Ellipse2D.Double(oldX - 5, oldY - 5, 10, 10));
      }
      marks.setComposite(AlphaComposite.SrcOver);
      marks.setColor(Color.BLACK);
      int x = pupilX(centerX, gazeX, gazeY, pupilRadius);
      int y = pupilY(centerY, gazeX, gazeY, pupilRadius);
      marks.fill(new Ellipse2D.Double(x - pupilRadius, y - pupilRadius,
          pupilRadius * 2, pupilRadius * 2));
    } finally {
      marks.dispose();
    }
  }

  private static int pupilX(int centerX, double x, double y, double radius) {
    double travel = EYE_RADIUS - radius - 1;
    return centerX + (int) Math.round(x * travel / Math.max(1.0, Math.hypot(x, y)));
  }

  private static int pupilY(int centerY, double x, double y, double radius) {
    double travel = EYE_RADIUS - radius - 1;
    return centerY + (int) Math.round(y * travel / Math.max(1.0, Math.hypot(x, y)));
  }

  private void drawBuffers(Graphics2D g) {
    module(g, "IMAGINAL", 60, 40, 160, 170, procedural.usesBuffer("imaginal"));
    box(g, 70, 60, 140, 140, procedural.usesBuffer("imaginal"));
    drawLiveBuffer(g, imaginal.snapshot, 60, 40);

    module(g, "GOAL", 240, 17, 220, 180);
    drawGoalBuffer(g, goal1, 250, 40, goalShade1, procedural.usesBuffer("goal"));
    drawGoalBuffer(g, goal2, 250, 120, goalShade2, procedural.usesBuffer("goal-2"));

    module(g, "RETRIEVAL", 480, 40, 160, 170, procedural.usesBuffer("retrieval"));
    box(g, 490, 60, 140, 140, procedural.usesBuffer("retrieval"));
    drawLiveBuffer(g, retrieval.snapshot, 480, 40);

    module(g, "VISUAL-LOCATION", 180, 240, 90, 90, procedural.usesBuffer("visual-location"));
    drawCompactVisualBuffer(g, visualLocation.snapshot, 180, 240);

    module(g, "VISUAL", 430, 240, 90, 90, procedural.usesBuffer("visual"));
    drawCompactVisualBuffer(g, visual.snapshot, 430, 240);

    module(g, "TEMPORAL", 580, 221, 90, 64, procedural.usesBuffer("temporal"));
    drawTemporalCounter(g);

    drawEarModule(g, "AURAL-LOCATION", 0, 295, false,
        procedural.usesBuffer("aural-location"));
    drawAudioBuffer(g, auralLocation.snapshot, 0, 295, true);
    drawLastAuralLocation(g);
    drawEarModule(g, "AURAL", 610, 295, true, procedural.usesBuffer("aural"));
    drawAudioBuffer(g, aural.snapshot, 610, 295, false);
    drawHearing(g);
  }

  private void drawEarModule(Graphics2D g, String name, int x, int y,
                             boolean mirror, boolean usedInLhs) {
    Path2D ear = new Path2D.Double();
    ear.moveTo(17, 3);
    ear.curveTo(4, 8, 0, 26, 0, 47);
    ear.curveTo(0, 61, 10, 67, 3, 83);
    ear.curveTo(-2, 98, 1, 118, 2, 136);
    ear.curveTo(2, 154, 9, 165, 27, 165);
    ear.curveTo(37, 165, 41, 162, 45, 157);
    ear.curveTo(49, 162, 59, 165, 70, 165);
    ear.curveTo(83, 165, 90, 154, 90, 139);
    ear.curveTo(90, 126, 84, 116, 83, 101);
    ear.curveTo(82, 88, 90, 78, 90, 63);
    ear.lineTo(90, 44);
    ear.curveTo(90, 18, 78, 4, 61, 2);
    ear.curveTo(45, -1, 31, -1, 17, 3);
    ear.closePath();

    Graphics2D outline = (Graphics2D) g.create();
    try {
      outline.translate(x + (mirror ? 90 : 0), y);
      if (mirror) outline.scale(-1, 1);
      outline.setColor(MODULE);
      outline.fill(ear);
      outline.setColor(usedInLhs ? MATCH_OUTLINE : OUTLINE);
      outline.setStroke(new BasicStroke(usedInLhs ? 1.5f : 0.5f));
      outline.draw(ear);
    } finally {
      outline.dispose();
    }
    centered(g, name, x, y, 90, LABEL_FONT, y + 12);
  }

  private void drawLastAuralLocation(Graphics2D g) {
    g.setColor(new Color(0xF7F4E9));
    g.fill(new RoundRectangle2D.Double(5, 418, 80, 36, 8, 8));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.8f));
    g.draw(new RoundRectangle2D.Double(5, 418, 80, 36, 8, 8));
    g.setFont(LABEL_FONT);
    g.drawString("LAST LOCATION", 10, 429);
    if (lastAuralLocation == null) return;

    Graphics2D text = (Graphics2D) g.create();
    try {
      text.clipRect(10, 432, 70, 18);
      float opacity = Math.max(0f, 1f - (float) (System.nanoTime() - lastAuralLocation.timeNanos)
          / TRAIL_LIFETIME_NANOS);
      text.setComposite(AlphaComposite.SrcOver.derive(opacity));
      text.setColor(new Color(0x343040));
      text.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 12));
      bufferLine(text, text.getFontMetrics(), lastAuralLocation.text, 10, 445, 70);
    } finally {
      text.dispose();
    }
  }

  private void drawHearing(Graphics2D g) {
    g.setColor(new Color(0xF7F4E9));
    g.fill(new RoundRectangle2D.Double(724, 310, 205, 137, 18, 18));
    Path2D ear = new Path2D.Double();
    ear.moveTo(700, 377);
    ear.lineTo(725, 355);
    ear.lineTo(725, 399);
    ear.closePath();
    g.fill(ear);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.8f));
    g.draw(new RoundRectangle2D.Double(724, 310, 205, 137, 18, 18));
    g.drawLine(700, 377, 725, 355);
    g.drawLine(700, 377, 725, 399);
    g.setFont(LABEL_FONT);
    g.drawString("HEARD", 737, 329);
    drawFlowingWords(g, visibleHearing, 737, 340, 179, 94);
    drawIncomingSoundWaves(g);
  }

  private void drawIncomingSoundWaves(Graphics2D g) {
    long now = System.nanoTime();
    if (!audioEncoding && pendingHearing.isEmpty()
        && now - lastHeardNanos >= 900_000_000L) return;
    Graphics2D waves = (Graphics2D) g.create();
    try {
      waves.setColor(Color.BLACK);
      waves.setStroke(new BasicStroke(2.2f, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND));
      double travel = (now / 30_000_000.0) % 15;
      for (int i = 0; i < 3; i++) {
        int height = 19 + i * 11;
        double x = 938 + i * 15 - travel;
        waves.draw(new Arc2D.Double(x, 378 - height / 2.0, 14, height, 90, 180, Arc2D.OPEN));
      }
    } finally {
      waves.dispose();
    }
  }

  private void drawCompactVisualBuffer(Graphics2D g, BufferSnapshot snapshot, int x, int y) {
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(x + 3, y + 15, 84, 73);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("S", x + 4, y + 28);
      compactBillboard(clipped, snapshot.state, x + 16, y + 17);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("B", x + 4, y + 45);
      compactBillboard(clipped,
          snapshot.empty ? snapshot.cleared ? "CLEARED" : "EMPTY" : "OCCUPIED", x + 16, y + 34);
      clipped.setColor(OUTLINE);
      clipped.setFont(DETAIL_FONT);
      FontMetrics small = clipped.getFontMetrics();
      if (snapshot.context != null) {
        String context = snapshot.context.equals("REQUESTED") ? "REQ" : snapshot.context;
        bufferLine(clipped, small, context, x + 4, y + 55, 82);
      } else if (!snapshot.empty && !snapshot.slots.isEmpty()) {
        bufferLine(clipped, small, snapshot.slots.get(0), x + 4, y + 55, 82);
      }
      bufferLine(clipped, small, "Chunk: " + (snapshot.empty ? "-" : snapshot.name), x + 4, y + 65, 82);
      bufferLine(clipped, small, "Type: " + (snapshot.empty ? "-" : snapshot.type), x + 4, y + 75, 82);
      if (snapshot.context != null && !snapshot.empty && !snapshot.slots.isEmpty()) {
        bufferLine(clipped, small, snapshot.slots.get(0), x + 4, y + 85, 82);
      } else if (snapshot.context == null && !snapshot.empty && snapshot.slots.size() > 1) {
        bufferLine(clipped, small, snapshot.slots.get(1), x + 4, y + 85, 82);
      }
    } finally {
      clipped.dispose();
    }
  }

  private void compactBillboard(Graphics2D g, String value, int x, int y) {
    g.setColor(BILLBOARD_BACKGROUND);
    g.fillRect(x, y, 68, 15);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.drawRect(x, y, 68, 15);
    g.setFont(BUFFER_FONT);
    g.drawString(value, x + 3, y + 11);
  }

  private void drawAudioBuffer(Graphics2D g, BufferSnapshot snapshot, int x, int y,
                               boolean reserveLocationTrail) {
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(x + 4, y + 17, 82, 144);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      FontMetrics metrics = clipped.getFontMetrics();
      clipped.drawString("STATE", x + 8, y + 29);
      audioBillboard(clipped, snapshot.state, x + 8, y + 33);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("BUFFER", x + 8, y + 64);
      audioBillboard(clipped,
          snapshot.empty ? snapshot.cleared ? "CLEARED" : "EMPTY" : "OCCUPIED", x + 8, y + 68);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      bufferLine(clipped, metrics, "Chunk: " + (snapshot.empty ? "-" : snapshot.name),
                 x + 8, y + 100, 74);
      bufferLine(clipped, metrics, "Type: " + (snapshot.empty ? "-" : snapshot.type),
                 x + 8, y + 112, 74);
      if (!snapshot.empty && !reserveLocationTrail) {
        for (int i = 0; i < Math.min(3, snapshot.slots.size()); i++) {
          bufferLine(clipped, metrics, snapshot.slots.get(i), x + 8, y + 124 + 12 * i, 74);
        }
        if (snapshot.slots.size() > 3) {
          clipped.drawString("+" + (snapshot.slots.size() - 3) + " more", x + 8, y + 160);
        }
      }
    } finally {
      clipped.dispose();
    }
  }

  private void audioBillboard(Graphics2D g, String value, int x, int y) {
    g.setColor(BILLBOARD_BACKGROUND);
    g.fillRect(x, y, 74, 16);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.drawRect(x, y, 74, 16);
    g.setFont(BILLBOARD_FONT);
    g.drawString(value, x + 5, y + 12);
  }

  private void drawTemporalCounter(Graphics2D g) {
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(583, 236, 84, 46);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("TICKS", 588, 248);
      clipped.setColor(BILLBOARD_BACKGROUND);
      clipped.fillRect(588, 252, 74, 24);
      clipped.setColor(OUTLINE);
      clipped.setStroke(new BasicStroke(0.5f));
      clipped.drawRect(588, 252, 74, 24);
      BufferSnapshot snapshot = temporal.snapshot;
      String display;
      if (snapshot.empty) display = snapshot.cleared ? "CLEARED" : "------";
      else {
        String ticks = snapshot.slotValues.get("ticks");
        display = ticks == null ? "?" : ticks;
        try {
          display = String.format(Locale.ROOT, "%06d", Integer.parseInt(display));
        } catch (NumberFormatException ignored) {
          // Keep the exact runtime value if it is not an integer.
        }
      }
      clipped.setFont(COUNTER_FONT);
      FontMetrics metrics = clipped.getFontMetrics();
      clipped.clipRect(591, 254, 68, 20);
      clipped.drawString(display, 657 - metrics.stringWidth(display), 269);
    } finally {
      clipped.dispose();
    }
  }

  private void drawGoalBuffer(Graphics2D g, LiveBufferDisplay display, int x, int y, int shade,
                              boolean usedInLhs) {
    box(g, x, y, 200, 70, usedInLhs);
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(x + 2, y + 2, 196, 66);
      if (shade > 0) {
        clipped.setColor(new Color(255, 0, 0, Math.round(Math.min(shade, 5) * 25.5f)));
        clipped.fillRect(x + 1, y + 1, 198, 68);
      }
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      FontMetrics metrics = clipped.getFontMetrics();
      clipped.drawString(display.label, x + 4, y + 14);
      clipped.drawString("Buffer", x + 47, y + 14);
      clipped.setColor(BILLBOARD_BACKGROUND);
      clipped.fillRect(x + 89, y + 2, 106, 16);
      clipped.setColor(OUTLINE);
      clipped.setStroke(new BasicStroke(0.5f));
      clipped.drawRect(x + 89, y + 2, 106, 16);
      clipped.setFont(BILLBOARD_FONT);
      BufferSnapshot snapshot = display.snapshot;
      clipped.drawString(snapshot.empty ? snapshot.cleared ? "CLEARED" : "EMPTY" : "OCCUPIED",
                         x + 95, y + 14);
      clipped.setFont(BUFFER_FONT);
      bufferLine(clipped, metrics, "Chunk: " + (snapshot.empty ? "-" : snapshot.name), x + 4, y + 29, 192);
      bufferLine(clipped, metrics, "Type: " + (snapshot.empty ? "-" : snapshot.type), x + 4, y + 41, 192);
      if (!snapshot.empty) {
        for (int i = 0; i < Math.min(2, snapshot.slots.size()); i++) {
          bufferLine(clipped, metrics, snapshot.slots.get(i), x + 4, y + 53 + i * 12, 192);
        }
      }
    } finally {
      clipped.dispose();
    }
  }

  private void drawLiveBuffer(Graphics2D g, BufferSnapshot snapshot, int x, int y) {
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(x + 12, y + 22, 136, 136);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      FontMetrics metrics = clipped.getFontMetrics();
      billboardRow(clipped, "State", snapshot.state, x, y + 25);
      billboardRow(clipped, "Buffer",
          snapshot.empty ? snapshot.cleared ? "CLEARED" : "EMPTY" : "OCCUPIED", x, y + 44);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      bufferLine(clipped, metrics, "Chunk: " + (snapshot.empty ? "-" : snapshot.name), x + 14, y + 72);
      bufferLine(clipped, metrics, "Type: " + (snapshot.empty ? "-" : snapshot.type), x + 14, y + 84);
      if (!snapshot.empty) {
        int baseline = y + 98;
        for (String slot : snapshot.slots) {
          if (baseline > y + 142) break;
          bufferLine(clipped, metrics, slot, x + 14, baseline);
          baseline += 11;
        }
      }
      bufferLine(clipped, metrics, "Click for all details", x + 14, y + 155);
    } finally {
      clipped.dispose();
    }
  }

  private void billboardRow(Graphics2D g, String label, String value, int x, int top) {
    g.setColor(OUTLINE);
    g.setFont(BUFFER_FONT);
    g.drawString(label, x + 14, top + 11);
    g.setColor(BILLBOARD_BACKGROUND);
    g.fillRect(x + 60, top, 84, 16);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.drawRect(x + 60, top, 84, 16);
    g.setFont(BILLBOARD_FONT);
    g.drawString(value, x + 66, top + 12);
  }

  private void bufferLine(Graphics2D g, FontMetrics metrics, String value, int x, int baseline) {
    bufferLine(g, metrics, value, x, baseline, 132);
  }

  private void bufferLine(Graphics2D g, FontMetrics metrics, String value, int x, int baseline,
                          int maxWidth) {
    String line = value.replace('\n', ' ').replace('\r', ' ');
    if (metrics.stringWidth(line) > maxWidth) {
      while (!line.isEmpty() && metrics.stringWidth(line + "...") > maxWidth) {
        line = line.substring(0, line.length() - 1);
      }
      line += "...";
    }
    g.drawString(line, x, baseline);
  }

  private void drawConflictResolution(Graphics2D g) {
    box(g, 150, 375, 400, 170);
    centered(g, "CONFLICT-RESOLUTION", 150, 375, 400, TITLE_FONT, 390);
    detail(g, "BASE U: REDDER=HIGHER", 158, 389);
    ProceduralSnapshot snapshot = procedural;
    g.setColor(BILLBOARD_BACKGROUND);
    g.fillRect(444, 378, 97, 15);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.drawRect(444, 378, 97, 15);
    g.setFont(BUFFER_FONT);
    bufferLine(g, g.getFontMetrics(), snapshot.stage, 449, 389, 88);

    List<ProceduralCandidate> ranked = new ArrayList<ProceduralCandidate>(snapshot.candidates);
    ranked.sort(Comparator.comparingDouble((ProceduralCandidate c) ->
        Double.isFinite(c.baseUtility) ? c.baseUtility : Double.NEGATIVE_INFINITY).reversed());
    double min = Double.POSITIVE_INFINITY;
    double max = Double.NEGATIVE_INFINITY;
    for (ProceduralCandidate item : ranked) {
      if (Double.isFinite(item.baseUtility)) {
        min = Math.min(min, item.baseUtility);
        max = Math.max(max, item.baseUtility);
      }
    }
    if (ranked.isEmpty()) {
      g.setColor(OUTLINE);
      g.setFont(BUFFER_FONT);
      g.drawString("NO MATCHES", 160, 409);
    } else {
      int shown = Math.min(ranked.size(), 6);
      if (ranked.size() > 6) shown = 5;
      for (int i = 0; i < shown; i++) {
        drawCandidate(g, ranked.get(i), 160 + (i % 3) * 126, 397 + (i / 3) * 22, min, max);
      }
      if (ranked.size() > 6) {
        g.setColor(OUTLINE);
        g.setFont(BUFFER_FONT);
        g.drawString("+" + (ranked.size() - 5) + " more (click)", 412, 430);
      }
    }

    box(g, 170, 445, 360, 30);
    g.setColor(OUTLINE);
    g.setFont(BUFFER_FONT);
    ProceduralCandidate chosen = snapshot.selected.isEmpty() ? null
        : snapshot.selected.get(snapshot.selected.size() - 1);
    String selection = chosen == null ? "SELECTED: -" : "SELECTED: " + chosen.label()
        + "  U=" + compactUtility(chosen.finalUtility);
    bufferLine(g, g.getFontMetrics(), selection, 178, 463, 344);
    arrow(g, false, true, 350, 426, 350, 445);

    box(g, 170, 495, 360, 30);
    g.setColor(OUTLINE);
    g.setFont(BUFFER_FONT);
    boolean firing = !snapshot.executing.isEmpty();
    String current = firing ? snapshot.executing.get(snapshot.executing.size() - 1) : snapshot.lastExecuted;
    bufferLine(g, g.getFontMetrics(), (firing ? "EXECUTING: " : "EXECUTED: ")
        + (current.isEmpty() ? "-" : current), 178, 513, 226);
    if (firing) {
      Path2D bolt = new Path2D.Double();
      bolt.moveTo(421, 500);
      bolt.lineTo(414, 510);
      bolt.lineTo(419, 510);
      bolt.lineTo(417, 520);
      bolt.lineTo(425, 507);
      bolt.lineTo(420, 507);
      bolt.closePath();
      g.fill(bolt);
    }
    arrow(g, false, true, 350, 475, 350, 495);
  }

  private void drawCandidate(Graphics2D g, ProceduralCandidate item, int x, int y,
                             double min, double max) {
    int alpha = Double.isFinite(item.baseUtility)
        ? min == max ? 80 : 30 + (int) Math.round(98 * (item.baseUtility - min) / (max - min))
        : 0;
    g.setColor(new Color(255, 0, 0, alpha));
    g.fillRect(x, y, 120, 18);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.drawRect(x, y, 120, 18);
    g.setFont(DETAIL_FONT);
    bufferLine(g, g.getFontMetrics(), item.label() + "  " + compactUtility(item.baseUtility),
               x + 3, y + 12, 114);
  }

  private static String compactUtility(double utility) {
    return Double.isFinite(utility) ? String.format(Locale.ROOT, "%.3f", utility) : "?";
  }

  private void drawOutputs(Graphics2D g) {
    module(g, "VOCAL", 235, 590, 230, 70, procedural.usesBuffer("vocal"));
    drawOutput(g, vocal.snapshot, 235, 590);
    drawLips(g);
    drawSpeech(g);

    module(g, "MANUAL", 286, 723, 230, 70, procedural.usesBuffer("manual"));
    drawOutput(g, manual.snapshot, 286, 723);
    drawHands(g);

    g.setColor(OUTLINE);
    g.setFont(TITLE_FONT);
    g.drawString("QN-ACTR-HAT", 30, 759);
    g.drawString("model loaded: takeoff", 10, 775);
  }

  private void drawLips(Graphics2D g) {
    double movement = vocalSpeaking ? 3 * Math.sin(System.nanoTime() / 95_000_000.0) : 0;
    double upperY = 584 - movement;
    double lowerY = 666 + movement;
    Graphics2D lips = (Graphics2D) g.create();
    try {
      lips.setColor(Color.BLACK);
      lips.setStroke(new BasicStroke(3.2f, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND));
      Path2D upper = new Path2D.Double();
      upper.moveTo(280, upperY);
      upper.curveTo(315, upperY - 5, 385, upperY - 5, 420, upperY);
      Path2D lower = new Path2D.Double();
      lower.moveTo(280, lowerY);
      lower.curveTo(315, lowerY + 5, 385, lowerY + 5, 420, lowerY);
      lips.draw(upper);
      lips.draw(lower);
    } finally {
      lips.dispose();
    }
  }

  private void drawHands(Graphics2D g) {
    drawHand(g);

    String stage = handPhase == HandPhase.FINISH ? "FINISH / RETURN" : handPhase.name();
    g.setColor(BILLBOARD_BACKGROUND);
    g.fill(new RoundRectangle2D.Double(684, 825, 144, 27, 10, 10));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.7f));
    g.draw(new RoundRectangle2D.Double(684, 825, 144, 27, 10, 10));
    g.setFont(BUFFER_FONT);
    FontMetrics metrics = g.getFontMetrics();
    g.drawString(stage, 756 - metrics.stringWidth(stage) / 2, 843);
  }

  private void drawHand(Graphics2D g) {
    int palmX = (int) Math.round(320 + handExtension);
    int buttonX = 548 + (int) Math.round(handPress * 5);
    Color skin = new Color(0xD8AA86);
    Color arm = new Color(0xC99572);
    Color outline = new Color(0x594334);
    g.setStroke(new BasicStroke(1.3f));

    g.setColor(new Color(0x949494));
    g.fill(new RoundRectangle2D.Double(565, 835, 13, 57, 5, 5));
    g.setColor(outline);
    g.draw(new RoundRectangle2D.Double(565, 835, 13, 57, 5, 5));
    g.setColor(new Color(0xD65B4A));
    g.fill(new RoundRectangle2D.Double(buttonX, 847, 18, 33, 8, 8));
    g.setColor(outline);
    g.draw(new RoundRectangle2D.Double(buttonX, 847, 18, 33, 8, 8));

    Path2D forearm = new Path2D.Double();
    forearm.moveTo(165, 835);
    forearm.lineTo(palmX - 20, 842);
    forearm.lineTo(palmX - 20, 879);
    forearm.lineTo(165, 886);
    forearm.closePath();
    g.setColor(arm);
    g.fill(forearm);
    g.setColor(outline);
    g.draw(forearm);

    g.setColor(skin);
    g.fill(new RoundRectangle2D.Double(palmX - 24, 841, 47, 39, 16, 16));
    g.setColor(outline);
    g.draw(new RoundRectangle2D.Double(palmX - 24, 841, 47, 39, 16, 16));

    for (int finger = 0; finger < 4; finger++) {
      int length = (int) Math.round(17 + handOpenness * (finger == 1 || finger == 2 ? 18 : 14)
          + (finger == 1 ? handPress * 23 : 0));
      int x = palmX + 17;
      int y = 844 + finger * 9;
      g.setColor(skin);
      g.fill(new RoundRectangle2D.Double(x, y, length, 8, 8, 8));
      g.setColor(outline);
      g.draw(new RoundRectangle2D.Double(x, y, length, 8, 8, 8));
    }

    g.drawLine(palmX - 20, 844, palmX - 20, 877);

    if (handPhase == HandPhase.EXECUTION && handPress > 0.05) {
      Graphics2D action = (Graphics2D) g.create();
      try {
        action.setComposite(AlphaComposite.SrcOver.derive((float) handPress));
        double pulse = 0.5 + 0.5 * Math.sin(System.nanoTime() / 90_000_000.0);
        int reach = 5 + (int) Math.round(4 * pulse);
        action.setColor(new Color(0xC84435));
        action.setStroke(new BasicStroke(1.6f));
        action.drawLine(buttonX + 3, 841, buttonX + 3 - reach, 837 - reach / 2);
        action.drawLine(buttonX + 3, 885, buttonX + 3 - reach, 889 + reach / 2);
      } finally {
        action.dispose();
      }
    }
  }

  private void drawSpeech(Graphics2D g) {
    g.setColor(new Color(0xF7F4E9));
    g.fill(new RoundRectangle2D.Double(487, 565, 203, 129, 18, 18));
    Path2D mouth = new Path2D.Double();
    mouth.moveTo(465, 625);
    mouth.lineTo(488, 605);
    mouth.lineTo(488, 645);
    mouth.closePath();
    g.fill(mouth);
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.8f));
    g.draw(new RoundRectangle2D.Double(487, 565, 203, 129, 18, 18));
    g.drawLine(465, 625, 488, 605);
    g.drawLine(465, 625, 488, 645);
    g.setFont(LABEL_FONT);
    g.drawString("SPEAK", 500, 584);

    drawFlowingWords(g, visibleSpeech, 500, 596, 178, 91);
  }

  private void drawFlowingWords(Graphics2D g, Deque<ThoughtWord> visible,
                                int left, int top, int width, int height) {
    Graphics2D words = (Graphics2D) g.create();
    try {
      words.clipRect(left, top, width, height);
      words.setFont(THOUGHT_FONT);
      FontMetrics metrics = words.getFontMetrics();
      List<ThoughtWord> current = new ArrayList<>(visible);
      int[] xPositions = new int[current.size()];
      int[] lines = new int[current.size()];
      int x = left;
      int line = 0;
      for (int i = 0; i < current.size(); i++) {
        int wordWidth = metrics.stringWidth(current.get(i).text);
        if (x > left && x + wordWidth > left + width) {
          x = left;
          line++;
        }
        xPositions[i] = x;
        lines[i] = line;
        x += wordWidth + 8;
      }
      int firstLine = Math.max(0, line - (height - 15) / 18);
      long now = System.nanoTime();
      for (int i = 0; i < current.size(); i++) {
        if (lines[i] < firstLine) continue;
        ThoughtWord word = current.get(i);
        float opacity = Math.max(0f, 1f - (float) (now - word.timeNanos) / TRAIL_LIFETIME_NANOS);
        words.setComposite(AlphaComposite.SrcOver.derive(opacity));
        words.setColor(new Color(0x343040));
        words.drawString(word.text, xPositions[i], top + 15 + (lines[i] - firstLine) * 18);
      }
    } finally {
      words.dispose();
    }
  }

  private void drawOutput(Graphics2D g, OutputSnapshot snapshot, int x, int y) {
    Graphics2D clipped = (Graphics2D) g.create();
    try {
      clipped.clipRect(x + 4, y + 16, 222, 52);
      clipped.setColor(OUTLINE);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("STAGE", x + 7, y + 29);
      clipped.setColor(BILLBOARD_BACKGROUND);
      clipped.fillRect(x + 44, y + 17, 100, 16);
      clipped.setColor(OUTLINE);
      clipped.setStroke(new BasicStroke(0.5f));
      clipped.drawRect(x + 44, y + 17, 100, 16);
      clipped.setFont(BILLBOARD_FONT);
      clipped.drawString(snapshot.stage, x + 49, y + 29);
      clipped.setFont(BUFFER_FONT);
      clipped.drawString("P:" + (snapshot.preparationFree ? "F" : "B")
          + " R:" + (snapshot.processorFree ? "F" : "B")
          + " E:" + (snapshot.executionFree ? "F" : "B"), x + 150, y + 29);
      FontMetrics metrics = clipped.getFontMetrics();
      bufferLine(clipped, metrics, "BUFFER: " + (snapshot.buffer.empty ? "EMPTY" : "OCCUPIED")
          + "   MODULE: " + (snapshot.stateFree ? "FREE" : "BUSY"), x + 7, y + 43, 214);
      bufferLine(clipped, metrics, "CMD: " + (snapshot.command.empty ? "-" : snapshot.command.type),
                 x + 7, y + 54, 214);
      if (!snapshot.command.empty) {
        bufferLine(clipped, metrics, snapshot.preview(), x + 7, y + 65, 214);
      }
    } finally {
      clipped.dispose();
    }
  }

  private void module(Graphics2D g, String name, double x, double y, double width, double height) {
    module(g, name, x, y, width, height, false);
  }

  private void module(Graphics2D g, String name, double x, double y, double width, double height,
                      boolean usedInLhs) {
    g.setColor(MODULE);
    g.fill(new RoundRectangle2D.Double(x, y, width, height, 10, 10));
    g.setColor(usedInLhs ? MATCH_OUTLINE : OUTLINE);
    g.setStroke(new BasicStroke(usedInLhs ? 1.5f : 0.5f));
    g.draw(new RoundRectangle2D.Double(x, y, width, height, 10, 10));
    centered(g, name, x, y, width, LABEL_FONT, y + 12);
  }

  private void box(Graphics2D g, double x, double y, double width, double height) {
    box(g, x, y, width, height, false);
  }

  private void box(Graphics2D g, double x, double y, double width, double height,
                   boolean usedInLhs) {
    g.setColor(MODULE);
    g.fill(new java.awt.geom.Rectangle2D.Double(x, y, width, height));
    g.setColor(usedInLhs ? MATCH_OUTLINE : OUTLINE);
    g.setStroke(new BasicStroke(usedInLhs ? 1.5f : 0.5f));
    g.draw(new java.awt.geom.Rectangle2D.Double(x, y, width, height));
  }

  private void circle(Graphics2D g, double centerX, double centerY, double radius) {
    g.setColor(MODULE);
    g.fill(new Ellipse2D.Double(centerX - radius, centerY - radius, radius * 2, radius * 2));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(1.0f));
    g.draw(new Ellipse2D.Double(centerX - radius, centerY - radius, radius * 2, radius * 2));
  }

  private void detail(Graphics2D g, String text, double x, double baseline) {
    g.setColor(OUTLINE);
    g.setFont(DETAIL_FONT);
    g.drawString(text, (float) x, (float) baseline);
  }

  private void centered(Graphics2D g, String text, double x, double y,
                        double width, Font font, double baseline) {
    g.setColor(OUTLINE);
    g.setFont(font);
    FontMetrics metrics = g.getFontMetrics();
    g.drawString(text, (float) (x + (width - metrics.stringWidth(text)) / 2.0),
                 (float) baseline);
  }

  private void arrow(Graphics2D g, boolean atStart, boolean atEnd, double... coordinates) {
    Path2D path = new Path2D.Double();
    path.moveTo(coordinates[0], coordinates[1]);
    for (int i = 2; i < coordinates.length; i += 2) {
      path.lineTo(coordinates[i], coordinates[i + 1]);
    }
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(1.0f));
    g.draw(path);
    if (atStart) arrowHead(g, coordinates[2], coordinates[3], coordinates[0], coordinates[1]);
    if (atEnd) {
      int last = coordinates.length - 2;
      arrowHead(g, coordinates[last - 2], coordinates[last - 1],
                coordinates[last], coordinates[last + 1]);
    }
  }

  private void arrowHead(Graphics2D g, double fromX, double fromY, double tipX, double tipY) {
    double angle = Math.atan2(tipY - fromY, tipX - fromX);
    double leftX = tipX - 5 * Math.cos(angle - Math.PI / 6);
    double leftY = tipY - 5 * Math.sin(angle - Math.PI / 6);
    double rightX = tipX - 5 * Math.cos(angle + Math.PI / 6);
    double rightY = tipY - 5 * Math.sin(angle + Math.PI / 6);
    Path2D head = new Path2D.Double();
    head.moveTo(tipX, tipY);
    head.lineTo(leftX, leftY);
    head.lineTo(rightX, rightY);
    head.closePath();
    g.fill(head);
  }
}
