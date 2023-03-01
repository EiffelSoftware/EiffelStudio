note
	description:
		"Set debugging options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXECUTION_PARAMETERS_CMD

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
		end

feature -- Formatting

	launch_project (params: DEBUGGER_EXECUTION_PROFILE)
		do
			if is_sensitive and attached eb_debugger_manager as dbg then
				dbg.run_project_cmd.launch_with_parameters ({EXEC_MODES}.run, params)
			end
		end

	execute
			-- Set the execution format to `stone'.
		do
			if is_sensitive then
				open_execution_parameters_dialog (agent launch_project)
			end
		end

	open_execution_parameters_dialog (a_cmd: PROCEDURE [DEBUGGER_EXECUTION_PROFILE])
			-- Show the arguments dialog
		local
			dlg: EB_EXECUTION_PARAMETERS_DIALOG
			dev: EV_WINDOW
		do
			if attached {EB_DEVELOPMENT_WINDOW} window_manager.last_focused_window as window then
				dev := window.window
				if not execution_parameters_dialog_is_valid then
					create dlg.make (window, a_cmd)
					set_execution_parameters_dialog (dlg)
				else
					execution_parameters_dialog.update
				end
				execution_parameters_dialog.raise
			end
		end

feature -- Properties

	tooltip: STRING_GENERAL
			-- Tooltip for `Current'.
		do
			Result := interface_names.b_Execution_parameters
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer which representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
		end

	pixmap: EV_PIXMAP
			-- Pixmap for the button.
		do
			Result := pixmaps.icon_pixmaps.tool_config_icon
		end

	name: STRING_GENERAL
			-- Name of the command.
		do
			Result := "Execution_parameters"
		end

	menu_name: STRING_GENERAL
			-- Menu name
		do
			Result := interface_names.m_Execution_parameters
		end

	tooltext: STRING_GENERAL
			-- Default text displayed in toolbar button
		do
			Result := interface_names.b_Execution_parameters
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
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

end -- class EB_DEBUG_OPTIONS_CMD
