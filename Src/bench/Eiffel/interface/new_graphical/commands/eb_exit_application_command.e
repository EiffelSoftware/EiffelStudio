indexing
	description	: "Command to exit the application"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXIT_APPLICATION_COMMAND

inherit
	EB_MENUABLE_COMMAND

	PROJECT_CONTEXT
		export {NONE} all end

	SHARED_APPLICATION_EXECUTION 
		export {NONE} all end

	EB_SHARED_MANAGERS 
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	SHARED_BENCH_LICENSES
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end
		
	EV_SHARED_APPLICATION
		export {NONE} all end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Basic operations

	execute is
			-- Exit application. Ask the user to save unsaved files and ask for
			-- confirmation on exit.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if Workbench.is_compiling then
				create cd.make_with_text (Warning_messages.w_Exiting_stops_compilation)
				cd.button ("OK").select_actions.extend (~confirm_stop_debug)
				cd.show_modal_to_window (window_manager.last_focused_window.window)
			else
				confirm_stop_debug
			end
		end

feature -- Status setting

	set_already_save_confirmed (b: BOOLEAN) is
			-- Set a flag saying a save dialog was already displayed => do not ask again.
		do
			already_confirmed_no_save := b
		end

feature {NONE} -- Callbacks

	confirm_stop_debug is
			-- Exit application. Ask the user to kill the debugger if it is running.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if Application.is_running then
				create cd.make_with_text (Warning_messages.w_Exiting_stops_debugger)
				cd.button ("OK").select_actions.extend (~confirm_and_exit)
				cd.show_modal_to_window (window_manager.last_focused_window.window)
			else
				confirm_and_exit
			end
		end

	confirm_and_exit is
			-- Ask to save files, to confirm if necessary and exit.
		local
			qd: EV_QUESTION_DIALOG
		do
			if window_manager.has_modified_windows then
				if not already_confirmed_no_save then
					create qd.make_with_text (Interface_names.l_Exit_warning)
					qd.button ("Yes").select_actions.extend (~save_and_exit)
					qd.button ("No").select_actions.extend (~exit_application)
					qd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					exit_application
				end
			else
				if not already_confirmed_no_save then
					ask_confirmation
				else
					exit_application
				end
			end
		end

	save_and_exit is
			-- Save all windows and exit.
		do
			window_manager.save_all
			if not Window_manager.has_modified_windows then
				exit_application
			end
		end

	exit_application is
			-- Exit the application
		do
			already_confirmed := True
			already_confirmed_no_save := True	
				-- If we were compiling, stop the compilation.
			if Workbench.is_compiling then
				stop_compilation_and_exit
			end
				-- If an application was being debugged, kill it.
			if Application.is_running then
				Application.kill
			end
			discard_licenses

			Recent_projects_manager.save_environment

				-- Destroy all development windows.
			window_manager.close_all

				-- Destroy the application.
			ev_application.destroy
		end

	ask_confirmation is
			-- Display a confirmation dialog box
		local
			exit_confirmation_dialog: EB_STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if not already_confirmed then
				create exit_confirmation_dialog.make_initialized (
					2, "confirm_on_exit",
					Interface_names.l_Exit_application, Interface_names.l_Dont_ask_me_again
				)
				exit_confirmation_dialog.set_ok_action (~exit_application)
				exit_confirmation_dialog.show_modal_to_window (window_manager.last_focused_window.window)
			end
		end

	stop_compilation_and_exit is
			-- Interrupt the current compilation.
		require
			Workbench.is_compiling
		do
			Workbench.Eiffel_project.stop_and_exit (~execute)
		end

feature {NONE} -- Attributes

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exit_project
		end

	already_confirmed: BOOLEAN
			-- Has the user already said he DID wanted to exit?
			--| We shouldn't ask again then.

	already_confirmed_no_save: BOOLEAN
			-- Has the user already said he didm't want to save?
			--| We shouldn't ask again then.

end -- class EB_EXIT_APPLICATION_CMD
