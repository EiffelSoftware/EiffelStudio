indexing
	description	: "Fourth state of the profiler wizard (Choose options & query)"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_FOURTH_STATE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			is_final_state
		end
		
	EB_PROFILER_WIZARD_SHARED_INFORMATION
		export
			{NONE} all
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			switchbox: EV_VERTICAL_BOX -- Form to display output switches on
			language_box: EV_VERTICAL_BOX -- Form to display language type on
			hbox: EV_HORIZONTAL_BOX
			switch_form: EV_FRAME
			language_form: EV_FRAME
		do
				--| Switches Frame
			create name_switch.make_with_text (Interface_names.b_Feature_name)
			create number_of_calls_switch.make_with_text (Interface_names.b_Number_of_calls)
			create time_switch.make_with_text (Interface_names.b_Function_time)
			create descendant_switch.make_with_text (Interface_names.b_Descendant_time)
			create total_time_switch.make_with_text (Interface_names.b_Total_time)
			create percentage_switch.make_with_text (Interface_names.b_Percentage)
			create switchbox
			switchbox.set_border_width (Small_border_size)
			switchbox.extend (name_switch)
			switchbox.extend (number_of_calls_switch)
			switchbox.extend (time_switch)
			switchbox.extend (descendant_switch)
			switchbox.extend (total_time_switch)
			switchbox.extend (percentage_switch)
			create switch_form.make_with_text (Interface_names.l_Output_switches)
			switch_form.extend (switchbox)

				--| Language Frame
			create eiffel_switch.make_with_text (Interface_names.b_Eiffel_features)
			create c_switch.make_with_text (Interface_names.b_C_functions)
			create recursive_switch.make_with_text (Interface_names.b_Recursive_functions)
			create language_box
			language_box.set_border_width (Small_border_size)
			language_box.extend (eiffel_switch)
			language_box.disable_item_expand (eiffel_switch)
			language_box.extend (c_switch)
			language_box.disable_item_expand (c_switch)
			language_box.extend (recursive_switch)
			language_box.disable_item_expand (recursive_switch)
			create language_form.make_with_text (Interface_names.l_Language_type)
			language_form.extend (language_box)
	
				--| Switches & Language Box
			create hbox
			hbox.set_padding (Small_padding_size)
			hbox.extend (switch_form)
			hbox.extend (language_form)
			
				--| Query Frame
			create query_text.make (Current)
			query_text.set_label_string (Interface_names.l_Query)
			query_text.generate
			
				--| Pack Query frame with Switch&Language Box
			choice_box.set_padding (Small_padding_size)
			choice_box.extend (hbox)
			choice_box.extend (query_text.widget)
		
				-- Update controls to reflect `information'
			if information.name_switch then
				name_switch.enable_select
			end
			if information.number_of_calls_switch then
				number_of_calls_switch.enable_select
			end
			if information.percentage_switch then
				percentage_switch.enable_select
			end
			if information.time_switch then
				time_switch.enable_select
			end
			if information.descendant_switch then
				descendant_switch.enable_select
			end
			if information.total_time_switch then
				total_time_switch.enable_select
			end
			if information.eiffel_switch then
				eiffel_switch.enable_select
			end
			if information.c_switch then
				c_switch.enable_select
			end
			if information.recursive_switch then
				recursive_switch.enable_select
			end
			if not information.query.is_empty then
				query_text.set_text (information.query)
			else
				query_text.set_text (information.default_query)
			end
			
			first_window.set_final_state (Interface_names.b_Finish)
		end

	proceed_with_current_info is 
		local
			wizard_generator: EB_PROFILER_WIZARD_GENERATOR
			old_cursor: EV_CURSOR
		do
			old_cursor := first_window.pointer_style
			first_window.set_pointer_style (Pixmaps.Busy_cursor)
			
			create wizard_generator.make (information)
			if information.generate_execution_profile then
				wizard_generator.generate_execution_profile
			end
			if wizard_generator.last_operation_successful then
				wizard_generator.execute_query
			end
			first_window.set_pointer_style (old_cursor)
			if wizard_generator.last_operation_successful then
				first_window.destroy
			else
				proceed_with_new_state(create {EB_PROFILER_WIZARD_GENERATION_ERROR_STATE}.make (wizard_information))
			end				
		end

	update_state_information is
			-- Check User Entries
		local
			loc_query: STRING
		do
			Precursor
			
			information.set_output_switches (
				name_switch.is_selected,
				number_of_calls_switch.is_selected,
				percentage_switch.is_selected,
				time_switch.is_selected,
				descendant_switch.is_selected,
				total_time_switch.is_selected)
				
			information.set_language_switches (
				eiffel_switch.is_selected,
				c_switch.is_selected,
				recursive_switch.is_selected)
				
			loc_query := query_text.text
			if loc_query = Void then
				loc_query := ""
			end
			information.set_query (loc_query)
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (Interface_names.wt_Switches_and_Query)
			subtitle.set_text (Interface_names.ws_Switches_and_Query)
			message_box.hide
		end
		
	is_final_state: BOOLEAN is True
			-- This is the last state of this wizard.

feature {NONE} -- Vision2 controls
		
	name_switch: EV_CHECK_BUTTON
			-- Switch for the feature names

	number_of_calls_switch: EV_CHECK_BUTTON
			-- Switch for the number of calls

	percentage_switch: EV_CHECK_BUTTON
			-- Switch for the percentage of time

	time_switch: EV_CHECK_BUTTON
			-- Switch for the amount of time
			-- spent in the function itself

	descendant_switch: EV_CHECK_BUTTON
			-- Switch for the amount of time
			-- spent in the called functions

	total_time_switch: EV_CHECK_BUTTON
			-- Switch for the amount of time
			-- spent in both the function itself
			-- and the called ones.
			
	eiffel_switch: EV_CHECK_BUTTON
			-- Switch for output of eiffel features

	c_switch: EV_CHECK_BUTTON
			-- Switch for output of c functions

	recursive_switch: EV_CHECK_BUTTON
			-- Switch for display of recursive funtions.

	query_text: EB_WIZARD_SMART_TEXT_FIELD
			-- Text field for query input

end -- class EB_PROFILER_WIZARD_FOURTH_STATE

