indexing

	description:	
		"Command for stopped applications.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STOPPED_CMD

inherit

	E_CMD
	SHARED_APPLICATION_EXECUTION
	WINDOWS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status			: APPLICATION_STATUS
			call_stack_elem	: CALL_STACK_ELEMENT
		do
			debug("DEBUGGER") io.put_string("APPLICATION_STOPPED_CMD: execute%N"); end
			status := Application.status
			if Application.is_stopped and then status /= Void then
					-- Application has stopped 
					-- after receiving and updating stack info
				Window_manager.object_win_mgr.synchronize
	
					-- Display the callstack, the current object & the current stop point.
				Application.set_current_execution_stack (1)	-- go on top of stack
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
					Project_tool.show_current_stoppoint
					Project_tool.show_current_object
					Project_tool.display_exception_stack
				end

					-- Display the callstack arrow in all opened feature tools.
				Window_manager.routine_win_mgr.synchronize_with_callstack

			else
					-- Before receiving and updating stack info
			end
		end

end -- class APPLICATION_STOPPED_CMD
