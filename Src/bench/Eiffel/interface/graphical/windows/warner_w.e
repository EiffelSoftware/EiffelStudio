
class WARNER_W 

inherit

	CLICK_WINDOW
		redefine
			display, clear_window
		end;
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
			hide_help_button;
			add_ok_action (Current, Current);
			add_cancel_action (Current, void_argument);
			add_help_action (Current,1);
		end;

	call (a_command: COMMAND_W; a_message: STRING) is
			-- Record calling command `a_command' and popup current with
			-- the message `a_message'.
		do
			hide_help_button;
			show_cancel_button;
			show_ok_button;
			set_ok_label (" Ok ");
			set_cancel_label ("Cancel");
			set_help_label ("Help");
			last_caller := a_command;
			set_message (a_message);
			set_exclusive_grab;
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	set_last_caller (cmd: COMMAND_W) is
		do
			last_caller := cmd
		end;

	gotcha_call (a_message: STRING) is
		do
			set_no_grab;
			custom_call (Void, a_message, Void, Void, Void);
		end;

	custom_call (a_command: COMMAND_W; a_message: STRING;
		ok_text, help_text, cancel_text: STRING) is
			-- A gotcha custom call is when a popup has one (or more) button
			-- in which the callback only pops the window down. 
			-- (a void a_command implies a gotcha warner)
		do
			hide_help_button;
			show_cancel_button;
			show_ok_button;
			set_ok_label (" Ok ");
			set_cancel_label ("Cancel");
			set_help_label ("Help");
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

			if (a_command /= Void) then
				set_exclusive_grab;
			end
			
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
			set_ok_label (" Ok ");
			set_cancel_label ("Cancel");
			set_help_label ("Help");
			i ?= argument;
			if last_caller /= void then
				if i = 1 then
					last_caller.execute (void)
				elseif argument = Current then
					last_caller.execute (Current)
				end
			end
		end;

	last_caller: COMMAND_W
			-- Last command which popped up current

feature {NONE} -- Clickable features

	error_message: STRING is
			-- Message that will be displayed as an error message
		once
			!!Result.make (20)
		end;

	put_string (s: STRING) is
		do
			error_message.append (s);
		end;

	put_clickable_string (a: ANY; s: STRING) is
		do
			put_string (s)
		end;

	new_line is
		do
			error_message.append ("%N");
		end;

	display is 
		do
			custom_call (last_caller, error_message, "OK", Void, Void);
			error_message.wipe_out;
		end;

	clear_window is
		do
			error_message.wipe_out;
			popdown;
			set_message ("")
		end;

	put_char (c: CHARACTER) is
		do
			error_message.append_character (c);
		end;

end
