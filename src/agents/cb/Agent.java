package agents.cb;

import java.util.*;

import jmt.gui.jmodel.mainGui.MainWindow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ingescape.*;
import qnactr.sim.QnactrSimulation;

public class Agent implements IopListener, ServiceListener {
    private static Logger _logger = LoggerFactory.getLogger(Agent.class);

    private static Agent instance = null;

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
    public volatile float parking_brake_i = 0.0f;
    public volatile float n1_match_bug_i = 0.0f;
    public volatile float pax_safety_i = 0.0f;
    public volatile float master_warning_i = 0.0f;
    public volatile float master_caution_i = 0.0f;
    public volatile float flight_director_i = 0.0f;
    public volatile float flc_mode_i = 0.0f;
    public volatile float heading_mode_i = 0.0f;
    public volatile float l_fuel_boost_i = 0.0f;
    public volatile float r_fuel_boost_i = 0.0f;
    public volatile float test_knob_i = 0.0f;
    public volatile float heading_sel_i = 0.0f;
    public volatile float alt_sel_i = 0.0f;
    public volatile float yaw_damper_i = 0.0f;
    public volatile float l_ign_switch_i = 0.0f;
    public volatile float r_ign_switch_i = 0.0f;
    public volatile float l_gen_switch_i = 0.0f;
    public volatile float r_gen_switch_i = 0.0f;
    public volatile float transfer_knob_i = 0.0f;
    public volatile float e1_n1_i = 0.0f;
    public volatile float e2_n1_i = 0.0f;
    public volatile float l_engine_fire_i = 0.0f;
    public volatile float r_engine_fire_i = 0.0f;
    public volatile float baro_setting_i = 0.0f;
    public volatile float cabin_alt_i = 0.0f;
    public volatile float l_gen_load_i = 0.0f;
    public volatile float r_gen_load_i = 0.0f;
    public volatile float pitot_heat_i = 0.0f;
    public volatile float l_eng_ai_i = 0.0f;
    public volatile float r_eng_ai_i = 0.0f;
    public volatile float l_windsh_ai_i = 0.0f;
    public volatile float r_windsh_ai_i = 0.0f;
    public volatile float exterior_lights_i = 0.0f;
    public volatile float anti_coll_lights_i = 0.0f;
    public volatile float trim_rudder_i = 0.0f;
    public volatile float l_bottle_arm_i = 0.0f;
    public volatile float r_bottle_arm_i = 0.0f;
    public volatile float radio_frequency_i = 0.0f;

    // For string inputs
    public volatile String ATC_msg_i = "";
    public volatile String current_procedure_i = "";
    public volatile String current_state_i = "";
    public volatile String next_state_i = "";
    public volatile String previous_state_i = "";
    public volatile String interaction_message_i = "";

    // For integer inputs
    public volatile int chrono_time_i = 0;
    public volatile int runway_centerline_deviation_i = 0;
    public volatile int heading_deviation_i = 0;
    public volatile int lateral_deviation_i = 0;
    public volatile int birds_i = 0;
    public volatile int TARS_speech_i = 0;
    public volatile int TARS_is_speaking_i = 0;
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

    /**
     * Start the Ingescape agent and register it with the simulation
     * @param mainWindow The main window that implements event listeners
     */
    public synchronized void start(MainWindow mainWindow) {
        //prevent multiple starts
        if (ingescapeAgent != null) {
            _logger.warn("IngeScape agent is already started");
            return;
        }

        _logger.info("Starting IngeScape agent...");

        try {
            // Create global context
            globalContext = new Global("ws://localhost:9009");
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

            _logger.info("IngeScape agent started successfully");

        } catch (Exception e) {
            _logger.error("Failed to start IngeScape agent", e);
        }
    }

    /**
     * Create all input definitions
     */
    private void createInputs() {
        ingescapeAgent.definition.inputCreate("airspeed", IopType.IGS_DOUBLE_T);
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
        ingescapeAgent.definition.inputCreate("parking_brake", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("n1_match_bug", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("pax_safety", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("master_warning", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("master_caution", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("flight_director", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("flc_mode", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("heading_mode", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_fuel_boost", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_fuel_boost", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("test_knob", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("heading_sel", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("alt_sel", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("yaw_damper", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_ign_switch", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_ign_switch", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_gen_switch", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_gen_switch", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("transfer_knob", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("e1_n1", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("e2_n1", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_engine_fire", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_engine_fire", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("baro_setting", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("cabin_alt", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_gen_load", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_gen_load", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("pitot_heat", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_eng_ai", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_eng_ai", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_windsh_ai", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_windsh_ai", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("exterior_lights", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("anti_coll_lights", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("trim_rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("l_bottle_arm", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("r_bottle_arm", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("radio_frequency", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.inputCreate("ATC_msg", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_procedure", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("current_state", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("next_state", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("previous_state", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("interaction_message", IopType.IGS_STRING_T);
        ingescapeAgent.definition.inputCreate("chrono_time", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("runway_centerline_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("heading_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("lateral_deviation", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("birds", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("TARS_speech", IopType.IGS_INTEGER_T);
        ingescapeAgent.definition.inputCreate("TARS_is_speaking", IopType.IGS_INTEGER_T);
    }

    /**
     * Register observers for all inputs
     */
    private void observeInputs() {
        String[] inputNames = {
                "airspeed", "elevator", "rudder", "aileron", "l_throttle", "r_throttle",
                "pitch", "roll", "slip", "heading", "vertical_speed", "altitude",
                "flaps", "landing_gear", "spoilers", "parking_brake", "n1_match_bug",
                "pax_safety", "master_warning", "master_caution", "flight_director",
                "flc_mode", "heading_mode", "l_fuel_boost", "r_fuel_boost", "test_knob",
                "heading_sel", "alt_sel", "yaw_damper", "l_ign_switch", "r_ign_switch",
                "l_gen_switch", "r_gen_switch", "transfer_knob", "e1_n1", "e2_n1",
                "l_engine_fire", "r_engine_fire", "baro_setting", "cabin_alt",
                "l_gen_load", "r_gen_load", "pitot_heat", "l_eng_ai", "r_eng_ai",
                "l_windsh_ai", "r_windsh_ai", "exterior_lights", "anti_coll_lights",
                "trim_rudder", "l_bottle_arm", "r_bottle_arm", "radio_frequency",
                "ATC_msg", "current_procedure", "current_state", "next_state",
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
        ingescapeAgent.definition.outputCreate("pax_safety", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("flight_director", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("speed_mode_toggle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("heading_mode_toggle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("autopilot", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_fuel_boost", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("r_fuel_boost", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("test_knob", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("yaw_damper", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_ign_switch", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("r_ign_switch", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("l_gen_switch", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("r_gen_switch", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("transfer_knob", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("baro_setting", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("pitot_heat", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_engine_anti_ice", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_engine_anti_ice", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("l_windshield_anti_ice", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_windshield_anti_ice", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("exterior_lights", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("anti_coll_lights", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("trim_rudder", IopType.IGS_DOUBLE_T);
        ingescapeAgent.definition.outputCreate("l_bottle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_bottle", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("master_warning", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("master_caution", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("atc_speech", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("vocal_command", IopType.IGS_STRING_T);
        ingescapeAgent.definition.outputCreate("l_eng_fire_switch", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("r_eng_fire_switch", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_approval", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_acknowledge", IopType.IGS_IMPULSION_T);
        ingescapeAgent.definition.outputCreate("task_cancelled", IopType.IGS_IMPULSION_T);
    }

    @Override
    public void handleIOP(com.ingescape.Agent agent, Iop iop, String name, IopType type, Object value) {
        _logger.debug("**received input {} with type {} and value {}", name, type, value);

        if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_DOUBLE_T) {
            double myDouble = (Double) value;
            float inputDouble = (float) myDouble;
            _logger.debug("**received double {} with value {}, processing...", name, inputDouble);

            // Store values in corresponding attributes
            switch (name) {
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
                case "parking_brake":
                    parking_brake_i = inputDouble;
                    break;
                case "n1_match_bug":
                    n1_match_bug_i = inputDouble;
                    break;
                case "pax_safety":
                    pax_safety_i = inputDouble;
                    break;
                case "master_warning":
                    master_warning_i = inputDouble;
                    break;
                case "master_caution":
                    master_caution_i = inputDouble;
                    break;
                case "flight_director":
                    flight_director_i = inputDouble;
                    break;
                case "flc_mode":
                    flc_mode_i = inputDouble;
                    break;
                case "heading_mode":
                    heading_mode_i = inputDouble;
                    break;
                case "l_fuel_boost":
                    l_fuel_boost_i = inputDouble;
                    break;
                case "r_fuel_boost":
                    r_fuel_boost_i = inputDouble;
                    break;
                case "test_knob":
                    test_knob_i = inputDouble;
                    break;
                case "heading_sel":
                    heading_sel_i = inputDouble;
                    break;
                case "alt_sel":
                    alt_sel_i = inputDouble;
                    break;
                case "yaw_damper":
                    yaw_damper_i = inputDouble;
                    break;
                case "l_ign_switch":
                    l_ign_switch_i = inputDouble;
                    break;
                case "r_ign_switch":
                    r_ign_switch_i = inputDouble;
                    break;
                case "l_gen_switch":
                    l_gen_switch_i = inputDouble;
                    break;
                case "r_gen_switch":
                    r_gen_switch_i = inputDouble;
                    break;
                case "transfer_knob":
                    transfer_knob_i = inputDouble;
                    break;
                case "e1_n1":
                    e1_n1_i = inputDouble;
                    break;
                case "e2_n1":
                    e2_n1_i = inputDouble;
                    break;
                case "l_engine_fire":
                    l_engine_fire_i = inputDouble;
                    break;
                case "r_engine_fire":
                    r_engine_fire_i = inputDouble;
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
                case "pitot_heat":
                    pitot_heat_i = inputDouble;
                    break;
                case "l_eng_ai":
                    l_eng_ai_i = inputDouble;
                    break;
                case "r_eng_ai":
                    r_eng_ai_i = inputDouble;
                    break;
                case "l_windsh_ai":
                    l_windsh_ai_i = inputDouble;
                    break;
                case "r_windsh_ai":
                    r_windsh_ai_i = inputDouble;
                    break;
                case "exterior_lights":
                    exterior_lights_i = inputDouble;
                    break;
                case "anti_coll_lights":
                    anti_coll_lights_i = inputDouble;
                    break;
                case "trim_rudder":
                    trim_rudder_i = inputDouble;
                    break;
                case "l_bottle_arm":
                    l_bottle_arm_i = inputDouble;
                    break;
                case "r_bottle_arm":
                    r_bottle_arm_i = inputDouble;
                    break;
                case "radio_frequency":
                    radio_frequency_i = inputDouble;
                    break;
            }
        }
        else if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_STRING_T) {
                String inputString = (String) value;
                switch (name) {
                    case "ATC_msg":
                        ATC_msg_i = inputString;
                        break;
                    case "current_procedure":
                        current_procedure_i = inputString;
                        break;
                    case "current_state":
                        current_state_i = inputString;
                        break;
                    case "next_state":
                        next_state_i = inputString;
                        break;
                    case "previous_state":
                        previous_state_i = inputString;
                        break;
                    case "interaction_message":
                        interaction_message_i = inputString;
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
                    case "birds":
                        birds_i = inputInt;
                        break;
                    case "TARS_speech":
                        TARS_speech_i = inputInt;
                        break;
                    case "TARS_is_speaking":
                        TARS_is_speaking_i = inputInt;
                        break;
                }
        }
    }

    @Override
    public void handleCallToService(com.ingescape.Agent agent, String senderAgentName, String senderAgentUUID,
                                    String serviceName, List<Object> arguments, String token) {
        _logger.debug("**received service call from {} ({}): {} (with token {})", senderAgentName, senderAgentUUID, serviceName, arguments, token);
    }

    /**
     * Stop and cleanup the agent
     */
    public void stop() {
        if (ingescapeAgent != null) {
            ingescapeAgent.stop();
            _logger.info("IngeScape agent stopped");
        }
    }
}