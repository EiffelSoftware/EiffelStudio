note
	description: "Command to execute the finalized code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_FINALIZED_CMD

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			new_sd_toolbar_item
		end

create
	make

feature -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Execution

	execute
			-- Execute Current.
		do
			if attached debugger_manager as dbg then
				dbg.controller.start_finalized_application (dbg.current_execution_parameters)
			end
		end

	execute_with_parameters (params: DEBUGGER_EXECUTION_PROFILE)
			-- Execute Current with parameters.
		do
			if attached debugger_manager as dbg then
				dbg.controller.start_finalized_application (dbg.resolved_execution_parameters (params))
			end
		end

feature -- Properties

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_finalized_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_finalized_icon_buffer
		end

	description: STRING_GENERAL
			-- Text describing `Current' in the customize tool bar dialog.
		do
			Result := Interface_names.f_Run_finalized
		end

	tooltip: STRING_GENERAL
			-- Short description of Current.
		do
			Result := Interface_names.f_Run_finalized
		end

	tooltext: STRING_GENERAL
			-- Short description of Current.
		do
			Result := Interface_names.b_Run_finalized
		end

	name: STRING = "Run_final"
			-- Text internally defining Current.

	menu_name: STRING_GENERAL
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_finalized
		end

feature -- Basic operations

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new docking tool bar button for this command.
		do
			Result := Precursor (display_text)
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Show the arguments dialog box when the user right clicks the button.
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and is_sensitive then
				if attached eb_debugger_manager.options_cmd as o then
					o.open_execution_parameters_dialog (agent execute_with_parameters)
				end
			end
		end

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

end -- class EB_EXEC_FINALIZED_CMD
