indexing
	description	: "Command to exit the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXIT_APPLICATION_COMMAND

inherit
	EB_MENUABLE_COMMAND

	PROJECT_CONTEXT
		export {NONE} all end

	SHARED_DEBUGGER_MANAGER
		export {NONE} all end

	EB_SHARED_MANAGERS
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	EV_SHARED_APPLICATION
		export {NONE} all end

	EB_SHARED_PREFERENCES
		export {NONE} all end

feature -- Basic operations

	execute is
			-- Exit application. Ask the user to save unsaved files and ask for
			-- confirmation on exit.
		local
			wd: EB_WARNING_DIALOG
		do
			already_confirmed := False
			if Workbench.is_compiling then
				already_confirmed := True
				create wd.make_with_text (Warning_messages.w_Exiting_stops_compilation)
				wd.show_modal_to_window (window_manager.last_focused_window.window)
			else
				if process_manager.is_process_running then
					process_manager.confirm_process_termination_for_quiting (agent confirm_stop_debug, agent do_nothing, window_manager.last_focused_window.window)
				else
					confirm_stop_debug
				end
			end
		end

feature -- Status setting

	set_already_confirmed (b: BOOLEAN) is
			-- Set a flag saying a confirmation dialog was already displayed => do not ask again.
		do
			already_confirmed := b
		end

feature {EB_WINDOW_MANAGER} -- Exit methods.

	ask_confirmation is
			-- Display a confirmation dialog box
		local
			exit_confirmation_dialog: EB_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if not already_confirmed then
				already_confirmed := True
				create exit_confirmation_dialog.make_initialized (
					2, preferences.dialog_data.confirm_on_exit_string,
					Interface_names.l_Exit_application, Interface_names.l_Dont_ask_me_again,
					preferences.preferences
				)
				exit_confirmation_dialog.set_ok_action (agent exit_application)
				exit_confirmation_dialog.show_modal_to_window (window_manager.last_focused_window.window)
			else
				exit_application
			end
		end

feature {NONE} -- Callbacks

	exit_application is
			-- Exit the application
		local
			l_err_dlg: EV_ERROR_DIALOG
		do
				-- If an application was being debugged, kill it.
			if Debugger_manager.application_is_executing then
				Debugger_manager.application.kill
			end
				-- If we are going to kill the application, we'd better warn project observers that the project will
				-- soon be unloaded before EiffelStudio is destroyed.
			if Workbench.Eiffel_project.initialized then
				Workbench.Eiffel_project.manager.on_project_close;
			end

				-- We will save all the preferences for next time we are opened
			preferences.preferences.save_preferences

				-- Store metric archive history.
			metric_manager.set_is_exit_requested (True)
			if metric_manager.has_archive_been_loaded then
				metric_manager.store_archive_history
			end
			if metric_manager.has_error then
				create l_err_dlg.make_with_text (metric_manager.last_error.message)
				l_err_dlg.set_buttons (<<interface_names.b_ok>>)
				l_err_dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
			end

				-- Destroy all development windows.
			window_manager.close_all

				-- Destroy the application.
			ev_application.destroy
		end

	confirm_stop_debug is
			-- Exit application. Ask the user to kill the debugger if it is running
		local
			cd: EB_CONFIRMATION_DIALOG
		do
			if process_manager.is_process_running then
				process_manager.terminate_process
			end
			if Debugger_manager.application_is_executing then
				already_confirmed := True
				create cd.make_with_text (Warning_messages.w_Exiting_stops_debugger)
				cd.button (cd.OK).select_actions.extend (agent confirm_and_exit)
				cd.show_modal_to_window (window_manager.last_focused_window.window)
			else
				confirm_and_exit
			end
		end

	confirm_and_exit is
			-- Ask to save files, to confirm if necessary and exit.
		local
			qd: EB_QUESTION_DIALOG
		do
			if window_manager.has_modified_windows then
				already_confirmed := True
				create qd.make_with_text (Interface_names.l_Exit_warning)
				qd.button (interface_names.b_yes).select_actions.extend (agent save_and_exit)
				qd.button (interface_names.b_no).select_actions.extend (agent ask_confirmation)
				qd.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				ask_confirmation
			end
		end

	save_and_exit is
			-- Save all windows and exit.
		local
			wd: EB_WARNING_DIALOG
		do
			window_manager.save_all
			if not Window_manager.has_modified_windows then
				ask_confirmation
			else
				create wd.make_with_text (Warning_messages.W_could_not_save_all)
				wd.show_modal_to_window (Window_manager.last_focused_window.window)
			end
		end

	stop_compilation_and_exit is
			-- Interrupt the current compilation.
		require
			Workbench.is_compiling
		do
			Workbench.Eiffel_project.stop_and_exit (agent ask_confirmation)
		end

feature {NONE} -- Attributes

	menu_name: STRING_GENERAL is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exit_project
		end

	already_confirmed: BOOLEAN;
			-- Has the user already said he DID want to exit?
			--| We shouldn't ask again then.

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

end -- class EB_EXIT_APPLICATION_CMD
