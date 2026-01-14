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
	:visual_text					("L_TRHOTTLE")
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
    ;;Navigation Display
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
	:visual_text					("CURRENT_TASK")
	:display_item_screen_location_x			(350)
	:display_item_screen_location_y			(990)
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

	;(
	;:item_type					display_item_visual_text
	;:visual_text					("airspeed")
	;:display_item_screen_location_x			(810)
	;:display_item_screen_location_y			(95)
	;)
	;( :item_type   display_item_visual_text_button
	;:visual_text   	(  "a13"  )				;Landing
	;:display_item_screen_location_x  (470)
	;:display_item_screen_location_y  (550)
	;:display_item_width		(20)
	;:display_item_height		(30)
	;)
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
    :ul             nil    ; disable the utility learning mechanism
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
)

(chunk-type component
    component-name
    component-status
    desired-status
)

(chunk-type  clearance
    procedure
    sender
    callsign
    wind
    runway
    altitude
    heading
    navigation
    frequency
    status
)

(chunk-type callsign
    content
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

(chunk type cleared-altitude
    altitude
)

(add-dm
    (start-task
		isa 			task
        procedure       IDLE
		task-object	    Idle
        task-value      Waiting
        phase           reading-tars-interface
        stage           1
	)
    ;(takeoff-clearance
        ;isa 			clearance
        ;procedure       takeoff
        ;sender          montreal-tower
        ;callsign        c-poly
        ;wind            nil
        ;runway          06L
        ;altitude        nil
        ;heading         nil
        ;navigation      nil
        ;frequency       nil
        ;status          pending
    ;)
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
    (w-cleared-for-takeoff isa word value cleared-for-takeoff category procedure)
    (w-runway-heading isa word value maintain-runway-heading category heading)
    (w-to-five-thousand isa word value climb-to-5000ft equivalent cleared-to-altitude-5000-ft-from-atc category altitude)
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
   ==>
   +aural>
     event          =aural-location
   =goal>
    phase           encode-sound
)
(spp detected-sound :u 1) ; is a salient production
; encode sound and location of sound into imaginal buffer
(p encode-sound
   =goal>
    phase   encode-sound
   =aural>
     isa     sound
     content   =content
     location  =location
   ==>
   +imaginal>
     isa        sound
     content    =content
     location   =location
     !output!   (=location); debug
     !output!   (=content); debug
    =goal>
    stage        sound-encoded
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; END BLOCK PERCEPTION AND ENCODING OF SOUND ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; READING TARS INTERFACE TO GET CURRENT TASK TO PERFORM;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visually attend to current task on TARS interface
(p x-1-visually-attend-current-task
   =goal>
	isa		    task
	phase		reading-tars-interface
    stage       1
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>
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
(p x-2-visually-encode-task-item
   =goal>
	isa		    task
	phase		reading-tars-interface
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
(p x-3-form-task-item-representation
   =goal>
	isa		    task
	phase		reading-tars-interface
    stage       3
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
	state		free
!bind! =value (read_input current_task_object)		; hard coded way to get the checklist item from TARS interface
!bind! =value2 (read_input current_task_value)		; hard coded way to get the checklist item from TARS interface
==>
   +imaginal>
	isa		    task
	task-object	=value ; is getting the value from agent.current_task_object
    task-value  =value2 ; is getting the value from agent.current_task_value
   =goal>
	stage		4
)

;; IF THE READ TASK HASN'T CHANGED YET AND IT HAS BEEN CHECKED READ AGAIN
(p x-4-same-task-stage-checked
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
     stage          1
)
;; IF WE'RE STILL IN (IDLE - WAIT) GO BACK TO P1 AND READ TARS INTERFACE AGAIN
(p x-4-wait-task-go-back-to-wait-for-start-command
   =goal>
	isa		    task
	phase		reading-tars-interface
    stage       4
   =imaginal>
	task-value	waiting
==>
   =goal>
	stage		1
)

(p x-4-na-task-go-back-to-wait-for-start-command
   =goal>
    isa		    task
    phase		reading-tars-interface
    stage       4
   =imaginal>
    task-value	n-a
==>
    =goal>
    stage		1
)
(spp x-4-na-task-go-back-to-wait-for-start-command :u 10) ; need to be higher to capture
;; IF TASK NOT CHANGED AND ALLOCATED TO TARS READ AGAIN
(p x-4-human-not-performer-of-task
   =goal>
    isa		        task
    phase           reading-tars-interface
    stage		    4
    status          wait-teammate
    task-object     =value_obj
    task-value      =value_val
   =imaginal>
    isa             task
    task-object     =value_obj
    task-value      =value_val
==>
    =goal>
    stage           1
)

;; ELSE IF NOT TASK WAITING AND THE TASK REPRESENTATION FORMED IS DIFFERENT FROM GOAL
;; THEN PROCEED TO NEXT STEPS TO READ TASK ALLOCATION INFORMATION
; visually attend to current task human role on TARS interface
(p x-4-not-waiting-new-task-value
    =imaginal>
    task-value      =value_val
    - task-value    waiting
   =goal>
	isa		    task
    phase       reading-tars-interface
	stage		4
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

(p x-4-not-waiting-new-task-object ; alternative version to capture both task-object and task-value changes
    =imaginal>
    - task-value    waiting
    task-object	    =value_obj
   =goal>
    isa		    task
    phase       reading-tars-interface
    stage		4
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

(p x-4-not-waiting-new-task-both ; alternative version to capture both task-object and task-value changes
    =imaginal>
    task-object	    =value_obj
    task-value      =value_val
   =goal>
    isa		    task
    phase       reading-tars-interface
    stage		4
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
(spp x-4-not-waiting-new-task-both :u 4) ; need to be higher to capture both in priority

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; END BLOCK READING TARS INTERFACE for new task;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; BLOCK CHECK ALLOCATION ON TARS INTERFACE FOR TASK;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p x-1-visually-attend-current-task-human-role
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
(p x-2-visually-encode-allocation-item
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
(p x-3-form-task-item-allocation-human-role-representation
   =goal>
	isa		    task
    phase        check-allocation
	stage       3

!bind! =value (read_input current_task_human_role)	; hard coded way to get the value from TARS interface

==>
   =imaginal>
   =goal>
	stage        4
    human-role	=value
)
; visually attend to current task autonomy role on TARS interface
(p x-4-visually-attend-current-task-autonomy_role
   =goal>
	isa		    task
    phase		check-allocation
	stage        4
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>					; make sure only start a step when no other action is taking place within these modules
	state		free
==>
   +visual-location>
	isa		visual-location
	screen-x	320			; representing current task location on TARS interface
	screen-y	990
   =goal>
	stage        5
    =imaginal>
)
; visually encode current task autonomy role on TARS interface
(p x-5-visually-encode-allocation-item
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
(p x-6-form-task-item-allocation-autonomy-role-representation
   =goal>
	isa		    task
    phase       check-allocation
	stage       6
   =visual>

!bind! =value (read_input current_task_autonomy_role)	; hard coded way to get the value from TARS interface

==>
   =goal>
    autonomy-role	=value
    phase           check-tars-input
	stage		    1
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
    phase        perform-task
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
(p x-1-visually-attend-tars-input-supporter ;if TARS is supporter
    =goal>
     isa		    task
     autonomy-role  supporter
     phase           check-tars-input
     stage          1
    ?visual>
    state		free
==>
    +visual-location>
     isa		visual-location
     screen-x	440			; representing TARS input box x-coordinate on TARS interface
     screen-y	1250
    =goal>
     stage        2
)

(p x-1-skip-tars-input-because-tars-is-not-supporter ;if TARS is not supporter
    =goal>
     isa		        task
     - autonomy-role    supporter
     phase              check-tars-input
     stage              1
    ?visual>
    state		        free
==>
    =goal>
     phase               perform-task
     stage              1
)

(p x-2-visually-encode-tars-input
    =goal>
     isa		    task
     autonomy-role  supporter
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

(p x-3-form-tars-input-representation
    =goal>
     isa		        task
     autonomy-role      supporter
     phase              check-tars-input
     stage              3
    =visual>
    ?imaginal>
    state		        free
!bind! =value (read_input tars_input)	; hard coded way to get the TARS input from TARS interface
==>
    =imaginal>
     tars-input         =value
    =goal>
    phase               perform-task
    stage              1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BLOCK CHECK TARS INPUT IN INTERACTION PANEL FOR SUPPORT;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;;;;;;;;;;;;;;COMPARE WORD TO SELF CALLSIGN TO DETERMINE IF THE CLEARANCE IS FOR US;;;;;;;;;;;;;;;;
(p retrieve-self-callsign
    =goal>
    stage           sound-encoded
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
==>
    +imaginal>
    isa             clearance
    procedure       takeoff
    callsign        c-poly
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    human-role      nil
    autonomy-role   nil
    phase           perform-task
    stage           wait
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
    phase       reading-tars-interface
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
    stage       wait
    =imaginal>
    isa         clearance
    procedure   takeoff
==>
    =imaginal>
    =goal>
    stage      start-timing
)

(p start-timing
    =goal>
    isa         task
    task-object takeoff-clearance
    task-value  confirm
    phase       perform-task
    stage       start-timing
    =imaginal>
    isa         clearance
    procedure   takeoff
==>
    =imaginal>
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RETRIEVAL ATTEMPT FOR WORD IN MEMORY;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This production follow up the encode-sound production to check if the message is from ATC
; retrieve self callsign from declarative memory if the message comes from ATC
(p retrieval-attempt-for-word-from-takeoff-clearance-stop-timer
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    phase           encode-sound
    =aural>
     isa            sound
     content        =content
     location       atc
    =imaginal>
     isa            clearance
     procedure      takeoff
==>
    +temporal>
    isa             clear
    =imaginal>
    +retrieval>
     isa         word
     value       =content
    =goal>
    phase       perform-task
     stage       add-to-clearance-representation
)
(spp retrieval-attempt-for-word-from-takeoff-clearance-stop-timer :u 4) ; utility higher than regular encode-word for priority to current task

;;;;;;;;;;;;;;;;;;;;;;;;RETRIEVAL SUCCESS, MAP RETRIEVED WORD TO CLEARANCE SLOT;;;;;;;;;;;;;;;;;;;;
(p form-sender-representation-from-takeoff-clearance
    =goal>
    phase       perform-task
    stage       add-to-clearance-representation
    =imaginal>
        isa         clearance
        procedure   takeoff
    =retrieval>
     isa         word
     value       =content
     category    sender
==>
    =imaginal>
    sender      =content
    =goal>
     stage       wait
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
     stage          wait
)
(spp form-runway-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

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
     stage          wait
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
     stage          wait
)
(spp form-altitude-representation-from-takeoff-clearance :u 3) ; high utility for priority before attending to new sound

(p end-of-communication-go-check-allocation ;end of the clearance
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

(p end-of-communication-and-we-have-allocation ;end of the clearance
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
(p allocation-to-takeoff-clearance-readback-by-tars
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    phase           perform-task
    stage           1
    - human-role    performer
==>
    =goal>
    phase           reading-tars-interface ; wait for next task because TARS will perform the readback
    stage           1
    status          wait-teammate
)

(p allocation-to-takeoff-clearance-readback-by-pilot
    =goal>
    isa             task
    task-object     takeoff-clearance
    task-value      confirm
    phase           perform-task
    stage           1
    human-role      performer
==>
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
;; PITOT-STATIC Switch - PITOT STATIC TASK ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pitot-heat-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pitot-static-switch
     task-value         pitot-static
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         pitot-heat-is-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp pitot-heat-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE PITOT STATIC SWITCH ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-pitot-static-switch
   =goal>
	isa		        task
	phase		    perform-task
    stage           1
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

(p form-pitot-heat-status-representation
   =goal>
	isa		    task
    phase        perform-task
    task-object	    pitot-static-switch
    task-value      pitot-static
	stage		form-representation-aircraft-component
    ?imaginal>
    state        free

!bind! =value (read_input pitot_heat)		; hard coded way to get the aircraft-component-status from X-Plane

==>
   +imaginal>
    isa                   component
	component-name        pitot-switch
	component-status      =value
   =goal>
	stage		action
)

;;;;;;;;;;;;;;;;;;;;;;;; SWITCH THE PITOT HEAT TO ON ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pitot-heat-take-action		;PITOT-HEAT is OFF
   =goal>
	isa		    task
    phase		perform-task
	stage		action
    task-object	    pitot-static-switch
    task-value      pitot-static
   =imaginal>
	isa		    component
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
)

(p pitot-heat-no-action		;PITOT-HEAT already ON
   =goal>
	isa		                    task
    phase		                perform-task
	stage		                action
    task-object	            pitot-static-switch
    task-value              pitot-static
   =imaginal>
	isa				            component
    component-name		        pitot-switch
    component-status			true			; true means PITOT-HEAT is ON
==>
   =goal>
    phase                       check-task-on-tars
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENGINE ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p engine-anti-ice-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         engine-anti-ice-is-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp engine-anti-ice-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p understand-engine-anti-ice-as-required-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    engine-anti-ice-switches
     task-value         as-required
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         =tars-input
==>
    =goal>
     stage		        2
     task-value         =tars-input
)
(spp engine-anti-ice-is-already-on-according-to-tars :u 2)

(p tars-recommend-check-visible-moisture-present-condition
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    engine-anti-ice-switches
     task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
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

(p tars-do-not-recommend-check-visible-moisture-present-condition
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    engine-anti-ice-switches
     - task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
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
     task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
     status              nil ; not yet set
    ?imaginal>
    state               free
==>
   +imaginal>
    isa		            component
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
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    status          left
    task-object	    engine-anti-ice-switches
    ?imaginal>
    state           free
!bind! =value (read_input l_eng_ai)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   component
    component-name        left-engine-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-left
)

;;;;;;;;;;;;;;;;;;;;;;;; EXECUTE ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p left-engine-anti-ice-take-action		;ENGINE ANTI-ICE is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action-left
    status      left
    task-object	    engine-anti-ice-switches
    task-value      last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
   =imaginal>
    isa		    component
    component-name		left-engine-anti-ice-switch
    - component-status				    true			; true means ENGINE ANTI-ICE is ON
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
    para-1			l_engine_anti_ice
    para-2			true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    stage          right-1
)

(p left-engine-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-left
     status             left
     task-object	    engine-anti-ice-switches
    =imaginal>
     isa		        component
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
    - task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
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
    isa                   component
    component-name        right-engine-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-right
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p engine-right-anti-ice-take-action		;RIGHT ENGINE ANTI-ICE is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action-right
    status      right
    task-object	    engine-anti-ice-switches
    task-value      last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
   =imaginal>
    isa		    component
    component-name		right-engine-anti-ice-switch
    - component-status				    true			; true means ENGINE ANTI-ICE is ON
   ?manual>
    state		free
==>
   +manual>
    isa 			    customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
    name			    agent-set-bool
    preparation-duration	0.050
    initiation-duration	0.050
    execution-duration	1.0
    finish-duration		1.0
    para-1			    r_engine_anti_ice
    para-2			    true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		        check-task-on-tars
    task-value          as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p right-engine-anti-ice-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    engine-anti-ice-switches
    =imaginal>
     isa		        component
     component-name     right-engine-anti-ice-switch
     component-status   true			; true means ENGINE ANTI-ICE is ON
==>
    =goal>
     phase		        check-task-on-tars
     task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p no-action-recommendation-right-engine-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    engine-anti-ice-switches
    - task-value        last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-engine-anti-ice-on
==>
    =goal>
    task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
    phase		       check-task-on-tars
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END ENGINE ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WINDSHIELD ANTI-ICE Switches - AS REQUIRED task ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p windshield-anti-ice-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         windshield-anti-ice-is-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp windshield-anti-ice-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p understand-windshield-anti-ice-as-required-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    windshield-anti-ice-switches
     task-value         as-required
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         =tars-input
==>
    =goal>
     stage		        2
     task-value         =tars-input
)
(spp windshield-anti-ice-is-already-on-according-to-tars :u 2)

(p tars-recommend-check-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    windshield-anti-ice-switches
     task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
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

(p tars-do-not-recommend-check-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    windshield-anti-ice-switches
     - task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
    ?imaginal>
    state               free
==>
    =goal>
     stage		        3
)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK ENVIRONMENT TO DECIDE ACTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p confirm-visible-moisture-present-condition-windshield
    =goal>
     isa		        task
     phase		        perform-task
     stage              form-representation-aircraft-component
     task-object	    windshield-anti-ice-switches
     task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
     status              nil ; not yet set
    ?imaginal>
    state               free
==>
   +imaginal>
    isa		            component
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
    isa                   component
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
    task-value      last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
   =imaginal>
    isa		    component
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
     isa		        component
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
    - task-value         last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
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
    isa                   component
    component-name        right-windshield-anti-ice-switch
    component-status      =value
   =goal>
    stage		action-right
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p right-windshield-anti-ice-take-action		;RIGHT WINDSHIELD ANTI-ICE is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action-right
    status      right
    task-object	    windshield-anti-ice-switches
    task-value      last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
   =imaginal>
    isa		    component
    component-name		right-windshield-anti-ice-switch
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
    para-1			    r_windshield_anti_ice
    para-2			    true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
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
     isa		        component
     component-name     right-windshield-anti-ice-switch
     component-status   true			; true means WINDSHIELD ANTI-ICE is ON
==>
    =goal>
     phase		        check-task-on-tars
     task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
)

(p no-action-recommendation-right-windshield-anti-ice
    =goal>
     isa		        task
     phase		        perform-task
     stage              action-right
     status             right
     task-object	    windshield-anti-ice-switches
    - task-value        last-metar-temperature-05-degrees-celsius---if-visible-moisture-present-windshield-anti-ice-on
==>
    =goal>
    task-value         as-required ;need to set it back otherwise it will read tars interface as a new task
    phase		       check-task-on-tars
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END WINDSHIELD ANTI-ICE Switches - AS REQUIRED task ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; PAX SAFETY Switch - PAX SAFETY task ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pax-safety-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    pax-safety-switch
     task-value         pax-safety
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         pax-safety-switch-is-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp pax-safety-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE PAX SAFETY SWITCH CURRENT STATUS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-pax-safety-switch
   =goal>
    isa		        task
    phase		    perform-task
    stage           1
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

(p form-pax-safety-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    pax-safety-switch
    task-value      pax-safety
    ?imaginal>
    state        free
!bind! =value (read_input pax_safety)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   component
    component-name        pax-safety-switch
    component-status      =value
   =goal>
    stage		action
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NEEDED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p pax-safety-take-action		;PAX SAFETY is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    pax-safety-switch
    task-value      pax-safety
   =imaginal>
    isa		    component
    component-name		pax-safety-switch
    - component-status				    true			; true means PAX SAFETY is ON
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
    para-1			pax_safety
    para-2			true
    para-3
    para-4
    ; hard coded way to send the updated aircraft-component-status to X-Plane using agent-set-output action
    =goal>
    phase		check-task-on-tars
)

(p pax-safety-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    pax-safety-switch
    =imaginal>
     isa		        component
     component-name        pax-safety-switch
     component-status      true			; true means PAX SAFETY is ON
==>
    =goal>
     phase		check-task-on-tars
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END PAX SAFETY Switch - PAX SAFETY task ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LANDING LIGHTS Switch - AS DESIRED task ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p landing-lights-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    landing-light-switch
     task-value         as-desired
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         landing-lights-is-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp landing-lights-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; CHECK TEAMMATE RECOMMENDATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p understand-landing-lights-as-desired-tars-recommendation
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    landing-light-switch
     task-value         as-desired
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         =tars-input
==>
    =goal>
     stage		        2
     task-value         =tars-input
)
(spp landing-lights-is-already-on-according-to-tars :u 2)

(p tars-recommend-landing-lights-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    landing-light-switch
     task-value         landing-lights-on
    ?imaginal>
    state               free
==>
    =goal>
     stage		        3
)

(p tars-do-not-recommend-landing-lights-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    landing-light-switch
     - task-value       landing-lights-on
    ?imaginal>
    state               free
==>
    =goal>
     stage              3
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
    isa                   component
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
    isa		    component
    component-name		landing-lights-switch
    - component-status				    true			; true means LANDING LIGHTS is ON
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
    task-value         as-desired ;need to set it back otherwise it will read tars interface as a new task
)

(p landing-lights-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    landing-light-switch
    =imaginal>
     isa		        component
     component-name        landing-lights-switch
     component-status      true			; true means LANDING LIGHTS is ON
==>
    =goal>
     phase		check-task-on-tars
     task-value         as-desired ;need to set it back otherwise it will read tars interface as a new task
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; END OF LANDING LIGHTS - AS DESIRED task ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; ANTI-COLL Light Switch - ON task ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p anti-coll-light-is-already-on-according-to-tars
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    anti-coll-light-switch
     task-value         on
    ?imaginal>
    state               free
    =imaginal>
     isa		        task
     tars-input         anti-collision-lights-are-on
==>
    =goal>
     phase		check-task-on-tars
)
(spp anti-coll-light-is-already-on-according-to-tars :u 2)

;;;;;;;;;;;;;;;;;;;;;;;; LOOK AT THE CURRENT STATE OF THE SWITCH;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p perform-visually-attend-anti-coll-light-switch
   =goal>
    isa		        task
    phase		    perform-task
    stage           1
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

(p form-anti-coll-light-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    anti-coll-light-switch
    task-value      on
    ?imaginal>
    state        free
!bind! =value (read_input anti_coll_lights)		; hard coded way to get the aircraft-component-status from X-Plane
==>
   +imaginal>
    isa                   component
    component-name        anti-coll-light-switch
    component-status      =value
   =goal>
    stage		action
)

;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NECESSARY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p anti-coll-light-take-action		;ANTI-COLL LIGHT is OFF
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    anti-coll-light-switch
    task-value      on
   =imaginal>
    isa		    component
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
)

(p anti-coll-light-is-already-on
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    anti-coll-light-switch
    =imaginal>
     isa		        component
     component-name        anti-coll-light-switch
     component-status      true			; true means ANTI-COLL LIGHT is ON
==>
    =goal>
     phase		check-task-on-tars
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

(p form-eicas-status-representation
   =goal>
    isa		        task
    phase           perform-task
    stage		    form-representation-aircraft-component
    task-object	    eicas
    task-value      checked
    ?imaginal>
    state        free
==>
   +imaginal>
    isa                   component
    component-name        eicas
    component-status      clear
   =goal>
    stage		action
)
;;;;;;;;;;;;;;;;;;;;;;;;; PERFORM ACTION IF NEEDED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p eicas-is-clear
   =goal>
    isa		    task
    phase		perform-task
    stage		action
    task-object	    eicas
    task-value      checked
   =imaginal>
    isa		    component
    component-name		eicas
    component-status    clear
   ?manual>
    state		free
==>
    =goal>
    phase		check-task-on-tars
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

(p retrieve-current-wind-belief-success-and-tars-input-available
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

(p wind-comparison-match ;assumed to always match for now
    =goal>
     isa		        task
     phase		        perform-task
     stage              compare
     task-object	    winds
     task-value         check
    - tars-input         nil
    =imaginal>
     isa                current-wind
==>
   =goal>
    phase               check-task-on-tars
)

(p retrieve-current-wind-belief-success-no-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    winds
     task-value         check
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
)

(p retrieve-current-wind-belief-failure-and-tars-input-available
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

(p verify-wind-information-coherence-and-tars-input-available
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

(p verify-wind-information-coherence-no-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              verify-coherence
     task-object	    winds
     task-value         check
     tars-input         nil
==>
   =goal>
    phase               check-task-on-tars
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; END OF WINDS - Check task ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Select Altitude - PRESET AS CLEARTED Task ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p retrieve-takeof-clearance
    =goal>
     isa		        task
     phase		        perform-task
     stage              1
     task-object	    select-altitude
     task-value         preset-as-cleared
==>
    +retrieval>
    isa                clearance
    =goal>
    stage              2
)

(p takeoff-clearance-retrieved-successfully-and-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
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
    stage              3
)

(p cleared-altitude-retrieved-and-match-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              3
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     tars-input         =value
    =retrieval>
     isa                word
     equivalent         =value
==>
   =goal>
    stage               4
   +imaginal>
    isa                 component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)

(p cleared-altitude-retrieved-and-do-not-match-tars-input
    =goal>
     isa		        task
     phase		        perform-task
     stage              3
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     tars-input         =value
    =retrieval>
     isa                word
    - equivalent        =value
==>
    =goal>
    stage               4
   +imaginal>
    isa                 component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)

(p takeoff-clearance-not-retrieved-but-tars-input-available
    =goal>
     isa		        task
     phase		        perform-task
     stage              2
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
    - tars-input        nil
    ?retrieval>
     state             error
==>
    =goal>
    stage               4
    +imaginal>
    isa                 component
    component-name      selected-altitude
    desired-status      5000 ; assuming cleared altitude is 5000 feet
)

(p look-at-selected-altitude-on-pfd
    =goal>
     isa		        task
     phase		        perform-task
     stage              4
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     isa                component
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
    isa                component
    component-name     selected-altitude
    desired-status     =value-goal
    ?imaginal>
    state        free

!bind! =value (read_input alt_sel)		; hard coded way to get the selected-altitude from X-Plane

==>
   +imaginal>
    isa                   component
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
    isa		            component
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
)

(p select-altitude-preset-as-cleared-is-already-set
    =goal>
     isa		        task
     phase		        perform-task
     stage              action
     task-object	    select-altitude
     task-value         preset-as-cleared
    =imaginal>
     isa		        component
     component-name        selected-altitude
     component-status      =value
     desired-status        =value
==>
    =goal>
     phase		check-task-on-tars
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; GENERAL CHECK TASK ON TARS ACTION ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(p check-task-on-tars
    =goal>
    isa         task
    phase       check-task-on-tars
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
    isa         customized-manual-action
    name        agent-set-impulsion
    preparation-duration 0.050
    initiation-duration  0.050
    execution-duration   0.050
    finish-duration      0.050
    para-1               task_check
    para-2               impulsion
    para-3
    para-4
    =goal>
    phase       reading-tars-interface
    status      checked
    stage       1
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; END OF GENERAL CHECK TASK ON TARS ACTION ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
