
class NAME_CHOOSER_W 

inherit

	COMMAND_W;
	NAMER;
	FILE_SEL_D
		rename
			make as file_sel_d_create,
			popup as file_sel_d_popup
		end;
	FILE_SEL_D
		rename
			make as file_sel_d_create
		redefine
			popup
		select
			popup
		end;
	LIC_EXITER

creation

	make
	
feature 

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		do
			file_sel_d_create (l_file_selection, a_composite);
			set_title (l_file_selection);
			hide_help_button;
			add_ok_action (Current, Current);
			add_cancel_action (Current, Void);
			set_title (l_Select_a_file);
			set_exclusive_grab;
			parent.hide
		end;

	popup is
			-- Popup file selection window.
		do
			if window /= Void then
				parent.set_x_y (window.real_x, window.real_y);
				parent.set_size (window.width, window.height);
				window := Void
			else
				parent.set_x_y (0, 0);
				parent.set_size (screen.width, screen.height);
			end;
			parent.hide;
			if is_popped_up then popdown end;
			file_sel_d_popup;
			raise
		end;

	call (a_command: COMMAND_W) is
			-- Record calling command `a_command' and popup current.
		do
			last_caller := a_command;
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	set_window (wind: TEXT_WINDOW) is
		do
			window ?= wind.tool
		end;

feature {NONE}

	work (argument: ANY) is
		do
			popdown;
			if argument = Current then
				last_caller.execute (Current)
			else
				set_global_cursor (watch_cursor);
				project_tool.set_changed (false);
				if not project_tool.initialized then
					discard_licence;
					exit
				end;
			end
		end;

	last_caller: COMMAND_W
			-- Last command which popped up current

	window: WIDGET;
			-- Window to which the file selection will apply

end
