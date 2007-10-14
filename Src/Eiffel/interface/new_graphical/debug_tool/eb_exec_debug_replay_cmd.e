indexing

	description:
		"Command to replay the execution of the debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_DEBUG_REPLAY_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

create
	make_back,
	make_forth

feature {NONE} -- Initialization

	make_back (a_manager: like debugger_manager)
			-- Initialize `Current'.
		do
			make_with_direction (a_manager, 1)
		end

	make_forth (a_manager: like debugger_manager)
			-- Initialize `Current'.
		do
			make_with_direction (a_manager, 2)
		end

	make_with_direction (a_manager: like debugger_manager; a_dir: like direction)
		do
			debugger_manager := a_manager
			direction := a_dir

			inspect direction
			when 1 then
				name := "ExecReplayBack"
			when 2 then
				name := "ExecReplayForth"
			when 3 then
				name := "ExecReplayLeft"
			when 4 then
				name := "ExecReplayRight"
			else
				name := "ExecReplay"
			end
		end

feature -- Properties

	direction: INTEGER

feature -- Execution

	execute is
			-- Pause the execution.
		require else
			stopped: debugger_manager.safe_application_is_stopped
			replay_activated: debugger_manager.application_status.replay_activated
		local
			b: BOOLEAN
			dm: like debugger_manager
		do
			dm := debugger_manager
			if dm.safe_application_is_stopped then
				inspect direction
				when 1 then
					b := dm.application.replay (1)
				when 2 then
					b := dm.application.replay (2)
				else
					b := False
				end
				check replay_succeed: b = True end
				dm.update_execution_replay
			end
		end

feature -- Access

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			inspect direction
			when 1 then
				Result := Interface_names.e_Exec_replay_back
			when 2 then
				Result := Interface_names.e_Exec_replay_forth
			when 3 then
				Result := Interface_names.e_Exec_replay_left
			when 4 then
				Result := Interface_names.e_Exec_replay_right
			else
				Result := Interface_names.e_Exec_replay
			end
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			inspect direction
			when 1 then
				Result := Interface_names.b_Exec_replay_back
			when 2 then
				Result := Interface_names.b_Exec_replay_forth
			when 3 then
				Result := Interface_names.b_Exec_replay_left
			when 4 then
				Result := Interface_names.b_Exec_replay_right
			else
			end
		end

	name: STRING
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			inspect direction
			when 1 then
				Result := Interface_names.m_Exec_replay_back
			when 2 then
				Result := Interface_names.m_Exec_replay_forth
			when 3 then
				Result := Interface_names.m_Exec_replay_left
			when 4 then
				Result := Interface_names.m_Exec_replay_right
			else
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			inspect direction
			when 1 then
				Result := pixmaps.icon_pixmaps.general_arrow_down_icon
			when 2 then
				Result := pixmaps.icon_pixmaps.general_arrow_up_icon
			when 3 then
				Result := pixmaps.icon_pixmaps.general_move_left_icon
			when 4 then
				Result := pixmaps.icon_pixmaps.general_move_right_icon
			else
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			inspect direction
			when 1 then
				Result := pixmaps.icon_pixmaps.general_arrow_down_icon_buffer
			when 2 then
				Result := pixmaps.icon_pixmaps.general_arrow_up_icon_buffer
			when 3 then
				Result := pixmaps.icon_pixmaps.general_move_left_icon_buffer
			when 4 then
				Result := pixmaps.icon_pixmaps.general_move_right_icon_buffer
			else
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EB_EXEC_DEBUG_REPLAY_CMD
