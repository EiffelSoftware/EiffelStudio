indexing
	description	: "Command for stopped applications."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_APPLICATION_STOPPED_COMMAND

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
			status: APPLICATION_STATUS
			call_stack_elem: CALL_STACK_ELEMENT
		do
			status := Application.status
			if Application.is_stopped and then status /= Void then
					-- Application has stopped 
					-- after receiving and updating stack info

				--| FIXME ARNAUD: Update the object tool here

					-- Display the callstack, the current object & the current stop point.
				Application.set_current_execution_stack (1)
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
--|					debug_tool.show_current_stoppoint
--|					debug_tool.show_current_object
--|					debug_tool.display_exception_stack
				end
					-- Display the callstack arrow in all opened windows.
--|				window_manager.synchronize_with_callstack
			end
		end

end -- class EB_APPLICATION_STOPPED_COMMAND
