indexing

	description:	
		"Command to stop debugging."
	date: "$Date$"
	revision: "$Revision$"

class EB_DEBUG_QUIT_CMD

inherit

	EV_COMMAND
	IPC_SHARED
	SHARED_APPLICATION_EXECUTION
	E_CMD
		rename
			execute as termination_processing
		end
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS

creation

	make, 
	non_gui_make

feature -- Initialization

	make is
			-- Initialize the command.
		do
			create request.make (Rqst_quit)
			Application.set_termination_command (Current)
		end

	non_gui_make is
			-- Initialization routine for the non GUI version.
		do
			create request.make (Rqst_quit)
		end

feature -- Processing

	recv_dead is
			-- Wait for the application to be killed.
		do
			if request.recv_dead then end
		end

feature -- Output

	termination_processing is
			-- Print the termination message to the debug_window
			-- and reset the object windows.
		local
			status: APPLICATION_STATUS
		do
			debug_tool.clear_cursor_position
			debug_window.clear_window
			debug_window.put_string ("System terminated")
			debug_window.new_line
			debug_window.display
			tool_supervisor.object_tool_mgr.reset
			debug_tool.clear_object_tool
			status := Application.status
			if status /= Void and then status.body_index /= Void then
				status.set_is_stopped (False)
				tool_supervisor.feature_tool_mgr.show_stoppoint
						(status.body_index, status.break_index)
				debug_tool.show_stoppoint
						(status.body_index, status.break_index)
			end
		end

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Debug_quit 
--		end
 
feature -- Execution

	kill is
			-- Continue execution.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status
			if status /= Void then
				Application.kill
			else
				--debug_window.clear_window
				--debug_window.put_string ("System not launched")
				--debug_window.display
			end
		end

	interrupt (argument: ANY) is
			-- Continue execution.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status
			if status /= Void then
				if not status.is_stopped then
						-- Ask the application to interrupt ASAP.
					debug_window.clear_window
					debug_window.put_string ("System is running")
					debug_window.new_line
					debug_window.put_string ("Interruption request")
					debug_window.new_line
					debug_window.display
					Application.interrupt
				end
			else
				--debug_window.clear_window
				--debug_window.put_string ("System not launched")
				--debug_window.display
			end
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_kill
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_kill
		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Debug_kill
--		end

	request: EWB_REQUEST
			-- Request of some sort.

end -- class EB_DEBUG_QUIT_CMD
