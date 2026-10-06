package qnactr.GUI;

import java.awt.BasicStroke;
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
import java.awt.geom.Ellipse2D;
import java.awt.geom.Path2D;
import java.awt.geom.RoundRectangle2D;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
  private static final int DESIGN_WIDTH = 700;
  private static final int DESIGN_HEIGHT = 800;
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
  private static final Color BILLBOARD_BACKGROUND = new Color(0xF5F5F5);
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
    double y = (event.getY() - (getHeight() - DESIGN_HEIGHT * scale) / 2.0) / scale;
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
    pendingAudio.set(new AudioPairSnapshot(
        BufferSnapshot.capture(state, goalEmpty(auralChunk), auralCleared, auralChunk),
        BufferSnapshot.capture(state, location.Empty, locationCleared,
                               location.Aural_Location_Buffer_Chunk)));
    queueAudioUpdate();
  }

  private void queueAudioUpdate() {
    if (!audioUpdateQueued.compareAndSet(false, true)) return;
    SwingUtilities.invokeLater(() -> {
      AudioPairSnapshot latest = pendingAudio.getAndSet(null);
      if (latest != null) {
        aural.apply(latest.aural);
        auralLocation.apply(latest.location);
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
  }

  public void updateManual(String stage, Chunk command, Manual_Buffer buffer, Motor_Module module) {
    manual.update(OutputSnapshot.capture(stage, command, buffer.Manual_Buffer_Chunk,
        module.State_Free, module.Preparation_Free, module.Processor_Free, module.Execution_Free));
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

      drawBackground(g);
      drawConnections(g);
      drawBuffers(g);
      drawConflictResolution(g);
      drawOutputs(g);
    } finally {
      g.dispose();
    }
  }

  private void drawBackground(Graphics2D g) {
    g.setColor(BACKGROUND);
    g.fill(new RoundRectangle2D.Double(0.25, 0.25, 699.5, 699.5, 180, 180));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.draw(new RoundRectangle2D.Double(0.25, 0.25, 699.5, 699.5, 180, 180));

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

    module(g, "AURAL-LOCATION", 0, 295, 90, 165, procedural.usesBuffer("aural-location"));
    drawAudioBuffer(g, auralLocation.snapshot, 0, 295);
    module(g, "AURAL", 610, 295, 90, 165, procedural.usesBuffer("aural"));
    drawAudioBuffer(g, aural.snapshot, 610, 295);
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

  private void drawAudioBuffer(Graphics2D g, BufferSnapshot snapshot, int x, int y) {
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
      if (!snapshot.empty) {
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

    module(g, "MANUAL", 286, 723, 230, 70, procedural.usesBuffer("manual"));
    drawOutput(g, manual.snapshot, 286, 723);

    g.setColor(OUTLINE);
    g.setFont(TITLE_FONT);
    g.drawString("QN-ACTR-HAT", 30, 759);
    g.drawString("model loaded: takeoff", 10, 775);
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
