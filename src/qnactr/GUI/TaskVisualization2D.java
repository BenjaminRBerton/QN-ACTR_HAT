package qnactr.GUI;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Paint;
import java.awt.RadialGradientPaint;
import java.awt.RenderingHints;
import java.awt.event.HierarchyEvent;
import java.awt.image.BufferedImage;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map.Entry;

import javax.swing.JPanel;
import javax.swing.Timer;
import javax.swing.UIManager;

import qnactr.sim.GlobalUtilities;
import qnactr.sim.ImageResources;
import qnactr.sim.QnactrSimulation;



public class TaskVisualization2D extends JPanel 
{
  // Visual-attention trail settings (logical display pixels and elapsed seconds).
  public static final int ATTENTION_MARKER_DIAMETER = 40;
  public static final int HEATMAP_DIAMETER = 140;
  public static final Color HEATMAP_COLOR = new Color(255, 35, 35);
  public static final double HEATMAP_HISTORY_SECONDS = 30.0;
  public static final double HEATMAP_SATURATION_SECONDS = 8.0;
  public static final Color SACCADE_LINE_COLOR = new Color(180, 20, 20);
  public static final float SACCADE_LINE_WIDTH = 5.0f;
  private static final int TRAIL_REFRESH_MILLISECONDS = 200;
  private static final long NANOS_PER_SECOND = 1_000_000_000L;

  private static final class Fixation {
    final int x;
    final int y;
    final long startedAt;
    long endedAt;

    Fixation(int x, int y, long startedAt) {
      this.x = x;
      this.y = y;
      this.startedAt = startedAt;
    }
  }

  private static final class Saccade {
    final int fromX;
    final int fromY;
    final int toX;
    final int toY;
    final long occurredAt;

    Saccade(int fromX, int fromY, int toX, int toY, long occurredAt) {
      this.fromX = fromX;
      this.fromY = fromY;
      this.toX = toX;
      this.toY = toY;
      this.occurredAt = occurredAt;
    }
  }

  private final Deque<Fixation> fixations = new ArrayDeque<>();
  private final Deque<Saccade> saccades = new ArrayDeque<>();
  private Fixation activeFixation;
  private final Timer trailRefreshTimer = new Timer(TRAIL_REFRESH_MILLISECONDS, event -> {
    synchronized (TaskVisualization2D.this) {
      if (!isShowing()) {
        ((Timer) event.getSource()).stop();
        return;
      }
      expireAttentionHistory(System.nanoTime());
      if (activeFixation == null && fixations.isEmpty() && saccades.isEmpty()) {
        ((Timer) event.getSource()).stop();
      }
    }
    repaint();
  });

  public int objectCounter = 0;
  public Hashtable<String, Object> currentAllObjects = new Hashtable<String, Object>();
  public Hashtable<String, DynamicVisualObjects> currentDynamicObjects = new Hashtable<String, DynamicVisualObjects>();
  public String[] leftHandFingerIDs = new String[5]; // 0, "thumb"; 1, "index"; 2, "middle"; 3, "ring"; 4, "pinkie"
  public String[] rightHandFingerIDs = new String[5];
  public String mouseCursorID;
  public String visualAttentionCircleID;
  public String vocalResponseDisplayID;
  
  public int defaultWidthPerChar = 7;
  public int defaultHeightPerChar = 11;
  
  private int winX1 = 30; //upper left corner
  private int winY1 = 30; //upper left corner
  private int winX2 = winX1 + QnactrSimulation.simulatedWindowDefaultSizeX; //bottom right corner
  private int winY2 = winY1 + QnactrSimulation.simulatedWindowDefaultSizeY; //bottom right corner
  private static final int LOGICAL_WIDTH = QnactrSimulation.simulatedWindowDefaultSizeX
          + QnactrSimulation.taskVisualization2DExtendSizeX + 60;
  private static final int LOGICAL_HEIGHT = QnactrSimulation.simulatedWindowDefaultSizeY
          + QnactrSimulation.taskVisualization2DExtendSizeY;
  
  
  
  public TaskVisualization2D(){
    
    
    setBackground(Color.WHITE);
    setPreferredSize(new Dimension(LOGICAL_WIDTH, LOGICAL_HEIGHT));
    addHierarchyListener(event -> {
      if ((event.getChangeFlags() & HierarchyEvent.SHOWING_CHANGED) == 0) return;
      synchronized (TaskVisualization2D.this) {
        if (isShowing() && (activeFixation != null || !fixations.isEmpty() || !saccades.isEmpty())) {
          trailRefreshTimer.start();
        } else {
          trailRefreshTimer.stop();
        }
      }
    });
    
    //add simulated window corners
    createStaticText("(" + 0 + ", " + 0 + ")    Visual Display", winX1 , winY1 - 20);
    createStaticText("(" + (winX2 - winX1) + ", " + (winY2 - winY1) + ")", winX2 , winY2);
    
    createStaticText("Audio Display", 0 , winY2 + 60);
    createStaticText("Vocal Response", 180 , winY2 + 60);
    createStaticText("Manual Response", 180 + 290, winY2 + 60 + 110);
    leftHandFingerIDs[0] = createStaticText("--", 180 + 260, winY2 + 60 + 90);
    leftHandFingerIDs[1] = createStaticText("--", 180 + 260 - 10, winY2 + 60 + 90 - 20);
    leftHandFingerIDs[2] = createStaticText("--", 180 + 260 - 35, winY2 + 60 + 90 - 40);
    leftHandFingerIDs[3] = createStaticText("--", 180 + 260 - 60, winY2 + 60 + 90 - 20);
    leftHandFingerIDs[4] = createStaticText("--", 180 + 260 - 80, winY2 + 60 + 90);
    rightHandFingerIDs[0] = createStaticText("--", 180 + 390 - 10, winY2 + 60 + 90);
    rightHandFingerIDs[1] = createStaticText("--", 180 + 390 + 10, winY2 + 60 + 90 - 20);
    rightHandFingerIDs[2] = createStaticText("--", 180 + 390 + 35, winY2 + 60 + 90 - 40);
    rightHandFingerIDs[3] = createStaticText("--", 180 + 390 + 60, winY2 + 60 + 90 - 20);
    rightHandFingerIDs[4] = createStaticText("--", 180 + 390 + 70, winY2 + 60 + 90);
    mouseCursorID = createDynamicImage(ImageResources.biMouseCursor, 0, 0, 10, 16); 
    visualAttentionCircleID = createDynamicOval(0, 0, ATTENTION_MARKER_DIAMETER,
                                                ATTENTION_MARKER_DIAMETER, Color.RED);
    vocalResponseDisplayID = createStaticText("--", 180, winY2 + 60 + 20);
    
    //test
    //    String id_1 = createStaticText("test1", 150, 200);
    //    setStaticTextString(rightHandFingerIDs[3], "updated text");
    //    removeObject(rightHandFingerIDs[0]);
    //    setDynamicObjectLocation(mouseCursorID, 100, 50);
    //createDynamicText("H", 100, 100);
    //createStaticText("createStaticText", winX1, winY1);
    
  }
  
  //================= paintComponent
  public synchronized void paintComponent(Graphics g) {
    super.paintComponent(g);  // Paint background, border
    if (getWidth() <= 0 || getHeight() <= 0) return;

    double scale = Math.min((double) getWidth() / LOGICAL_WIDTH,
                            (double) getHeight() / LOGICAL_HEIGHT);
    Graphics2D scaled = (Graphics2D) g.create();
    try {
      scaled.translate((getWidth() - LOGICAL_WIDTH * scale) / 2.0,
                       (getHeight() - LOGICAL_HEIGHT * scale) / 2.0);
      scaled.scale(scale, scale);
      scaled.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
      scaled.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
      scaled.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
      // Draw everything in the same logical coordinate system, including the labels.
      scaled.drawLine(winX1, winY1, winX2, winY1);
      scaled.drawLine(winX1, winY1, winX1, winY2);
      scaled.drawLine(winX1, winY2, winX2, winY2);
      scaled.drawLine(winX2, winY1, winX2, winY2);

      scaled.drawImage(ImageResources.biVisual, 0, 0, 30, 30, null);
      scaled.drawImage(ImageResources.biAudio, 0, winY2 + 30, 30, 24, null);
      scaled.drawImage(ImageResources.biVocal, 180, winY2 + 30, 30, 30, null);
      scaled.drawImage(ImageResources.biLeftHand, 180 + 220, winY2 + 30 + 120, 24, 32, null);
      scaled.drawImage(ImageResources.biRightHand, 180 + 220 + 200, winY2 + 30 + 120, 24, 32, null);

      for (Object object : currentAllObjects.values()) {
        if (object instanceof TV2DLabel) {
          TV2DLabel label = (TV2DLabel) object;
          if (!label.hide) label.draw(scaled);
        }
      }

      paintAttentionTrail(scaled, System.nanoTime());

      Iterator<Entry<String, DynamicVisualObjects>> itrEntires = currentDynamicObjects.entrySet().iterator();
      while(itrEntires.hasNext()){
        Entry<String, DynamicVisualObjects> anEntry = itrEntires.next();
        if (anEntry.getKey().equals(visualAttentionCircleID)) continue;
        DynamicVisualObjects anObj = anEntry.getValue();
        if(!anObj.hide)anObj.draw(scaled);
      }
      paintAttentionMarker(scaled);
    } finally {
      scaled.dispose();
    }
  }

  private void paintAttentionTrail(Graphics2D g, long now) {
    expireAttentionHistory(now);
    Graphics2D trail = (Graphics2D) g.create();
    try {
      trail.clipRect(winX1, winY1, winX2 - winX1, winY2 - winY1);
      long cutoff = now - (long) (HEATMAP_HISTORY_SECONDS * NANOS_PER_SECOND);
      int radius = HEATMAP_DIAMETER / 2;

      for (Fixation fixation : fixations) {
        long end = fixation == activeFixation ? now : fixation.endedAt;
        double visibleSeconds = (end - Math.max(fixation.startedAt, cutoff))
                / (double) NANOS_PER_SECOND;
        if (visibleSeconds <= 0) continue;
        int opacity = (int) Math.round(190 * Math.min(1.0,
                visibleSeconds / HEATMAP_SATURATION_SECONDS));
        if (opacity <= 0) continue;
        Paint previousPaint = trail.getPaint();
        trail.setPaint(new RadialGradientPaint(fixation.x + winX1, fixation.y + winY1,
                radius, new float[] {0.0f, 1.0f}, new Color[] {
                  new Color(HEATMAP_COLOR.getRed(), HEATMAP_COLOR.getGreen(),
                            HEATMAP_COLOR.getBlue(), opacity),
                  new Color(HEATMAP_COLOR.getRed(), HEATMAP_COLOR.getGreen(),
                            HEATMAP_COLOR.getBlue(), 0)
                }));
        trail.fillOval(fixation.x + winX1 - radius, fixation.y + winY1 - radius,
                       HEATMAP_DIAMETER, HEATMAP_DIAMETER);
        trail.setPaint(previousPaint);
      }

      trail.setStroke(new BasicStroke(SACCADE_LINE_WIDTH, BasicStroke.CAP_ROUND,
                                      BasicStroke.JOIN_ROUND));
      for (Saccade saccade : saccades) {
        double remaining = 1.0 - (now - saccade.occurredAt)
                / (HEATMAP_HISTORY_SECONDS * NANOS_PER_SECOND);
        int opacity = (int) Math.round(210 * Math.max(0.0, remaining));
        if (opacity <= 0) continue;
        trail.setColor(new Color(SACCADE_LINE_COLOR.getRed(), SACCADE_LINE_COLOR.getGreen(),
                                 SACCADE_LINE_COLOR.getBlue(), opacity));
        trail.drawLine(saccade.fromX + winX1, saccade.fromY + winY1,
                       saccade.toX + winX1, saccade.toY + winY1);
      }
    } finally {
      trail.dispose();
    }
  }

  private void paintAttentionMarker(Graphics2D g) {
    DynamicVisualObjects marker = currentDynamicObjects.get(visualAttentionCircleID);
    if (marker == null || marker.hide || activeFixation == null) return;
    int x = marker.locX + winX1;
    int y = marker.locY + winY1;
    int radius = ATTENTION_MARKER_DIAMETER / 2;
    g.setColor(new Color(255, 255, 255, 210));
    g.fillOval(x - radius, y - radius, ATTENTION_MARKER_DIAMETER, ATTENTION_MARKER_DIAMETER);
    g.setColor(Color.RED);
    g.setStroke(new BasicStroke(4.0f));
    g.drawOval(x - radius, y - radius, ATTENTION_MARKER_DIAMETER, ATTENTION_MARKER_DIAMETER);
    g.fillOval(x - 4, y - 4, 8, 8);
  }

  private void expireAttentionHistory(long now) {
    long cutoff = now - (long) (HEATMAP_HISTORY_SECONDS * NANOS_PER_SECOND);
    while (!fixations.isEmpty() && fixations.peekFirst() != activeFixation
            && fixations.peekFirst().endedAt <= cutoff) {
      fixations.removeFirst();
    }
    while (!saccades.isEmpty() && saccades.peekFirst().occurredAt <= cutoff) {
      saccades.removeFirst();
    }
  }

  private void updateAttentionFixation(int x, int y) {
    long now = System.nanoTime();
    expireAttentionHistory(now);
    if (activeFixation != null && activeFixation.x == x && activeFixation.y == y) return;
    if (activeFixation != null) {
      activeFixation.endedAt = now;
      saccades.addLast(new Saccade(activeFixation.x, activeFixation.y, x, y, now));
    }
    activeFixation = new Fixation(x, y, now);
    fixations.addLast(activeFixation);
    if (!trailRefreshTimer.isRunning()) trailRefreshTimer.start();
  }

  private void endAttentionFixation() {
    if (activeFixation != null) {
      activeFixation.endedAt = System.nanoTime();
      activeFixation = null;
    }
  }
  
  
  
  //========= static (do not move them) objects
  
  
  private class TV2DLabel
  {
    String ID;
    String text;
    int locX;
    int locY;
    Color background;
    boolean hide;
    
    public TV2DLabel (String text, int locX, int locY) {
      this.text = text;
      this.locX = locX;
      this.locY = locY;
      objectCounter++;
      ID = String.valueOf(objectCounter);
      currentAllObjects.put(ID, this);
    }

    public void draw(Graphics2D g) {
      java.awt.Font oldFont = g.getFont();
      java.awt.Font labelFont = UIManager.getFont("Label.font");
      if (labelFont != null) g.setFont(labelFont);
      int height = Math.max(defaultHeightPerChar + 2, g.getFontMetrics().getHeight());
      if (background != null) {
        int width = Math.max(text.length() * (defaultWidthPerChar + 2),
                             g.getFontMetrics().stringWidth(text));
        g.setColor(background);
        g.fillRect(locX, locY, width, height);
      }
      g.setColor(Color.BLACK);
      g.drawString(text, locX, locY + g.getFontMetrics().getAscent());
      g.setFont(oldFont);
    }
    
  }
  
  /**
   * 
   * @param text
   * @param locX, reference to the TaskVisualization2D, upper-left corner
   * @param locY, reference to the TaskVisualization2D, upper-left corner
   * @return
   */
  public synchronized String createStaticText(String text, int locX, int locY){
    TV2DLabel label = new TV2DLabel (text, locX, locY);
    repaint();
    return label.ID;
  }
  
  
  /**
   * 
   * @param ID
   * @param newText
   */
  public synchronized void setStaticTextString (String ID, String newText){
    TV2DLabel label = (TV2DLabel)currentAllObjects.get(ID);
    label.text = newText;
    repaint();
  }
  
  public synchronized void setStaticTextBackgroundColor(String ID, Color color){
    TV2DLabel label = (TV2DLabel)currentAllObjects.get(ID);
    label.background = color;
    repaint();
  }
  
  
  //========== dynamic objects (can move them)
  
  
  private abstract class DynamicVisualObjects {
    int locX; //reference to simulated window (0,0) 
    int locY; //reference to simulated window (0,0)
    String ID;
    Color color = Color.BLACK;
    
    boolean hide = false;
    
    public DynamicVisualObjects() {
      objectCounter++;
      ID = String.valueOf(objectCounter);
      currentAllObjects.put(ID, this);
      currentDynamicObjects.put(ID, this);
    }
    
    public abstract void draw (Graphics g);
  }
  
  private class DynamicText extends DynamicVisualObjects{
    String text;
    
    public DynamicText(String t, int x, int y){
      text = t;
      locX = x;
      locY = y;
    }
    
    public void draw (Graphics g){
      g.setColor(color);
      int heightOffSet = (int) (g.getFontMetrics().getHeight()  / 2); //g.drawString seems to use the bottom left corner of the text as the reference point.
      g.drawString(text, locX + winX1, locY + winY1 + heightOffSet);  //because reference to simulated window (0,0)
    }
    
  }
  
  private class DynamicImage extends DynamicVisualObjects{
    int displayHeight;
    int displayWidth;
    BufferedImage srcImage;
    
    public DynamicImage(BufferedImage bi, int x, int y, int w, int h){
      srcImage = bi;
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;

    }
    
    public void draw (Graphics g){
      g.drawImage(srcImage, locX + winX1, locY + winY1, displayWidth, displayHeight, null);  //because reference to simulated window (0,0)
    }
    
  }
  
  private class DynamicRect extends DynamicVisualObjects{
    int displayWidth;
    int displayHeight;
    
    public DynamicRect(int x, int y, int w, int h){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;

    }
    
    public DynamicRect(int x, int y, int w, int h, Color cl){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;
      color = cl;

    }
    
    public void draw (Graphics g){
      g.setColor(color); 
      g.drawRect(locX + winX1, locY + winY1, displayWidth, displayHeight);  //because reference to simulated window (0,0)
    }
    
  }
  
  private class DynamicOval extends DynamicVisualObjects{
    int displayHeight;
    int displayWidth;
    
    public DynamicOval(int x, int y, int w, int h){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;

    }
    
    public DynamicOval(int x, int y, int w, int h, Color cl){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;
      color = cl;

    }
    
    public void draw (Graphics g){
      g.setColor(color); 
      g.drawOval(locX + winX1, locY + winY1, displayWidth, displayHeight);  //because reference to simulated window (0,0)
    }
    
  }
    
  private class DynamicLine extends DynamicVisualObjects{
    int displayWidth;
    int displayHeight;
    
    public DynamicLine(int x, int y, int w, int h){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;

    }
    
    public DynamicLine(int x, int y, int w, int h, Color cl){
      locX = x;
      locY = y;
      displayWidth = w;
      displayHeight = h;
      color = cl;

    }
    
    public void draw (Graphics g){
      g.setColor(color); 
      g.drawLine(locX + winX1, locY + winY1, locX + winX1 + displayWidth, locY + winY1 + displayHeight);  //because reference to simulated window (0,0)
    }
    
  }
  
  //============= create and set properties of dynamic objects
  
  /**
   * 
   * @param text
   * @param x, upper-left corner, reference to simulated window (0,0)
   * @param y, upper-left corner, reference to simulated window (0,0)
   * @return
   */
  public synchronized String createDynamicText (String text, int x, int y){
    DynamicText dt = new DynamicText (text, x, y);
    repaint();
    //System.out.println("TaskVisualization2D createDynamicText text: " + text);
    return dt.ID;
  }
  
  /**
   * 
   * @param bi
   * @param x, upper-left corner, reference to simulated window (0,0)
   * @param y, upper-left corner, reference to simulated window (0,0)
   * @param w, display width
   * @param h, display height
   * @return
   */
  public synchronized String createDynamicImage (BufferedImage bi, int x, int y, int w, int h){
    DynamicImage di = new DynamicImage (bi, x, y, w, h);
    repaint();
    //System.out.println("TaskVisualization2D createDynamicImage ");
    return di.ID;
  }
  
  public synchronized String createDynamicLine (int x, int y, int w, int h){
    DynamicLine dl = new DynamicLine (x, y, w, h);
    repaint();
    return dl.ID;
  }
  
  public synchronized String createDynamicLine (int x, int y, int w, int h, Color color){
    DynamicLine dl = new DynamicLine (x, y, w, h, color);
    repaint();
    return dl.ID;
  }
  
  
  public synchronized String createDynamicOval (int x, int y, int w, int h){
    DynamicOval dyo = new DynamicOval (x, y, w, h);
    repaint();
    return dyo.ID;
  }
  
  public synchronized String createDynamicOval (int x, int y, int w, int h, Color color){
    DynamicOval dyo = new DynamicOval (x, y, w, h, color);
    repaint();
    return dyo.ID;
  }
  
  public synchronized String createDynamicRect (int x, int y, int w, int h){
    DynamicRect drect = new DynamicRect (x, y, w, h);
    repaint();
    return drect.ID;
  }
  
  public synchronized String createDynamicRect (int x, int y, int w, int h, Color color){
    DynamicRect drect = new DynamicRect (x, y, w, h, color);
    repaint();
    return drect.ID;
  }
  
  public synchronized void setDynamicTextColor (String ID, String colorString){
    if(!currentDynamicObjects.containsKey(ID)){
      System.out.println("ERROR! TaskVisualization2D.setDynamicTextColor has non-existing currentDynamicObjects ID: " + ID);
      return;
    }
    
    DynamicText dt = (DynamicText)currentDynamicObjects.get(ID);
    dt.color = GlobalUtilities.colorStringToColorType(colorString);    
    repaint();
  }
  
  public synchronized void setDynamicObjectLocation (String ID, int x, int y){
    if(!currentDynamicObjects.containsKey(ID)){
      System.out.println("ERROR! TaskVisualization2D.setDynamicObjectLocation has non-existing currentDynamicObjects ID: " + ID);
      return;
    }
    currentDynamicObjects.get(ID).locX = x;
    currentDynamicObjects.get(ID).locY = y;
    if (ID.equals(visualAttentionCircleID)) updateAttentionFixation(x, y);
    repaint();
  }
  
  //============= general methods for all Objects   
  
  public synchronized void removeObject(String ID){
    if(!currentAllObjects.containsKey(ID)){
      System.out.println("ERROR! TaskVisualization2D.removeObject has non-existing currentAllObjects ID: " + ID);
      return;
    }
    
    currentDynamicObjects.remove(ID);
    currentAllObjects.remove(ID);
    repaint();
  }
  
  public synchronized void hideObject(String ID){
    if(!currentAllObjects.containsKey(ID)){
      System.out.println("ERROR! TaskVisualization2D.hideObject has non-existing currentAllObjects ID: " + ID);
      return;
    }
    
    if(currentAllObjects.get(ID) instanceof TV2DLabel){
      ((TV2DLabel)currentAllObjects.get(ID)).hide = true;
    }
    else{ //all dynamic objects
      if(!currentDynamicObjects.containsKey(ID)){
        System.out.println("ERROR! TaskVisualization2D.hideObject has non-existing currentDynamicObjects ID: " + ID);
        return;
      }
      currentDynamicObjects.get(ID).hide = true;
    }

    if (ID.equals(visualAttentionCircleID)) endAttentionFixation();
    
    repaint();
  }
  
  public synchronized void showObject(String ID){
    if(!currentAllObjects.containsKey(ID)){
      System.out.println("ERROR! TaskVisualization2D.showObject has non-existing currentAllObjects ID: " + ID);
      return;
    }
    
    if(currentAllObjects.get(ID) instanceof TV2DLabel){
      ((TV2DLabel)currentAllObjects.get(ID)).hide = false;
    }
    else{ //all dynamic objects
      if(!currentDynamicObjects.containsKey(ID)){
        System.out.println("ERROR! TaskVisualization2D.showObject has non-existing currentDynamicObjects ID: " + ID);
        return;
      }
      currentDynamicObjects.get(ID).hide = false;
    }
    
    repaint();
  }
}
