indexing

	description:	
		"Command for stopped applications.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STOPPED_CMD

inherit

	E_CMD;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS;
			mp: MOUSE_PTR;
			call_stack: CALL_STACK_ELEMENT;
			e_feature: E_FEATURE;
			break_index: INTEGER;
			object_address: STRING;
			dynamic_class: CLASS_C;
		do
			!! mp.do_nothing;
			if Application.is_stopped then
					-- Application has stopped 
					-- after receiving and updating stack info
				Window_manager.object_win_mgr.synchronize;
				status := Application.status;
				if status.e_feature /= Void then
					call_stack := status.current_stack_element;
					Window_manager.routine_win_mgr.show_stoppoint
								(status.e_feature, status.break_index);
					Project_tool.show_current_stoppoint;
					Project_tool.show_current_object;
					Project_tool.display_exception_stack
				end;
				mp.restore
			else
					-- Before receiving and updating stack info
				mp.set_watch_cursor
			end
		end

end -- class APPLICATION_STOPPED_CMD
