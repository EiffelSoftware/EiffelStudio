class HELP_CONSTANTS

feature -- Message

	no_help_available_message: STRING is 
		"%NNo help available for this error%N%
		 %(cannot read file: ";
	contact_ise_message: STRING is
		")%N%
		%%NAn error message should always be available.%N% 
		%Please contact ISE.%N%N";


feature 

	attribute_help_fn: STRING is "ATTRIBUTE";
	behavior_help_fn: STRING is "BEHAVIOR";
	color_help_fn: STRING is "COLOR";
	event_help_fn: STRING is "EVENT";
	group_help_fn: STRING is "GROUP";
	label_help_fn: STRING is "TRANS_LABEL";
	instance_help_fn: STRING is "INSTANCE";
	pred_command_help_fn: STRING is "PRED_CMD";
	state_help_fn: STRING is "STATE";
	user_command_help_fn: STRING is "USER_CMD";
	transition_help_fn: STRING is "TRANS_LINE";

feature
		-- Help file names for context are
		-- derived from the eiffel type.
		-- One exception is group_c.e where
		-- help_file_name is redefined
--arrow_b_c.e:	eiffel_type: STRING is "ARROW_B";
--bar_c.e:		eiffel_type: STRING is "BAR";
--bulletin_c.e:   eiffel_type: STRING is "EB_BULLETIN"
--check_box_c.e:  eiffel_type: STRING is "CHECK_BOX";
--dr_area_c.e:	eiffel_type: STRING is "DRAWING_BOX";
--label_c.e:	  eiffel_type: STRING is "LABEL";
--menu_entry_c.e: eiffel_type: STRING is "PUSH_B";
--menu_pull_c.e:  eiffel_type: STRING is "MENU_PULL";
--opt_pull_c.e:   eiffel_type: STRING is "OPT_PULL";
--perm_wind_c.e:  eiffel_type: STRING is "PERM_WIND";
--pict_color_c.e: eiffel_type: STRING is "PICT_COLOR_B";
--push_b_c.e:	 eiffel_type: STRING is "PUSH_B";
--radio_box_c.e:  eiffel_type: STRING is "RADIO_BOX";
--scale_c.e:	  eiffel_type: STRING is "SCALE";
--scroll_list_c.e:		eiffel_type: STRING is "SCROLL_LIST";
--separator_c.e:  eiffel_type: STRING is "SEPARATOR";
--temp_wind_c.e:  eiffel_type: STRING is "TEMP_WIND";
--text_c.e:	   eiffel_type: STRING is "SCROLLED_T";
--text_field_c.e: eiffel_type: STRING is "TEXT_FIELD";
--toggle_b_c.e:   eiffel_type: STRING is "TOGGLE_B";

end
