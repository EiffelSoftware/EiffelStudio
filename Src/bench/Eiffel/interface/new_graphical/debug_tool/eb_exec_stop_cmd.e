indexing

	description:	
		"Command to pause the execution of the debugged application."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_STOP_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
				True, False, True)
			accelerator.actions.extend (~execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if
				Application /= Void and then
				Application.is_running and then
				not Application.is_stopped
			then
				Application.interrupt
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
			Result := Interface_names.e_Exec_stop
		end

	name: STRING is "Exec_stop"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Debug_interrupt_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing `Current' on buttons.
		once
			Result := Pixmaps.Icon_exec_stop
		end

end -- class EB_EXEC_STOP_CMD

