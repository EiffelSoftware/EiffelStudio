indexing

	description:	
		"Window describing an Eiffel object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create,
			close_windows as old_close_windows
		redefine
			text_window, build_format_bar, hole, build_widgets,
			tool_name, default_format
		end
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole, default_format, close_windows,
			tool_name, make, build_widgets, attach_all
		select
			make, attach_all, close_windows
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only;
		end;

feature -- Window Properties

	text_window: OBJECT_TEXT;
			-- Window to display the text in.

	tool_name: STRING is
		do
			Result := l_Object
		end;

feature -- Commands

	showattr_command: SHOW_ATTR_VALUES;

	showonce_command: SHOW_ONCE_RESULTS;

	current_target: CURRENT_OBJECT;

	previous_target: PREVIOUS_OBJECT;

	next_target: NEXT_OBJECT;

	slice_command: SLICE_COMMAND;

feature {NONE} -- Properties; Forms And Holes

	hole: OBJECT_HOLE;
			-- Hole charaterizing current

	command_bar: FORM;
			-- Bar with the command buttons

feature {NONE} -- Implementation; Window Settings

	close_windows is
			-- Close sub-windows.
		do
			old_close_windows;
			if slice_command.slice_window.is_popped_up then
				slice_command.slice_window.popdown
			end
		end;

feature {NONE} -- Implementation; Graphical Interface

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!! showonce_command.make (format_bar, text_window);
			!! showattr_command.make (format_bar, text_window);
			format_bar.attach_top (showattr_command, 0);
			format_bar.attach_left (showattr_command, 0);
			format_bar.attach_top (showonce_command, 0);
			format_bar.attach_left_widget (showattr_command, showonce_command,0)
		end;

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!! text_window.make (new_name, global_form, Current);
			else
				!OBJECT_TAB_TEXT! text_window.make (new_name, global_form, Current);
			end;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
				!! command_bar.make (new_name, global_form);
			build_command_bar;
			text_window.set_last_format (default_format);
			attach_all
		end;

	attach_all is
		do
			default_attach_all;
			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
		end;

	build_command_bar is
		do
			!! slice_command.make (command_bar, text_window);
			command_bar.attach_left (slice_command, 0);
			command_bar.attach_right (slice_command, 0);
			command_bar.attach_bottom (slice_command, 0)
			!! current_target.make (command_bar, text_window);
			command_bar.attach_left (current_target, 0);
			command_bar.attach_right (current_target, 0);
			command_bar.attach_bottom_widget (slice_command, current_target, 10)
			!! next_target.make (command_bar, text_window);
			command_bar.attach_left (next_target, 0);
			command_bar.attach_right (next_target, 0);
			command_bar.attach_bottom_widget (current_target, next_target, 0);
			!! previous_target.make (command_bar, text_window);
			command_bar.attach_left (previous_target, 0);
			command_bar.attach_right (previous_target, 0);
			command_bar.attach_bottom_widget (next_target, previous_target, 0);
		end;

	default_format: FORMATTER is
			-- Default format shows attributes' values
		do
			Result := showattr_command
		end;

end -- class OBJECT_W
