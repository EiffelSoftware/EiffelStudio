indexing

	description:	
		"Command to stop the execution of the debugged application."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_QUIT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_DEBUG_TOOLS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
				False, False, True)
			accelerator.actions.extend (~execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if Application /= Void and then Application.is_running then
				ask_and_kill
			end
		end

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_kill
		end

	name: STRING is "Exec_quit"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Debug_kill
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing `Current' on buttons.
		once
			Result := Pixmaps.Icon_exec_quit
		end

feature {NONE} -- Implementation

	ask_and_kill is
			-- Pop up a discardable confirmation dialog before killing the application.
		local
			cd: EB_STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (2, "confirm_kill", 
					Interface_names.l_Confirm_kill, Interface_names.l_Do_not_show_again)
			cd.set_ok_action (~kill)
			cd.show_modal_to_window (debugger_manager.debugging_window.window)
		end

	kill is
			-- Effectively kill the application.
		require
			valid_application: Application /= Void and then Application.is_running
		do
			if Application /= Void and then Application.is_running then
				Application.kill
			end
		end

end -- class EB_EXEC_QUIT_CMD


