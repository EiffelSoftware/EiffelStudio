
class WARNER_W 

inherit

	COMMAND_W;
	NAMER;
	WARNING_D
		rename
			make as warning_create
		end

creation

	make
	
feature 

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		local
			void_argument: ANY
		do
			warning_create (l_Warning, a_composite);
			set_title (l_Warning);
			set_exclusive_grab;
			hide_help_button;
			add_ok_action (Current, Current);
			add_cancel_action (Current, void_argument)
		end;

	call (a_command: COMMAND_W; a_message: STRING) is
			-- Record calling command `a_command' and popup current with
			-- the message `a_message'.
		do
			last_caller := a_command;
			set_message (a_message);
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	
feature {NONE}

	work (argument: ANY) is
        do
			popdown;
			if argument = Current then
				last_caller.execute (Current)
			end
		end;

	last_caller: COMMAND_W
			-- Last command which popped up current

end
