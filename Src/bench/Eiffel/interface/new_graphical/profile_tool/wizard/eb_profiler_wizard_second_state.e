indexing
	description	: "Second state of the profiler wizard (Choose execution profile)"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_SECOND_STATE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	EB_PROFILER_WIZARD_SHARED_INFORMATION
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end
		
create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			execution_profile_radio_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			empty_box: EV_CELL
		do 
				-- Radio buttons
			create use_existing_execution_profile.make_with_text (Interface_names.l_Use_existing_profile)
			create generate_execution_profile.make_with_text (Interface_names.l_Generate_profile_from_rtir)
			
			create execution_profile_text_field.make (Current)
			execution_profile_text_field.enable_file_browse_button ("*."+Dot_profile_information)
			execution_profile_text_field.set_starting_directory (information.generation_path)
			execution_profile_text_field.generate
			create empty_box
			empty_box.set_minimum_width (Dialog_unit_to_pixels (20))
			create hbox
			hbox.extend (empty_box)
			hbox.disable_item_expand (empty_box)
			hbox.extend (execution_profile_text_field.widget)
			
			create execution_profile_radio_box
			execution_profile_radio_box.set_border_width (Default_border_size)
			execution_profile_radio_box.extend (generate_execution_profile)
			execution_profile_radio_box.extend (use_existing_execution_profile)
			execution_profile_radio_box.extend (hbox)

				-- Link
			choice_box.extend (execution_profile_radio_box)
			choice_box.disable_item_expand (execution_profile_radio_box)
			choice_box.extend (create {EV_CELL})

				-- Update controls to reflect `information'
			if information.generate_execution_profile then
				generate_execution_profile.enable_select
				execution_profile_text_field.disable_sensitive
			else
				use_existing_execution_profile.enable_select
			end
			if information.existing_profile /= Void then
				execution_profile_text_field.set_text (information.existing_profile)
			end

				-- Connect agents
			use_existing_execution_profile.select_actions.extend (agent on_change_check_button)
			generate_execution_profile.select_actions.extend (agent on_change_check_button)
		end

	proceed_with_current_info is 
		do
			if use_existing_execution_profile.is_selected then
				if not is_supplied_execution_profile_valid then
					proceed_with_new_state(create {EB_PROFILER_WIZARD_EXECUTION_PROFILE_ERROR_STATE}.make (wizard_information))
				else
					proceed_with_new_state(create {EB_PROFILER_WIZARD_FOURTH_STATE}.make (wizard_information))
				end
			else
				proceed_with_new_state(create {EB_PROFILER_WIZARD_THIRD_STATE}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		local
			execution_profile_filename: FILE_NAME
			execution_profile_text: STRING
		do
			Precursor
			
			if use_existing_execution_profile.is_selected then
				execution_profile_text := execution_profile_text_field.text
				if not execution_profile_text.is_empty then
					create execution_profile_filename.make_from_string (execution_profile_text)
					information.set_use_existing_execution_profile (execution_profile_filename)
				end
			else
				information.set_generate_execution_profile
			end
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (Interface_names.wt_Execution_Profile)
			subtitle.set_text (Interface_names.ws_Execution_Profile)
			message.set_text (Interface_names.wb_Execution_Profile)
		end

feature {NONE} -- Implementation

	is_supplied_execution_profile_valid: BOOLEAN is
			-- Is the supplied execution profile a valid file?
		local
			execution_profile_file: RAW_FILE
			execution_profile_text: STRING
		do
			execution_profile_text := execution_profile_text_field.text
			if execution_profile_text.is_empty then
				Result := False
			else
				create execution_profile_file.make (execution_profile_text)
				Result := execution_profile_file.exists and then execution_profile_file.is_readable
			end
		end

	on_change_check_button is
			-- The user has selected a different button
		local
			existing_profile_selected: BOOLEAN
			textfield_sensitive: BOOLEAN
		do
			existing_profile_selected := use_existing_execution_profile.is_selected
			textfield_sensitive := execution_profile_text_field.is_sensitive

			if existing_profile_selected and not textfield_sensitive then
				execution_profile_text_field.enable_sensitive
			elseif not existing_profile_selected and textfield_sensitive then
				execution_profile_text_field.disable_sensitive
			end
		end

feature {NONE} -- Vision2 controls

	use_existing_execution_profile: EV_RADIO_BUTTON
			-- When checked, use an existing execution profile.
			
	generate_execution_profile: EV_RADIO_BUTTON
			-- When checked, generate the execution profile.
			
	execution_profile_text_field: EB_WIZARD_SMART_TEXT_FIELD
			-- Path where the execution profile to use is located.

end -- class EB_PROFILER_WIZARD_SECOND_STATE
