indexing
	description: "Command for stopped applications."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_APPLICATION_STOPPED_CMD

inherit
	E_CMD
	SHARED_APPLICATION_EXECUTION
	EB_SHARED_INTERFACE_TOOLS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS;
--			mp: MOUSE_PTR;
			call_stack: CALL_STACK_ELEMENT;
			e_feature: E_FEATURE;
			break_index: INTEGER;
			object_address: STRING;
			dynamic_class: CLASS_C;
		do
--			!! mp.do_nothing;
			if Application.is_stopped then
					-- Application has stopped 
					-- after receiving and updating stack info
				tool_supervisor.object_tool_mgr.synchronize;
				status := Application.status;
				if status.e_feature /= Void then
					call_stack := status.current_stack_element;
					tool_supervisor.feature_tool_mgr.show_stoppoint
								(status.e_feature, status.break_index);
					debug_tool.show_current_stoppoint;
					debug_tool.show_current_object;
					debug_tool.display_exception_stack
				end;
--				mp.restore
			else
					-- Before receiving and updating stack info
--				mp.set_watch_cursor
			end
		end

end -- class EB_APPLICATION_STOPPED_CMD
