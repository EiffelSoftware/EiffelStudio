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

	EB_SHARED_DEBUGGER_MANAGER
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

	SHARED_FLAGS
		export {NONE} all end

	ES_SHARED_DIALOG_BUTTONS
		export
			{NONE} all
		end

feature -- Basic operations

	execute is
			-- Exit application. Ask the user to save unsaved files and ask for
			-- confirmation on exit.
		local
			l_warning: ES_WARNING_PROMPT
			l_exit: BOOLEAN
		do
			already_confirmed := False

			if Workbench.is_compiling then
				create l_warning.make_standard_with_cancel (warning_messages.w_exiting_stops_compilation)
				l_warning.set_button_text ({ES_DIALOG_BUTTONS}.ok_button, interface_names.b_force_exit)
				l_warning.set_button_icon ({ES_DIALOG_BUTTONS}.ok_button, pixmaps.icon_pixmaps.general_warning_icon)
				l_warning.set_button_text ({ES_DIALOG_BUTTONS}.cancel_button, interface_names.b_ok)
				l_warning.show_on_active_window
				l_exit := l_warning.dialog_result = {ES_DIALOG_BUTTONS}.ok_button
			else
				l_exit := True
			end

			if l_exit then
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
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
		do
			if not already_confirmed then
				already_confirmed := True
				create l_confirm.make_standard (interface_names.l_exit_application, "", preferences.dialog_data.confirm_on_exit_string)
				l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent exit_application)
				l_confirm.show_on_active_window
			else
				exit_application
			end
		end

feature {NONE} -- Callbacks

	exit_application is
			-- Exit the application
			-- This application means Eiffel Studio.
		local
			l_error: ES_ERROR_PROMPT
			l_eb_debugger_manager: EB_DEBUGGER_MANAGER
		do
			l_eb_debugger_manager := eb_Debugger_manager
			if l_eb_debugger_manager /= Void and then l_eb_debugger_manager.raised then
				l_eb_debugger_manager.enable_exiting_eiffel_studio
			end
				-- If an application was being debugged, kill it.			
			if Debugger_manager.application_is_executing then
				Debugger_manager.application.kill
			end
			if Eb_debugger_manager.debug_mode_forced then
				Eb_debugger_manager.save_debug_docking_layout
			end

				-- If we are going to kill the application, we'd better warn project observers that the project will
				-- soon be unloaded before EiffelStudio is destroyed.
			if Workbench.Eiffel_project.initialized then
				Workbench.Eiffel_project.manager.on_project_close;
			end

				-- We will save all the preferences for next time we are opened
			preferences.preferences.save_preferences

				-- Store metric archive history.
			set_is_exit_requested (True)
			if metric_manager.has_archive_been_loaded then
				metric_manager.store_archive_history
			end
			if metric_manager.has_error then
					-- Metric error
				create l_error.make_standard (metric_manager.last_error.message)
				l_error.show_on_active_window
			end

				-- Store customized formatters
			if customized_formatter_manager.is_loaded then
				customized_formatter_manager.store
			end

			window_manager.a_development_window.save_tools_docking_layout

				-- Destroy all development windows.
			window_manager.close_all

				-- Destroy the application.
			ev_application.destroy
		end

	confirm_stop_debug is
			-- Exit application. Ask the user to kill the debugger if it is running
		local
			l_confirm: ES_QUESTION_PROMPT
		do
			if process_manager.is_process_running then
				process_manager.terminate_process
			end
			if Debugger_manager.application_is_executing then
				already_confirmed := True
				create l_confirm.make_standard (warning_messages.w_exiting_stops_debugger)
				l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent confirm_and_exit)
				l_confirm.show_on_active_window
			else
				confirm_and_exit
			end
		end

	confirm_and_exit is
			-- Ask to save files, to confirm if necessary and exit.
		local
			l_exit_save_prompt: ES_SAVE_CLASSES_PROMPT
			l_list: DS_ARRAYED_LIST [CLASS_I]
		do
			if window_manager.has_modified_windows then
				already_confirmed := True

				create l_list.make_default
				window_manager.all_modified_classes.do_all (agent l_list.force_last)

				create l_exit_save_prompt.make_standard_with_cancel (interface_names.l_exit_warning)
				l_exit_save_prompt.classes := l_list
				l_exit_save_prompt.set_button_action (l_exit_save_prompt.dialog_buttons.yes_button, agent save_and_exit)
				l_exit_save_prompt.set_button_action (l_exit_save_prompt.dialog_buttons.no_button, agent exit_application)
				l_exit_save_prompt.show_on_active_window
			else
				ask_confirmation
			end
		end

	save_and_exit is
			-- Save all windows and exit.
		local
			l_error: ES_ERROR_PROMPT
		do
			window_manager.save_all
			if not window_manager.has_modified_windows then
				ask_confirmation
			else
					-- Was unable to save all, so do not exit
				create l_error.make_standard (warning_messages.w_could_not_save_all)
				l_error.show_on_active_window
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
