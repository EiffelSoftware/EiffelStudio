indexing

	description:	
		"Command for stopped applications.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STOPPED_CMD

inherit

	E_CMD;
	SHARED_APPLICATION_EXECUTION;
	CURSOR_W;
	WINDOWS;
	GRAPHICS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS
		do
			if Application.is_stopped then
					-- Application has stopped 
					-- after receiving and updating stack info
				Window_manager.object_win_mgr.synchronize;
				status := Application.status;
				if status.e_feature /= Void then
					Window_manager.routine_win_mgr.show_stoppoint
								(status.e_feature, status.break_index)
				end;
				status.display_status (Debug_window);
				restore_cursors
			else
					-- Before receiving and updating stack info
				set_global_cursor (watch_cursor);	
			end
		end

end -- class APPLICATION_STOPPED_CMD
