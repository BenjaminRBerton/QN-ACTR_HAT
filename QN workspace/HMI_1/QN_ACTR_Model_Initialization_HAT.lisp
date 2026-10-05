;; QN_ACTR_Model_Initialization HAT citation Mustang Takeoff with TARS
;; QN-ACTR, Sample piloting model
;; For questions and comments, please send to Shi Cao (shi.cao@uwaterloo.ca).

(sgp :trace-detail high)
(sgp :v t)
(sgp :crt t)
(sgp :cst t)
;;;;;;;;;;;;;;;;;;;;;
;; Task definition ;;
;;;;;;;;;;;;;;;;;;;;;

(use_world3d_template
	:method    	pilotingxplane
)

(use_predefined_model_setup		model_pilot_xplane)
;; the model will be connected with XPlane


; visual representation of the Cessna Citation Mustang Cockpit environment
(use_task_dbt_template
	:method						discrete_display_feedback_two_stages_method
	:response_terminates_display			nil
	:reset_all_modules_before_each_trial		nil
	:auto_compute_default_reaction_time		nil
	:auto_compute_default_response_correctness	nil
)

(add_trials_from_discrete_display_feedback_two_stages_method
	:add_number_of_blocks_per_day			1
	:add_number_of_trials_per_block			1

	:number_of_responses_per_trial			1
	:display_and_response_duration			(-1.0)  ;; (-1.0) by default, meaning keep displaying without time limit.

    ;; Control panel first row
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_GEN")
	:display_item_screen_location_x			(980)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_GEN")
	:display_item_screen_location_x			(1080)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_FU_BO")
	:display_item_screen_location_x			(1223)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_FU_BO")
	:display_item_screen_location_x			(1270)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_EAI")
	:display_item_screen_location_x			(1390)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_EAI")
	:display_item_screen_location_x			(1430)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("LANDING_GEAR")
	:display_item_screen_location_x			(1540)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("PAX")
	:display_item_screen_location_x			(1730)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("LANDING_L")
	:display_item_screen_location_x			(1780)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("ANTI_COLL_L")
	:display_item_screen_location_x			(1870)
	:display_item_screen_location_y			(1170)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    ;; Control panel second row
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_IGN")
	:display_item_screen_location_x			(1120)
	:display_item_screen_location_y			(1260)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_IGN")
	:display_item_screen_location_x			(1170)
	:display_item_screen_location_y			(1260)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_WAI")
	:display_item_screen_location_x			(1390)
	:display_item_screen_location_y			(1260)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_WAI")
	:display_item_screen_location_x			(1430)
	:display_item_screen_location_y			(1260)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("PITOT-STATIC")
	:display_item_screen_location_x			(1480)
	:display_item_screen_location_y			(1260)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    ;; PFD
    (
	:item_type					display_item_visual_text
	:visual_text					("SLIP")
	:display_item_screen_location_x			(1260)
	:display_item_screen_location_y			(690)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("PITCH")
	:display_item_screen_location_x			(1260)
	:display_item_screen_location_y			(750)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("ROLL")
	:display_item_screen_location_x			(1200)
	:display_item_screen_location_y			(750)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("KIAS")
	:display_item_screen_location_x			(1170)
	:display_item_screen_location_y			(750)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("HEADING")
	:display_item_screen_location_x			(1260)
	:display_item_screen_location_y			(790)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("AP_HEADING")
	:display_item_screen_location_x			(1200)
	:display_item_screen_location_y			(800)
    )
    (
    :item_type					display_item_visual_text
    :visual_text					("AP_ALTITUDE")
    :display_item_screen_location_x			(1350)
    :display_item_screen_location_y			(680)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("BARO_PRESS")
	:display_item_screen_location_x			(1350)
	:display_item_screen_location_y			(810)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("ALT")
	:display_item_screen_location_x			(1350)
	:display_item_screen_location_y			(750)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CLIMB_RATE")
	:display_item_screen_location_x			(1400)
	:display_item_screen_location_y			(750)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("RADIO_FREQ")
	:display_item_screen_location_x			(1370)
	:display_item_screen_location_y			(650)
    )
    ;; Attention getters
    (
	:item_type					display_item_visual_text_button
	:visual_text					("M_W")
	:display_item_screen_location_x			(1240)
	:display_item_screen_location_y			(600)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("M_C")
	:display_item_screen_location_x			(1290)
	:display_item_screen_location_y			(600)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_ENG_FIRE")
	:display_item_screen_location_x			(1570)
	:display_item_screen_location_y			(540)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_BOTTLE")
	:display_item_screen_location_x			(1570)
	:display_item_screen_location_y			(590)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_ENG_FIRE")
	:display_item_screen_location_x			(2050)
	:display_item_screen_location_y			(540)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_BOTTLE")
	:display_item_screen_location_x			(2050)
	:display_item_screen_location_y			(590)
    :display_item_width		                (30)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("TEST_KNOB")
	:display_item_screen_location_x			(2200)
	:display_item_screen_location_y			(570)
    :display_item_width		                (20)
    :display_item_height		            (30)
    )
    ;;AUTOPILOT CONTROL PANEL
    (
	:item_type					display_item_visual_text_button
	:visual_text					("HEADING_MODE")
	:display_item_screen_location_x			(1740)
	:display_item_screen_location_y			(400)
    :display_item_width		                (20)
    :display_item_height		            (10)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("FD")
	:display_item_screen_location_x			(1850)
	:display_item_screen_location_y			(400)
    :display_item_width		                (20)
    :display_item_height		            (10)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("FLC")
	:display_item_screen_location_x			(2060)
	:display_item_screen_location_y			(400)
    :display_item_width		                (20)
    :display_item_height		            (10)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("HDG_KNOB")
	:display_item_screen_location_x			(1740)
	:display_item_screen_location_y			(430)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("AP")
	:display_item_screen_location_x			(1860)
	:display_item_screen_location_y			(430)
    :display_item_width		                (20)
    :display_item_height		            (10)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("YD")
	:display_item_screen_location_x			(1900)
	:display_item_screen_location_y			(430)
    :display_item_width		                (20)
    :display_item_height		            (10)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("ALT_KNOB")
	:display_item_screen_location_x			(1950)
	:display_item_screen_location_y			(415)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("VS")
	:display_item_screen_location_x			(2020)
	:display_item_screen_location_y			(410)
    :display_item_width		                (10)
    :display_item_height		            (30)
    )
    ;;Flight controls bottom
    (
	:item_type					display_item_visual_text_button
	:visual_text					("PARK_BRAKE")
	:display_item_screen_location_x			(1640)
	:display_item_screen_location_y			(1350)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("PITCH_TRIM")
	:display_item_screen_location_x			(1820)
	:display_item_screen_location_y			(1330)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("YAW_TRIM")
	:display_item_screen_location_x			(1820)
	:display_item_screen_location_y			(1400)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("L_THROTTLE")
	:display_item_screen_location_x			(2020)
	:display_item_screen_location_y			(1330)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("R_THROTTLE")
	:display_item_screen_location_x			(2170)
	:display_item_screen_location_y			(1340)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("FLAPS")
	:display_item_screen_location_x			(2130)
	:display_item_screen_location_y			(1280)
    :display_item_width		                (20)
    :display_item_height		            (20)
    )
    ;;Navigation Display ND nd
    (
	:item_type					display_item_visual_text
	:visual_text					("N1%")
	:display_item_screen_location_x			(1600)
	:display_item_screen_location_y			(760)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("N2%")
	:display_item_screen_location_x			(1630)
	:display_item_screen_location_y			(760)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CAS")
	:display_item_screen_location_x			(1600)
	:display_item_screen_location_y			(920)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("BATTERY_V")
	:display_item_screen_location_x			(1670)
	:display_item_screen_location_y			(840)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("BATTERY_A")
	:display_item_screen_location_x			(1670)
	:display_item_screen_location_y			(860)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CABIN_PRESS")
	:display_item_screen_location_x			(1670)
	:display_item_screen_location_y			(920)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("RUDD_TRIM")
	:display_item_screen_location_x			(1700)
	:display_item_screen_location_y			(990)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("FLAPS_POS")
	:display_item_screen_location_x			(1690)
	:display_item_screen_location_y			(1010)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("LATERAL_DEVIATION")
	:display_item_screen_location_x			(1880)
	:display_item_screen_location_y			(900)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("HEADING_DEVIATION")
	:display_item_screen_location_x			(1880)
	:display_item_screen_location_y			(850)
    )
    ;; Outside the Window
    (
	:item_type					display_item_visual_text
	:visual_text					("BIRDS")
	:display_item_screen_location_x			(1120)
	:display_item_screen_location_y			(370)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("RUNWAY_CENTERLINE_DEVIATION")
	:display_item_screen_location_x			(1120)
	:display_item_screen_location_y			(340)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("LEFT-SIDE-OTW")
	:display_item_screen_location_x			(500)
	:display_item_screen_location_y			(420)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("WIND-SOCK")
	:display_item_screen_location_x			(760)
	:display_item_screen_location_y			(450)
    )
    ;; TARS INTERFACE
    (
	:item_type					display_item_visual_text
	:visual_text					("SPEECH_OUTPUT_TEXT")
	:display_item_screen_location_x			(140)
	:display_item_screen_location_y			(940)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("IS_SPEAKING")
	:display_item_screen_location_x			(170)
	:display_item_screen_location_y			(1030)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CURRENT_PROCEDURE")
	:display_item_screen_location_x			(430)
	:display_item_screen_location_y			(910)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("PREVIOUS_TASK")
	:display_item_screen_location_x			(430)
	:display_item_screen_location_y			(940)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("AUTONOMY_ROLE")
	:display_item_screen_location_x			(320)
	:display_item_screen_location_y			(990)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CURRENT_TASK_OBJECT")
	:display_item_screen_location_x			(350)
	:display_item_screen_location_y			(990)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("CURRENT_TASK_VALUE")
	:display_item_screen_location_x			(350)
	:display_item_screen_location_y			(1010)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("HUMAN_ROLE")
	:display_item_screen_location_x			(770)
	:display_item_screen_location_y			(990)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("NEXT_TASK")
	:display_item_screen_location_x			(430)
	:display_item_screen_location_y			(1040)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("CHECK")
	:display_item_screen_location_x			(640)
	:display_item_screen_location_y			(990)
    :display_item_width		                (50)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("CANCEL")
	:display_item_screen_location_x			(690)
	:display_item_screen_location_y			(990)
    :display_item_width		                (50)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("INTERACTION_TEXT")
	:display_item_screen_location_x			(440)
	:display_item_screen_location_y			(1200)
    )
    (
	:item_type					display_item_visual_text
	:visual_text					("TARS_INPUT")
	:display_item_screen_location_x			(440)
	:display_item_screen_location_y			(1250)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("INTERACTION_LEFT_BUTTON")
	:display_item_screen_location_x			(420)
	:display_item_screen_location_y			(1320)
    :display_item_width		                (180)
    :display_item_height		            (20)
    )
    (
	:item_type					display_item_visual_text_button
	:visual_text					("INTERACTION_RIGHT_BUTTON")
	:display_item_screen_location_x			(610)
	:display_item_screen_location_y			(1320)
    :display_item_width		                (180)
    :display_item_height		            (20)
    )
    (
    :item_type					display_item_visual_text_button
    :visual_text					("YOKE_CHECK_ACTION")
    :display_item_screen_location_x			(1490)
    :display_item_screen_location_y			(1030)
    :display_item_width		                (40)
    :display_item_height		            (40)
    )
    ;; Push-To-Talk Button
    (
    :item_type					display_item_visual_text_button
    :visual_text					("P_T_T")
    :display_item_screen_location_x			(1490)
    :display_item_screen_location_y			(990)
    :display_item_width		                (40)
    :display_item_height		            (40)
    )
    ;ATIS note
    (
    :item_type					display_item_visual_text_button
    :visual_text					("ATIS_NOTE")
    :display_item_screen_location_x			(800)
    :display_item_screen_location_y			(1600)
    :display_item_width		                (40)
    :display_item_height		            (40)
    )
)

;;;;;;;;;;;;;;;;;;;;;
;; Mind definition ;;
;;;;;;;;;;;;;;;;;;;;;

; Single Pilot Takeoff procedure in the Cessna Citation Mustang
; Teaming with TARS
; different tasks represented by different chunk types, e.g., checklist-procedure, manual-flight-control

;;;;;;;;;;; PARAMETERS
(sgp
    :esc             t	; enable the Subsymbolic Components
    :egs            0.5 ; noise scale
    :act            t	; enable the activation trace
	:visual-attention-latency	0.085	;This parameter specifies how long a visual attention shift will take in seconds.  The default value is .085.
	:imaginal-delay			0.2	;a non-negative number	The imaginal-delay parameter controls how long it takes a request or modification request to the imaginal buffer to complete.  It can be set to a non-negative time (in seconds) and defaults to .2.
    :ul             t    ; disable the utility learning mechanism
    :alpha          0.2
)


;;;;;;;;;;; CHUNKS

(chunk-type  procedure ; A procedure is a set of task (e.g. PRE-TAKEOFF)
    procedure-name
)

(chunk-type  task ; A task is a step within a procedure (e.g. IGNITION SWITCH OFF)
    task-object
    task-value
    phase
    stage
    status
	procedure
    human-role
    autonomy-role
    tars-input
    crosscheck
    imaginal-pointer
)

(chunk-type aircraft-component
    component-name
    component-status
    desired-status
)

(chunk-type aviate-situation
    pitch
    roll
    slip
    altitude
    airspeed
    vertical-speed
)

(chunk-type navigate-situation
    lateral-deviation
    heading-deviation
)

(chunk-type eicas-situation
    e1-n1
    e2-n1
    cas
    cas-status
)

(chunk-type throttle-situation
    left-throttle-position
    right-throttle-position
)

(chunk-type outside-world-situation
    birds
    runway-centerline-deviation
)

(chunk-type  clearance
    procedure
    sender
    callsign
    wind
    runway
    altimeter
    altitude
    heading
    navigation
    frequency
    status
)

(chunk-type callsign
    content
)

(chunk-type aoi
    name
)

(chunk-type word
    value
    equivalent
    category
)

(chunk-type TARS-status-representation ; representation of the status of TARS visible via the Shared Interface
    tars-component-name
    status
)

(chunk-type atis-information
    information
    time
    wind
    visibility
    temperature
    dewpoint
    altimeter-setting
    runway-surface
    runway-in-use
)

(chunk-type current-wind
    speech-value
    wind-direction
    wind-speed
)

(chunk-type cleared-altitude
    altitude
)

(add-dm
    (start-task
		isa 			task
        procedure       IDLE
		task-object	    Idle
        task-value      Waiting
        phase           send-start
        stage           1
	)
    (current-wind-belief
        isa                 current-wind
        speech-value        wind-0-9-0-at-4
        wind-direction      090
        wind-speed          4
    )
    (atis-alpha
        isa                 atis-information
        information         alpha
        time                1500
        wind                current-wind-belief
        visibility          one-sm
        temperature         five
        dewpoint            four
        altimeter-setting   29.92
        runway-surface      dry
        runway-in-use       zero-six-left
    )
    (self-callsign
        isa             callsign
        content         c-poly
    )
    (w-cpoly isa word value c-poly category callsign)
    (w-montreal-tower isa word value montreal-tower category sender)
    (w-zero-niner-zero isa word value wind-0-9-0-at-4 category wind)
    (w-zero-six-left isa word value runway-zero-six-left category runway)
    (w-zero-six-right isa word value runway-zero-six-right category runway)
    (w-two-four-right isa word value runway-two-four-right category runway)
    (w-two-four-left isa word value runway-two-four-left category runway)
    (w-altimeter-std isa word value altimeter-two-niner-niner-two category altimeter)
    (w-cleared-for-takeoff isa word value cleared-for-takeoff category procedure)
    (w-runway-heading isa word value maintain-runway-heading category heading)
    (w-to-five-thousand isa word value climb-to-five-thousand equivalent cleared-to-altitude-5000-ft-from-atc category altitude)
    (w-direct-agmeb-then-omeki isa word value proceed-direct-agmeb-then-omeki category navigation)
    (w-on-one-one-eight-decimal-niner isa word value departure-on-one-one-eight-decimal-niner category frequency)
    (w-good-flight isa word value good-flight category ending)
)

(goal-focus start-task)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; PRODUCTION RULES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; PRODUCTION RULES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; PRODUCTION RULES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;starting point
(p start-task-initiate
    =goal>
     isa                    task
     procedure              IDLE
     phase                  send-start
     stage                  1
==>
    +manual>
     isa                    customized-manual-action
     name                   agent-set-bool
     preparation-duration   3.000
     initiation-duration    1.000
     execution-duration     1.000
     finish-duration        1.000
     para-1                 start
     para-2                 true
     para-3
     para-4
    =goal>
     phase                  attend-aoi
     stage                  1
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; PERCEPTION AND ENCODING OF SOUND ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; process incoming aural information except from self, can happen at any time
(p detected-sound
   =aural-location>
    isa             audio-event
    - location      self
   ?aural>
     state          free
   ?retrieval>
     state          free
   ?imaginal>
     state          free
   ==>
   +aural>
     event          =aural-location
   =goal>
    stage           encode-sound
)
(spp detected-sound :u 1) ; is a salient production

; encode sound and location of sound into imaginal buffer
(p sound-from-self-resume-task
    =goal>
    stage       encode-sound
    =aural>
     isa         sound
     location    self
     content     =content
==>
    =goal>
    stage       1
)
(spp sound-from-self-resume-task :u 100) ; need to be higher to capture
;(spp sound-from-self-resume-task :fixed-utility t)

(p encode-sound
   ?imaginal>
     state          free
   =goal>
     stage          encode-sound
   =aural>
     isa            sound
     content        =content
     location       =location
==>
   +imaginal>
     isa            sound
     content        =content
     location       =location
    =goal>
     stage          sound-encoded
)

(p sound-encoded-from-tars
   =goal>
    stage       sound-encoded
   =imaginal>
     isa         sound
     location    tars
     content     =content
==>
    !output!    (=content); debug
    =goal>
     stage       1
)

(p sound-encoded-from-atc-human-role-not-determined
   =goal>
    stage           sound-encoded
    task-object     takeoff-clearance
    human-role      nil
    ?imaginal>
        state       free
   =imaginal>
     isa         sound
     location    atc
     content     =content
==>
    !output!    (=content); debug
    =goal>
     stage       1
)

(p sound-encoded-from-atc-not-performer
   =goal>
    stage           sound-encoded
    task-object     takeoff-clearance
    - human-role    performer
    ?imaginal>
        state       free
   =imaginal>
     isa         sound
     location    atc
     content     =content
==>
    !output!    (=content); debug
    =goal>
     stage       1
)

(p sound-encoded-from-atc-not-in-atc-task
   =goal>
    stage           sound-encoded
    - task-object   takeoff-clearance
    ?imaginal>
    state           free
   =imaginal>
     isa         sound
     location    atc
     content     =content
==>
    !output!    (=content); debug
    =goal>
     stage       1
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; END BLOCK PERCEPTION AND ENCODING OF SOUND ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; SEEV ATTEND TO AoI SWITCH BLOCK ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p get-where-should-i-look-next
    =goal>
     isa        task
     phase      attend-aoi
     stage      1
    ?visual>
     state      free
    ?imaginal>
     state      free
    ?manual>
    state       free
    ?vocal>
    state       free
    !bind! =aoi_x (seev_get_next_aoi x)
    !bind! =aoi_y (seev_get_next_aoi y)
==>
    +visual-location>
     isa        visual-location
     screen-x   =aoi_x
     screen-y   =aoi_y
    =goal>
     stage      2
    !output!    (=aoi_x) ; debug
    !output!    (=aoi_y) ; debug
)

(p attend-to-next-aoi
    =goal>
     isa        task
     phase      attend-aoi
     stage      2
    =visual-location>
    ?visual>
     state      free
==>
    +visual>
     isa        move-attention
     screen-pos =visual-location
    =goal>
     stage      3
)

(p encode-aoi-information
    =goal>
     isa        task
     phase      attend-aoi
     stage      3
    =visual>
    value       =value
    ?imaginal>
     state      free
==>
    =goal>
    phase       attending-aoi
    stage       1
    +imaginal>
     isa        aoi
     name       =value
    !output!    (=value) ; debug
)

(p attending-aoi-imaginal-empty
    =goal>
     isa		 task
     phase       attending-aoi
     stage       1
    ?imaginal>
     buffer      empty
     state       free
==>
    =goal>
    phase       attend-aoi
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; END SEEV ATTEND TO AoI SWITCH BLOCK ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; AoI PFD - construct Aviate Situation-Awareness;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p x-3-form-pfd-aoi-representation
   =goal>
    isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "PITCH"
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
!bind! =value (read_input pitch)		; hard coded way to get the checklist item from PFD AoI
==>
   +imaginal>
    isa		    aviate-situation
    pitch       =value ; is getting the value from agent.pfd_pitch
   =goal>
    phase       read-pfd
    stage		1
)

(p resume-read-pfd-task
    =goal>
    phase       read-pfd
    stage       1
    ?imaginal>
    buffer      empty
    state       free
!bind! =value_pitch (read_input pitch)		; hard coded way to get the checklist item from PFD AoI
==>
    +imaginal>
    isa         aviate-situation
    pitch       =value_pitch ; is getting the value from imaginal buffer
)

(p visually-attend-pfd-roll
   =goal>
    isa		    task
    phase		read-pfd
    stage       1
   ?visual>
    state		free
   ?imaginal>
    state		free
    - buffer    empty
==>
    +visual-location>
    isa		visual-location
    screen-x	1200			; representing roll label x-coordinate on PFD AoI in the scene
    screen-y	750         ; representing roll label y-coordinate on PFD AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-pfd-roll-aoi-representation
   =goal>
    isa		    task
    phase		read-pfd
    stage       form-representation-aircraft-component
    =imaginal>
    isa         aviate-situation
    pitch       =value_pitch
    roll            nil
    slip            nil
    altitude        nil
    airspeed        nil
    vertical-speed  nil
   ?imaginal>
    state		free
!bind! =value (read_input roll)		; hard coded way to get the checklist item from PFD AoI
==>
   +imaginal>
    isa		    aviate-situation
    pitch       =value_pitch ; is getting the value from imaginal buffer
    roll        =value ; is getting the value from agent.pfd_roll
    =goal>
    stage		2
)

(p visually-attend-pfd-slip
   =goal>
    isa		    task
    phase		read-pfd
    stage       2
   ?visual>
    state		free
   ?imaginal>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1260			; representing slip label x-coordinate on PFD AoI in the scene
    screen-y	690         ; representing slip label y-coordinate on PFD AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-pfd-slip-aoi-representation
   =goal>
    isa		    task
    phase		read-pfd
    stage       form-representation-aircraft-component
    =imaginal>
    isa         aviate-situation
    pitch       =value_pitch
    roll        =value_roll
    slip            nil
    altitude        nil
    airspeed        nil
    vertical-speed  nil
   ?imaginal>
    state		free
!bind! =value (read_input slip)		; hard coded way to get the checklist item from PFD AoI
==>
   +imaginal>
    isa		    aviate-situation
    pitch       =value_pitch ; is getting the value from imaginal buffer
    roll        =value_roll ; is getting the value from imaginal buffer
    slip        =value ; is getting the value from agent.pfd_slip
    =goal>
    stage        3
)

(p visually-attend-pfd-altitude
   =goal>
    isa		    task
    phase		read-pfd
    stage       3
   ?visual>
    state		free
   ?imaginal>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1350			; representing altitude label x-coordinate on PFD AoI in the scene
    screen-y	750         ; representing altitude label y-coordinate on PFD AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-pfd-altitude-aoi-representation
   =goal>
    isa		    task
    phase		read-pfd
    stage       form-representation-aircraft-component
    =imaginal>
    isa         aviate-situation
    pitch       =value_pitch
    roll        =value_roll
    slip        =value_slip
    altitude        nil
    airspeed        nil
    vertical-speed  nil
   ?imaginal>
    state		free
!bind! =value (read_input altitude)		; hard coded way to get the checklist item from PFD AoI
==>
   +imaginal>
    isa		    aviate-situation
    pitch       =value_pitch ; is getting the value from imaginal buffer
    roll        =value_roll ; is getting the value from imaginal buffer
    slip        =value_slip ; is getting the value from imaginal buffer
    altitude    =value ; is getting the value from agent.pfd_altitude
    =goal>
    stage       4
)

(p visually-attend-pfd-airspeed
   =goal>
    isa		    task
    phase		read-pfd
    stage       4
   ?visual>
    state		free
   ?imaginal>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1170			; representing airspeed label x-coordinate on PFD AoI in the scene
    screen-y	750         ; representing airspeed label y-coordinate on PFD AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-pfd-airspeed-aoi-representation
   =goal>
    isa		    task
    phase		read-pfd
    stage       form-representation-aircraft-component
    =imaginal>
    isa         aviate-situation
    pitch       =value_pitch
    roll        =value_roll
    slip        =value_slip
    altitude    =value_altitude
    airspeed        nil
    vertical-speed  nil
   ?imaginal>
    state		free
!bind! =value (read_input airspeed)		; hard coded way to get the checklist item from PFD AoI
==>
   +imaginal>
    isa		    aviate-situation
    pitch       =value_pitch ; is getting the value from imaginal buffer
    roll        =value_roll ; is getting the value from imaginal buffer
    slip        =value_slip ; is getting the value from imaginal buffer
    altitude    =value_altitude ; is getting the value from imaginal buffer
    airspeed    =value ; is getting the value from agent.pfd_airspeed
    =goal>
    phase       attend-aoi
    stage		1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of AoI PFD - construct Aviate Situation-Awareness ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; AoI ND - construct Navigate Situation-Awareness ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p x-3-form-nd-aoi-representation
   =goal>
    isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "LATERAL_DEVIATION"
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
!bind! =value (read_input lateral_deviation)		; hard coded way to get the checklist item from ND AoI
==>
    +imaginal>
    isa		    navigate-situation
    lateral-deviation       =value ; is getting the value from agent.nd_lateral_deviation
   =goal>
    phase       read-nd
    stage		1
)

(p resume-read-nd-task
    =goal>
    phase       read-nd
    stage       1
    ?imaginal>
    buffer      empty
    state       free
!bind! =value_lateral_deviation (read_input lateral_deviation)		; hard coded way to get the checklist item from ND AoI
==>
    +imaginal>
    isa         navigate-situation
    lateral-deviation       =value_lateral_deviation ; is getting the value from imaginal buffer
)

(p visually-attend-nd-heading-deviation
   =goal>
    isa		    task
    phase		read-nd
    stage       1
   ?visual>
    state		free
   ?imaginal>
    - buffer    empty
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1880			; representing heading deviation label x-coordinate on ND AoI in the scene
    screen-y	850         ; representing heading deviation label y-coordinate on ND AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-nd-heading-deviation-aoi-representation
   =goal>
    isa		    task
    phase		read-nd
    stage       form-representation-aircraft-component
    =imaginal>
    isa         navigate-situation
    lateral-deviation       =value_lateral_deviation
    heading-deviation       nil
   ?imaginal>
    state		free
!bind! =value (read_input heading_deviation)		; hard coded way to get the checklist item from ND AoI
==>
   +imaginal>
    isa		    navigate-situation
    lateral-deviation       =value_lateral_deviation ; is getting the value from imaginal buffer
    heading-deviation       =value ; is getting the value from agent.nd_heading_deviation
    =goal>
    phase       attend-aoi
    stage		1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; end of AoI ND - construct Navigate Situation-Awareness ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; AoI E/WD - construct eicas situation ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; goal-2 is reserved for the EICAS worker; goal keeps the caller's task context.
(p x-3-form-eicas-aoi-representation
   =goal>
    isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "CAS"
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
==>
    +imaginal>
     isa		    eicas-situation
     cas            clear ; is getting the value from agent.eicas_cas
     cas-status     no-alert
    =goal>
     phase       waiting-for-eicas
     stage       idle
    +goal-2>
     isa         task
     task-object eicas
     phase       read-eicas
     stage       1
)

(p resume-read-eicas-task
    =goal-2>
    phase       read-eicas
    stage       1
    ?imaginal>
    buffer      empty
    state       free
==>
    +imaginal>
    isa         eicas-situation
    cas         clear ; is getting the value from imaginal buffer
    cas-status  no-alert
)

(p visually-attend-eicas-n1-percent
   =goal-2>
    isa		    task
    phase		read-eicas
    stage       1
   ?visual>
    state		free
   ?imaginal>
    - buffer    empty
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1600			; representing n1 percent label x-coordinate on E/WD AoI in the scene
    screen-y	760         ; representing n1 percent label y-coordinate on E/WD AoI in the scene
   =goal-2>
    stage       visual-encode-aircraft-component
)

(p visually-encode-eicas-component
   =goal-2>
    isa         task
    phase       read-eicas
    stage       visual-encode-aircraft-component
   =visual-location>
   ?visual>
    state       free
==>
   +visual>
    isa         move-attention
    screen-pos  =visual-location
   =goal-2>
    stage       form-representation-aircraft-component
)

(p form-eicas-e1-n1-percent-aoi-representation
   =goal-2>
    isa		    task
    phase		read-eicas
    stage       form-representation-aircraft-component
    =imaginal>
    isa         eicas-situation
    cas         =value_cas
    cas-status  =value_cas_status
    e1-n1      nil
    e2-n1      nil
   ?imaginal>
    state		free
!bind! =value (read_input e1_n1)		; hard coded way to get the checklist item from E/WD AoI
==>
   +imaginal>
    isa		    eicas-situation
    cas         =value_cas ; is getting the value from imaginal buffer
    cas-status  =value_cas_status
    e1-n1  =value ; is getting the value from agent.eicas_n1_percent
    =goal-2>
    stage		2
)

(p visually-attend-eicas-e2-n1-percent
   =goal-2>
    isa		    task
    phase		read-eicas
    stage       2
   ?visual>
    state		free
   ?imaginal>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1630			; representing n2 percent label x-coordinate on E/WD AoI in the scene
    screen-y	760         ; representing n2 percent label y-coordinate on E/WD AoI in the scene
   =goal-2>
    stage       visual-encode-aircraft-component
)

(p form-eicas-e2-n1-percent-aoi-representation
   =goal-2>
    isa		    task
    phase		read-eicas
    stage       form-representation-aircraft-component
    =imaginal>
    isa         eicas-situation
    cas         =value_cas
    cas-status  =value_cas_status
    e1-n1  =value_n1_percent
    e2-n1      nil
   ?imaginal>
    state		free
!bind! =value (read_input e2_n1)		; hard coded way to get the checklist item from E/WD AoI
==>
   +imaginal>
    isa		    eicas-situation
    cas         =value_cas ; is getting the value from imaginal buffer
    cas-status  =value_cas_status
    e1-n1  =value_n1_percent ; is getting the value from imaginal buffer
    e2-n1  =value ; is getting the value from agent.eicas_n2_percent
    =goal-2>
    phase       eicas-complete
    stage       1
)

(p finish-idle-eicas-check
   =goal>
    phase       waiting-for-eicas
    stage       idle
   =goal-2>
    phase       eicas-complete
   =imaginal>
    isa         eicas-situation
    cas         clear
    cas-status  no-alert
    e1-n1       =e1_n1
    e2-n1       =e2_n1
==>
   =goal>
    phase       attend-aoi
    stage       1
   =imaginal>
   -goal-2>
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; end of AoI E/WD - construct eicas situation ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; AoI Central Console - construct throttle situation;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p x-3-form-central-console-aoi-representation
   =goal>
    isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "L_THROTTLE"
    =visual>					; assume the model has read the checklist item properly
    ?imaginal>
    state		free
!bind! =value (read_input l_throttle)		; hard coded way to get the checklist item from Central Console AoI
==>
   +imaginal>
   isa            throttle-situation
    left-throttle-position    =value ; is getting the value from agent.cc_left_throttle
    =goal>
    phase       read-central-console
    stage		1
)

(p resume-read-central-console-task
    =goal>
    phase       read-central-console
    stage       1
    ?imaginal>
    buffer      empty
    state       free
!bind! =value_left_throttle (read_input l_throttle)		; hard coded way to get the checklist item from Central Console AoI
==>
    +imaginal>
    isa         throttle-situation
    left-throttle-position    =value_left_throttle ; is getting the value from imaginal buffer
)

(p visually-attend-central-console-right-throttle
   =goal>
    isa		    task
    phase		read-central-console
    stage       1
   ?visual>
    state		free
   ?imaginal>
    - buffer    empty
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	2170			; representing right throttle label x-coordinate on Central Console AoI in the scene
    screen-y	1340         ; representing right throttle label y-coordinate on Central Console AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-central-console-right-throttle-aoi-representation
   =goal>
    isa		    task
    phase		read-central-console
    stage       form-representation-aircraft-component
    =imaginal>
    isa         throttle-situation
    left-throttle-position    =value_left_throttle
    right-throttle-position   nil
   ?imaginal>
    state		free
!bind! =value (read_input r_throttle)		; hard coded way to get the checklist item from Central Console AoI
==>
   +imaginal>
    isa		    throttle-situation
    left-throttle-position    =value_left_throttle ; is getting the value from imaginal buffer
    right-throttle-position   =value ; is getting the value from agent.cc_right_throttle
    =goal>
    phase       attend-aoi
    stage		1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; end of AoI Central Console - construct throttle situation;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; AoI Outside the Window - construct Outside S-A ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p x-3-form-outside-window-aoi-representation
   =goal>
    isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "RUNWAY_CENTERLINE_DEVIATION"
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
!bind! =value (read_input runway_centerline_deviation)		; hard coded way to get the checklist item from Outside the Window AoI
==>
   +imaginal>
    isa		    outside-world-situation
    runway-centerline-deviation       =value ; is getting the value from agent.outside_runway_centerline_deviation
   =goal>
    phase       read-outside-window
    stage		1
)

(p resume-read-outside-window-task
    =goal>
    phase       read-outside-window
    stage       1
    ?imaginal>
    buffer      empty
    state       free
!bind! =value_runway_centerline_deviation (read_input runway_centerline_deviation)		; hard coded way to get the checklist item from Outside the Window AoI
==>
    +imaginal>
    isa         outside-world-situation
    runway-centerline-deviation       =value_runway_centerline_deviation ; is getting the value from imaginal buffer
)

(p visually-attend-outside-window-birds
   =goal>
    isa		    task
    phase		read-outside-window
    stage       1
   ?visual>
    state		free
   ?imaginal>
    - buffer    empty
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	1120			; representing birds label x-coordinate on Outside the Window AoI in the scene
    screen-y	370         ; representing birds label y-coordinate on Outside the Window AoI in the scene
   =goal>
    stage       visual-encode-aircraft-component
)

(p form-outside-window-birds-aoi-representation
   =goal>
    isa		    task
    phase		read-outside-window
    stage       form-representation-aircraft-component
    =imaginal>
    isa         outside-world-situation
    runway-centerline-deviation       =value_runway_centerline_deviation
    birds            nil
   ?imaginal>
    state		free
!bind! =value (read_input birds)		; hard coded way to get the checklist item from Outside the Window AoI
==>
   +imaginal>
    isa		    outside-world-situation
    runway-centerline-deviation       =value_runway_centerline_deviation ; is getting the value from imaginal buffer
    birds       =value ; is getting the value from agent.outside_birds
    =goal>
    phase       attend-aoi
    stage		1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; end of AoI Outside the Window - construct Outside S-A ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AoI TARS INTERFACE - GET CURRENT TASK TO PERFORM;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visually attend to current task on TARS interface
;; form task item representation in imaginal buffer
(p 3-form-task-object-item-representation
   =goal>
	isa		    task
    phase       attending-aoi
    stage       1
   =imaginal>
    isa         aoi
    name        "CURRENT_TASK_OBJECT"
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
	state		free

!bind! =value (read_input current_task_object)		; hard coded way to get the checklist item from TARS interface

==>
   +imaginal>
	isa		    task
	task-object	=value ; is getting the value from agent.current_task_object
   =goal>
    phase       reading-tars-interface
	stage		2-1
)

(p resume-task-has-read-task-object-from-tars
   =goal>
    isa		        task
    task-object     =value_obj
    phase		    reading-tars-interface
    stage           1
   ?imaginal>
    state		    free

!bind! =value (read_input current_task_object)		; hard coded way to get the checklist item from TARS interface

==>
    +imaginal>
    isa		        task
    task-object	    =value
    =goal>
    stage           2-1
)

(p 2-1-visually-attend-current-task-value
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       2-1
   ?visual>
    state		free
   ?imaginal>
    state		free
   ?manual>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	350			; representing current task value label x-coordinate on TARS interface in the scene
    screen-y	1010        ; representing current task value label y-coordinate on TARS interface in the scene
   =goal>
    stage		2-2
)
;; visually encode current task value on TARS interface
(p 2-2-visually-encode-task-value-item
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       2-2
   =visual-location>
   ?visual>
    state		free
==>
   +visual>
    isa		move-attention
    screen-pos	=visual-location
   =goal>
    stage		2-3
)
;; form task value item representation in imaginal buffer
(p 2-3-form-task-value-item-representation
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       2-3
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
   =imaginal>
    task-object	=value_obj
!bind! =value (read_input current_task_value)		; hard coded way to get the checklist item from TARS interface
==>
   +imaginal>
    isa		    task
    task-object	=value_obj ; is getting the value from imaginal buffer
    task-value	=value ; is getting the value from agent.current_task_value
   =goal>
    stage		4
)

;; IF THE READ TASK HASN'T CHANGED YET AND IT HAS BEEN CHECKED READ AGAIN
(p t-i-x-4-same-task-stage-checked
   =goal>
    isa		        task
    phase		    reading-tars-interface
    status          checked
    stage           4
    task-object     =value_obj
    task-value      =value_val
   =imaginal>
    isa             task
    task-object     =value_obj
    task-value      =value_val
==>
    =goal>
    phase           attend-aoi
     stage          1
)
;; IF WE'RE STILL IN (IDLE - WAIT) GO BACK TO IDLE
(p x-4-wait-task-go-back-to-attend-aoi
   =goal>
	isa		    task
	phase		reading-tars-interface
    stage       4
   =imaginal>
	task-value	waiting
==>
   =goal>
    phase       attend-aoi
	stage		1
)

(p x-4-not-wait-task
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       4
   =imaginal>
    - task-value	waiting
==>
    =imaginal>
    =goal>
    stage		5
)

(p x-5-na-value-task-go-back-to-wait-for-start-command
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       5
   =imaginal>
    task-value	n-a
==>
    =goal>
    phase       attend-aoi
    stage		1
)

(p x-5-na-object-task-go-back-to-wait-for-start-command
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       5
   =imaginal>
    task-object	n-a
==>
    =goal>
    phase       attend-aoi
    stage		1
)

(p x-5-not-n-a-task-continue
    =goal>
     isa		    task
     phase		    reading-tars-interface
     stage          5
    =imaginal>
     - task-object	n-a
     - task-value	n-a
     task-object =value_obj
     task-value =value_val
==>
    !output! (=value_obj)
    !output! (=value_val)
    =goal>
     stage		6
    =imaginal>
)
;; IF TASK NOT CHANGED AND ALLOCATED TO TARS READ AGAIN
(p t-i-x-6-human-not-performer-of-task
   =goal>
    isa		        task
    phase           reading-tars-interface
    stage		    6
    status          wait-teammate
    task-object     =value_obj
    task-value      =value_val
   =imaginal>
    isa             task
    task-object     =value_obj
    task-value      =value_val
==>
    =goal>
    phase           attend-aoi
    stage           1
)

;; ELSE IF NOT TASK WAITING AND THE TASK REPRESENTATION FORMED IS DIFFERENT FROM GOAL
;; THEN PROCEED TO NEXT STEPS TO READ TASK ALLOCATION INFORMATION
; visually attend to current task human role on TARS interface
(p x-6-not-waiting-new-task-value
    =imaginal>
    task-value      =value_val
    - task-value    waiting
   =goal>
	isa		        task
    phase           reading-tars-interface
	stage		    6
    - task-value   =value_val
==>
   =imaginal>
   =goal>
    task-value      =value_val ; set the task-value from imaginal to goal buffer
    human-role      nil
    autonomy-role   nil
	phase		    check-allocation
    stage           1
    status          nil
)

(p x-6-not-waiting-new-task-object ; alternative version to capture both task-object and task-value changes
    =imaginal>
    - task-value    waiting
    task-object	    =value_obj
   =goal>
    isa		        task
    phase           reading-tars-interface
    stage		    6
    - task-object   =value_obj
==>
    =imaginal>
    =goal>
    task-object     =value_obj ; set the task-object from imaginal to goal buffer
    human-role      nil
    autonomy-role   nil
    phase		    check-allocation
    stage           1
    status          nil
)

(p x-6-not-waiting-new-task-both ; alternative version to capture both task-object and task-value changes
    =imaginal>
    task-object	    =value_obj
    task-value      =value_val
   =goal>
    isa		        task
    phase           reading-tars-interface
    stage		    6
    - task-object   =value_obj
    - task-value    =value_val
==>
    =imaginal>
    =goal>
    task-object     =value_obj ; set the task-object from imaginal to goal buffer
    task-value      =value_val ; set the task-value from imaginal to goal buffer
    human-role      nil
    autonomy-role   nil
    phase		    check-allocation
    stage           1
    status          nil
)
(spp x-6-not-waiting-new-task-both :u 100) ; need to be higher to capture both in priority
;(spp x-6-not-waiting-new-task-both :fixed-utility t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; END BLOCK READING TARS INTERFACE for new task;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; BLOCK CHECK ALLOCATION ON TARS INTERFACE FOR TASK;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-x-1-visually-attend-current-task-human-role
   =goal>
	isa		    task
	phase		check-allocation
    stage       1
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>					; make sure only start a step when no other action is taking place within these modules
	state		free
==>
   =imaginal>
   +visual-location>
	isa		visual-location
	screen-x	770			; representing current task human-role label x-coordinate on TARS interface
	screen-y	990         ; representing current task human-role label y-coordinate on TARS interface
   =goal>
	stage        2
)
; visually encode current task human role on TARS interface
(p t-i-x-2-visually-encode-allocation-item
   =goal>
	isa		    task
    phase        check-allocation
	stage        2
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		move-attention
	screen-pos	=visual-location
   =goal>
	stage        3
)
; form task item allocation human role representation in imaginal buffer
(p t-i-x-3-form-task-item-allocation-human-role-representation
   =goal>
	isa		    task
    phase       check-allocation
	stage       3

!bind! =value (read_input current_task_human_role)	; hard coded way to get the value from TARS interface

==>
   ;=imaginal>
   =goal>
	stage       4
    human-role	=value
)
; visually attend to current task autonomy role on TARS interface
(p t-i-x-4-visually-attend-current-task-autonomy_role
   =goal>
	isa		    task
    phase		check-allocation
	stage       4
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>					; make sure only start a step when no other action is taking place within these modules
	state		free
==>
    =imaginal>
   +visual-location>
	isa		    visual-location
	screen-x	320			; representing current task location on TARS interface
	screen-y	990
   =goal>
	stage       5
)
; visually encode current task autonomy role on TARS interface
(p t-i-x-5-visually-encode-allocation-item
   =goal>
	isa		    task
    phase        check-allocation
	stage        5
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		move-attention
	screen-pos	=visual-location
   =goal>
	stage        6
    =imaginal>
)
; form task item allocation autonomy role representation in imaginal buffer
(p t-i-x-6-form-task-item-allocation-autonomy-role-representation
   =goal>
	isa		    task
    phase       check-allocation
	stage       6
   =visual>

!bind! =value (read_input current_task_autonomy_role)	; hard coded way to get the value from TARS interface

==>
   =goal>
    autonomy-role	=value
	stage		    7
)

(p t-i-x-7-decide-crosscheck
    =goal>
     isa		        task
     phase              check-allocation
     stage              7
    - autonomy-role     n-a
==>
    =goal>
     crosscheck        yes
     phase             check-tars-input
     stage             1
)

(p t-i-x-7-no-crosscheck
    =goal>
     isa		        task
     phase              check-allocation
     stage              7
    - autonomy-role      n-a
==>
    =goal>
     crosscheck        no
     phase             check-tars-input
     stage             1
)
;(spp x-7-no-crosscheck :reward 2) ;

(p t-i-tars-n-a-allocation-go-to-perform-task
    =goal>
     isa		        task
     phase              check-allocation
     stage              7
    autonomy-role       n-a
==>
    =goal>
     crosscheck         yes
     phase              perform-task
    tars-input          nil
     stage              1
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END BLOCK CHECK ALLOCATION ON TARS INTERFACE FOR TASK;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; GENERAL PRODUCTION FOR ENCODING AIRCRAFT COMPONENT VISUALLY  - SHARED BY ALL TASKS
;;;;
(p x-a-visually-encode-aircraft-component	;phase a. all steps can share this production rule for phase a
   =goal>
	isa		    task
	stage		visual-encode-aircraft-component
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		    move-attention
	screen-pos	=visual-location
   =goal>
	stage		form-representation-aircraft-component
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BLOCK CHECK TARS INPUT IN INTERACTION PANEL FOR SUPPORT;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-x-1-visually-attend-tars-input-supporter ;if TARS is supporter
    =goal>
     isa		        task
     - autonomy-role    n-a
     phase              check-tars-input
     stage              1
    ?visual>
    state		        free
==>
    +visual-location>
     isa		        visual-location
     screen-x	        440			; representing TARS input box x-coordinate on TARS interface
     screen-y	        1250
    =goal>
     stage              2
)

(p t-i-x-1-skip-tars-input-because-tars-is-not-supporter ;if TARS is not supporter
    =goal>
     isa		        task
     autonomy-role    n-a
     phase              check-tars-input
     stage              1
    ?visual>
    state		        free
==>
    =goal>
     phase              perform-task
     stage              1
)

(p t-i-x-2-visually-encode-tars-input
    =goal>
     isa		    task
     phase          check-tars-input
     stage          2
    =visual-location>
    ?visual>
    state		free
==>
    +visual>
     isa		move-attention
     screen-pos	=visual-location
    =goal>
     stage        3
)

(p t-i-x-3-form-tars-input-representation
    =goal>
     isa		        task
     phase              check-tars-input
     stage              3
    task-object       =value_obj
    task-value        =value_val
    crosscheck        =value_crosscheck
    =visual>

!bind! =value (read_input tars_input)	; hard coded way to get the TARS input from TARS interface

==>
    =goal>
    phase               perform-task
    stage               1
    tars-input          =value
    !output!             (tars-input =value); debug
    !output!             (task-object =value_obj); debug
    !output!             (task-value =value_val); debug debug
    !output!             (crosscheck =value_crosscheck); debug
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BLOCK CHECK TARS INPUT IN INTERACTION PANEL FOR SUPPORT;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(p no-task-found-for-object-value-pair
    =goal>
     isa		        task
     phase              perform-task
     stage              1
    ?imaginal>
     state           free
==>
    =goal>
     phase              attend-aoi
     stage              1
    +imaginal>
        isa                aoi
        name               "CURRENT_TASK_OBJECT"
)
;;;;
;;;; AT this point, THE MODEL HAS READ THE TASK TO PERFORM AND THE ALLOCATION INFORMATION
;;;; THE FOLLOWING PRODUCTION RULES ARE UNIQUE FOR EACH TASK THEY, REPRESENT THE "SWITCH" TO
;;;; TASK-SPECIFIC BEHAVIOUR
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TAKEOFF-CLEARANCE CONFIRMATION TASK ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p enter-takeoff-clearance
   =goal>
	isa		        task
    task-object	    takeoff-clearance
    task-value      confirm
	phase		    perform-task
    stage           1
    =imaginal>
    - procedure     takeoff; hasn't started encoding takeoff clearance yet
    - callsign      c-poly
==>
   =imaginal>
   =goal>
    stage		    wait
)
(spp enter-takeoff-clearance :u 1000) ;higher than default of value-pair not found
;;;;;;;;;;;;;;;COMPARE WORD TO SELF CALLSIGN TO DETERMINE IF THE CLEARANCE IS FOR US;;;;;;;;;;;;;;;;
(p retrieve-self-callsign
    =goal>
    stage           sound-encoded
    human-role      nil
    autonomy-role   nil
    task-object     Idle
    task-value      Waiting
    =imaginal>
     isa            sound
     content        =content
     location       atc
==>
    =imaginal>
    +retrieval>
     isa         callsign
    =goal>
    stage       check-is-our-callsign
)
(spp retrieve-self-callsign :u 2) ;

(p is-our-callsign
    =goal>
    stage           check-is-our-callsign
    =imaginal>
    isa             sound
    content         =content
    =retrieval>
    isa             callsign
    content         =content
    ?imaginal>
    state           free
==>
    =goal>
    isa             task
    human-role      nil
    autonomy-role   nil
    phase           attending-aoi
    stage           1
    +imaginal>
    isa             aoi
    name            "CURRENT_TASK_OBJECT"
)
(spp is-our-callsign :u 2)

(p is-not-our-callsign
    =goal>
    stage       check-is-our-callsign
    =imaginal>
    isa         sound
    content     =content
    =retrieval>
    isa         callsign
    - content     =content
==>
    =imaginal>
    =goal>
    isa         task
    phase       attend-aoi
    stage       1
)
(spp is-not-our-callsign :u 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WAIT FOR NEXT WORD FROM ATC;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p wait-for-next-word
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    human-role  performer
    stage       1
==>
    =goal>
    stage      start-timing
)
(spp wait-for-next-word :u 1000) ;higher than default of value-pair not found

(p start-timing
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       start-timing
    ;=imaginal>
    ;isa         clearance
    ;procedure   takeoff
==>
    ;=imaginal>
    +temporal>
    isa         time
    ticks       0
    =goal>
    stage       waiting
)

(p atc-not-speaking-end-of-message
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       waiting
    =imaginal>
    isa         clearance
    procedure   takeoff
   =temporal>
    isa         time
    ticks       31
==>
    =imaginal>
    +temporal>
    isa         clear
    =goal>
    stage       end-detected
)

(p stop-runaway-timer-on-new-sound
   =temporal>
    isa         time
    ticks       35
==>
    +temporal>
    isa         clear
    =goal>
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RETRIEVAL ATTEMPT FOR WORD IN MEMORY;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This production follow up the encode-sound production to check if the message is from ATC
; retrieve self callsign from declarative memory if the message comes from ATC
(p encode-and-retrieval-attempt-for-word-from-takeoff-clearance-stop-timer
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    human-role      performer
    stage           encode-sound
    =aural>
     isa            sound
     content        =content
     location       atc
    ;=imaginal>
     ;isa            clearance
     ;procedure      takeoff
==>
    +temporal>
    isa             clear
    ;=imaginal>
    +retrieval>
     isa         word
     value       =content
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
)
(spp encode-and-retrieval-attempt-for-word-from-takeoff-clearance-stop-timer :u 1000) ; utility higher than regular encode-word for priority to current task

;;;;;;;;;;;;;;;;;;;;;;;;RETRIEVAL SUCCESS, MAP RETRIEVED WORD TO CLEARANCE SLOT;;;;;;;;;;;;;;;;;;;;
(p form-sender-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    ?imaginal>
    state       free
    =retrieval>
     isa         word
     value       =content
     category    sender
==>
    +imaginal>
    isa         clearance
    procedure   takeoff
    sender      =content
    callsign     c-poly
    =goal>
     stage       1
)
(spp form-sender-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

(p form-runway-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    =imaginal>
        isa         clearance
        procedure   takeoff
    =retrieval>
     isa            word
     value          =content
     category       runway
==>
    =imaginal>
    runway          =content
    =goal>
     stage          1
)
(spp form-runway-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

(p form-altimeter-runway-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    =imaginal>
        isa         clearance
        procedure   takeoff
    =retrieval>
     isa            word
     value          =content
     category       altimeter
==>
    =imaginal>
    altimeter          =content
    =goal>
     stage          1
)

(p form-wind-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    =imaginal>
        isa         clearance
        procedure   takeoff
    =retrieval>
     isa            word
     value          =content
     category       wind
==>
    =imaginal>
    wind            =content
    =goal>
     stage          update-wind-belief
)
(spp form-wind-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

(p update-wind-belief-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       update-wind-belief
    =imaginal>
        isa         clearance
        procedure   takeoff
        wind        =value
==>
    =imaginal>
    +retrieval>
    isa             current-wind
    =goal>
     stage          1
)

(p form-altitude-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    =imaginal>
        isa         clearance
        procedure   takeoff
    =retrieval>
     isa            word
     value          =content
     category       altitude
==>
    =imaginal>
    altitude        =retrieval
    =goal>
     stage          1
)
(spp form-altitude-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

(p t-i-end-of-communication-go-check-allocation ;end of the clearance
    =goal>
    phase           perform-task
    stage           end-detected
    human-role      nil
    autonomy-role   nil
    =imaginal>
        isa         clearance
        procedure   takeoff
==>
    =imaginal>
    =goal>
     phase          check-allocation ; proceed to encode task allocation information
     stage          1
)

(p t-i-end-of-communication-and-we-have-allocation ;end of the clearance
    =goal>
    phase           perform-task
    stage           end-detected
    - human-role    nil
    - autonomy-role nil
    =imaginal>
        isa         clearance
        procedure   takeoff
==>
    =imaginal>
    =goal>
     stage          start-readback ; proceed to encode task allocation information
)

;;;;;;;;;;;;;;;;;;;;;;;; SWITCH ALLOCATION FOR READBACK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-allocation-to-takeoff-clearance-readback-by-tars
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    phase           perform-task
    stage           1
    - human-role    performer
==>
    =goal>
    phase           attend-aoi ; wait for next task because TARS will perform the readback
    stage           1
    status          wait-teammate
)
(spp t-i-allocation-to-takeoff-clearance-readback-by-tars :u 1000) ; high utility to prioritize this production

(p t-i-allocation-to-takeoff-clearance-readback-by-pilot
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    phase           perform-task
    stage           start-readback
    human-role      performer
    =imaginal>
     isa            clearance
     procedure      takeoff
     - sender       nil
     - callsign     nil
     - runway       nil
     - altitude     nil
==>
    =imaginal>
    =goal>
    stage           start-readback-push-ptt
)

;;;;;;;;;;;;;;;;;;;;;;;; PTT ON BEFORE READING BACK THE CLEARANCE TO ATC ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p start-readback-push-ptt-on
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       start-readback-push-ptt
    =imaginal>
    isa         clearance
    procedure   takeoff
    sender      =sender
    callsign    =callsign
    runway      =runway
    altitude    =altitude
    ?manual>
    state       free
==>
    =imaginal>
    +manual>
        isa         customized-manual-action
        name        agent-set-bool
        preparation-duration 0.050
        initiation-duration  0.050
        execution-duration   0.050
        finish-duration      0.050
        para-1               push_to_talk
        para-2               true
        para-3
        para-4
    =goal>
    stage                   start-readback-speech
    !output!   (=sender); debug
    !output!   (=callsign); debug
    !output!   (=runway); debug
    !output!   (=altitude); debug
)

;;;;;;;;;;;;;;;;;;;;;;;; READING BACK THE CLEARANCE TO ATC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p start-readback-sender
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       start-readback-speech
    =imaginal>
    isa         clearance
    procedure   takeoff
    sender      =sender
    ?manual>
    state       free
    ?vocal>
    state       free
==>
    =imaginal>
    +vocal>
    cmd         speak
    string      =sender
    =goal>
    stage       readback-callsign
)

(p readback-callsign
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       readback-callsign
    =imaginal>
    isa         clearance
    procedure   takeoff
    callsign    =callsign
    ?vocal>
    state       free
==>
    =imaginal>
    +vocal>
    cmd         speak
    string      =callsign
    =goal>
    stage       readback-cleared-for-takeoff
)

(p readback-cleared-for-takeoff
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       readback-cleared-for-takeoff
    ?vocal>
    state       free
==>
    =imaginal>
    +vocal>
    cmd         speak
    string      cleared-for-takeoff
    =goal>
    stage       readback-runway-heading
)

(p readback-runway-heading
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       readback-runway-heading
    =imaginal>
    isa         clearance
    procedure   takeoff
    runway      =runway
    ?vocal>
    state       free
==>
    =imaginal>
    +vocal>
    cmd         speak
    string      =runway
    =goal>
    stage       readback-climb-to-altitude
)

(p readback-climb-to-altitude
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       readback-climb-to-altitude
    =imaginal>
    isa         clearance
    procedure   takeoff
    altitude    =altitude
    ?vocal>
    state       free
==>
    =imaginal>
    +vocal>
    cmd         speak
    string      =altitude
    =goal>
    stage       ptt-off
)

;;;;;;;;;;;;;;;;;;;;;;;; PTT OFF ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p finish-readback
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       ptt-off
    =imaginal>
    isa         clearance
    procedure   takeoff
    ?manual>
    state       free
==>
    =imaginal>
    +manual>
        isa        customized-manual-action
        name       agent-set-bool
        preparation-duration 0.050
        initiation-duration  0.050
        execution-duration   0.01
        finish-duration      0.050
        para-1              push_to_talk
        para-2              false
        para-3
        para-4
    =goal>
    phase                   check-task-on-tars
    stage                   1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END TAKEOFF-CLEARANCE CONFIRMATION TASK ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; FLAPS - SET FOR TAKEOFF TASK ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-flaps-set-for-takeoff-tars-input-is-set-and-trusted
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    flaps
     task-value         set-for-takeoff
     crosscheck         no
     tars-input         flap-handle-is-currently-set-to-takeoff-position
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-flaps-set-for-takeoff-tars-input-is-set-and-trusted :reward 4); TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-flaps-set-for-takeoff-tars-input-is-set-and-trusted :u 1000); higher than default of value-pair not found

(p t-i-flaps-set-for-takeoff-tars-input-is-set-and-distrust
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    flaps
     task-value         set-for-takeoff
     crosscheck         yes
     tars-input         flap-handle-is-currently-set-to-takeoff-position
    ?imaginal>
    state               free
==>
    =goal>
     stage               2
)
(spp t-i-flaps-set-for-takeoff-tars-input-is-set-and-distrust :u 1000); higher than default of value-pair not found

(p t-i-flaps-set-for-takeoff-tars-input-is-not-set
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    flaps
     task-value         set-for-takeoff
     - tars-input       flap-handle-is-currently-set-to-takeoff-position
    ?imaginal>
    state               free
==>
    =goal>
    stage               2
)
(spp t-i-flaps-set-for-takeoff-tars-input-is-not-set :u 1000); higher than default of value-pair not found

(p no-tars-input-on-flaps
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    flaps
     task-value         set-for-takeoff
     tars-input          nil
==>
    =goal>
    stage               2
)
(spp no-tars-input-on-flaps :u 1000); higher than default of value-pair not found

(p n-a-tars-input-on-flaps
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    flaps
     task-value         set-for-takeoff
     tars-input         n-a
==>
    =goal>
    stage               2
)
(spp n-a-tars-input-on-flaps :u 1000); higher than default of value-pair not found


;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE FLAPS SWITCH CURRENT STATUS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-flaps
   =goal>
    isa		        task
    phase		    perform-task
    stage           2
    task-object	    flaps
    task-value      set-for-takeoff
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1690			; representing flap indicator location on the MFD
    screen-y	    1010
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-flaps-status-representation-has-tars-input
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    flaps
    task-value      set-for-takeoff
    - tars-input      nil
    ?imaginal>
    state        free
!bind! =value (read_input flaps)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   aircraft-component
    component-name        flaps
    component-status      =value
   =goal>
    stage		          verify-tars-input
)

(p form-flaps-status-representation-no-tars-input
   =goal>
    isa		        task
    phase           perform-task
    task-object	    flaps
    task-value      set-for-takeoff
    stage		    form-representation-aircraft-component
    tars-input       nil
    ?imaginal>
    state           free
!bind! =value (read_input flaps)		; hard coded way to get the aircraft-component-status from X-Plane
==>
    +imaginal>
    isa                   aircraft-component
    component-name        flaps
    component-status      =value
   =goal>
    stage		          action
)

(p t-i-flaps-status-set-for-takeoff-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    flaps
     task-value         set-for-takeoff
     tars-input         flap-handle-is-currently-set-to-takeoff-position
    =imaginal>
     isa		        aircraft-component
     component-name		flaps
     component-status   0.5			; 0.5 means TARS was reliable
==>
    =imaginal>
    =goal>
     phase               check-task-on-tars
    stage       1
)
(spp t-i-flaps-status-set-for-takeoff-correspond-to-tars-input :reward -1) ;it took unnecessary time to check TARS input

(p t-i-flaps-status-does-not-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    flaps
     task-value         set-for-takeoff
     tars-input         flap-handle-is-currently-set-to-takeoff-position
    =imaginal>
     isa		        aircraft-component
     component-name		flaps
     - component-status   0.5			; 0.5 means TARS was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-flaps-status-does-not-correspond-to-tars-input :reward 4) ;it was a good idea to check TARS input will be less
;trusted in the future

(p t-i-flaps-status-correspond-to-tars-input-not-set-and-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    flaps
     task-value         set-for-takeoff
     - tars-input         flap-handle-is-currently-set-to-takeoff-position
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		flaps
     - component-status   0.5			; non-0.5 means TARS was reliable
==>
    =imaginal>
    =goal>
    stage               action
)
(spp t-i-flaps-status-correspond-to-tars-input-not-set-and-crosscheck :reward -1)

(p t-i-flaps-status-correspond-to-tars-input-not-set-and-no-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    flaps
     task-value         set-for-takeoff
     -tars-input         flap-handle-is-currently-set-to-takeoff-position
     crosscheck         no
    =imaginal>
     isa		        aircraft-component
     component-name		flaps
     - component-status   0.5			; non-0.5 means TARS was reliable
==>
    =imaginal>
    =goal>
     stage              action
)
(spp t-i-flaps-status-correspond-to-tars-input-not-set-and-no-crosscheck :reward 4)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NEEDED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p flaps-take-action		;FLAPS are not set for takeoff
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    flaps
    task-value      set-for-takeoff
   =imaginal>
    isa		    aircraft-component
    component-name		flaps
    - component-status  0.5			; 0.5 means FLAPS are set for takeoff
   ?manual>
    state		free
==>
   +manual>
    isa 			customized-manual-action		; representing hand reach to flap handle (time duration should be estimated based on human pilot video recordings)
    name			agent-set-double
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			flaps
    para-2			0.5
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
)

(p flaps-is-already-set-for-takeoff
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    flaps
    =imaginal>
     isa		        aircraft-component
     component-name        flaps
     component-status      0.5			; 0.5 means FLAPS are set for takeoff
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; END FLAPS - SET FOR TAKEOFF TASK ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PITOT-STATIC Switch - PITOT STATIC TASK ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-pitot-heat-tars-input-is-on-and-trusted
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pitot-static-switch
     task-value         pitot-static
     crosscheck         no
     tars-input         pitot-heat-is-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		        check-task-on-tars
    stage       1
)
(spp t-i-pitot-heat-tars-input-is-on-and-trusted :reward 4); TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-pitot-heat-tars-input-is-on-and-trusted :u 1000); higher than default of value-pair not found

(p t-i-pitot-heat-tars-input-is-on-and-distrust
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pitot-static-switch
     task-value         pitot-static
     crosscheck         yes
     tars-input         pitot-heat-is-on
    ?imaginal>
    state               free
==>
    =goal>
     stage              2
)
(spp t-i-pitot-heat-tars-input-is-on-and-distrust :u 1000); higher than default of value-pair not found

(p t-i-pitot-heat-tars-input-is-off
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-off
    ?imaginal>
    state               free
==>
    =goal>
     stage		        2
)
(spp t-i-pitot-heat-tars-input-is-off :u 1000); higher than default of value-pair not found

(p t-i-no-tars-input-on-pitot-heat
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pitot-static-switch
     task-value         pitot-static
    tars-input          nil
==>
    =goal>
    stage               2
)
(spp t-i-no-tars-input-on-pitot-heat :u 1000); higher than default of value-pair not found


;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE PITOT STATIC SWITCH ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-pitot-static-switch
   =goal>
	isa		        task
	phase		    perform-task
    stage           2
	task-object	    pitot-static-switch
    task-value      pitot-static
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
	isa		        visual-location
	screen-x	    1480			; representing pitot-static location
	screen-y	    1260
   =goal>
    stage		    visual-encode-aircraft-component
)

(p form-pitot-heat-status-representation-has-tars-input
   =goal>
	isa		        task
    phase           perform-task
	stage		    form-representation-aircraft-component
    task-object	    pitot-static-switch
    task-value      pitot-static
    - tars-input      nil
    ?imaginal>
    state           free

!bind! =value (read_input pitot_heat)		; hard coded way to get the aircraft-component-status from X-Plane

==>
   +imaginal>
    isa                aircraft-component
	component-name     pitot-switch
	component-status   =value
   =goal>
	stage		          verify-tars-input
)

(p form-pitot-heat-status-representation-no-tars-input
   =goal>
    isa		        task
    phase           perform-task
    task-object	    pitot-static-switch
    task-value      pitot-static
    stage		    form-representation-aircraft-component
    tars-input       nil
    ?imaginal>
    state           free
!bind! =value (read_input pitot_heat)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   aircraft-component
    component-name        pitot-switch
    component-status      =value
   =goal>
    stage		          action
)

(p t-i-pitot-heat-status-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-on
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   true			; true means tars was reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pitot-heat-status-correspond-to-tars-input :reward -1) ;it took unnecessary time to check TARS input

(p t-i-pitot-heat-status-does-not-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-on
    crosscheck          yes
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   false			; true means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pitot-heat-status-does-not-correspond-to-tars-input :reward 100) ;it was a good idea to check TARS input will be less
;trusted in the future

(p t-i-pitot-heat-status-does-not-correspond-to-tars-input-off
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-off
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   true			; false means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pitot-heat-status-does-not-correspond-to-tars-input-off :reward 100) ;it was a good idea to check TARS input will be less
;trusted in the future

(p t-i-pitot-heat-status-does-not-correspond-to-tars-input-off-and-no-crossheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-off
    crosscheck          no
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   true			; true means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)

(p t-i-pitot-heat-status-does-not-correspond-to-tars-input-on-and-no-crossheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-on
    crosscheck          no
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   false			; false means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)

(p t-i-pitot-heat-status-correspond-to-tars-input-off-and-crossheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-off
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   false			; false means tars was reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pitot-heat-status-correspond-to-tars-input-off-and-crossheck :reward -1); it took unnecessary time to check TARS input

(p t-i-pitot-heat-status-correspond-to-tars-input-off-and-no-crossheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pitot-static-switch
     task-value         pitot-static
     tars-input         pitot-heat-is-off
     crosscheck         no
    =imaginal>
     isa		        aircraft-component
     component-name		pitot-switch
     component-status   false			; true means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pitot-heat-status-correspond-to-tars-input-off-and-no-crossheck :reward 4)


;;;;;;;;;;;;;;;;;;;;;;;; SWITCH THE PITOT HEAT TO ON ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pitot-heat-take-action		;PITOT-HEAT is OFF
   =goal>
	isa		    task
    phase		perform-task
	stage		action
    task-object	    pitot-static-switch
    task-value      pitot-static
   =imaginal>
	isa		    aircraft-component
	component-name		pitot-switch
	- component-status				    true			; true means PITOT-HEAT is ON
   ?manual>
	state		free
==>
   +manual>
	isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
	name			agent-set-bool
	preparation-duration	0.050
	initiation-duration	0.050
	execution-duration	1.0
	finish-duration		1.0
    para-1			pitot_heat
	para-2			true
    para-3
    para-4

	; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action

   =goal>
	phase		check-task-on-tars
    stage       1
)

(p pitot-heat-no-action		;PITOT-HEAT already ON
   =goal>
	isa		                    task
    phase		                perform-task
	stage		                action
    task-object	            pitot-static-switch
    task-value              pitot-static
   =imaginal>
	isa				            aircraft-component
    component-name		        pitot-switch
    component-status			true			; true means PITOT-HEAT is ON
==>
   =goal>
    phase                       check-task-on-tars
    stage       1
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENGINE ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-engine-anti-ice-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         engine-anti-ice-is-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-engine-anti-ice-is-already-on-according-to-tars :u 1000); higher than default of value-pair not found

(p engine-anti-ice-no-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         nil
    ?imaginal>
    state               free
==>
    =goal>
    phase               retrieve-atis
    stage               1
)
(spp engine-anti-ice-no-tars-recommendation :u 1000); higher than default of value-pair not found

(p engine-anti-ice-n-a-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         n-a
    ?imaginal>
    state               free
==>
    =goal>
    phase               retrieve-atis
    stage               1
)
(spp engine-anti-ice-n-a-tars-input :u 1000); higher than default of value-pair not found

(p retrieve-last-atis-temperature
    =goal>
     isa		        task
     phase		        retrieve-atis
     stage              1
    ?imaginal>
    state               free
    ?retrieval>
    state               free
==>
   +retrieval>
    isa		            atis-information
   =goal>
    stage               2
)

(p form-last-atis-temperature-representation
    =goal>
     isa		        task
     phase		        retrieve-atis
     stage              2
    =retrieval>
     isa		        atis-information
     temperature	    =value
==>
   +imaginal>
    isa                 atis-information
    temperature         =value
   =goal>
    phase               understand-requirement
    stage		        2
)

(p last-atis-retrieval-failure
    =goal>
     isa		        task
     phase		        retrieve-atis
     stage              2
     ?retrieval>
     state              error
==>
   =goal>
    phase               understand-requirement
    stage               2
    status              atis-retrieval-failure
)

(p engine-anti-ice-could-not-retrieve-atis
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    engine-anti-ice-switches
     task-value         as-required
     status             atis-retrieval-failure
    ?imaginal>
    state               free
==>
    =goal>
    phase               check-task-on-tars
    stage               1
)

(p temperature-is-5-degrees-take-action
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         nil
    =imaginal>
     isa		        atis-information
     temperature	    five
==>
    =goal>
    phase               perform-task
    stage               3
)

(p temperature-is-above-5-degrees-no-action
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         nil
    =imaginal>
     isa		        atis-information
     - temperature	    five
==>
    =goal>
    phase               check-task-on-tars
    stage               1
)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-tars-recommend-check-visible-moisture-present-condition
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
    ?imaginal>
    state               free
==>
    +visual-location>
     isa		        visual-location
     screen-x	        500			; representing a point in the left side of OTW
     screen-y	        420
    =goal>
     stage		        visual-encode-aircraft-component
)
(spp t-i-tars-recommend-check-visible-moisture-present-condition :u 1000); higher than default of value-pair not found

(p t-i-tars-do-not-recommend-check-visible-moisture-present-condition
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    engine-anti-ice-switches
     task-value         as-required
     - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
    ?imaginal>
    state               free
==>
    =goal>
     stage		        3
)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK ENVIRONMENT TO DECIDE ACTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p confirm-visible-moisture-present-condition
    =goal>
     isa		        task
     phase		        perform-task
     stage              form-representation-aircraft-component
     task-object	    engine-anti-ice-switches
     task-value         as-required
     tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
     status              nil ; not yet set
    ?imaginal>
    state               free
==>
   +imaginal>
    isa		            aircraft-component
    component-name      visible-moisture-present
    component-status    true
   =goal>
    stage		        3
)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-engine-left-anti-ice-switches
   =goal>
    isa		            task
    phase		        perform-task
    stage               3
    task-object	        engine-anti-ice-switches
    human-role          =value
    autonomy-role       =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1390			; representing left engine-anti-ice-switches location
    screen-y	    1170
    =goal>
    stage		    visual-encode-aircraft-component
    status          left
)

(p form-left-engine-anti-ice-status-representation
   =goal>
    isa		                task
    phase                   perform-task
    stage		            form-representation-aircraft-component
    status                  left
    task-object	            engine-anti-ice-switches
    ?imaginal>
    state                   free
!bind! =value (read_input l_eng_ai)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                     aircraft-component
    component-name          left-engine-anti-ice-switch
    component-status        =value
   =goal>
    stage		            action-left
)

;;;;;;;;;;;;;;;;;;;;;;;; EXECUTE ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p left-engine-anti-ice-take-action		;ENGINE ANTI-ICE is OFF
   =goal>
    isa		            task
    phase		        perform-task
    stage		        action-left
    status              left
    task-object	        engine-anti-ice-switches
    task-value          as-required
    tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
   =imaginal>
    isa		            aircraft-component
    component-name		left-engine-anti-ice-switch
    - component-status  true			; true means ENGINE ANTI-ICE is ON
   ?manual>
    state		        free
==>
   +manual>
    isa 			        customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			        agent-set-bool
    preparation-duration	0.050
    initiation-duration	    0.050
    execution-duration	    1.0
    finish-duration		    1.0
    para-1			        l_engine_anti_ice
    para-2			        true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    stage                   right-1
)

(p left-engine-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-left
     status             left
     task-object	    engine-anti-ice-switches
    =imaginal>
     isa		        aircraft-component
     component-name        left-engine-anti-ice-switch
     component-status      true			; true means ENGINE ANTI-ICE is ON
==>
    =goal>
     stage              right-1
)

(p no-action-recommendation-left-engine-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-left
     status             left
     task-object	    engine-anti-ice-switches
     task-value         as-required
     - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
==>
    =goal>
     stage              right-1
)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-engine-right-anti-ice-switches
   =goal>
    isa		        task
    phase		    perform-task
    stage           right-1
    task-object	    engine-anti-ice-switches
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1430			; representing right engine-anti-ice-switches
    screen-y	    1170
    =goal>
    stage		    visual-encode-aircraft-component
    status          right
)

(p form-engine-right-anti-ice-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    status          right
    task-object	    engine-anti-ice-switches
    ?imaginal>
    state        free
!bind! =value (read_input r_eng_ai)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   aircraft-component
    component-name        right-engine-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-right
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p engine-right-anti-ice-take-action		;RIGHT ENGINE ANTI-ICE is OFF
   =goal>
    isa		                task
    phase		            perform-task
    stage		            action-right
    status                  right
    task-object	            engine-anti-ice-switches
    task-value              as-required
    tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
   =imaginal>
    isa		                aircraft-component
    component-name		    right-engine-anti-ice-switch
    - component-status      true			; true means ENGINE ANTI-ICE is ON
   ?manual>
    state		            free
==>
   +manual>
    isa 			        customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			        agent-set-bool
    preparation-duration	0.050
    initiation-duration	    0.050
    execution-duration	    1.0
    finish-duration		    1.0
    para-1			        r_engine_anti_ice
    para-2			        true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		            check-task-on-tars
    stage                   1
    task-value              as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p right-engine-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    engine-anti-ice-switches
    =imaginal>
     isa		        aircraft-component
     component-name     right-engine-anti-ice-switch
     component-status   true			; true means ENGINE ANTI-ICE is ON
==>
    =goal>
     phase		        check-task-on-tars
    stage       1
     task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p no-action-recommendation-right-engine-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    engine-anti-ice-switches
     task-value         as-required
     - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-engine-anti-ice--->-on
==>
    =goal>
    task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
    phase		       check-task-on-tars
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END ENGINE ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WINDSHIELD ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-windshield-anti-ice-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     tars-input         windshield-anti-ice-is-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-windshield-anti-ice-is-already-on-according-to-tars :reward 4); TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-windshield-anti-ice-is-already-on-according-to-tars :u 1000); higher than default of value-pair not found

(p t-i-windshield-anti-ice-no-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         nil
    ?imaginal>
    state               free
==>
    =goal>
    phase               retrieve-atis
    stage               1
)
(spp t-i-windshield-anti-ice-no-tars-recommendation :u 1000); higher than default of value-pair not found

(p windshield-anti-ice-n-a-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         n-a
    ?imaginal>
    state               free
==>
    =goal>
    phase               retrieve-atis
    stage               1
)
(spp windshield-anti-ice-n-a-tars-input :u 1000); higher than default of value-pair not found

(p windshield-anti-ice-could-not-retrieve-atis
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     status              atis-retrieval-failure
    ?imaginal>
    state               free
==>
    =goal>
    phase               check-task-on-tars
    stage               1
)

(p temperature-is-5-degrees-take-action-windshield
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         nil
    =imaginal>
     isa		        atis-information
     temperature	    five
==>
    =goal>
    phase               perform-task
    stage               3
)

(p temperature-is-above-5-degrees-no-action-windshield
    =goal>
     isa		        task
     phase		        understand-requirement
     stage              2
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         nil
    =imaginal>
     isa		        atis-information
     - temperature	    five
==>
    =goal>
    phase               check-task-on-tars
    stage               1
)


;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p tars-recommend-check-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
    ?imaginal>
    state               free
==>
    +visual-location>
     isa		        visual-location
     screen-x	        500			; representing a point in the left side of OTW
     screen-y	        420
    =goal>
     stage		        visual-encode-aircraft-component
)
(spp tars-recommend-check-visible-moisture-present-condition-windshield :u 1000); higher than default of value-pair not found

(p tars-do-not-recommend-check-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
    ?imaginal>
    state               free
==>
    =goal>
     stage		        3
)
(spp tars-do-not-recommend-check-visible-moisture-present-condition-windshield :u 1000); higher than default of value-pair not found

;;;;;;;;;;;;;;;;;;;;;;;; CHECK ENVIRONMENT TO DECIDE ACTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p confirm-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              form-representation-aircraft-component
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
     status              nil ; not yet set
    ?imaginal>
    state               free
==>
   +imaginal>
    isa		            aircraft-component
    component-name      visible-moisture-present
    component-status    true
   =goal>
    stage		        3
)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-left-windshield-anti-ice-switches
   =goal>
    isa		        task
    phase		    perform-task
    stage           3
    task-object	    windshield-anti-ice-switches
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1390			; representing left windshield-anti-ice-switches location
    screen-y	    1260
    =goal>
    stage		    visual-encode-aircraft-component
    status          left
)

(p form-left-windshield-anti-ice-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    status          left
    task-object	    windshield-anti-ice-switches
    ?imaginal>
    state        free
!bind! =value (read_input l_windsh_ai)		; hard coded way to get the aircraft-component-status from X-Plane
==>
    +imaginal>
    isa                   aircraft-component
    component-name        left-windshield-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-left
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p left-windshield-anti-ice-take-action		;WINDSHIELD ANTI-ICE is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action-left
    status      left
    task-object	    windshield-anti-ice-switches
    task-value      as-required
    tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
   =imaginal>
    isa		    aircraft-component
    component-name		left-windshield-anti-ice-switch
    - component-status				    true			; true means WINDSHIELD ANTI-ICE is ON
   ?manual>
    state		free
==>
   +manual>
    isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			agent-set-bool
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			l_windshield_anti_ice
    para-2			true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    stage          right-1
)

(p left-windshield-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-left
     status             left
     task-object	    windshield-anti-ice-switches
    =imaginal>
     isa		        aircraft-component
     component-name        left-windshield-anti-ice-switch
     component-status      true			; true means WINDSHIELD ANTI-ICE is ON
==>
    =goal>
     stage              right-1
)

(p no-action-recommendation-left-windshield-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-left
     status             left
     task-object	    windshield-anti-ice-switches
     task-value         as-required
     - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
==>
    =goal>
     stage              right-1
)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-right-windshield-anti-ice-switches
   =goal>
    isa		        task
    phase		    perform-task
    stage           right-1
    task-object	    windshield-anti-ice-switches
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1430			; representing right windshield-anti-ice-switches
    screen-y	    1260
    =goal>
    stage		    visual-encode-aircraft-component
    status          right
)

(p form-right-windshield-anti-ice-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    status          right
    task-object	    windshield-anti-ice-switches
    ?imaginal>
    state        free
!bind! =value (read_input r_windsh_ai)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   aircraft-component
    component-name        right-windshield-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-right
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p right-windshield-anti-ice-take-action		;RIGHT WINDSHIELD ANTI-ICE is OFF
   =goal>
    isa		            task
    phase		        perform-task
    stage		        action-right
    status              right
    task-object	        windshield-anti-ice-switches
    task-value          as-required
    tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
   =imaginal>
    isa		            aircraft-component
    component-name		right-windshield-anti-ice-switch
    - component-status  true			; true means WINDSHIELD ANTI-ICE is ON
   ?manual>
    state		        free
==>
   +manual>
    isa 			    customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			    agent-set-bool
    preparation-duration	0.050
    initiation-duration	    0.050
    execution-duration	    1.0
    finish-duration		    1.0
    para-1			    r_windshield_anti_ice
    para-2			    true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
    task-value          as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p right-windshield-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    windshield-anti-ice-switches
    =imaginal>
     isa		        aircraft-component
     component-name     right-windshield-anti-ice-switch
     component-status   true			; true means WINDSHIELD ANTI-ICE is ON
==>
    =goal>
     phase		        check-task-on-tars
    stage       1
     task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p no-action-recommendation-right-windshield-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    windshield-anti-ice-switches
     task-value         as-required
    - tars-input         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-i-suggest:-windshield-anti-ice--->-on
==>
    =goal>
    task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
    phase		       check-task-on-tars
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END WINDSHIELD ANTI-ICE Switches - AS REQUIRED task ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; PAX SAFETY Switch - PAX SAFETY task ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-pax-safety-tars-input-is-on-and-trusted
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
     crosscheck         no
     tars-input         pax-safety-switch-is-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-pax-safety-tars-input-is-on-and-trusted :reward 4); TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-pax-safety-tars-input-is-on-and-trusted :u 1000); higher than default of value-pair not found

(p t-i-pax-safety-tars-input-is-on-and-distrust
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
     crosscheck         yes
     tars-input         pax-safety-switch-is-on
    ?imaginal>
    state               free
==>
    =goal>
     stage               2
)
(spp t-i-pax-safety-tars-input-is-on-and-distrust :u 1000); higher than default of value-pair not found

(p t-i-pax-safety-tars-input-is-off
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         pax-safety-switch-is-off
    ?imaginal>
    state               free
==>
    =goal>
    stage               2
)
(spp t-i-pax-safety-tars-input-is-off :u 1000); higher than default of value-pair not found

(p no-tars-input-on-pax-safety
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input          nil
==>
    =goal>
    stage               2
)
(spp no-tars-input-on-pax-safety :u 1000); higher than default of value-pair not found

(p n-a-tars-input-on-pax-safety
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         n-a
==>
    =goal>
    stage               2
)
(spp n-a-tars-input-on-pax-safety :u 1000); higher than default of value-pair not found


;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE PAX SAFETY SWITCH CURRENT STATUS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-pax-safety-switch
   =goal>
    isa		        task
    phase		    perform-task
    stage           2
    task-object	    pax-safety-switch
    task-value      pax-safety
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1730			; representing pax-safety-switch location
    screen-y	    1170
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-pax-safety-status-representation-has-tars-input
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    pax-safety-switch
    task-value      pax-safety
    - tars-input      nil
    ?imaginal>
    state        free
!bind! =value (read_input pax_safety)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   aircraft-component
    component-name        pax-safety-switch
    component-status      =value
   =goal>
    stage		          verify-tars-input
)

(p form-pax-safety-status-representation-no-tars-input
   =goal>
    isa		        task
    phase           perform-task
    task-object	    pax-safety-switch
    task-value      pax-safety
    stage		    form-representation-aircraft-component
    tars-input       nil
    ?imaginal>
    state           free
!bind! =value (read_input pax_safety)		; hard coded way to get the aircraft-component-status from X-Plane
==>
    +imaginal>
    isa                   aircraft-component
    component-name        pax-safety-switch
    component-status      =value
   =goal>
    stage		          action
)

(p t-i-pax-safety-status-on-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         pax-safety-switch-is-on
    =imaginal>
     isa		        aircraft-component
     component-name		pax-safety-switch
     component-status   2			; true means tars was reliable
==>
    =imaginal>
    =goal>
     phase               check-task-on-tars
    stage       1
)
(spp t-i-pax-safety-status-on-correspond-to-tars-input :reward -1) ;it took unnecessary time to check TARS input

(p t-i-pax-safety-status-does-not-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         pax-safety-switch-is-on
    =imaginal>
     isa		        aircraft-component
     component-name		pax-safety-switch
     - component-status   2			; true means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-pax-safety-status-does-not-correspond-to-tars-input :reward 4) ;it was a good idea to check TARS input will be less
;trusted in the future

(p t-i-pax-safety-status-correspond-to-tars-input-off-and-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         pax-safety-switch-is-off
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		pax-safety-switch
     - component-status   2			; false means tars was reliable
==>
    =imaginal>
    =goal>
    stage               action
)
(spp t-i-pax-safety-status-correspond-to-tars-input-off-and-crosscheck :reward -1)

(p t-i-pax-safety-status-correspond-to-tars-input-off-and-no-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    pax-safety-switch
     task-value         pax-safety
     tars-input         pax-safety-switch-is-off
     crosscheck         no
    =imaginal>
     isa		        aircraft-component
     component-name		pax-safety-switch
     - component-status   2			; false means tars was reliable
==>
    =imaginal>
    =goal>
     stage              action
)
(spp t-i-pax-safety-status-correspond-to-tars-input-off-and-no-crosscheck :reward 4)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NEEDED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pax-safety-take-action		;PAX SAFETY is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    pax-safety-switch
    task-value      pax-safety
   =imaginal>
    isa		    aircraft-component
    component-name		pax-safety-switch
    - component-status  2			; true means PAX SAFETY is ON
   ?manual>
    state		free
==>
   +manual>
    isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			agent-set-int
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			pax_safety
    para-2			2
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
)

(p pax-safety-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    pax-safety-switch
    =imaginal>
     isa		        aircraft-component
     component-name        pax-safety-switch
     component-status      2			; true means PAX SAFETY is ON
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END PAX SAFETY Switch - PAX SAFETY task ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LANDING LIGHTS Switch - AS DESIRED task ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-landing-lights-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    landing-light-switch
     task-value         as-desired
     tars-input         landing-lights-is-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-landing-lights-is-already-on-according-to-tars :reward 4)
(spp t-i-landing-lights-is-already-on-according-to-tars :u 1000); higher than default of value-pair not found

(p landing-lights-no-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    landing-light-switch
     task-value         as-desired
     tars-input         nil
    ?imaginal>
    state               free
==>
    =goal>
    stage               3
)
(spp landing-lights-no-tars-recommendation :u 1000); higher than default of value-pair not found

;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-understand-landing-lights-as-desired-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    landing-light-switch
     task-value         as-desired
     tars-input         =tars-input
    ?imaginal>
    state               free
==>
    =goal>
     task-value         =tars-input
     stage		        2
)
(spp t-i-understand-landing-lights-as-desired-tars-recommendation :u 1000); higher than default of value-pair not found

(p t-i-tars-recommend-landing-lights-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    landing-light-switch
     task-value         on-an-active-runway-to-enhance-visibility:-landing-lights-on
    ?imaginal>
    state               free
==>
    =goal>
     stage		        3
)

(p t-i-tars-do-not-recommend-landing-lights-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    landing-light-switch
     - task-value       on-an-active-runway-to-enhance-visibility:-landing-lights-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		        check-task-on-tars
    stage       1
     task-value         as-desired ;need to set it back otherwise it will read tars interface as a new task
)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-landing-lights-switch
   =goal>
    isa		        task
    phase		    perform-task
    stage           3
    task-object	    landing-light-switch
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1780			; representing landing-lights-switch location
    screen-y	    1170
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-landing-lights-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    landing-light-switch
    ?imaginal>
    state        free
!bind! =value (read_input landing_lights)		; hard coded way to get the aircraft-component-status from X-Plane
==>
    +imaginal>
    isa                   aircraft-component
    component-name        landing-lights-switch
    component-status      =value
   =goal>
    stage		action
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p landing-lights-take-action		;LANDING LIGHTS is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    landing-light-switch
   =imaginal>
    isa		    aircraft-component
    component-name		landing-lights-switch
    - component-status				    2			; 2 means LANDING LIGHTS is ON
   ?manual>
    state		free
==>
   +manual>
    isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			agent-set-int
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			landing_lights
    para-2			2
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
    task-value         as-desired ;need to set it back otherwise it will read tars interface as a new task
)

(p landing-lights-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    landing-light-switch
    =imaginal>
     isa		        aircraft-component
     component-name        landing-lights-switch
     component-status      2			; true means LANDING LIGHTS is ON
==>
    =goal>
     phase		check-task-on-tars
    stage       1
     task-value         as-desired ;need to set it back otherwise it will read tars interface as a new task
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; END OF LANDING LIGHTS - AS DESIRED task ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; ANTI-COLL Light Switch - ON task ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-anti-coll-light-is-on-and-trusted
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    anti-coll-light-switch
     task-value         on
     crosscheck         no
     tars-input         anti-collision-lights-are-on
    ?imaginal>
    state               free
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
(spp t-i-anti-coll-light-is-on-and-trusted :reward 4) ; TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-anti-coll-light-is-on-and-trusted :u 1000); higher than default of value-pair not found

(p t-i-anti-coll-light-is-on-and-distrust
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    anti-coll-light-switch
     task-value         on
     crosscheck         yes
     tars-input         anti-collision-lights-are-on
    ?imaginal>
    state               free
==>
    =goal>
     stage               2
)
(spp t-i-anti-coll-light-is-on-and-distrust :u 1000); higher than default of value-pair not found

(p anti-coll-light-is-off
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input         anti-collision-lights-are-off
    ?imaginal>
    state               free
==>
    =goal>
    stage               2
)
(spp anti-coll-light-is-off :u 1000); higher than default of value-pair not found

(p no-tars-input-on-anti-coll-light
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input          nil
==>
    =goal>
    stage               2
)
(spp no-tars-input-on-anti-coll-light :u 1000); higher than default of value-pair not found

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-anti-coll-light-switch
   =goal>
    isa		        task
    phase		    perform-task
    stage           2
    task-object	    anti-coll-light-switch
    task-value      on
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
   +visual-location>
    isa		        visual-location
    screen-x	    1870			; representing anti-coll-light-switch location
    screen-y	    1170
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-anti-coll-light-status-representation-has-tars-input
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    anti-coll-light-switch
    task-value      on
    - tars-input    nil
    ?imaginal>
    state           free

!bind! =value (read_input anti_coll_lights)		; hard coded way to get the aircraft-component-status from X-Plane

==>
   +imaginal>
    isa                   aircraft-component
    component-name        anti-coll-light-switch
    component-status      =value
   =goal>
    stage		          verify-tars-input
)

(p form-anti-coll-light-status-representation-no-tars-input
   =goal>
    isa		        task
    phase           perform-task
    task-object	    anti-coll-light-switch
    task-value      on
    stage		    form-representation-aircraft-component
    tars-input       nil
    ?imaginal>
    state           free
!bind! =value (read_input anti_coll_lights)		; hard coded way to get the aircraft-component-status from X-Plane
==>
    +imaginal>
    isa                   aircraft-component
    component-name        anti-coll-light-switch
    component-status      =value
   =goal>
    stage		          action
)

(p t-i-anti-coll-light-status-on-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input         anti-collision-lights-are-on
    =imaginal>
     isa		        aircraft-component
     component-name		anti-coll-light-switch
     component-status   true			; true means tars was reliable
==>
    =imaginal>
    =goal>
     phase               check-task-on-tars
    stage       1
)
(spp t-i-anti-coll-light-status-on-correspond-to-tars-input :reward -1) ;it took unnecessary time to check TARS input

(p t-i-anti-coll-light-status-does-not-correspond-to-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input         anti-collision-lights-are-on
    =imaginal>
     isa		        aircraft-component
     component-name		anti-coll-light-switch
     - component-status   true			; true means tars was not reliable
==>
    =imaginal>
    =goal>
     stage               action
)
(spp t-i-anti-coll-light-status-does-not-correspond-to-tars-input :reward 4) ;it was a good idea to check TARS input will be less
;trusted in the future

(p t-i-anti-coll-light-status-correspond-to-tars-input-off-and-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input         anti-collision-lights-are-off
     crosscheck         yes
    =imaginal>
     isa		        aircraft-component
     component-name		anti-coll-light-switch
     - component-status   true			; false means tars was reliable
==>
    =imaginal>
    =goal>
    stage               action
)
(spp t-i-anti-coll-light-status-correspond-to-tars-input-off-and-crosscheck :reward -1)

(p t-i-anti-coll-light-status-correspond-to-tars-input-off-and-no-crosscheck
    =goal>
     isa		        task
     phase		        perform-task
     stage		        verify-tars-input
     task-object	    anti-coll-light-switch
     task-value         on
     tars-input         anti-collision-lights-are-off
     crosscheck         no
    =imaginal>
     isa		        aircraft-component
     component-name		anti-coll-light-switch
     - component-status   true			; false means tars was reliable
==>
    =imaginal>
    =goal>
    stage               action
)
(spp t-i-anti-coll-light-status-correspond-to-tars-input-off-and-no-crosscheck :reward 4)
;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p anti-coll-light-take-action		;ANTI-COLL LIGHT is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    anti-coll-light-switch
    task-value      on
   =imaginal>
    isa		    aircraft-component
    component-name		anti-coll-light-switch
    - component-status				    true			; true means ANTI-COLL LIGHT is ON
   ?manual>
    state		free
==>
   +manual>
    isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			agent-set-bool
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			anti_coll_lights
    para-2			true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
)

(p anti-coll-light-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    anti-coll-light-switch
    =imaginal>
     isa		        aircraft-component
     component-name        anti-coll-light-switch
     component-status      true			; true means ANTI-COLL LIGHT is ON
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; END OF ANTI-COLL LIGHT - ON task ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; EICAS - Checked task ;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE EICAS CURRENT STATUS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-eicas
   =goal>
    isa		        task
    phase		    perform-task
    stage           1
    task-object	    eicas
    task-value      checked
    human-role      =value
    autonomy-role   =value2
    ?imaginal>
    state               free
==>
    +visual-location>
    isa		        visual-location
    screen-x	    1600			; representing eicas location
    screen-y	    920
    =goal>
    stage		    visual-encode-aircraft-component
)
(spp perform-visually-attend-eicas :u 1000); higher than default of value-pair not found

(p form-eicas-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    eicas
    task-value      checked
    ?imaginal>
    state           free
==>
   +imaginal>
    isa             eicas-situation
    cas             clear
    cas-status      no-alert
   =goal>
    phase           waiting-for-eicas
    stage           checked
   +goal-2>
    isa             task
    task-object     eicas
    phase           read-eicas
    stage           1
)

(p finish-procedural-eicas-check
   =goal>
    isa             task
    phase           waiting-for-eicas
    stage           checked
    task-object     eicas
    task-value      checked
   =goal-2>
    phase           eicas-complete
   =imaginal>
    isa             eicas-situation
    cas             clear
    cas-status      =cas_status
    e1-n1           =e1_n1
    e2-n1           =e2_n1
   ?imaginal>
    state           free
==>
   +imaginal>
    isa             aircraft-component
    component-name  eicas
    component-status =cas_status
   =goal>
    phase           perform-task
    stage           action
   -goal-2>
)
;;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NEEDED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p eicas-is-clear
   =goal>
    isa		        task
    phase		    perform-task
    stage		    action
    task-object	    eicas
    task-value      checked
   =imaginal>
    isa		        aircraft-component
    component-name		eicas
    component-status    no-alert
   ?manual>
    state		free
==>
    =goal>
    phase		check-task-on-tars
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; END OF EICAS - Checked task ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; WINDS - Check task ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; RETRIEVE THE WINDS CURRENT STATUS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p retrieve-current-wind-belief
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    winds
     task-value         check
    ?imaginal>
    state               free
==>
    =imaginal>
    +retrieval>
    isa                current-wind
    =goal>
    stage              2
)
(spp retrieve-current-wind-belief :u 1000); higher than default of value-pair not found

(p t-i-retrieve-current-wind-belief-success-and-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    winds
     task-value         check
    =imaginal>
    tars-input         =value
    =retrieval>
     isa                current-wind
     wind-direction     =wind-direction
     wind-speed         =wind-speed
==>
   +imaginal>
    isa                 current-wind
    wind-direction      =wind-direction
    wind-speed          =wind-speed
   =goal>
    tars-input         =value
    stage               compare
)

(p t-i-wind-comparison-match-tars-supporter ;assumed to always match for now
    =goal>
     isa		        task
     phase		        perform-task
     stage              compare
     task-object	    winds
     task-value         check
     autonomy-role      supporter
    - tars-input         nil
    =imaginal>
     isa                current-wind
==>
   =goal>
    phase               check-winds-popup
    stage               1
)

(p t-i-wind-comparison-match-tars-not-supporter ;assumed to always match for now
    =goal>
     isa		        task
     phase		        perform-task
     stage              compare
     task-object	    winds
     task-value         check
     -autonomy-role     supporter
    - tars-input         nil
    =imaginal>
     isa                current-wind
==>
   =goal>
    phase               check-task-on-tars
    stage               1
)

(p retrieve-current-wind-belief-success-no-tars-input-tars-supporter
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    winds
     task-value         check
     autonomy-role      supporter
    =imaginal>
    tars-input          nil
    =retrieval>
     isa                current-wind
     wind-direction     =wind-direction
     wind-speed         =wind-speed
==>
   +imaginal>
    isa                 current-wind
    wind-direction      =wind-direction
    wind-speed          =wind-speed
   =goal>
    phase               check-winds-popup
    stage               1
)

(p retrieve-current-wind-belief-success-no-tars-input-tars-no-supporter
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    winds
     task-value         check
     -autonomy-role     supporter
    =imaginal>
    tars-input          nil
    =retrieval>
     isa                current-wind
     wind-direction     =wind-direction
     wind-speed         =wind-speed
==>
   +imaginal>
    isa                 current-wind
    wind-direction      =wind-direction
    wind-speed          =wind-speed
   =goal>
    phase               check-task-on-tars
    stage               1
)

(p t-i-retrieve-current-wind-belief-failure-and-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    winds
     task-value         check
     ?retrieval>
     state             error
    =imaginal>
    tars-input         =value
==>
   =goal>
    tars-input         =value
    stage               check-atis
)

(p check-atis-for-wind-information
    =goal>
     isa		        task
     phase		        perform-task
     stage              check-atis
     task-object	    winds
     task-value         check
==>
    +visual-location>
    isa		        visual-location
    screen-x	    1600			; representing ATIS visual memo location
    screen-y	    920
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-atis-wind-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    winds
    task-value      check
    ?imaginal>
    state           free
==>
   +imaginal>
    isa                   current-wind
    wind-direction        090         ; assumed ATIS wind direction
    wind-speed            4           ; assumed ATIS wind speed
   =goal>
    stage		          check-windsock
)

(p check-windsock-for-wind-information
    =goal>
     isa		        task
     phase		        perform-task
     task-object	    winds
     task-value         check
     stage              check-windsock
    ?imaginal>
     state               free
==>
    =imaginal>
    +visual-location>
    isa		        visual-location
    screen-x	    760			; representing windsock OTW location
    screen-y	    450
    =goal>
    stage		    verify-coherence
)

(p t-i-verify-wind-information-coherence-and-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              verify-coherence
     task-object	    winds
     task-value         check
     - tars-input       nil
    ?imaginal>
    state               free
==>
   =goal>
    stage               compare
)

(p verify-wind-information-coherence-no-tars-input-tars-no-support
    =goal>
     isa		        task
     phase		        perform-task
     stage              verify-coherence
     task-object	    winds
     task-value         check
     tars-input         nil
     -autonomy-role     supporter
==>
   =goal>
    phase               check-task-on-tars
    stage               1
)

(p verify-wind-information-coherence-no-tars-input-tars-support
    =goal>
     isa		        task
     phase		        perform-task
     stage              verify-coherence
     task-object	    winds
     task-value         check
     tars-input         nil
     autonomy-role      supporter
==>
   =goal>
    phase               check-winds-popup
    stage               1
)

;;;;;;;;;;;; CHECK TASK FOR WINDS ;;;;;;;;;;;;;

(p check-1-press-check-winds-popup
    =goal>
    isa         task
    phase       check-winds-popup
    stage       1
    ?imaginal>
    state       free
    ?visual>
    state       free
    ?manual>
    state       free
    ?vocal>
    state       free
    ?aural>
    state       free
==>
    +manual>
        isa                     customized-manual-action
        name                    agent-set-impulsion
        preparation-duration    0.050
        initiation-duration     0.050
        execution-duration      0.050
        finish-duration         0.050
        para-1                  task_check
        para-2                  impulsion
        para-3
        para-4
    =goal>
        stage                   2
)
(p check-2-visually-attend-tars-wind-components-input
   =goal>
	isa		    task
	phase		check-winds-popup
    stage       2
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>
	state		free
   ?vocal>
    state		free
==>
   +visual-location>
	isa		visual-location
	screen-x	440			; representing tars input label
	screen-y	1250         ; representing tars input label
   =goal>
	stage		3
)
;; visually encode tars-wind-components-input
(p check-2-visually-encode-tars-wind-components-input
   =goal>
	isa		    task
	phase		check-winds-popup
    stage       3
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		    move-attention
	screen-pos	=visual-location
   =goal>
	stage		4
)
;; form tars-wind-components representation
(p check-3-form-tars-wind-components-representation
   =goal>
	isa		    task
	phase		check-winds-popup
    stage       4
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
	state		free
!bind! =value (read_input tars-input)		; hard coded way to get the TARS input
==>
   =imaginal>
	tars-input  =value
   =goal>
	phase		check-task-on-tars
	stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; END OF WINDS - Check task ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Select Altitude - PRESET AS CLEARED Task ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p t-i-selected-altitude-as-cleared-tars-input-trusted
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    select-altitude
     task-value         preset-as-cleared
     crosscheck         no
     tars-input         cleared-to-altitude-5000-ft-from-atc
    ?imaginal>
    state               free
==>
    =goal>
    stage               4
    +imaginal>
    isa                 aircraft-component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)
(spp t-i-selected-altitude-as-cleared-tars-input-trusted :reward 4); TARS has been trusted, no crosscheck ==> is reinforced
(spp t-i-selected-altitude-as-cleared-tars-input-trusted :u 1000); higher than default of value-pair not found

(p t-i-selected-altitude-as-cleared-tars-input-distrust
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    select-altitude
     task-value         preset-as-cleared
     crosscheck         yes
     tars-input         cleared-to-altitude-5000-ft-from-atc
    ?imaginal>
    state               free
==>
    =goal>
    stage              2
)
(spp t-i-selected-altitude-as-cleared-tars-input-distrust :u 1000); higher than default of value-pair not found

(p selected-altitude-as-cleared-no-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    select-altitude
     task-value         preset-as-cleared
     tars-input         nil
==>
    =goal>
    stage              2
)
(spp selected-altitude-as-cleared-no-tars-input :u 1000); higher than default of value-pair not found

(p retrieve-takeof-clearance
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    select-altitude
     task-value         preset-as-cleared
==>
    +retrieval>
    isa                clearance
    =goal>
    stage              3
)

(p t-i-takeoff-clearance-not-retrieved-but-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              3
     task-object	    select-altitude
     task-value         preset-as-cleared
    -tars-input        nil
    ?retrieval>
     state             error
==>
    =goal>
    stage               4
    +imaginal>
    isa                 aircraft-component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)

(p takeoff-clearance-retrieved-no-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              3
     task-object	    select-altitude
     task-value         preset-as-cleared
    =retrieval>
     isa                clearance
     altitude           =cleared-altitude
    =imaginal>
    tars-input         nil
==>
   +imaginal>
    isa                 aircraft-component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
   =goal>
    stage              4
)

(p t-i-takeoff-clearance-retrieved-successfully-and-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              3
     task-object	    select-altitude
     task-value         preset-as-cleared
    =retrieval>
     isa                clearance
     altitude           =cleared-altitude
    =imaginal>
    - tars-input        nil
    ?retrieval>
     state           free
==>
    =imaginal>
    +retrieval>
    =cleared-altitude
   =goal>
    stage              4
)

(p t-i-cleared-altitude-match-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              4
     task-object	    select-altitude
     task-value         preset-as-cleared
     crosscheck         yes
    =imaginal>
     tars-input         =value
    =retrieval>
     isa                word
     equivalent         =value
==>
   =goal>
    stage               5
   +imaginal>
    isa                 aircraft-component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)
(spp t-i-cleared-altitude-match-tars-input :reward -1) ; it took unnecessary time to check TARS input

(p t-i-cleared-altitude-retrieved-and-do-not-match-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              4
     task-object	    select-altitude
     task-value         preset-as-cleared
     crosscheck         yes
    =imaginal>
     tars-input         =value
    =retrieval>
     isa                word
    - equivalent        =value
==>
    =goal>
    stage               5
   +imaginal>
    isa                 aircraft-component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)
(spp t-i-cleared-altitude-retrieved-and-do-not-match-tars-input :reward 4) ; it was a good idea to check TARS input will be less

(p look-at-selected-altitude-on-pfd
    =goal>
     isa		        task
     phase		        perform-task
     stage              4
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     isa                aircraft-component
     component-name     selected-altitude
     desired-status     =value
   ?imaginal>
    state               free
==>
    =imaginal>
    +visual-location>
    isa		        visual-location
    screen-x	    1350			; representing selected altitude on PFD
    screen-y	    680
    =goal>
    stage		    visual-encode-aircraft-component
)

(p form-select-altitude-preset-as-cleared-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    select-altitude
    task-value      preset-as-cleared
   =imaginal>
    isa                aircraft-component
    component-name     selected-altitude
    desired-status     =value-goal
    ?imaginal>
    state        free

!bind! =value (read_input alt_sel)		; hard coded way to get the selected-altitude from X-Plane

==>
   +imaginal>
    isa                   aircraft-component
    component-name        selected-altitude
    component-status      =value
    desired-status        =value-goal
   =goal>
    stage		          action
)

(p select-altitude-preset-as-cleared-take-action
   =goal>
    isa		            task
    phase		        perform-task
    stage		        action
    task-object	        select-altitude
    task-value          preset-as-cleared
   =imaginal>
    isa		            aircraft-component
    component-name      selected-altitude
    component-status    =value
    - desired-status       =value
   ?manual>
    state		free
==>
    +manual>
    isa 			        customized-manual-action		; representing hand reach to altitude selector (time duration should be estimated based on human pilot video recordings)
    name			        agent-set-int
    preparation-duration	0.050
    initiation-duration	    0.050
    execution-duration	    5.0
    finish-duration		    1.0
    para-1			        alt_sel
    para-2			        5000 ; assuming cleared altitude is 5000 feet
    para-3
    para-4
    ; hard coded way to send the updated selected-altitude to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
    stage       1
)

(p select-altitude-preset-as-cleared-is-already-set
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     isa		        aircraft-component
     component-name        selected-altitude
     component-status      =value
     desired-status        =value
==>
    =goal>
     phase		check-task-on-tars
    stage       1
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; CHECK CAS TAKEOFF TASK ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;starting point
(p start-cas-check-clear-takeoff
    =goal>
     isa                    task
     phase                  perform-task
     stage                  1
    task-object             cas
    task-value              check-clear
    ?manual>
    state		            free
    ?imaginal>
    state                   free
==>
     =goal>
     phase                  waiting-for-eicas
     stage                  cas
    +imaginal>
     isa                    eicas-situation
     cas                    clear
     cas-status             no-alert
    +goal-2>
     isa                    task
     task-object            eicas
     phase                  read-eicas
     stage                  1
)
(spp start-cas-check-clear-takeoff :u 1000); higher than default of value-pair not found

(p finish-cas-eicas-check
   =goal>
    isa                    task
    phase                  waiting-for-eicas
    stage                  cas
    task-object            cas
    task-value             check-clear
   =goal-2>
    phase                  eicas-complete
   =imaginal>
    isa                    eicas-situation
    cas                    clear
    cas-status             no-alert
    e1-n1                  =e1_n1
    e2-n1                  =e2_n1
==>
   =goal>
    phase                  check-task-on-tars
    stage                  1
   =imaginal>
   -goal-2>
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; END OF CHECK CAS TAKEOFF TASK ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; GENERAL CHECK TASK ON TARS ACTION ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p check-1-visually-attend-current-task-object
   =goal>
	isa		    task
	phase		check-task-on-tars
    stage       1
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>
	state		free
   ?vocal>
    state		free
==>
   +visual-location>
	isa		visual-location
	screen-x	350			; representing current task label x-coordinate on TARS interface in the scene
	screen-y	990         ; representing current task label y-coordinate on TARS interface in the scene
   =goal>
	stage		2
)
;; visually encode current task on TARS interface
(p check-2-visually-encode-task-object-item
   =goal>
	isa		    task
	phase		check-task-on-tars
    stage       2
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		move-attention
	screen-pos	=visual-location
   =goal>
	stage		3
)
;; form task item representation in imaginal buffer
(p check-3-form-task-object-item-representation
   =goal>
	isa		    task
	phase		check-task-on-tars
    stage       3
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
	state		free
!bind! =value (read_input current_task_object)		; hard coded way to get the checklist item from TARS interface
==>
   +imaginal>
	isa		    task
	task-object	=value ; is getting the value from agent.current_task_object
   =goal>
	stage		check-2-1
)

(p check-2-1-visually-attend-current-task-value
   =goal>
    isa		    task
    phase		check-task-on-tars
    stage       check-2-1
   ?visual>
    state		free
   ?imaginal>
    state		free
   ?manual>
    state		free
==>
    +visual-location>
    isa		visual-location
    screen-x	350			; representing current task value label x-coordinate on TARS interface in the scene
    screen-y	1010        ; representing current task value label y-coordinate on TARS interface in the scene
   =goal>
    stage		check-2-2
)
;; visually encode current task value on TARS interface
(p 2-2-visually-encode-task-value-item
   =goal>
    isa		    task
    phase		check-task-on-tars
    stage       check-2-2
   =visual-location>
   ?visual>
    state		free
==>
   +visual>
    isa		move-attention
    screen-pos	=visual-location
   =goal>
    stage		check-2-3
)
;; form task value item representation in imaginal buffer
(p 2-3-form-task-value-item-representation
   =goal>
    isa		    task
    phase		check-task-on-tars
    stage       check-2-3
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
    state		free
   =imaginal>
    task-object	=value_obj
!bind! =value (read_input current_task_value)		; hard coded way to get the checklist item from TARS interface
==>
   +imaginal>
    isa		    task
    task-object	=value_obj ; is getting the value from imaginal buffer
    task-value	=value ; is getting the value from agent.current_task_value
   =goal>
    stage		4
)

(p t-i-task-was-autochecked-new-task-object
    =goal>
    isa             task
    phase           check-task-on-tars
    stage           4
    task-object     =task-object
    task-value      =task-value
    human-role      =human-role
    autonomy-role   =autonomy-role
    tars-input      =tars-input
    crosscheck      =crosscheck
   ?imaginal>
    state           free
    =imaginal>
   - task-object    =task-object
==>
    =goal>
    phase           attend-aoi
    stage           1
    status          checked
    +imaginal>
    isa             task
    task-object     =task-object
    task-value      =task-value
    human-role      =human-role
    autonomy-role   =autonomy-role
    tars-input      =tars-input
    crosscheck      =crosscheck
    status          checked
    !output! (task-object =task-object)
    !output! (task-value =task-value)
    !output! (status =status)
    !output! (human-role =human-role)
    !output! (autonomy-role =autonomy-role)
    !output! (tars-input =tars-input)
    !output! (crosscheck =crosscheck)
)

(p t-i-task-was-autochecked-new-task-value
    =goal>
    isa             task
    phase           check-task-on-tars
    stage           4
    task-value     =task-value
    task-object    =task-object
    human-role      =human-role
    autonomy-role   =autonomy-role
    tars-input      =tars-input
    crosscheck      =crosscheck
   ?imaginal>
    state           free
    =imaginal>
   - task-value     =task-value
==>
    =goal>
    phase           attend-aoi
    stage           1
    status          checked
    +imaginal>
    isa             task
    task-object     =task-object
    task-value      =task-value
    human-role      =human-role
    autonomy-role   =autonomy-role
    tars-input      =tars-input
    crosscheck      =crosscheck
    status          checked
    !output! (task-object =task-object)
    !output! (task-value =task-value)
    !output! (status =status)
    !output! (human-role =human-role)
    !output! (autonomy-role =autonomy-role)
    !output! (tars-input =tars-input)
    !output! (crosscheck =crosscheck)
)

(p t-i-task-was-not-autochecked-no-change
    =goal>
    isa             task
    phase           check-task-on-tars
    stage           4
    task-object     =task-object
    task-value      =task-value
   ?imaginal>
    state           free
    =imaginal>
     task-object    =task-object
     task-value     =task-value
==>
    =goal>
    stage           5
)

(p t-i-check-task-on-tars
    =goal>
    isa         task
    phase       check-task-on-tars
    stage       5
    ?imaginal>
    state       free
    ?visual>
    state       free
    ?manual>
    state       free
    ?vocal>
    state       free
    ?aural>
    state       free
==>
    +manual>
        isa                     customized-manual-action
        name                    agent-set-impulsion
        preparation-duration    0.050
        initiation-duration     0.050
        execution-duration      0.050
        finish-duration         0.050
        para-1                  task_check
        para-2                  impulsion
        para-3
        para-4
    =goal>
        stage                   6
)

(p t-i-subvocalize-check-task-on-tars
    =goal>
    isa         task
    phase       check-task-on-tars
    stage       6
   ?vocal>
    state       free
   ?manual>
    state       free
==>
    +vocal>
    cmd         subvocalize
    string      check-task-on-tars-interface
    =goal>
    stage       7
    status      checked
)

(p form-task-done
    =goal>
    isa             task
    phase           check-task-on-tars
    stage           7
    task-object     =task-object
    task-value      =task-value
    status          =status
    human-role      =human-role
   ?imaginal>
    state           free
   ?manual>
    state           free
==>
   +imaginal>
    isa            task
    task-object    =task-object
    task-value     =task-value
    status         =status
    human-role     =human-role
    =goal>
    phase          attend-aoi
    stage          1
    !output! (task-object =task-object)
    !output! (task-value =task-value)
    !output! (status =status)
    !output! (human-role =human-role)
)
;(spp form-task-done :at 0.5) ;schedule in 0.5 seconds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; END OF GENERAL CHECK TASK ON TARS ACTION ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
