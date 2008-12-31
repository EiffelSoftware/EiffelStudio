note
	description	: "Final state of the wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make,
			fill_message_and_title_box,
			build
		end

	WIZARD_PROJECT_SHARED

	BENCH_WIZARD_CONSTANTS

create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information)
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_FINAL_STATE_WINDOW} (an_info)
		end

feature -- Basic Operations

	build
			-- Special display box for the first and the last state
		do
			create message_text_field
			message_text_field.set_background_color (white_color)

			Precursor
		end

	proceed_with_current_info
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)
			Precursor
		end

feature -- Access

	display_state_text
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.m_Final_title)
			message_text_field.set_text (Common_message)
			message.set_text (interface_names.m_final_state_message (wizard_information.compile_project))
		end

	final_message: STRING_GENERAL
		do
		end

feature {NONE} -- Widgets

	message_text_field: EV_TEXT
			-- Text field summarizing the project settings

	instruction: EV_LABEL
			-- Message telling the user how to launch code generation and compilation

feature {NONE} -- Implementation

	message_text: STRING
			-- Final message

	fill_message_and_title_box (message_and_title_box: EV_VERTICAL_BOX)
			-- Fill `message_and_title_box' with needed widgets.
		do
			message_and_title_box.extend (message_text_field) -- Expandable item
			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)
		end

	pixmap_icon_location: FILE_NAME
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string (Wizard_icon_name)
			 Result.add_extension (pixmap_extension)
		end

feature {NONE} -- Constants

	h_filename: STRING = "help/wizards/edotnet/docs/reference/40_settings_summary/index.html"
			-- Path to HTML help file

	Common_message: STRING_32
			-- Message to the user (no matter if there are selected assemblies)
		local
			creation_routine_name,
			l_root_class_name: STRING
		do
			create Result.make (3000)
			Result.append (interface_names.l_you_have_specified_following_settings.as_string_32 + New_line + New_line +
					 bench_interface_names.l_Project_name.as_string_32 + ": " + New_line + Tab + wizard_information.project_name + New_line +
					 bench_interface_names.l_project_location.as_string_32 + ": " + New_line + Tab + wizard_information.project_location + New_line +
					interface_names.l_application_type.as_string_32 + ": " + New_line + Tab)
			if wizard_information.generate_dll then
				Result.append (interface_names.l_Dll_type)
			else
				Result.append (interface_names.l_Exe_type)
			end
			Result.append (New_line)
			Result.append (interface_names.l_Console_application.as_string_32 + ": " + New_line + Tab)
			if wizard_information.console_application then
				Result.append (interface_names.l_yes)
			else
				Result.append (interface_names.l_no)
			end

			Result.append (New_line + New_line)
			l_root_class_name := wizard_information.root_class_name.twin
			Result.append (interface_names.l_Root_class_name.as_string_32 + ": " + New_line + Tab + l_root_class_name + New_line)
			creation_routine_name := wizard_information.creation_routine_name
			l_root_class_name.to_lower
			if not l_root_class_name.is_equal (interface_names.l_none_class) and then creation_routine_name /= Void and then not creation_routine_name.is_empty then
				Result.append (interface_names.l_Creation_routine_name.as_string_32 + ": " + New_line + Tab + wizard_information.creation_routine_name + New_line)
			end
			Result.append (New_line)
			Result.append (interface_names.l_clr_version.as_string_32 + New_line + Tab)
			if wizard_information.is_most_recent_clr_version then
				Result.append (interface_names.l_clr_most_recent_version_summary)
			else
				Result.append (wizard_information.clr_version)
			end
			Result.append (New_line)
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end

	Space: STRING = " ";
			-- Space

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class WIZARD_FINAL_STATE
