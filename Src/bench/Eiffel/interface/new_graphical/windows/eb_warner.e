indexing
	description: "EiffelBench warning dialog"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_WARNER

inherit

--	OUTPUT_WINDOW
--		redefine
--			display, clear_window
--		end
	EV_COMMAND
	NAMER

	EV_WARNING_DIALOG
		rename
			make_with_text as warning_create
		redefine
			show
		end
	WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a warning window.
		do
			warning_create (par, Interface_names.t_Warning, Interface_names.n_X_resource_name)
			add_ok_command (Current, Void)
			add_cancel_command (Current, Void)
			add_help_command (Current, Void)
			allow_resize
			set_default_position (false)
		end

feature -- Graphical Interface

	show is
			-- Popup warning window.
--		local
--			new_x, new_y: INTEGER
		do
--			if window = Void then
--				new_x := (screen.width - width) // 2
--				new_y := (screen.height - height) // 2
--			elseif is_exclusive_grab then
--				new_x := window.x + (window.width - width) // 2
--				new_y := window.y + (window.height - height) // 2
--			else
--				new_x := window.x + (window.width - width) // 2
--				new_y := window.y - height
--			end
--			if new_x + width > screen.width then
--				new_x := screen.width - width
--			end
--			if new_x < 0 then
--				new_x := 0
--			end
--			if new_y + height > screen.height then
--				new_y := screen.height - height
--			end
--			if new_y < 0 then
--				new_y := 0
--			end
--			set_x_y (new_x, new_y)
			{EV_WARNING_DIALOG} Precursor
		end

feature -- Window Settings

	set_last_caller (cmd: WARNER_CALLBACKS) is
		do
			last_caller := cmd
		end

	set_window (wind: like window) is
		do
			window := wind
		end

feature -- Access

	full_call (a_command: WARNER_CALLBACKS; a_message: STRING) is
			-- Record calling command `a_command' and popup current with
			-- the message `a_message'.
		do
			show_ok_cancel_button
			last_caller := a_command
			set_message (a_message)
			show
		ensure
			last_caller_recorded: last_caller = a_command
		end

	just_ok_call (a_message: STRING) is
		do
			last_caller := Void
			show_ok_button
			set_message (a_message)
			show
		end

	custom_call (a_command: WARNER_CALLBACKS; a_message: STRING;
with_cancel, with_help: BOOLEAN) is
			-- A gotcha custom call is when a popup has one (or more) button
			-- in which the callback only pops the window down. 
			-- (a void a_command implies a gotcha warner)
		do
			last_caller := a_command
			set_message (a_message)
			if with_cancel then
				show_ok_cancel_button
			else
				show_ok_button
			end
			if with_help then
				show_help_button
			end
			show
		end

feature {NONE} -- Properties

	last_caller: WARNER_CALLBACKS
			-- Last command which popped up current

	window: EV_WINDOW
			-- Window to which the warning will apply

feature {NONE} -- Implementation

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			hide
			if last_caller /= Void then	
				if selected_button = "OK" then
						-- ok button for custom call window
					last_caller.execute_warner_ok (Current)
				end
				elseif  selected_button = "Help" then
						-- custom help
					last_caller.execute_warner_help
				end
			end
		end

feature {NONE} -- Clickable features

	error_message: STRING is
			-- Message that will be displayed as an error message
		once
			!!Result.make (20)
		end

	put_string (s: STRING) is
		do
			error_message.append (s)
		end

	new_line is
		do
			error_message.append ("%N")
		end

	display is 
		do
			custom_call (last_caller, error_message, "OK", Void, Void)
			error_message.wipe_out
		end

	clear_window is
		do
			error_message.wipe_out
			hide
			set_message ("")
		end

	put_char (c: CHARACTER) is
		do
			error_message.extend (c)
		end

end -- class EB_WARNER
