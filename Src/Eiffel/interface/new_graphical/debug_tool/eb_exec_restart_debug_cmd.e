indexing

	description:
		"Set execution format so that breakable point %
			%will be taken into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_RESTART_DEBUG_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			Step_into as execution_mode
		redefine
			internal_execute,
			tooltext
		end

	EB_SHARED_PREFERENCES

create
	make

feature -- Initialization

	internal_execute (a_execution_mode: INTEGER) is
			-- Execute.
		local
			ag: PROCEDURE [ANY, TUPLE]
		do
			if eb_debugger_manager.application_is_executing then
				eb_debugger_manager.enable_keep_raised

				if delayed_run_action = Void then
					create delayed_run_action.make (agent internal_execute (a_execution_mode), 5)
				end
				ag := agent delayed_run_action.request_call
				eb_debugger_manager.application_quit_actions.extend (ag)
				eb_debugger_manager.application_quit_actions.prune_when_called (ag)

				kill_requested := False
				ask_and_kill

				if not kill_requested then
					eb_debugger_manager.application_quit_actions.prune_all (ag)
				end
			else
				delayed_run_action.cancel_request
				delayed_run_action := Void
				Precursor (a_execution_mode)
			end
		end

	delayed_run_action: ES_DELAYED_ACTION

feature {NONE} -- Implementation

	ask_and_kill is
			-- Pop up a discardable confirmation dialog before killing the application.
		local
			cd: EB_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (2, preferences.dialog_data.confirm_kill_and_restart_string,
					Interface_names.l_Confirm_kill_and_restart, Interface_names.l_Do_not_show_again,
					preferences.preferences)
			cd.set_ok_action (agent kill)
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			window_manager.last_focused_window.show
		end

	kill is
			-- Effectively kill the application.
		require
			valid_application: eb_debugger_manager.application_is_executing
		do
			if eb_debugger_manager.application_is_executing then
				kill_requested := True
				eb_debugger_manager.application.kill
			end
		end

	kill_requested: BOOLEAN

feature {NONE} -- Attributes

	pixmap: EV_PIXMAP is
			-- Pixmap for the button.
		do
			Result := pixmaps.icon_pixmaps.debug_restart_icon
		end

	name: STRING is "Exec_restart_debug"
			-- Name of the command.

	tooltext: STRING_GENERAL is
			-- Default text displayed in toolbar button
		do
			Result := "Restart" --Interface_names.b_launch
		end

	internal_tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := "Restart" --Interface_names.e_Exec_debug
		end

	menu_name: STRING_GENERAL is
			-- Name used in menu entry.
		once
			Result := "Restart" -- Interface_names.m_Debug_run_new
		end

indexing
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

end -- class EB_EXEC_NO_STOP_CMD
