indexing

	description:	
		"Window to show a warning.";
	date: "$Date$";
	revision: "$Revision$"

class WARNER_W 

inherit

	OUTPUT_WINDOW
		redefine
			display, clear_window
		end;
	COMMAND_W
		redefine
			execute
		end;
	NAMER;
	WARNING_D
		rename
			make as warning_create,
			popup as warning_popup
		end;
	WARNING_D
		rename
			make as warning_create
		redefine
			popup
		select
			popup
		end;
	WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_parent: COMPOSITE) is
			-- Create a warning window.
		do
			warning_create (l_Warning, a_parent);
			set_title (l_Warning);
			add_ok_action (Current, Current);
			add_cancel_action (Current, Void);
			add_help_action (Current, help_it);
			allow_resize;
			set_default_position (false);
			set_composite_attributes (Current);
			realize
		end;

feature -- Graphical Interface

	popup is
			-- Popup warning window.
		local
			new_x, new_y: INTEGER
		do
			if window = Void then
				new_x := (screen.width - width) // 2;
				new_y := (screen.height - height) // 2
			elseif is_exclusive_grab then
				new_x := window.real_x + (window.width - width) // 2;
				new_y := window.real_y + (window.height - height) // 2
			else
				new_x := window.real_x + (window.width - width) // 2;
				new_y := window.real_y - height
			end;
			if new_x + width > screen.width then
				new_x := screen.width - width
			end;
			if new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			end;
			if new_y < 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y);
			warning_popup
		end;

feature -- Window Settings

	set_last_caller (cmd: WARNER_CALLBACKS) is
		do
			last_caller := cmd
		end;

	set_window (wind: like window) is
		do
			window := wind
		end;

feature -- Access

	call (a_command: WARNER_CALLBACKS; a_message: STRING) is
			-- Record calling command `a_command' and popup current with
			-- the message `a_message'.
		do
			hide_help_button;
			show_cancel_button;
			show_ok_button;
			set_ok_label (l_Ok);
			set_cancel_label (l_Cancel);
			last_caller := a_command;
			set_message (a_message);
			set_exclusive_grab;
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	gotcha_call (a_message: STRING) is
		do
			set_no_grab;
			add_button_press_action (1, Current, popdown_action);
			custom_call (Void, a_message, Void, Void, Void);
		end;

	custom_call (a_command: WARNER_CALLBACKS; a_message: STRING;
		ok_text, help_text, cancel_text: STRING) is
			-- A gotcha custom call is when a popup has one (or more) button
			-- in which the callback only pops the window down. 
			-- (a void a_command implies a gotcha warner)
		do
			last_caller := a_command;
			set_message (a_message);
			if ok_text = void then
				hide_ok_button
			else
				set_ok_label (ok_text);
				show_ok_button
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
				set_cancel_label (cancel_text);
				show_cancel_button
			end;

			if (a_command /= Void) then
				set_exclusive_grab;
			end
			
			popup;
		end;

feature {NONE} -- Properties

	popdown_action: ANY is
		once
			!!Result
		end;

	help_it: ANY is
		once
			!!Result
		end;

	last_caller: WARNER_CALLBACKS
			-- Last command which popped up current

	window: WIDGET;
			-- Window to which the warning will apply

feature {NONE} -- Implementation

	execute (argument: ANY) is
		do
			work (argument)
		end;

	work (argument: ANY) is
		do
			popdown;
			if argument /= popdown_action then
				if last_caller /= void then
					if argument = help_it then
						last_caller.execute_warner_help
					elseif argument = Current then
						last_caller.execute_warner_ok (Current)
					end
				end
			end
		end;

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
			error_message.extend (c);
		end;

end -- class WARNER_W
