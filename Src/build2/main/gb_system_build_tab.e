indexing
	description: "Objects that represent the build tab in the project settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_BUILD_TAB

inherit
	
	GB_SYSTEM_TAB
		export
			{NONE} all
		end
	
	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end	
	
	EIFFEL_RESERVED_WORDS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and build widget structure.
		local
			label: EV_LABEL
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
		do
			create frame.make_with_text ("Build type")
			extend (frame)
			create vertical_box
			frame.extend (vertical_box)
			create application_class_name_field
			create project_name_field
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create project_radio_button.make_with_text ("Project")
			horizontal_box.extend (project_radio_button)
				-- We now force the appearance of a gap between the project button and
				-- rebuild ace file button, by modifying the minimum width.
			project_radio_button.set_minimum_width (project_radio_button.minimum_width + 20)
			create rebuild_ace_file.make_with_text ("Always rebuild ace?")
			horizontal_box.extend (rebuild_ace_file)
			horizontal_box.disable_item_expand (project_radio_button)
			horizontal_box.merge_radio_button_groups (vertical_box)
			create class_radio_button.make_with_text ("Class")
			vertical_box.extend (class_radio_button)
		
			create label.make_with_text (project_name_prompt)
			extend (label)
			extend (project_name_field)
			
			
			create label.make_with_text (application_class_name_prompt)
			extend (label)
			extend (application_class_name_field)

			
			create label.make_with_text (window_class_name_prompt)
			extend (label)
			create main_window_class_name_field
			extend (main_window_class_name_field)			
			

			is_initialized := True
			disable_all_items (Current)
			align_labels_left (Current)
			
				-- Connect events to project and class buttons.
			class_radio_button.select_actions.extend (agent project_type_modified)
			project_radio_button.select_actions.extend (agent project_type_modified)
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
			project_name_field.set_text (project_settings.project_name)
			if project_settings.complete_project then
				project_radio_button.enable_select
			else
				class_radio_button.enable_select
			end
			if project_settings.rebuild_ace_file then
				rebuild_ace_file.enable_select
			else
				rebuild_ace_file.disable_select
			end
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		do
			project_settings.set_main_window_class_name (main_window_class_name_field.text.as_upper)
			project_settings.set_application_class_name (application_class_name_field.text.as_upper)
			project_settings.set_project_name (project_name_field.text)
			if project_radio_button.is_selected then
				project_settings.enable_complete_project
			else
				project_settings.disable_complete_project
			end
			if rebuild_ace_file.is_selected then
				project_settings.enable_rebuild_ace_file
			else
				project_settings.disable_rebuild_ace_file
			end
		end	

feature {GB_SYSTEM_WINDOW} -- Implementation

	validate is
			-- Validate input fields of `Current'.
		local
			warning_dialog: EV_WARNING_DIALOG
			application_name_lower, class_name_lower, project_name_lower,
			invalid_text, warning_message: STRING
		do
				-- Check for invalid eiffel names as language specification.
			validate_successful := True
			application_name_lower := application_class_name_field.text.as_lower
			class_name_lower := main_window_class_name_field.text.as_lower
			project_name_lower := project_name_field.text.as_lower
			if not valid_class_name (application_name_lower) then
				invalid_text := application_name_lower
			elseif not valid_class_name (class_name_lower) then
				invalid_text := class_name_lower
			elseif not valid_class_name (project_name_lower) then
				invalid_text := project_name_lower
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
			elseif reserved_words.has (project_name_lower) then
				invalid_text := project_name_lower
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
				project_name_field.enable_sensitive
				rebuild_ace_file.enable_sensitive
			else
				application_class_name_field.disable_sensitive
				project_name_field.disable_sensitive
				rebuild_ace_file.disable_sensitive
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
		
	project_name_field: EV_TEXT_FIELD
		-- Holds the name used for generated project name.
		
	rebuild_ace_file: EV_CHECK_BUTTON;
		-- Holds whether we should re-generate the ace file every time.
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_SYSTEM_BUILD_TAB
