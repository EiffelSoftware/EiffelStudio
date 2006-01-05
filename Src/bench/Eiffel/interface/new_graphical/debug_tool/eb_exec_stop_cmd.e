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
		redefine
			tooltext
		end

	EB_CONSTANTS

	EB_SHARED_DEBUG_TOOLS

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
			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if
				eb_debugger_manager.application_is_executing and then
				not eb_debugger_manager.application_is_stopped
			then
				eb_debugger_manager.application.interrupt
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

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_stop
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

