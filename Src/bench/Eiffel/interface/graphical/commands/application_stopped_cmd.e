indexing

	description:	
		"Command for stopped applications.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STOPPED_CMD

inherit

	E_CMD;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS;
	GRAPHICS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS;
			mp: MOUSE_PTR;
			st: STRUCTURED_TEXT
		do
			!! mp.do_nothing;
			if Application.is_stopped then
					-- Application has stopped 
					-- after receiving and updating stack info
				Window_manager.object_win_mgr.synchronize;
				status := Application.status;
				if status.e_feature /= Void then
					Window_manager.routine_win_mgr.show_stoppoint
								(status.e_feature, status.break_index)
				end;
				!! st.make;
				status.display_status (st);
				Debug_window.clear_window;
				Debug_window.process_text (st);
				Debug_window.display;
				mp.restore
			else
					-- Before receiving and updating stack info
				mp.set_watch_cursor
			end
		end

end -- class APPLICATION_STOPPED_CMD
