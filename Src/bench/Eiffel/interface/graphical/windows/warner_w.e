
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
			add_cancel_action (Current, void_argument);
			add_help_action (Current,1);
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

	custom_call (a_command: COMMAND_W; a_message: STRING;
		ok_text, help_text, cancel_text: STRING) is
			
		do
			last_caller := a_command;
			set_message (a_message);
			if ok_text = void then
				hide_ok_button
			else
				set_ok_label (ok_text)
			end;
			if help_Text = void then
				hide_help_button
			else
				set_help_label (help_text);
				show_help_button
			end;
			if cancel_Text = void then
				hide_cancel_button
			else
				set_cancel_label (cancel_text)
			end;
			popup;
		end;
			
	
feature {NONE}

	work (argument: ANY) is
		local
			i : INTEGER_REF; 
        do
			popdown;
			hide_help_button;
			show_cancel_button;
			show_ok_button;
			set_ok_label ("OK");
			set_cancel_label ("Cancel");
			set_help_label ("Help");
			i ?= argument;
			if i = 1 then
				last_caller.execute (void)
			elseif argument = Current then
				last_caller.execute (Current)
			end
		end;

	last_caller: COMMAND_W
			-- Last command which popped up current

end
