;; QN_ACTR_Model_Initialization HAT citation Mustang Takeoff with TARS
;; QN-ACTR, Sample piloting model 
;; For questions and comments, please send to Shi Cao (shi.cao@uwaterloo.ca).

;;;;;;;;;;;;;;;;;;;;;
;; Task definition ;;
;;;;;;;;;;;;;;;;;;;;;

(use_world3d_template   
	:method    	pilotingxplane    
)

(use_predefined_model_setup		model_pilot_xplane)
;; the model will be connected with XPlane


; visual representation of the C172 control panel
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
	:visual_text					("CURRENT_TASK")
	:display_item_screen_location_x			(350)
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

; simplified procedure for C172SP in X-Plane
; piloting aircraft 
; different tasks represented by different chunk types, e.g., checklist-procedure, manual-flight-control


;;;;;;;;;;; PARAMETERS

(sgp	
	:visual-attention-latency	0.085	;This parameter specifies how long a visual attention shift will take in seconds.  The default value is .085.
	:imaginal-delay			0.2	;a non-negative number	The imaginal-delay parameter controls how long it takes a request or modification request to the imaginal buffer to complete.  It can be set to a non-negative time (in seconds) and defaults to .2.
)





;;;;;;;;;;; CHUNKS

(chunk-type  checklist-procedure			
	procedure-name
	step			
	phase

)

(chunk-type  checklist-item-representation
	item-name
)

(chunk-type  aircraft-component-status-representation
	aircraft-component-name
	status				
)



(add-dm	(checklist-goal 
		isa 			checklist-procedure
		procedure-name	 	pre-takeoff			
		step 			1
		phase			1
	)
)

(goal-focus checklist-goal)




;;;;;;;;;;; PRODUCTION RULES

(p x-1-visually-attend-checklist		;step x, phase 1. all steps can share this production rule for phase 1
   =goal>
	isa		checklist-procedure
	phase		1
   ?visual>
	state		free
   ?imaginal>
	state		free
   ?manual>					; make sure only start a step when no other action is taking place within these modules
	state		free
==>
   +visual-location>
	isa		visual-location
	screen-x	1600			; representing checklist location
	screen-y	500	   
   =goal>
	phase		2
)

(p x-2-visually-encode-checklist-item		;step x, phase 2. all steps can share this production rule for phase 2
   =goal>
	isa		checklist-procedure
	phase		2
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		move-attention
	screen-pos	=visual-location
   =goal>
	phase		3
)

(p 1-3-form-checklist-item-representation
   =goal>
	isa		checklist-procedure
	step		1
	phase		3
   =visual>					; assume the model has read the checklist item properly
   ?imaginal>
	state		free
==>
   +imaginal>
	isa		checklist-item-representation
	item-name	ignition-switch-off	; assume this is the result from reading the checklist
   =goal>
	phase		4
)

(p 1-4-visually-attend-aircraft-component
   =goal>
	isa		checklist-procedure
	step		1
	phase		4
   =imaginal>
	isa		checklist-item-representation
	item-name	ignition-switch-off
==>
   +visual-location>
	isa		visual-location
	screen-x	160			; representing ignition-switch location
	screen-y	520	   
   =goal>
	phase		5
)

(p x-5-visually-encode-aircraft-component	;step x, phase 2. all steps can share this production rule for phase 2
   =goal>
	isa		checklist-procedure
	phase		5
   =visual-location>
   ?visual>
	state		free
==>
   +visual>
	isa		move-attention
	screen-pos	=visual-location
   =goal>
	phase		6
)

(p 1-6-form-aircraft-component-status-representation
   =goal>
	isa		checklist-procedure
	step		1
	phase		6
   =visual>					; assume the model has read the aircraft-component-status properly
   ?imaginal>
	state		free

!bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/ignition_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
   +imaginal>
	isa				aircraft-component-status-representation
	aircraft-component-name		ignition-switch-1
	status				=value
   =goal>
	phase		7
)

(p 1-7a-take-control-action		;ignition set to OFF
   =goal>
	isa		checklist-procedure
	step		1
	phase		7
   =imaginal>
	isa				aircraft-component-status-representation
	aircraft-component-name		ignition-switch-1
	- status				0			; 0 means ignition is OFF, so this condition is met when it is not OFF
   ?manual>
	state		free
==>
   +manual>
	isa 			customized-manual-action		; representing hand reach to ignition switch (time duration should be estimated based on human pilot video recordings)
	name			x-plane-button-action
	preparation-duration	0.050
	initiation-duration	0.050
	execution-duration	1.0
	finish-duration		1.0
	para-1 			sim/cockpit2/engine/actuators/ignition_on
	para-2			0
    para-3
    para-4
	
	; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

   =goal>
	step		2
	phase		1
)


(p 1-7b-no-action-needed
   =goal>
	isa		checklist-procedure
	step		1
	phase		7
   =imaginal>
	isa				aircraft-component-status-representation
	aircraft-component-name		ignition-switch-1
	status				0
==>
   =goal>
	step		2
	phase		1
)

(p 2-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		2
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	avionics-switch-off	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 2-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		2
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	avionics-switch-off
==>
+visual-location>
 isa		visual-location
 screen-x	380			; representing avionics-switch location
 screen-y	490
=goal>
 phase		5
)

(p 2-6-form-aircraft-component-status-representation
=goal>
 isa		checklist-procedure
 step		2
 phase		6
=visual>					; assume the model has read the aircraft-component-status properly
?imaginal>
 state		free

!bind! =value (x-plane-getdref  sim/cockpit2/switches/avionics_power_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
+imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		avionics-switch-1
 status				=value
=goal>
 phase		7
)

(p 2-7a-take-control-action		;avionics set to OFF
=goal>
 isa		checklist-procedure
 step		2
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		avionics-switch-1
 - status				0			; 0 means avionics is OFF, so this condition is met when it is not OFF
?manual>
 state		free
==>
+manual>
 isa 			customized-manual-action		; representing hand reach to avionics switch (time duration should be estimated based on human pilot video recordings)
 name			x-plane-button-action
 preparation-duration	0.050
 initiation-duration	0.050
 execution-duration	1.0
 finish-duration		1.0
 para-1 			sim/cockpit2/switches/avionics_power_on
 para-2			0
 para-3 			sim/cockpit2/electrical/cross_tie
 para-4			0

 ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

=goal>
 step		3
 phase		1
)


(p 2-7b-no-action-needed
=goal>
 isa		checklist-procedure
 step		2
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		avionics-switch-1
 status				0
==>
=goal>
 step		3
 phase		1
)

(p 3-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		3
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	master-switch-on	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 3-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		3
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	master-switch-on
==>
+visual-location>
 isa		visual-location
 screen-x	320 		; representing master-switch location
 screen-y	490
=goal>
 phase		5
)

(p 3-6-form-aircraft-component-status-representation
=goal>
 isa		checklist-procedure
 step		3
 phase		6
=visual>					; assume the model has read the aircraft-component-status properly
?imaginal>
 state		free

!bind! =value (x-plane-getdref  sim/cockpit/electrical/battery_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
+imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		master-switch
 status				=value
=goal>
 phase		7
)

(p 3-7a-take-control-action		;master switch set to OFF
=goal>
 isa		checklist-procedure
 step		3
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		master-switch
 - status				1			; 0 means master is OFF, so this condition is met when it is not OFF
?manual>
 state		free
==>
+manual>
 isa 			customized-manual-action		; representing hand reach to master switch (time duration should be estimated based on human pilot video recordings)
 name			x-plane-button-action
 preparation-duration	0.050
 initiation-duration	0.050
 execution-duration	    1.0              ; movement and making change
 finish-duration		1.985
 para-1 			sim/cockpit/electrical/battery_on
 para-2			1
 para-3 			sim/cockpit/electrical/generator_on
 para-4			1

 ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

=goal>
 step		4
 phase		1
)


(p 3-7b-no-action-needed
=goal>
 isa		checklist-procedure
 step		3
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		master-switch
 status				1
==>
=goal>
 step		4
 phase		1
)

(p 4-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		4
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	fuel-quantity	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 4-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		4
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	fuel-quantity
==>
+visual-location>
 isa		visual-location
 screen-x	1190			; representing fuel display location
 screen-y	285
=goal>
 phase		5
)

(p 4-6-form-aircraft-component-status-representation
=goal>
 isa		checklist-procedure
 step		4
 phase		6
=visual>					; assume the model has read the aircraft-component-status properly
?imaginal>
 state		free

!bind! =value (x-plane-getdref  sim/cockpit2/fuel/fuel_quantity)		; hard coded way to get the aircraft-component-status from X-Plane

==>
+imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		fuel-quantity-panel
 status				=value
=goal>
 step		5
 phase		1
)

(p 5-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		5
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	flaps-switch-up	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 5-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		5
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	flaps-switch-up
==>
+visual-location>
 isa		visual-location
 screen-x	1190			; representing flaps control location
 screen-y	285
=goal>
 phase		5
)

(p 5-6-form-aircraft-component-status-representation
=goal>
 isa		checklist-procedure
 step		5
 phase		6
=visual>					; assume the model has read the aircraft-component-status properly
?imaginal>
 state		free

!bind! =value (x-plane-getdref  sim/cockpit2/controls/flap_ratio)		; hard coded way to get the aircraft-component-status from X-Plane

==>
+imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		flaps-switch
 status				=value
=goal>
 phase		7
)

(p 5-7a-take-control-action		;flaps up
=goal>
 isa		checklist-procedure
 step		5
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		flaps-switch
 - status				0			; 0 means flaps is up
?manual>
 state		free
==>
+manual>
 isa 			customized-manual-action		; representing hand reach to flaps control (time duration should be estimated based on human pilot video recordings)
 name			x-plane-button-action
 preparation-duration	0.050
 initiation-duration	0.050
 execution-duration	    1.0
 finish-duration		1.0
 para-1 			sim/cockpit2/controls/flap_ratio
 para-2			0
 para-3
 para-4

 ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

=goal>
 step		6
 phase		1
)


(p 5-7b-no-action-needed
=goal>
 isa		checklist-procedure
 step		5
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		flaps-switch
 status				0
==>
=goal>
 step		6
 phase		1
)

(p 6-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		6
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
 +imaginal>
  isa		checklist-item-representation
  item-name	throttle-init	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 6-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		6
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name	throttle-init
==>
 +visual-location>
  isa		visual-location
  screen-x	1840			; representing trottle location
  screen-y	920
 =goal>
  phase		5
)

(p 6-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		6
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/throttle_ratio_all)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		throttle
  status				=value
 =goal>
  phase		7
)

(p 6-7a-take-control-action		;flaps up
=goal>
 isa		checklist-procedure
 step		6
 phase		7
=imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		throttle
 - status				0.15			; 0 means flaps is up
?manual>
 state		free
==>
+manual>
 isa 			customized-manual-action		; representing hand reach to flaps control (time duration should be estimated based on human pilot video recordings)
 name			x-plane-button-action
 preparation-duration	0.050
 initiation-duration	0.050
 execution-duration	    1.0                       ; movement and making change
 finish-duration		3.25
 para-1 			sim/cockpit2/engine/actuators/throttle_ratio_all
 para-2			0.15
 para-3
 para-4

 ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

=goal>
 step		7
 phase		1
)


(p 6-7b-no-action-needed
 =goal>
  isa		checklist-procedure
  step		6
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		throttle
  status				0.15
==>
 =goal>
  step		7
  phase		1
)

(p 7-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		7
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
 +imaginal>
  isa		checklist-item-representation
  item-name	mixture-ratio	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 7-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		7
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name	mixture-ratio
==>
 +visual-location>
  isa		visual-location
  screen-x	1920			; representing trottle location
  screen-y	920
 =goal>
  phase		5
)

(p 7-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		7
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/mixture_ratio_all)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		mixture-1
  status				=value
 =goal>
  phase		7
)

(p 7-7a-take-control-action		;mixture set to OFF
 =goal>
  isa		checklist-procedure
  step		7
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		mixture-1
  - status				0			; 0 means mixture is idle, so this condition is met when it is not OFF
 ?manual>
  state		free
==>
 +manual>
  isa 			customized-manual-action		; representing hand reach to mixture (time duration should be estimated based on human pilot video recordings)
  name			x-plane-button-action
  preparation-duration	0.050
  initiation-duration	0.050
  execution-duration	1.0
  finish-duration		1.0
  para-1 		sim/cockpit2/engine/actuators/mixture_ratio_all
  para-2			0
  para-3
  para-4

  ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

 =goal>
  step		8
  phase		1
)


(p 7-7b-no-action-needed
 =goal>
  isa		checklist-procedure
  step		7
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		mixture-1
  status				0
==>
 =goal>
  step		8
  phase		1
)

(p 8-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		8
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
+imaginal>
  isa		checklist-item-representation
  item-name	beacon-switch	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 8-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		8
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name	beacon-switch
==>
 +visual-location>
  isa		visual-location
  screen-x	410			; representing trottle location
  screen-y	490
 =goal>
  phase		5
)

(p 8-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		8
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/switches/beacon_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		beacon-switch
  status				=value
 =goal>
  phase		7
)

(p 8-7a-take-control-action		;beacon set to OFF
 =goal>
  isa		checklist-procedure
  step		8
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		beacon-switch
  - status				1			; 0 means beacon is off, so this condition is met when it is not OFF
 ?manual>
  state		free
==>
 +manual>
  isa 			customized-manual-action		; representing hand reach to beacon (time duration should be estimated based on human pilot video recordings)
  name			x-plane-button-action
  preparation-duration	0.050
  initiation-duration	0.050
  execution-duration	1.0                   ; movement and making change
  finish-duration		2.405
  para-1 			sim/cockpit2/switches/beacon_on
  para-2			1
  para-3
  para-4

  ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

 =goal>
  step		9
  phase		1
)


(p 8-7b-no-action-needed
 =goal>
  isa		checklist-procedure
  step		8
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		beacon-switch
  status				1
==>
 =goal>
  step		9
  phase		1
)

(p 9-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		9
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
 +imaginal>
  isa		checklist-item-representation
  item-name	fuel-pump-on	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 9-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		9
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name	fuel-pump-on
==>
 +visual-location>
  isa		visual-location
  screen-x	410			; representing trottle location
  screen-y	490
 =goal>
  phase		5
)

(p 9-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		9
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/fuel_pump_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-1
  status				=value
 =goal>
  phase		7
)

(p 9-7a-take-control-action		;fuel pump set to OFF
 =goal>
  isa		checklist-procedure
  step		9
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-1
  - status				1			; 0 means fuel pump is off, so this condition is met when it is not OFF
 ?manual>
  state		free
==>
 +manual>
  isa 			customized-manual-action		; representing hand reach to fuel pump (time duration should be estimated based on human pilot video recordings)
  name			x-plane-button-action
  preparation-duration	0.050
  initiation-duration	0.050
  execution-duration	1.0                  ; movement and making change
  finish-duration		2.745
  para-1 			sim/cockpit2/engine/actuators/fuel_pump_on
  para-2			1
  para-3
  para-4

  ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

 =goal>
  step		10
  phase		1
)

(p 9-7b-no-action-needed
 =goal>
  isa		checklist-procedure
  step		9
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-1
  status				1
==>
 =goal>
  step		10
  phase		1
)

(p 10-3-form-checklist-item-representation
    =goal>
     isa		checklist-procedure
     step		10
     phase		3
    =visual>					; assume the model has read the checklist item properly
    ?imaginal>
     state		free
==>
    +imaginal>
     isa		checklist-item-representation
     item-name	init-mixture	; assume this is the result from reading the checklist
    =goal>
     phase		4
)

(p 10-4-visually-attend-aircraft-component
    =goal>
     isa		checklist-procedure
     step		10
     phase		4
    =imaginal>
     isa		checklist-item-representation
     item-name	init-mixture
==>
    +visual-location>
     isa		visual-location
     screen-x	1920			; representing trottle location
     screen-y	920
    =goal>
     phase		5
)

(p 10-6-take-push-action		;mixture set to idle
    =goal>
     isa		checklist-procedure
     step		10
     phase		6
    ?manual>
     state		free
==>
    +manual>
     isa 			customized-manual-action		; representing hand reach to mixture (time duration should be estimated based on human pilot video recordings)
     name			x-plane-button-action
     preparation-duration	0.050
     initiation-duration	0.050
     execution-duration	    1.0                       ; 1 for reaching 0.625 for pushing mixture handle
     finish-duration		10.805                        ; hold mixture for 5 sec
     para-1 		sim/cockpit2/engine/actuators/mixture_ratio_all
     para-2			1
     para-3
     para-4


     ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

    =goal>
     step		10
     phase		7
)


(p 10-7-take-push-action		;mixture set to idle
    =goal>
     isa		checklist-procedure
     step		10
     phase		7
    ?manual>
     state		free
==>
    +manual>
     isa 			customized-manual-action		; representing hand reach to mixture (time duration should be estimated based on human pilot video recordings)
     name			x-plane-button-action
     preparation-duration	0.050
     initiation-duration	0.050
     execution-duration	    1.0                      ; 1 for reaching 0.625 for pushing mixture handle
     finish-duration		1.0                      ; hold mixture for 5 sec
     para-1 		sim/cockpit2/engine/actuators/mixture_ratio_all
     para-2			0
     para-3
     para-4


     ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

    =goal>
     step		11
     phase		1
)

(p 11-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		11
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
 +imaginal>
  isa		checklist-item-representation
  item-name	fuel-pump-off	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 11-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		11
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name	fuel-pump-off
==>
 +visual-location>
  isa		visual-location
  screen-x	410			; representing trottle location
  screen-y	490
 =goal>
  phase		5
)

(p 11-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		11
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/fuel_pump_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-2
  status				=value
 =goal>
  phase		7
)

(p 11-7a-take-control-action		;fuel pump set to OFF
 =goal>
  isa		checklist-procedure
  step		11
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-2
  - status				0			; 0 means fuel pump is off, so this condition is met when it is not OFF
 ?manual>
  state		free
==>
 +manual>
  isa 			customized-manual-action		; representing hand reach to fuel pump (time duration should be estimated based on human pilot video recordings)
  name			x-plane-button-action
  preparation-duration	0.050
  initiation-duration	0.050
  execution-duration	1.0                   ; movement and making change
  finish-duration		1.575
  para-1 			sim/cockpit2/engine/actuators/fuel_pump_on
  para-2			0
  para-3
  para-4

  ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

 =goal>
  step		12
  phase		1
)

(p 11-7b-no-action-needed
 =goal>
  isa		checklist-procedure
  step		9
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		fuel-pump-2
  status				0
==>
 =goal>
  step		12
  phase		1
)

(p 12-3-form-checklist-item-representation
 =goal>
  isa		checklist-procedure
  step		12
  phase		3
 =visual>					; assume the model has read the checklist item properly
 ?imaginal>
  state		free
==>
 +imaginal>
  isa		checklist-item-representation
  item-name	ignition-switch-on	; assume this is the result from reading the checklist
 =goal>
  phase		4
)

(p 12-4-visually-attend-aircraft-component
 =goal>
  isa		checklist-procedure
  step		12
  phase		4
 =imaginal>
  isa		checklist-item-representation
  item-name ignition-switch-on
==>
 +visual-location>
  isa		visual-location
  screen-x	160			; representing trottle location
  screen-y	520
 =goal>
  phase		5
)

(p 12-6-form-aircraft-component-status-representation
 =goal>
  isa		checklist-procedure
  step		12
  phase		6
 =visual>					; assume the model has read the aircraft-component-status properly
 ?imaginal>
  state		free

 !bind! =value (x-plane-getdref  sim/cockpit2/engine/actuators/ignition_key)		; hard coded way to get the aircraft-component-status from X-Plane

==>
 +imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		ignition-switch-2
  status				=value
 =goal>
  phase		7
)

(p 12-7-take-control-action		;ignition set to start
 =goal>
  isa		checklist-procedure
  step		12
  phase		7
 =imaginal>
  isa				aircraft-component-status-representation
  aircraft-component-name		ignition-switch-2
  - status				4			; 4 means ignition start, so this condition is met when it is not OFF
 ?manual>
  state		free
==>
 +manual>
  isa 			customized-manual-action		; representing hand reach to ignition (time duration should be estimated based on human pilot video recordings)
  name			x-plane-ignition-start
  para-1 		sim/cockpit2/engine/actuators/ignition_on
  para-2		1
  preparation-duration	0.050
  initiation-duration	0.050
  execution-duration	1.000                   ; movement and making change
  finish-duration		7.260

  ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

 =goal>
  step		13
  phase		1
)

(p 13-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		13
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	oil-pressure	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 13-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		13
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	oil-pressure
==>
+visual-location>
 isa		visual-location
 screen-x	1190			; representing oil pressure panel
 screen-y	285
=goal>
 phase		5
)

(p 13-6-form-aircraft-component-status-representation
=goal>
 isa		checklist-procedure
 step		13
 phase		6
=visual>					; assume the model has read the aircraft-component-status properly
?imaginal>
 state		free

!bind! =value (x-plane-getdref  sim/cockpit2/engine/indicators/oil_pressure_psi)		; hard coded way to get the aircraft-component-status from X-Plane

==>
+imaginal>
 isa				aircraft-component-status-representation
 aircraft-component-name		oil-pressure-panel
 status				=value
=goal>
 step		14
 phase		1
)

(p 14-3-form-checklist-item-representation
=goal>
 isa		checklist-procedure
 step		14
 phase		3
=visual>					; assume the model has read the checklist item properly
?imaginal>
 state		free
==>
+imaginal>
 isa		checklist-item-representation
 item-name	avionics-switch-on	; assume this is the result from reading the checklist
=goal>
 phase		4
)

(p 14-4-visually-attend-aircraft-component
=goal>
 isa		checklist-procedure
 step		14
 phase		4
=imaginal>
 isa		checklist-item-representation
 item-name	avionics-switch-on
==>
+visual-location>
 isa		visual-location
 screen-x	380			; representing avionics-switch location
 screen-y	490
=goal>
 phase		5
)

(p 14-6-form-aircraft-component-status-representation
    =goal>
     isa		checklist-procedure
     step		14
     phase		6
    =visual>					; assume the model has read the aircraft-component-status properly
    ?imaginal>
     state		free

    !bind! =value (x-plane-getdref  sim/cockpit2/switches/avionics_power_on)		; hard coded way to get the aircraft-component-status from X-Plane

==>
    +imaginal>
     isa				aircraft-component-status-representation
     aircraft-component-name		avionics-switch-2
     status				=value
    =goal>
     phase		7
)

(p 14-7-take-control-action		;avionics set to OFF
    =goal>
     isa		checklist-procedure
     step		14
     phase		7
    ?manual>
     state		free
==>
    +manual>
     isa 			customized-manual-action		; representing hand reach to avionics switch (time duration should be estimated based on human pilot video recordings)
     name			x-plane-button-action
     preparation-duration	0.050
     initiation-duration	0.050
     execution-duration	    1.0                 ; movement and making change
     finish-duration		2.325
     para-1 			sim/cockpit2/switches/avionics_power_on
     para-2			1
     para-3 			sim/cockpit2/electrical/cross_tie
     para-4			1

     ; hard coded way to send the updated aircraft-component-status to X-Plane using x-plane-senddref

    =goal>
     step		15
     phase		1
)
