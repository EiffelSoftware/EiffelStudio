indexing

	description:	
		"Command for to go and down an exception stack trace.";
	date: "$Date$";
	revision: "$Revision $"

class DISPLAY_CURRENT_STACK

inherit

	PIXMAP_COMMAND;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (go_up: BOOLEAN; a_tool: like tool) is	
			-- Initialize `go_up_one_level' to `go_up'
		do
			go_up_one_level := go_up;
			init (a_tool)
		ensure
			set: go_up_one_level = go_up
		end;

feature -- Access

	go_up_one_level: BOOLEAN;
			-- Go up one level in the stack
			-- (False implies to go one level down)

	name: STRING is
			-- Name of command
		do
			if go_up_one_level then
				Result := l_Up_stack
			else
				Result := l_Down_stack
			end
		end;

	symbol: PIXMAP is
			-- Symbol of command
		do
			if go_up_one_level then
				Result := bm_Up_stack
			else
				Result := bm_Down_stack
			end
		end;

feature -- Execution

	work (arg: ANY) is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			mp: MOUSE_PTR;
			stack_num: INTEGER;
			app_cmd: APPLICATION_STOPPED_CMD
		do
			if Application.is_running and then Application.is_stopped then
				stack_num := Application.current_execution_stack_number;
				if go_up_one_level then
					stack_num := stack_num - 1;
				else
					stack_num := stack_num + 1;
				end;
				if stack_num >= 1 and then 
					stack_num <= Application.number_of_stack_elements 
				then
					Application.set_current_execution_stack (stack_num);
					!! app_cmd;
					app_cmd.execute
				end
			end
		end

end -- class DISPLAY_CURRENT_STACK
