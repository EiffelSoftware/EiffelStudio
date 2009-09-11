note
	description	: "Second state of the wizard wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_NAME_AND_LOCATION_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	BENCH_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build
			-- Build entries.
		do
			create project_name.make (Current)
			project_name.set_label_string_and_size (Bench_interface_names.l_Project_name, 10)
			project_name.set_textfield_string (wizard_information.project_name)
			project_name.generate
			project_name.change_actions.extend (agent on_change_name)

			create project_location.make (Current)
			project_location.set_label_string_and_size (Bench_interface_names.l_Project_location, 10)
			project_location.set_textfield_string (wizard_information.project_location)
			project_location.enable_directory_browse_button
			project_location.generate

			create to_compile_b.make_with_text (Bench_interface_names.l_Compile_project)
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end

			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (project_name.widget)
			choice_box.disable_item_expand (project_name.widget)
			choice_box.extend (project_location.widget)
			choice_box.disable_item_expand (project_location.widget)
			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL}) -- expandable item

			set_updatable_entries(<<
				project_name.change_actions,
				project_location.change_actions,
				to_compile_b.select_actions>>)
		end

	proceed_with_current_info
		local
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
			a_project_location: DIRECTORY_NAME
			a_directory: DIRECTORY
		do
			if not rescued then
				if not is_project_name_valid (project_name.text) then
						-- Ask for a valid project name
					create {WIZARD_ERROR_PROJECT_NAME} next_window.make (wizard_information)
				else
					a_project_location := validate_directory_string (project_location.text)
					if a_project_location.is_empty then
						create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
					else
							-- create the directory
						create a_directory.make (a_project_location)
						if not a_directory.exists then
							a_directory.create_dir
						end
						if a_directory.has_entry ("EIFGENs") then
							create {WIZARD_WARNING_PROJECT_EXIST} next_window.make (wizard_information)
						else
							create {WIZARD_SECOND_STATE} next_window.make (wizard_information)
						end
					end
				end
			else
				-- Something went wrong when checking that the selected directory exists
				-- or when trying to create the directory, go to error.
				create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
			end

			Precursor
			proceed_with_new_state (next_window)
		rescue
			rescued := True
			retry
		end

	update_state_information
			-- Check User Entries
		local
			a_project_location: DIRECTORY_NAME
		do
			a_project_location := validate_directory_string (project_location.text)
			wizard_information.set_project_location (a_project_location)
			wizard_information.set_project_name (project_name.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end

feature {NONE} -- Implementation

	on_change_name
			-- The user has changed the project name, update the project location
		local
			curr_project_location: STRING
			curr_project_name: STRING
			sep_index: INTEGER
		do
			curr_project_location := project_location.text
			curr_project_name := project_name.text
			if curr_project_location /= Void then
				sep_index := curr_project_location.last_index_of (Operating_environment.Directory_separator, curr_project_location.count)
				curr_project_location.keep_head (sep_index)
				if curr_project_name /= Void then
					curr_project_location.append (curr_project_name)
				end

				project_location.set_text (curr_project_location)
			end
		end

	validate_directory_string (a_directory: STRING): DIRECTORY_NAME
			-- Validate the directory `a_directory' and return the
			-- validated version of `a_directory'.
		local
			a_directory_name: DIRECTORY_NAME
		do
			if a_directory /= Void then
				create a_directory_name.make_from_string (a_directory)
--				a_directory_name := validate_directory_name (a_directory_name)
--				if a_directory_name /= Void then
					Result := a_directory_name
--				end
			end
			if Result = Void then
				create Result.make_from_string("")
			end
		ensure
			valid_Result: Result /= Void
		end

	is_project_name_valid (a_project_name: STRING): BOOLEAN
			-- Is `a_project_name' valid as project name?
		local
			curr_index: INTEGER
			curr_character: CHARACTER
		do
			if a_project_name = Void or else a_project_name.is_empty then
				Result := False
			else
				from
					Result := True
					curr_index := 1
				until
					not Result or (curr_index > a_project_name.count)
				loop
					curr_character := a_project_name @ curr_index
					if curr_index = 1 then
						Result := curr_character.is_alpha
					else
						Result := curr_character.is_alpha or curr_character.is_digit or
							curr_character = '_' or curr_character = '.'
					end
					curr_index := curr_index + 1
				end
			end
		end

	display_state_text
			-- Display message text relative to current state.
		do
			title.set_text (Bench_interface_names.t_Project_name_and_location_state)
			subtitle.set_text (Bench_interface_names.st_Project_name_and_location_state)
			message.set_text (Bench_interface_names.m_Project_name_and_location_state)
		end

	project_location: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the location of the project

	project_name: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the name of the wizard

	to_compile_b: EV_CHECK_BUTTON;
			-- Should compilation be launched?.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class WIZARD_PROJECT_NAME_AND_LOCATION_STATE
