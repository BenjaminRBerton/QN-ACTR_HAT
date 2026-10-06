package agents.cb;

import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

import jmt.gui.jmodel.mainGui.MainWindow;
//import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.Level;

import com.ingescape.*;
import qnactr.sim.QnactrSimulation;
import jmt.engine.simEngine.SimSystem;
import jmt.gui.jmodel.controller.Mediator;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Agent implements IopListener, ServiceListener {
    //private static Logger _logger = LoggerFactory.getLogger(Agent.class);
    static {
        Logger ingescapeLogger = (Logger) LoggerFactory.getLogger("com.ingescape");
        ingescapeLogger.setLevel(Level.WARN);
    }

    private static Agent instance = null;
    private QnactrSimulation simulation = null;
    private Mediator mediator = null;
    private static final float INTERVAL_BETWEEN_WORDS = 3.00f; // seconds
    private static final String[] CYUL_RUNWAY_NAMES = {"06L", "06R", "24R", "24L"};
    private static final double[][] CYUL_RUNWAY_THRESHOLDS = {
            {45.461222, -73.76474},  // 06L
            {45.457832, -73.741171}, // 06R
            {45.483156, -73.73607},  // 24R
            {45.476887, -73.716188}  // 24L
    };

    // Public accessible attributes that other classes can read
    public volatile float airspeed_i = 0.0f;
    public volatile float altitude_i = 0.0f;
    public volatile float pitch_i = 0.0f;
    public volatile float roll_i = 0.0f;
    public volatile float heading_i = 0.0f;
    public volatile float elevator_i = 0.0f;
    public volatile float rudder_i = 0.0f;
    public volatile float aileron_i = 0.0f;
    public volatile float l_throttle_i = 0.0f;
    public volatile float r_throttle_i = 0.0f;
    public volatile float slip_i = 0.0f;
    public volatile float vertical_speed_i = 0.0f;
    public volatile float flaps_i = 0.0f;
    public volatile float landing_gear_i = 0.0f;
    public volatile float spoilers_i = 0.0f;
    public volatile float e1_n1_i = 0.0f;
    public volatile float e2_n1_i = 0.0f;
    public volatile float baro_setting_i = 0.0f;
    public volatile float cabin_alt_i = 0.0f;
    public volatile float l_gen_load_i = 0.0f;
    public volatile float r_gen_load_i = 0.0f;
    public volatile float trim_rudder_i = 0.0f;
    public volatile float radio_frequency_i = 0.0f;
    public volatile Double latitude_i = null;
    public volatile Double longitude_i = null;
    public volatile String current_runway = null;

    // For boolean inputs
    public volatile boolean l_bottle_arm_i = false;
    public volatile boolean r_bottle_arm_i = false;
    public volatile boolean pitot_heat_i = false;
    public volatile boolean l_eng_ai_i = false;
    public volatile boolean r_eng_ai_i = false;
    public volatile boolean l_windsh_ai_i = false;
    public volatile boolean r_windsh_ai_i = false;
    public volatile boolean l_engine_fire_i = false;
    public volatile boolean r_engine_fire_i = false;
    public volatile boolean parking_brake_i = true;
    public volatile boolean n1_match_bug_i = false;
    public volatile boolean master_warning_i = false;
    public volatile boolean master_caution_i = false;
    public volatile boolean yaw_damper_i = false;
    public volatile boolean l_ign_switch_i = false;
    public volatile boolean r_ign_switch_i = false;
    public volatile boolean TARS_is_speaking_i = false;
    public volatile boolean birds_i = false;
    public volatile boolean anti_coll_lights_i = false;

    // For string inputs - using AtomicReference for thread-safe string operations
    private final AtomicReference<String> ATC_msg_i = new AtomicReference<>("");
    private final AtomicReference<String> TARS_msg_i = new AtomicReference<>("");
    private final AtomicReference<String> current_procedure_i = new AtomicReference<>("IDLE");
    private final AtomicReference<String> current_task_object_i = new AtomicReference<>("Idle");
    private final AtomicReference<String> current_task_value_i = new AtomicReference<>("waiting");
    private final AtomicReference<String> current_task_autonomy_role_i = new AtomicReference<>("na");
    private final AtomicReference<String> current_task_human_role_i = new AtomicReference<>("na");
    private final AtomicReference<String> next_state_i = new AtomicReference<>("");
    private final AtomicReference<String> previous_state_i = new AtomicReference<>("");
    private final AtomicReference<String> interaction_message_i = new AtomicReference<>("");

    // For integer inputs
    public volatile int pax_safety_i = 0;
    public volatile int flight_director_i = 0;
    public volatile int flc_mode_i = 0;
    public volatile int heading_mode_i = 0;
    public volatile int l_fuel_boost_i = 0;
    public volatile int r_fuel_boost_i = 0;
    public volatile int test_knob_i = 0;
    public volatile int heading_sel_i = 0;
    public volatile int alt_sel_i = 0;
    public volatile int l_gen_switch_i = 0;
    public volatile int r_gen_switch_i = 0;
    public volatile int chrono_time_i = 0;
    public volatile int runway_centerline_deviation_i = 0;
    public volatile int heading_deviation_i = 0;
    public volatile int lateral_deviation_i = 0;
    public volatile int transfer_knob_i = 0;
    public volatile int landing_lights_i = 0;
    // Add more as needed...

    private com.ingescape.Agent ingescapeAgent;
    private Global globalContext;

    private Agent() {
        // Empty constructor - initialization happens in start()
    }

    public static Agent getInstance() {
        if (instance == null) {
            instance = new Agent();
        }
        return instance;
    }

    public void setSimulation(QnactrSimulation sim) {
        this.simulation = sim;
    }

    // Getter methods for thread-safe string access
    public String getATCMsg() {
        return ATC_msg_i.get();
    }

    public String getCurrentProcedure() {
        return current_procedure_i.get();
    }

    public String getCurrentTaskObject() {
        return current_task_object_i.get();
    }

    public String getCurrentTaskValue() {
        return current_task_value_i.get();
    }

    public String getCurrentTaskAutonomyRole() {
        return current_task_autonomy_role_i.get();
    }

    public String getCurrentTaskHumanRole() {
        return current_task_human_role_i.get();
    }

    public String getNextState() {
        return next_state_i.get();
    }

    public String getPreviousState() {
        return previous_state_i.get();
    }

    public String getInteractionMessage() {
        return interaction_message_i.get();
    }

    /**
     * Get the "message" field from the interaction message JSON
     * @return the message content, or empty string if not found or invalid JSON
     */
    public String getInteractionMessageField() {
        return getInteractionMessageField("message");
    }

    /**
     * Get the "tars_input" field from the interaction message JSON
     * @return the tars_input content, or empty string if not found or invalid JSON
     */
    public String getInteractionTarsInput() {
        return getInteractionMessageField("tars_input");
    }

    /**
     * Get a specific field from the interaction message JSON
     * @param fieldName the name of the field to extract ("message" or "tars_input")
     * @return the field content, or empty string if not found or invalid JSON
     */
    private String getInteractionMessageField(String fieldName) {
        String jsonString = interaction_message_i.get();
        if (jsonString == null || jsonString.isEmpty()) {
            return "";
        }

        try {
            JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
            if (jsonObject.has(fieldName)) {
                String returnString = jsonObject.get(fieldName).getAsString();
                returnString = returnString.replace(".", ""); // Remove periods
                returnString = returnString.replace(",", ""); // Remove commas
                return returnString;
            }
        } catch (Exception e) {
            // Invalid JSON or field not found, return empty string
            return "";
        }

        return "";
    }
    /**
     * Start the Ingescape agent and register it with the simulation
     * @param mainWindow The main window that implements event listeners
     * @param mediator The mediator for controlling simulation lifecycle
     */
    public synchronized void start(MainWindow mainWindow, Mediator mediator) {
        //prevent multiple starts
        if (ingescapeAgent != null) {
            //_logger.warn("IngeScape agent is already started");
            return;
        }

        // Store the mediator reference for simulation control
        this.mediator = mediator;

        //_logger.info("Starting IngeScape agent...");

        try {
            // Create global context
            globalContext = new Global("ws://localhost:9009");
            //globalContext = new Global("ws://192.168.0.13:9009");
            globalContext.observeWebSocketEvents(mainWindow);

            // Create the Ingescape agent
            ingescapeAgent = globalContext.agentCreate("Cognitive_Model_Agent");
            ingescapeAgent.observeAgentEvents(mainWindow);

            // Set agent metadata
            ingescapeAgent.definition.setName("Cognitive_Model");
            ingescapeAgent.definition.setDescription("QN-ACTR model of the Single Pilot");
            ingescapeAgent.definition.setVersion("1.0");

            // Create inputs
            createInputs();

            // Observe inputs (register callbacks)
            observeInputs();

            // Create outputs
            createOutputs();

            // Start the agent
            ingescapeAgent.start();

            //_logger.info("IngeScape agent started successfully");

        } catch (Exception e) {
            //_logger.error("Failed to start IngeScape agent", e);
        }
    }

    /**
     * Create all input definitions
     */
    private void createInputs() {
        ingescapeAgent.definition.inputCreate("reset", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.inputCreate("airspeed", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("latitude", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("longitude", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("elevator", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("aileron", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_throttle", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_throttle", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("pitch", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("roll", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("slip", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("heading", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("vertical_speed", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("altitude", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("flaps", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("landing_gear", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("spoilers", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("parking_brake", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("n1_match_bug", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("pax_safety", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("master_warning", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("master_caution", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("flight_director", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("flc_mode", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("heading_mode", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("l_fuel_boost", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("r_fuel_boost", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("test_knob", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("heading_sel", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("alt_sel", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("yaw_damper", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("l_ign_switch", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("r_ign_switch", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("l_gen_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("r_gen_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("transfer_knob", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("e1_n1", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("e2_n1", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_engine_fire", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("r_engine_fire", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("baro_setting", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("cabin_alt", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_gen_load", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_gen_load", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("pitot_heat", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("l_eng_ai", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("r_eng_ai", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("l_windsh_ai", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("r_windsh_ai", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("landing_lights", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("anti_coll_lights", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("trim_rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_bottle_arm", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("r_bottle_arm", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("radio_frequency", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("ATC_speech", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_procedure", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_task_object", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_task_value", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_task_autonomy_role", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_task_human_role", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("next_state", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("previous_state", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("interaction_message", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("chrono_time", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("runway_centerline_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("heading_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("lateral_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("birds", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.inputCreate("TARS_speech", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("TARS_is_speaking", IopType.IGS_BOOL_T);
    }

    /**
     * Register observers for all inputs
     */
    private void observeInputs() {
        String[] inputNames = {
                "reset", "airspeed", "latitude", "longitude", "elevator", "rudder", "aileron", "l_throttle", "r_throttle",
                "pitch", "roll", "slip", "heading", "vertical_speed", "altitude",
                "flaps", "landing_gear", "spoilers", "parking_brake", "n1_match_bug",
                "pax_safety", "master_warning", "master_caution", "flight_director",
                "flc_mode", "heading_mode", "l_fuel_boost", "r_fuel_boost", "test_knob",
                "heading_sel", "alt_sel", "yaw_damper", "l_ign_switch", "r_ign_switch",
                "l_gen_switch", "r_gen_switch", "transfer_knob", "e1_n1", "e2_n1",
                "l_engine_fire", "r_engine_fire", "baro_setting", "cabin_alt",
                "l_gen_load", "r_gen_load", "pitot_heat", "l_eng_ai", "r_eng_ai",
                "l_windsh_ai", "r_windsh_ai", "landing_lights", "anti_coll_lights",
                "trim_rudder", "l_bottle_arm", "r_bottle_arm", "radio_frequency",
                "ATC_speech", "current_procedure", "current_task_object", "current_task_value",
                "current_task_autonomy_role", "current_task_human_role","next_state",
                "previous_state", "interaction_message", "chrono_time",
                "runway_centerline_deviation", "heading_deviation", "lateral_deviation",
                "birds", "TARS_speech", "TARS_is_speaking"
        };

        for (String name : inputNames) {
            ingescapeAgent.observeInput(name, this);
        }
    }

    /**
     * Create all output definitions
     */
    private void createOutputs() {
        ingescapeAgent.definition.outputCreate("elevator", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("aileron", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("throttle", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("park_brake", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("alt_sel", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("heading_sel", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("l_throttle", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("r_throttle", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("flaps", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("landing_gear", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("pax_safety", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("flight_director", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("speed_mode_toggle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("heading_mode_toggle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("autopilot", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_fuel_boost", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("r_fuel_boost", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("test_knob", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("yaw_damper", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_ign_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("r_ign_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("l_gen_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("r_gen_switch", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("transfer_knob", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("baro_setting", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("pitot_heat", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("l_engine_anti_ice", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("r_engine_anti_ice", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("l_windshield_anti_ice", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("r_windshield_anti_ice", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("landing_lights", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.outputCreate("anti_coll_lights", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("trim_rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("l_bottle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_bottle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("master_warning", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("master_caution", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("vocal_command", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("speech_output", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("l_eng_fire_switch", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_eng_fire_switch", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_approve", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_check", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_cancel", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("push_to_talk", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("production_selected", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("start", IopType.IGS_BOOL_T);
        ingescapeAgent.definition.outputCreate("runway_number", IopType.IGS_STRING_T);
    }

    public void outputSetString(String name, String value) {
        if (ingescapeAgent != null) {
            ingescapeAgent.outputSetString(name, value);
        }
    }

    public void outputSetDouble(String name, double value) {
        if (ingescapeAgent != null) {
            ingescapeAgent.outputSetDouble(name, value);
        }
    }

    public void outputSetInteger(String name, int value) {
        if (ingescapeAgent != null) {
            ingescapeAgent.outputSetInt(name, value);
        }
    }

    public void outputSetImpulsion(String name) {
        if (ingescapeAgent != null) {
            ingescapeAgent.outputSetImpulsion(name);
        }
    }

    public void outputSetBool(String name, boolean value) {
        if (ingescapeAgent != null) {
            ingescapeAgent.outputSetBool(name, value);
        }
    }

    private synchronized void updateGpsPosition(String name, double value) {
        boolean valid = Double.isFinite(value)
                && (name.equals("latitude") ? Math.abs(value) <= 90.0 : Math.abs(value) <= 180.0);
        if (!valid) {
            if (name.equals("latitude")) {
                latitude_i = null;
            } else {
                longitude_i = null;
            }
            if (current_runway != null) {
                current_runway = null;
                outputSetString("runway_number", "");
            }
            return;
        }

        if (name.equals("latitude")) {
            latitude_i = value;
        } else {
            longitude_i = value;
        }
        if (latitude_i == null || longitude_i == null) {
            return;
        }

        double currentLatitudeRadians = Math.toRadians(latitude_i);
        double currentLongitudeRadians = Math.toRadians(longitude_i);
        int closestRunwayIndex = -1;
        double closestDistance = Double.POSITIVE_INFINITY;
        for (int i = 0; i < CYUL_RUNWAY_THRESHOLDS.length; i++) {
            double runwayLatitudeRadians = Math.toRadians(CYUL_RUNWAY_THRESHOLDS[i][0]);
            double deltaLatitude = runwayLatitudeRadians - currentLatitudeRadians;
            double deltaLongitude = Math.toRadians(CYUL_RUNWAY_THRESHOLDS[i][1]) - currentLongitudeRadians;
            double a = Math.pow(Math.sin(deltaLatitude / 2.0), 2.0)
                    + Math.cos(currentLatitudeRadians) * Math.cos(runwayLatitudeRadians)
                    * Math.pow(Math.sin(deltaLongitude / 2.0), 2.0);
            double angularDistance = 2.0 * Math.asin(Math.min(1.0, Math.sqrt(a)));
            if (angularDistance < closestDistance) {
                closestDistance = angularDistance;
                closestRunwayIndex = i;
            }
        }

        String closestRunway = CYUL_RUNWAY_NAMES[closestRunwayIndex];
        if (!closestRunway.equals(current_runway)) {
            current_runway = closestRunway;
            outputSetString("runway_number", closestRunway);
            System.out.printf(Locale.ROOT,
                    "Runway detected: %s (nearest threshold at %.6f, %.6f)%n",
                    closestRunway,
                    CYUL_RUNWAY_THRESHOLDS[closestRunwayIndex][0],
                    CYUL_RUNWAY_THRESHOLDS[closestRunwayIndex][1]);
        }
    }

    @Override
    public void handleIOP(com.ingescape.Agent agent, Iop iop, String name, IopType type, Object value) {
        //_logger.debug("**received input {} with type {} and value {}", name, type, value);

        if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_DOUBLE_T) {
            double myDouble = (Double) value;
            float inputDouble = (float) myDouble;
            //_logger.debug("**received double {} with value {}, processing...", name, inputDouble);
            // Store values in corresponding attributes
            switch (name) {
                case "latitude":
                case "longitude":
                    updateGpsPosition(name, myDouble);
                    break;
                case "airspeed":
                    airspeed_i = inputDouble;
                    break;
                case "altitude":
                    altitude_i = inputDouble;
                    break;
                case "pitch":
                    pitch_i = inputDouble;
                    break;
                case "roll":
                    roll_i = inputDouble;
                    break;
                case "heading":
                    heading_i = inputDouble;
                    break;
                case "elevator":
                    elevator_i = inputDouble;
                    break;
                case "rudder":
                    rudder_i = inputDouble;
                    break;
                case "aileron":
                    aileron_i = inputDouble;
                    break;
                case "l_throttle":
                    l_throttle_i = inputDouble;
                    break;
                case "r_throttle":
                    r_throttle_i = inputDouble;
                    break;
                case "slip":
                    slip_i = inputDouble;
                    break;
                case "vertical_speed":
                    vertical_speed_i = inputDouble;
                    break;
                case "flaps":
                    flaps_i = inputDouble;
                    break;
                case "landing_gear":
                    landing_gear_i = inputDouble;
                    break;
                case "spoilers":
                    spoilers_i = inputDouble;
                    break;
                case "e1_n1":
                    e1_n1_i = inputDouble;
                    break;
                case "e2_n1":
                    e2_n1_i = inputDouble;
                    break;
                case "baro_setting":
                    baro_setting_i = inputDouble;
                    break;
                case "cabin_alt":
                    cabin_alt_i = inputDouble;
                    break;
                case "l_gen_load":
                    l_gen_load_i = inputDouble;
                    break;
                case "r_gen_load":
                    r_gen_load_i = inputDouble;
                    break;
                case "trim_rudder":
                    trim_rudder_i = inputDouble;
                    break;
                case "radio_frequency":
                    radio_frequency_i = inputDouble;
                    break;
            }
        }
        else if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_BOOL_T) {
            boolean inputBool = (Boolean) value;
            switch (name) {
                case "parking_brake":
                    parking_brake_i = inputBool;
                    break;
                case "n1_match_bug":
                    n1_match_bug_i = inputBool;
                    break;
                case "master_warning":
                    master_warning_i = inputBool;
                    break;
                case "master_caution":
                    master_caution_i = inputBool;
                    break;
                case "yaw_damper":
                    yaw_damper_i = inputBool;
                    break;
                case "l_ign_switch":
                    l_ign_switch_i = inputBool;
                    break;
                case "r_ign_switch":
                    r_ign_switch_i = inputBool;
                    break;
                case "l_engine_fire":
                    l_engine_fire_i = inputBool;
                    break;
                case "r_engine_fire":
                    r_engine_fire_i = inputBool;
                    break;
                case "pitot_heat":
                    pitot_heat_i = inputBool;
                    break;
                case "l_eng_ai":
                    l_eng_ai_i = inputBool;
                    break;
                case "r_eng_ai":
                    r_eng_ai_i = inputBool;
                    break;
                case "l_windsh_ai":
                    l_windsh_ai_i = inputBool;
                    break;
                case "r_windsh_ai":
                    r_windsh_ai_i = inputBool;
                    break;
                case "anti_coll_lights":
                    anti_coll_lights_i = inputBool;
                    break;
                case "l_bottle_arm":
                    l_bottle_arm_i = inputBool;
                    break;
                case "r_bottle_arm":
                    r_bottle_arm_i = inputBool;
                    break;
                case "birds":
                    birds_i = inputBool;
                    break;
                case "TARS_is_speaking":
                    TARS_is_speaking_i = inputBool;
                    break;
            }
        }
        else if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_STRING_T) {
                String inputString = (String) value;
                switch (name) {
                    case "ATC_speech":
                        if (inputString.isEmpty()){
                            break;
                        }
                        ATC_msg_i.set(inputString);
                        if (simulation != null) {
                            // Split the message into words
                            inputString = inputString.toLowerCase();
                            inputString = inputString.replace(",", "");
                            inputString = inputString.replace(".", "");
                            String[] words = inputString.trim().split("\\s+");

                            // Get current simulation time
                            double currentTime = SimSystem.clock();

                            // Schedule each word with cumulative onset time
                            for (int i = 0; i < words.length; i++) {
                                double onsetTime = currentTime + (i * INTERVAL_BETWEEN_WORDS);
                                simulation.funs.DeviceModuleFun__Audio_Display_Prepare_Word_Sound(
                                    words[i],
                                    String.valueOf(onsetTime),
                                    "atc"
                                );
                            }
                        }
                        break;
                        case "TARS_speech":
                            if (inputString.isEmpty()){
                                break;
                            }
                            TARS_msg_i.set(inputString);
                            if (simulation != null) {
                                // Split the message into words
                                inputString = inputString.toLowerCase();
                                inputString = inputString.replace(" ", "-");
                                inputString = inputString.replace(",", "");
                                inputString = inputString.replace("\"", "");
                                inputString = inputString.replace(".", "");
                                String[] words = inputString.trim().split("\\s+");

                                // Get current simulation time
                                double currentTime = SimSystem.clock();

                                // Schedule each word with cumulative onset time
                                for (int i = 0; i < words.length; i++) {
                                    double onsetTime = currentTime + (i * INTERVAL_BETWEEN_WORDS);
                                    simulation.funs.DeviceModuleFun__Audio_Display_Prepare_Word_Sound(
                                            words[i],
                                            String.valueOf(onsetTime),
                                            "tars"
                                    );
                                }
                            }
                            break;
                    case "current_procedure":
                        current_procedure_i.set(inputString);
                        break;
                    case "current_task_object":
                        current_task_object_i.set(inputString);
                        break;
                    case "current_task_value":
                        current_task_value_i.set(inputString);
                        break;
                    case "current_task_autonomy_role":
                        current_task_autonomy_role_i.set(inputString);
                        break;
                    case "current_task_human_role":
                        current_task_human_role_i.set(inputString);
                        break;
                    case "next_state":
                        next_state_i.set(inputString);
                        break;
                    case "previous_state":
                        previous_state_i.set(inputString);
                        break;
                    case "interaction_message":
                        interaction_message_i.set(inputString);
                        break;
                }
        }
        else if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_INTEGER_T) {
                int inputInt = (Integer) value;
                switch (name) {
                    case "chrono_time":
                        chrono_time_i = inputInt;
                        break;
                    case "runway_centerline_deviation":
                        runway_centerline_deviation_i = inputInt;
                        break;
                    case "heading_deviation":
                        heading_deviation_i = inputInt;
                        break;
                    case "lateral_deviation":
                        lateral_deviation_i = inputInt;
                        break;
                    case "pax_safety":
                        pax_safety_i = inputInt;
                        break;
                    case "flight_director":
                        flight_director_i = inputInt;
                        break;
                    case "flc_mode":
                        flc_mode_i = inputInt;
                        break;
                    case "heading_mode":
                        heading_mode_i = inputInt;
                        break;
                    case "l_fuel_boost":
                        l_fuel_boost_i = inputInt;
                        break;
                    case "r_fuel_boost":
                        r_fuel_boost_i = inputInt;
                        break;
                    case "test_knob":
                        test_knob_i = inputInt;
                        break;
                    case "heading_sel":
                        heading_sel_i = inputInt;
                        break;
                    case "alt_sel":
                        alt_sel_i = inputInt;
                        break;
                    case "l_gen_switch":
                        l_gen_switch_i = inputInt;
                        break;
                    case "r_gen_switch":
                        r_gen_switch_i = inputInt;
                        break;
                    case "transfer_knob":
                        transfer_knob_i = inputInt;
                        break;
                    case "landing_lights":
                        landing_lights_i = inputInt;
                        break;
                }
        } else if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_IMPULSION_T) {
            // Handle impulsion inputs if needed
            switch (name) {
                case "reset":
                    System.out.println("**received reset impulsion input, processing...");
                    if (mediator != null) {
                        // Stop the current simulation
                        mediator.stopSimulation();

                        // Wait a brief moment to ensure clean stop
                        try {
                            Thread.sleep(100);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }

                        // Start a new simulation
                        mediator.startSimulation();
                        System.out.println("**simulation reset completed");
                    } else {
                        System.err.println("**ERROR: Cannot reset simulation - mediator reference not set");
                    }
                    break;
            }
        }
    }

    @Override
    public void handleCallToService(com.ingescape.Agent agent, String senderAgentName, String senderAgentUUID,
                                    String serviceName, List<Object> arguments, String token) {
        //_logger.debug("**received service call from {} ({}): {} (with token {})", senderAgentName, senderAgentUUID, serviceName, arguments, token);
    }

    /**
     * Stop and cleanup the agent
     */
    public void stop() {
        if (ingescapeAgent != null) {
            ingescapeAgent.stop();
            //_logger.info("IngeScape agent stopped");
        }
    }
}
