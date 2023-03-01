note
	description	: "Command to update the Eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLEAN_COMPILE_PROJECT_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			is_tooltext_important,
			new_sd_toolbar_item
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_DEBUGGER_MANAGER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default values.
		do
		end

feature {NONE} -- Compilation implementation

	reset_debugger
			-- Kill the application, if it is running.
		do
			eb_debugger_manager.quit_cmd.execute
		end

feature -- Execution

	execute
			-- Compile from scratch the project.
		do
			if is_sensitive then
				reset_debugger
				on_clean_compilation
			end
		end

	on_clean_compilation
		local
			dlg: ES_QUESTION_WARNING_PROMPT
		do
			create dlg.make_standard (interface_names.h_clean_compile)
			dlg.show_on_active_window
			if dlg.dialog_result = {ES_DIALOG_BUTTONS}.yes_button then
				process_clean_compile
			end
		end

	process_clean_compile
		local
			p_ecf: PATH
			cmd: READABLE_STRING_GENERAL
			exit: EB_EXIT_APPLICATION_COMMAND
			l_old_ec_name: detachable READABLE_STRING_GENERAL
		do
			if attached workbench as wb then
				create p_ecf.make_from_string (wb.lace.file_name)
				if attached execution_environment.arguments.command_name as cln then
					l_old_ec_name := execution_environment.item ("EC_NAME")
					execution_environment.put (cln, "EC_NAME")
				end
				cmd := eiffel_layout.studio_command_line (p_ecf, wb.lace.target_name, wb.lace.project_path, True, True) + " -melt"
				create exit
				exit.execute_with_confirmation (False)
				{COMMAND_EXECUTOR}.execute (cmd)
				if l_old_ec_name /= Void then
					execution_environment.put (l_old_ec_name, "EC_NAME")
				end
			end
		end

feature -- Access

	name: STRING_GENERAL
			-- <Precursor>
		do
			Result := command_name
		end

	command_name: STRING = "clean_compile"
			-- Value for `name` used in this class.

feature {NONE} -- Implementation

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Create a new docking tool bar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

	tooltext: STRING_GENERAL
			-- Text displayed in toolbar
		do
			Result := Interface_names.b_Clean_compile
		end

	is_tooltext_important: BOOLEAN
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := tooltext.same_string (Interface_names.b_Clean_compile)
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_clean_compile
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_reset_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_reset_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_clean_compile
		end

	description: STRING_GENERAL
			-- Description for the command.
		do
			Result := Interface_names.f_clean_compile
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_MELT_PROJECT_COMMAND
