package qnactr.GUI;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Path2D;
import java.awt.geom.RoundRectangle2D;

import javax.swing.JPanel;

/** Static Swing rendering of the 700 x 800 ACT-R live-diagram mock-up. */
public class ActrLiveDiagram extends JPanel {
  private static final int DESIGN_WIDTH = 700;
  private static final int DESIGN_HEIGHT = 800;
  private static final Color BACKGROUND = new Color(0xEDEDED);
  private static final Color MODULE = new Color(0xD9D9D9);
  private static final Color OUTLINE = Color.BLACK;
  private static final Font LABEL_FONT = new Font(Font.SANS_SERIF, Font.PLAIN, 9);
  private static final Font TITLE_FONT = new Font(Font.SANS_SERIF, Font.PLAIN, 12);
  private static final Font DETAIL_FONT = new Font(Font.SANS_SERIF, Font.PLAIN, 8);

  public ActrLiveDiagram() {
    setBackground(Color.WHITE);
    setPreferredSize(new Dimension(DESIGN_WIDTH, DESIGN_HEIGHT));
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
    module(g, "IMAGINAL", 60, 40, 160, 170);
    box(g, 70, 60, 140, 140);
    detail(g, "CHUNK X", 74, 73);
    detail(g, "slot", 74, 82);
    detail(g, "value", 161, 82);

    module(g, "GOAL", 240, 17, 220, 180);
    box(g, 250, 40, 200, 70);
    box(g, 250, 120, 200, 70);
    detail(g, "GOAL - 1", 253, 51);
    detail(g, "GOAL - 2", 253, 131);

    module(g, "RETRIEVAL", 480, 40, 160, 170);
    box(g, 490, 60, 140, 140);
    detail(g, "CHUNK X", 494, 73);
    detail(g, "slot", 494, 82);
    detail(g, "value", 581, 82);

    module(g, "VISUAL-LOCATION", 180, 240, 90, 90);
    circle(g, 225, 285, 34.5);
    detail(g, "ITEM: airspeed", 196, 283);
    detail(g, "X:# Y:#", 210, 293);

    module(g, "VISUAL", 430, 240, 90, 90);
    circle(g, 475, 285, 34.5);
    detail(g, "CONTENT:", 454, 284);

    module(g, "TEMPORAL", 580, 221, 90, 64);
    detail(g, "TICK", 615, 258);

    module(g, "AURAL-LOCATION", 0, 295, 90, 165);
    detail(g, "location:", 9, 339);
    module(g, "AURAL", 610, 295, 90, 165);
    detail(g, "content:", 619, 339);
  }

  private void drawConflictResolution(Graphics2D g) {
    box(g, 150, 375, 400, 170);
    centered(g, "CONFLICT-RESOLUTION", 150, 375, 400, TITLE_FONT, 390);

    candidate(g, 174, 395, new Color(255, 0, 0, 25));
    candidate(g, 295, 395, new Color(255, 0, 0, 50));
    candidate(g, 416, 395, new Color(255, 0, 0, 125));

    box(g, 170, 445, 360, 30);
    centered(g, "SELECTED: p-check-task  U=##", 170, 445, 360, DETAIL_FONT, 463);
    arrow(g, false, true, 350, 426, 350, 445);

    box(g, 170, 495, 360, 30);
    centered(g, "EXECUTION: p-check-task", 170, 495, 360, DETAIL_FONT, 513);
    Path2D bolt = new Path2D.Double();
    bolt.moveTo(421, 500);
    bolt.lineTo(414, 510);
    bolt.lineTo(419, 510);
    bolt.lineTo(417, 520);
    bolt.lineTo(425, 507);
    bolt.lineTo(420, 507);
    bolt.closePath();
    g.setColor(OUTLINE);
    g.fill(bolt);
    arrow(g, false, true, 350, 475, 350, 495);
  }

  private void drawOutputs(Graphics2D g) {
    module(g, "VOCAL", 235, 590, 230, 70);
    detail(g, "CMD:", 241, 630);
    detail(g, "string:", 241, 640);

    module(g, "MANUAL", 286, 723, 230, 70);
    detail(g, "CMD:", 292, 769);
    detail(g, "string:", 292, 779);

    g.setColor(OUTLINE);
    g.setFont(TITLE_FONT);
    g.drawString("QN-ACTR-HAT", 30, 759);
    g.drawString("model loaded: takeoff", 10, 775);
  }

  private void candidate(Graphics2D g, double x, double y, Color fill) {
    g.setColor(fill);
    g.fill(new java.awt.geom.Rectangle2D.Double(x, y, 110, 20));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.draw(new java.awt.geom.Rectangle2D.Double(x, y, 110, 20));
    centered(g, "p-check-task    U=##", x, y, 110, DETAIL_FONT, y + 13);
  }

  private void module(Graphics2D g, String name, double x, double y, double width, double height) {
    g.setColor(MODULE);
    g.fill(new RoundRectangle2D.Double(x, y, width, height, 10, 10));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
    g.draw(new RoundRectangle2D.Double(x, y, width, height, 10, 10));
    centered(g, name, x, y, width, LABEL_FONT, y + 12);
  }

  private void box(Graphics2D g, double x, double y, double width, double height) {
    g.setColor(MODULE);
    g.fill(new java.awt.geom.Rectangle2D.Double(x, y, width, height));
    g.setColor(OUTLINE);
    g.setStroke(new BasicStroke(0.5f));
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
