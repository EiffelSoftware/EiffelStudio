indexing

	description:	
		"Command to stop debugging and kill the application."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_QUIT 

inherit

	PIXMAP_COMMAND
	IPC_SHARED
	SHARED_APPLICATION_EXECUTION
	E_CMD
		rename
			execute as termination_processing
		end

creation

	make, 
	non_gui_make

feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize the command.
		do
			init (a_tool)
			create request.make (Rqst_quit)
			Application.set_termination_command (Current)
		end

	non_gui_make is
			-- Initialization routine for the non GUI version.
		do
			create request.make (Rqst_quit)
		end

feature -- Processing

	exit_now is
			-- Force an immediate exit.
		do
			work(Void)
		end
	
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
			Project_tool.clear_cursor_position
			debug_window.clear_window
			debug_window.put_string ("System terminated")
			debug_window.new_line
			debug_window.display
			window_manager.object_win_mgr.reset
			Project_tool.clear_object_tool
			status := Application.status
			if status /= Void and then status.body_index /= 0 then
				status.set_is_stopped (False)
--				Window_manager.routine_win_mgr.show_stoppoint(status.body_index, status.break_index)
				Project_tool.show_stoppoint(status.body_index, status.break_index)
			end
		end

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Debug_quit 
		end
 
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Continue execution.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status
			if status /= Void then
				Application.kill
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

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	request: EWB_REQUEST
			-- Request of some sort.

end -- class DEBUG_QUIT
