/**
 * 2013 QN-Java project file
 * 
 */

package qnactr.sim;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import java.util.Hashtable;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.swing.JFrame;

import qnactr.GUI.EntitiesViewer;
import qnactr.GUI.ActrLiveDiagram;
import qnactr.GUI.TaskVisualization2D;
import qnactr.GUI.TaskVisualization3D;
import qnactr.objectDesigner.Entity;
import qnactr.objectDesigner.Chunk;
import qnactr.objectDesigner.Production_Rule;
import qnactr.objectDesigner.Production_Rule_Condition_Action_Item;
//import qnactr.taskInterface.gui.*;
import jmt.engine.QueueNet.Job;
import jmt.engine.QueueNet.NetNode;
import jmt.engine.simEngine.HybridEventQueue;
import jmt.engine.simEngine.SimEvent;
import jmt.engine.simEngine.SimSystem;
import jmt.engine.simEngine.Simulation;
import jmt.engine.simEngine.Simulation.SimNode;

/**
 * each QnactrSimulation object represents an HMI unit
 * @author shicao
 *
 */
public class QnactrSimulation
{
  /**
   * start from 1. Operator ID. defined by # of Regions in JMT network drawing
   */
  public int ID;  
  public Simulation simJMT;
  
  
  public Variables vars = new Variables(this);
  public Functions funs = new Functions(this);
  public ServerLogics logics = new ServerLogics(this);
  public QnactrFiles files = new QnactrFiles(this);
  public PathLogics pathLogics = new PathLogics(this);

  
  public static boolean globalVarInitialized = false;
  public static Hashtable<String, NetNode> globalAllNetNodesTable;

  //ben
  private static final Object entitiesListLock = new Object();
  //ben
  public static LinkedList<Entity> globalAllEntitiesList = new LinkedList<Entity>();
  public static int entityNumber = 1;
  
  public static JFrame frameEntitiesViewer;
  public static EntitiesViewer newContentPaneEntitiesViewer;

  public static JFrame frameTaskVisualization2DViewer;
  public static TaskVisualization2D taskVisualization2D; //currently just one static member may change this to each object has one member

  public static JFrame frameActrLiveDiagramViewer;
  public static volatile ActrLiveDiagram actrLiveDiagram;
  private boolean imaginalWasCleared;
  private boolean retrievalWasCleared;
  private boolean goal1WasCleared;
  private boolean goal2WasCleared;
  private boolean temporalWasCleared;
  private boolean auralWasCleared;
  private boolean auralLocationWasCleared;
  private boolean visualWasCleared;
  private boolean visualLocationWasCleared;
  private int vocalDiagramRequestTag = -1;
  private int manualDiagramRequestTag = -1;
  private int proceduralMatchTag = -1;
  private int proceduralCapturingTag = -1;
  private String proceduralStage = "IDLE";
  private String proceduralLastExecuted = "";
  private final List<ActrLiveDiagram.ProceduralCandidate> proceduralCandidates = new ArrayList<ActrLiveDiagram.ProceduralCandidate>();
  private final List<ActrLiveDiagram.ProceduralCandidate> proceduralSelected = new ArrayList<ActrLiveDiagram.ProceduralCandidate>();
  private final Map<Integer, List<String>> proceduralExecuting = new LinkedHashMap<Integer, List<String>>();
  private final GoalRecency goalRecency = new GoalRecency();
  
  //public TaskInterfaceWindow ucWindow;
  
  public static JFrame frameTaskVisualization3DViewer;
  public static TaskVisualization3D taskVisualization3D; 
  
  final public static int simulatedWindowDefaultSizeX = 2560;
  final public static int simulatedWindowDefaultSizeY = 1440;

  final public static int taskVisualization2DExtendSizeX = 120;
  final public static int taskVisualization2DExtendSizeY = 280;
  
  final public static int taskVisualization3DSizeX = 800;
  final public static int taskVisualization3DSizeY = 600;
  
  public static double simSleepCycle = 0.5; // second of real world time
  public static double simLastShownClock;
  
  public static double simStartRealClockTime; // Millisecond
  public static double simEndRealClockTime; // Millisecond
  public static double simEndSimulationClockTime;
  
  
  ///////////// SETUP Begin///////////////////
  public static boolean entitiesViewerEnable = false; // true or false
  public static boolean taskVisualization2DEnable = true;
  public static boolean actrLiveDiagramEnable = true;
  public static boolean taskVisualization3DEnable = false;
  public static boolean taskInterfaceWindowEnable = false; //TODO, for radar operator tasks
    
  public static double simSpeedFactor = 1; // -1 or any number < 0 means as fast as possible, larger number means faster simulation. N times normal speed.
  public static boolean computeUtilization = true;
  
  ///////////// SETUP end ////////////////////
  
  
  
  



  
  public QnactrSimulation (int id, Simulation simulation){
    
    ID = id; 
    simJMT= simulation; 
    
    //special initialization and re-initialization for static members
    if(!globalVarInitialized){
      globalAllNetNodesTable = new Hashtable<String, NetNode>();
      List<SimNode> nodes = simJMT.getSimNodes();
      
      for (int i = 0; i < nodes.size(); i++) {
        NetNode aNetNode = (nodes.get(i)).getNode();
        String lowerCaseNoSpaceName =  GlobalUtilities.stringLowNoSpace(aNetNode.getName());
        globalAllNetNodesTable.put(lowerCaseNoSpaceName, aNetNode);
      }
      
      //reset these before each simulation run
      globalAllEntitiesList = new LinkedList<Entity>();
      entityNumber = 1;
      simLastShownClock = 0.0;
      
      globalVarInitialized = true;
    }
    
  }

  
  public static void globalAllEntitiesListAddLast(Entity anEntity){
    //ben
    synchronized(entitiesListLock){
      QnactrSimulation.globalAllEntitiesList.addLast( anEntity );
    }
    //ben

    if(entitiesViewerEnable){
      //here update EntitiesViewer's data model
        newContentPaneEntitiesViewer.updateModelData(QnactrSimulation.globalAllEntitiesList);
    }
  }
  
  public static void createAndShowEntitiesViewerGUI() {
    
    frameEntitiesViewer = new JFrame("EntitiesViewer");
    frameEntitiesViewer.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);

    newContentPaneEntitiesViewer = new EntitiesViewer();
    newContentPaneEntitiesViewer.setOpaque(true); //content panes must be opaque
    frameEntitiesViewer.setContentPane(newContentPaneEntitiesViewer);

    frameEntitiesViewer.pack();
    frameEntitiesViewer.setLocationByPlatform(true);
    frameEntitiesViewer.setVisible(true);
}
  
  public void createAndShowTaskInterfaceWindowGUI() {
//	  ucWindow=new TaskInterfaceWindow(this);
//	  ucWindow.setVisible(true);
  }
  
  public static void createAndShowTaskVisualization2DViewerGUI() {
    frameTaskVisualization2DViewer  = new JFrame("TaskVisualization2DViewer");
    frameTaskVisualization2DViewer.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
    
    taskVisualization2D = new TaskVisualization2D();
    taskVisualization2D.setOpaque(true); //content panes must be opaque
    frameTaskVisualization2DViewer.setContentPane(taskVisualization2D);

    frameTaskVisualization2DViewer.pack();
    Rectangle usableScreen = GraphicsEnvironment.getLocalGraphicsEnvironment().getMaximumWindowBounds();
    frameTaskVisualization2DViewer.setSize(Math.min(1200, usableScreen.width),
                                           Math.min(800, usableScreen.height));
    frameTaskVisualization2DViewer.setLocationByPlatform(true);
    frameTaskVisualization2DViewer.setVisible(true);
  }

  public static void createAndShowActrLiveDiagramViewerGUI() {
    frameActrLiveDiagramViewer = new JFrame("ACT-R Live Diagram");
    frameActrLiveDiagramViewer.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);

    actrLiveDiagram = new ActrLiveDiagram();
    frameActrLiveDiagramViewer.setContentPane(actrLiveDiagram);
    frameActrLiveDiagramViewer.pack();
    Rectangle usableScreen = GraphicsEnvironment.getLocalGraphicsEnvironment().getMaximumWindowBounds();
    frameActrLiveDiagramViewer.setSize(Math.min(760, usableScreen.width),
                                       Math.min(860, usableScreen.height));
    frameActrLiveDiagramViewer.setLocationByPlatform(true);
    frameActrLiveDiagramViewer.setVisible(true);
  }

  /** Called after an imaginal transition, while the simulation still owns its mutable state. */
  public void publishImaginalDiagram(boolean cleared) {
    if (cleared) imaginalWasCleared = true;
    if (!vars.imaginalBuffer.Empty) imaginalWasCleared = false;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateImaginal(vars.imaginalBuffer, vars.imaginaryModule, imaginalWasCleared);
    }
  }

  public void resetImaginalDiagram() {
    imaginalWasCleared = false;
    publishImaginalDiagram(false);
  }

  /** Publish a retrieval transition from the simulation thread. */
  public void publishRetrievalDiagram(boolean cleared) {
    if (cleared) retrievalWasCleared = true;
    if (!vars.retrievalBuffer.Empty || vars.declarativeModule.State_Error) retrievalWasCleared = false;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateRetrieval(vars.retrievalBuffer, vars.declarativeModule, retrievalWasCleared);
    }
  }

  public void resetRetrievalDiagram() {
    retrievalWasCleared = false;
    publishRetrievalDiagram(false);
  }

  /** One shade step per simulation time; changes to both goals at that time share the newest shade. */
  public void publishGoalDiagram(int goalIndex, boolean cleared) {
    goalRecency.mark(goalIndex, SimSystem.clock());
    if (goalIndex == 1) {
      if (cleared) goal1WasCleared = true;
    } else {
      if (cleared) goal2WasCleared = true;
    }
    if (hasGoalChunk(vars.goalBuffer.Goal_Buffer_Chunk)) goal1WasCleared = false;
    if (hasGoalChunk(vars.goalBuffer.Goal_Buffer_Chunk_2)) goal2WasCleared = false;
    publishGoalSnapshot();
  }

  /** Reset either goal (1 or 2), or both (0), without marking a user-visible update. */
  public void resetGoalDiagram(int goalIndex) {
    goalRecency.reset(goalIndex);
    if (goalIndex == 0 || goalIndex == 1) {
      goal1WasCleared = false;
    }
    if (goalIndex == 0 || goalIndex == 2) {
      goal2WasCleared = false;
    }
    publishGoalSnapshot();
  }

  static final class GoalRecency {
    int first;
    int second;
    private double lastClock = Double.NaN;

    void mark(int goalIndex, double clock) {
      if (goalIndex != 1 && goalIndex != 2) throw new IllegalArgumentException("goalIndex");
      if (Double.compare(clock, lastClock) != 0) {
        first = Math.max(0, first - 1);
        second = Math.max(0, second - 1);
        lastClock = clock;
      }
      if (goalIndex == 1) first = 5;
      else second = 5;
    }

    void reset(int goalIndex) {
      if (goalIndex != 0 && goalIndex != 1 && goalIndex != 2) {
        throw new IllegalArgumentException("goalIndex");
      }
      if (goalIndex == 0 || goalIndex == 1) first = 0;
      if (goalIndex == 0 || goalIndex == 2) second = 0;
      lastClock = Double.NaN;
    }
  }

  private static boolean hasGoalChunk(Chunk chunk) {
    return chunk != null && (!chunk.Chunk_Name.isEmpty() || !chunk.Chunk_Type.isEmpty());
  }

  private void publishGoalSnapshot() {
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateGoals(vars.goalBuffer.Goal_Buffer_Chunk, vars.goalBuffer.Goal_Buffer_Chunk_2,
                          goal1WasCleared, goal2WasCleared, goalRecency.first, goalRecency.second);
    }
  }

  /** Publish the temporal buffer after a request, tick, modification, or clear. */
  public void publishTemporalDiagram(boolean cleared) {
    if (cleared) temporalWasCleared = true;
    if (!vars.temporalBuffer.Empty) temporalWasCleared = false;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateTemporal(vars.temporalBuffer, temporalWasCleared);
    }
  }

  /** Capture both audio buffers and the common audio-module state after a transition. */
  public void publishAudioDiagram(boolean auralCleared, boolean locationCleared) {
    if (auralCleared) auralWasCleared = true;
    if (locationCleared) auralLocationWasCleared = true;
    if (hasGoalChunk(vars.auralBuffer.Aural_Buffer_Chunk)) auralWasCleared = false;
    if (!vars.auralLocationBuffer.Empty) auralLocationWasCleared = false;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateAudio(vars.auralBuffer, vars.auralLocationBuffer, vars.audioModule,
                          auralWasCleared, auralLocationWasCleared);
    }
  }

  public void resetAudioDiagram() {
    auralWasCleared = false;
    auralLocationWasCleared = false;
    publishAudioDiagram(false, false);
  }

  /** Capture both visual buffers after stuffing, a request, a modification, or a clear. */
  public void publishVisualDiagram(boolean visualCleared, boolean locationCleared) {
    if (visualCleared) visualWasCleared = true;
    if (locationCleared) visualLocationWasCleared = true;
    if (hasGoalChunk(vars.visualBuffer.Visual_Buffer_Chunk) || vars.visionModule.State_Error) {
      visualWasCleared = false;
    }
    if (!vars.visualLocationBuffer.Empty || vars.visualLocationBuffer.State_Error) {
      visualLocationWasCleared = false;
    }
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateVisual(vars.visualBuffer, vars.visualLocationBuffer, vars.visionModule,
                           visualWasCleared, visualLocationWasCleared);
    }
  }

  public void resetVisualDiagram() {
    visualWasCleared = false;
    visualLocationWasCleared = false;
    publishVisualDiagram(false, false);
  }

  /** Track the newest vocal request so an older completion cannot replace a newer command. */
  public void publishVocalDiagram(int requestTag, String stage, Chunk command) {
    if (requestTag < vocalDiagramRequestTag) return;
    vocalDiagramRequestTag = requestTag;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateVocal(stage, command, vars.vocalBuffer, vars.speechModule);
    }
  }

  public void resetVocalDiagram() {
    vocalDiagramRequestTag = -1;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateVocal("IDLE", null, vars.vocalBuffer, vars.speechModule);
    }
  }

  /** Track the newest manual request independently of overlapping older movements. */
  public void publishManualDiagram(int requestTag, String stage, Chunk command) {
    if (requestTag < manualDiagramRequestTag) return;
    manualDiagramRequestTag = requestTag;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateManual(stage, command, vars.manualBuffer, vars.motorModule);
    }
  }

  public void resetManualDiagram() {
    manualDiagramRequestTag = -1;
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (actrLiveDiagramEnable && diagram != null) {
      diagram.updateManual("IDLE", null, vars.manualBuffer, vars.motorModule);
    }
  }

  public void resetProceduralDiagram() {
    proceduralMatchTag = -1;
    proceduralCapturingTag = -1;
    proceduralStage = "IDLE";
    proceduralLastExecuted = "";
    proceduralCandidates.clear();
    proceduralSelected.clear();
    proceduralExecuting.clear();
    publishProceduralSnapshot();
  }

  public void beginProceduralDiagram(int entityTag) {
    proceduralCapturingTag = entityTag;
    if (entityTag < proceduralMatchTag) return;
    proceduralMatchTag = entityTag;
    proceduralStage = "MATCHING";
    proceduralCandidates.clear();
    proceduralSelected.clear();
    publishProceduralSnapshot();
  }

  /** Called by the existing selector after it has calculated noise and thread offsets. */
  public void recordProceduralSelection(List<Production_Rule> matches, Production_Rule chosen,
                                        Hashtable offsets) {
    if (proceduralCapturingTag != proceduralMatchTag) return;
    ActrLiveDiagram.ProceduralCandidate selectedCandidate = null;
    for (Production_Rule rule : matches) {
      String name = rule.Rule_Name;
      double base = proceduralBaseUtility(name);
      double finalValue = numberOrNaN(vars.utilityModule.utility.get(name));
      Object offset = offsets.get(name + rule.Condition_Part_Goal_X_Reference);
      double offsetValue = numberOrNaN(offset);
      if (Double.isFinite(finalValue) && Double.isFinite(offsetValue)) finalValue += offsetValue;
      ActrLiveDiagram.ProceduralCandidate candidate = new ActrLiveDiagram.ProceduralCandidate(
          name, rule.Condition_Part_Goal_X_Reference, base, finalValue, proceduralLhsBuffers(rule));
      proceduralCandidates.add(candidate);
      if (chosen != null && name.equals(chosen.Rule_Name)
          && rule.Condition_Part_Goal_X_Reference.equals(chosen.Condition_Part_Goal_X_Reference)) {
        selectedCandidate = candidate;
      }
    }
    if (selectedCandidate != null && !selectedCandidate.name.equals("nil")) {
      proceduralSelected.add(selectedCandidate);
      proceduralStage = "SELECTED";
    } else {
      proceduralStage = "NO MATCH";
    }
    publishProceduralSnapshot();
  }

  private static List<String> proceduralLhsBuffers(Production_Rule rule) {
    Set<String> buffers = new LinkedHashSet<String>();
    for (Production_Rule_Condition_Action_Item condition : rule.Condition) {
      // Both chunk tests and buffer-state queries participate in LHS matching.
      if (!"=".equals(condition.Type) && !"?".equals(condition.Type)) continue;
      String buffer = condition.Buffer_Name;
      if ("goal-x".equals(buffer)) buffer = rule.Condition_Part_Goal_X_Reference;
      if (buffer != null && !buffer.isEmpty()) buffers.add(buffer);
    }
    return new ArrayList<String>(buffers);
  }

  private double proceduralBaseUtility(String name) {
    Object base;
    if (vars.utilityModule.utility_Computation_Method.equals("PG-C")) {
      base = vars.centralParametersModule.esc
          ? vars.utilityModule.pg_c.get(name) : vars.utilityModule.PG_C_value.get(name);
    } else {
      base = vars.utilityModule.U_N_Without_Noise.get(name);
    }
    return numberOrNaN(base);
  }

  private static double numberOrNaN(Object value) {
    if (value == null || "nil".equals(value)) return Double.NaN;
    try {
      return Double.parseDouble(value.toString());
    } catch (NumberFormatException ignored) {
      return Double.NaN;
    }
  }

  public void finishProceduralMatch(int entityTag) {
    if (entityTag != proceduralMatchTag) return;
    if (proceduralSelected.isEmpty()) proceduralStage = "NO MATCH";
    publishProceduralSnapshot();
  }

  public void beginProceduralExecution(int entityTag, List<Production_Rule> rules) {
    if (rules == null || rules.isEmpty()) return;
    List<String> names = new ArrayList<String>();
    for (Production_Rule rule : rules) {
      names.add(rule.Condition_Part_Goal_X_Reference.isEmpty() ? rule.Rule_Name
          : rule.Rule_Name + " [" + rule.Condition_Part_Goal_X_Reference + "]");
    }
    proceduralExecuting.put(entityTag, names);
    publishProceduralSnapshot();
  }

  public void finishProceduralExecution(int entityTag) {
    List<String> finished = proceduralExecuting.remove(entityTag);
    if (finished != null) proceduralLastExecuted = String.join(", ", finished);
    if (finished != null && entityTag == proceduralMatchTag && proceduralExecuting.isEmpty()) {
      proceduralStage = "COMPLETE";
    }
    publishProceduralSnapshot();
  }

  private void publishProceduralSnapshot() {
    ActrLiveDiagram diagram = actrLiveDiagram;
    if (!actrLiveDiagramEnable || diagram == null) return;
    List<String> executing = new ArrayList<String>();
    for (List<String> names : proceduralExecuting.values()) executing.addAll(names);
    diagram.updateProcedural(executing.isEmpty() ? proceduralStage : "EXECUTING",
        proceduralCandidates, proceduralSelected, executing, proceduralLastExecuted);
  }
  
  public static void createAndShowTaskVisualization3DViewerGUI() {
    frameTaskVisualization3DViewer  = new JFrame("TaskVisualization3DViewer");
    frameTaskVisualization3DViewer.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
    
    taskVisualization3D = new TaskVisualization3D();
    taskVisualization3D.setOpaque(true); //content panes must be opaque
    frameTaskVisualization3DViewer.setContentPane(taskVisualization3D);

    frameTaskVisualization3DViewer.pack();
    frameTaskVisualization3DViewer.setLocationByPlatform(true);
    frameTaskVisualization3DViewer.setVisible(true);
    
    int x = taskVisualization3DSizeX;
    int y = taskVisualization3DSizeY;
    
    frameTaskVisualization3DViewer.setSize(x, y);
    frameTaskVisualization3DViewer.setBackground(Color.WHITE);
  }
  
  
  public static LinkedList<Entity> getAllEntitiesCarriedBySimEventsAtCurrentClock(){
    LinkedList<Entity> returnList = new LinkedList<Entity>();
    LinkedList<Integer> entityTags = new LinkedList<Integer>();
    
    Iterator<SimEvent> itrEvents = ((HybridEventQueue)SimSystem.getFutureQueue()).getCurrentList().iterator();
    while(itrEvents.hasNext()){
      SimEvent anEvent = itrEvents.next();
      if(anEvent.eventTime() == SimSystem.clock()){
        Job job = (Job)anEvent.getData();
        Entity entity = job.qnactrEntity;
        if(!entityTags.contains(entity.Tag)){
          entityTags.addLast(entity.Tag);
          returnList.addLast(entity);
        }
      }
      
    }
    
    return returnList;
  }
  
  public static LinkedList<Entity> getAllEntitiesCarriedBySimEventsAtCurrentClockNoTrash(){
    LinkedList<Entity> returnList = new LinkedList<Entity>();
    LinkedList<Integer> entityTags = new LinkedList<Integer>();
    
    Iterator<SimEvent> itrEvents = ((HybridEventQueue)SimSystem.getFutureQueue()).getCurrentList().iterator();
    while(itrEvents.hasNext()){
      SimEvent anEvent = itrEvents.next();
      if(anEvent.eventTime() == SimSystem.clock()){
        Job job = (Job)anEvent.getData();
        
        if(job == null) 
        	continue;
        
        Entity entity = job.qnactrEntity;
        if(!entityTags.contains(entity.Tag) && !entity.Trash){
          entityTags.addLast(entity.Tag);
          returnList.addLast(entity);
        }
      }
      
    }
    
    return returnList;
  }
  
  public static LinkedList<Entity> getNotEndedGlobalAllEntitiesList(){
    LinkedList<Entity> returnList = new LinkedList<Entity>();
    //ben
    synchronized(entitiesListLock){
      for(Entity anEntity : globalAllEntitiesList){
        if(!anEntity.Trash) returnList.addLast(anEntity);
      }
    }
    //ben
    return returnList;
  }
  
}
