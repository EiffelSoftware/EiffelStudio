indexing
	description: "Objects that represent the build tab in the project settings."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_BUILD_TAB

inherit
	
	GB_SYSTEM_TAB
	
	GB_NAMING_UTILITIES
		undefine
			is_equal, copy, default_create
		end
	
	GB_SHARED_TOOLS
		undefine
			is_equal, copy, default_create
		end
		
	GB_CONSTANTS
	
	EIFFEL_RESERVED_WORDS
		undefine
			is_equal, copy, default_create
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and build widget structure.
		local
			label: EV_LABEL
			vertical_box: EV_VERTICAL_BOX
			frame: EV_FRAME
		do
			create frame.make_with_text ("Build type")
			extend (frame)
			create vertical_box
			frame.extend (vertical_box)
			create application_class_name_field
			create project_radio_button.make_with_text ("Project")
			project_radio_button.select_actions.extend (agent project_type_modified)
			vertical_box.extend (project_radio_button)
			create class_radio_button.make_with_text ("Class")
			class_radio_button.select_actions.extend (agent project_type_modified)
			vertical_box.extend (class_radio_button)
			create label.make_with_text (window_class_name_prompt)
			extend (label)
			create main_window_class_name_field
			extend (main_window_class_name_field)
			create label.make_with_text (application_class_name_prompt)
			extend (label)
			extend (application_class_name_field)

			is_initialized := True
			disable_all_items (Current)
			align_labels_left (Current)
		end
		
feature -- Access

	name: STRING is "Build"
		-- Name to be displayed for `Current'.
		
feature -- Status setting

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		do
			main_window_class_name_field.set_text (project_settings.main_window_class_name)
			application_class_name_field.set_text (project_settings.application_class_name)
			if project_settings.complete_project then
				project_radio_button.enable_select
			else
				class_radio_button.enable_select
			end
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		do
			project_settings.set_main_window_class_name (main_window_class_name_field.text)
			project_settings.set_application_class_name (application_class_name_field.text)
			if project_radio_button.is_selected then
				project_settings.enable_complete_project
			else
				project_settings.disable_complete_project
			end
		end	

feature {GB_SYSTEM_WINDOW} -- Implementation

	validate is
			-- Validate input fields of `Current'.
		local
			warning_dialog: EV_WARNING_DIALOG
			invalid_text: STRING
			application_name_lower, class_name_lower: STRING
			warning_message: STRING
		do
				-- Check for invalid eiffel names as language specification.
			validate_successful := True
			application_name_lower := application_class_name_field.text.as_lower
			class_name_lower := main_window_class_name_field.text.as_lower
			if not valid_class_name (application_name_lower) then
				invalid_text := application_name_lower
			elseif not valid_class_name (class_name_lower) then
				invalid_text := class_name_lower
			end
			if invalid_text /= Void then
				warning_message := Class_invalid_name_warning
			else
				warning_message := Reserved_word_warning
			end
				-- Check for names that are Eiffel reserved words.
			if reserved_words.has (application_name_lower) then
				invalid_text := application_name_lower
			elseif reserved_words.has (class_name_lower) then
				invalid_text := class_name_lower
			end
			if invalid_text /= Void then
				select_in_parent
				create warning_dialog.make_with_text ("'" + invalid_text + warning_message)
				warning_dialog.show_modal_to_window (main_window)
				validate_successful := False				
			end

				-- Check for conflicting names.
			if application_name_lower.is_equal (class_name_lower) or 
				application_name_lower.is_equal (class_name_lower + class_implementation_extension.as_lower) then
				select_in_parent
				create warning_dialog.make_with_text (Matching_class_and_application_names_warning)
				warning_dialog.show_modal_to_window (main_window)
				validate_successful := False
			end
		end
		
	project_type_modified is
			-- Update sensitivity of `application_class_name_field'
			-- dependent on state of `project_radio_button.
		do
			if project_radio_button.is_selected then
				application_class_name_field.enable_sensitive
			else
				application_class_name_field.disable_sensitive
			end
		end
		

feature {NONE} -- Implementation

	project_radio_button: EV_RADIO_BUTTON
		-- Selects the generate project option.
	
	class_radio_button: EV_RADIO_BUTTON
		-- Selects the generate class option.
		
	main_window_class_name_field: EV_TEXT_FIELD
		-- Holds the name used for the generated window class.
	
	application_class_name_field: EV_TEXT_FIELD
		-- Holds the name used for generated window file name.
		
end -- class GB_SYSTEM_BUILD_TAB
