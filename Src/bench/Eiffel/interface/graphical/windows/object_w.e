--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing an Eiffel object.

class OBJECT_W 

inherit

	BAR_AND_TEXT
		rename
			attach_all as default_attach_all,
			make as normal_create
		redefine
			text_window, build_format_bar, hole, build_widgets,
			tool_name, set_default_position, default_format
		end
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole, default_format,
			tool_name, set_default_position, make, build_widgets, attach_all
		select
			make, attach_all
		end

creation

	make

feature 

	make (a_screen: SCREEN) is
			-- Create an object tool.
		do
			normal_create (a_screen);
			text_window.set_read_only;
		end;

	text_window: OBJECT_TEXT;

	
feature {NONE}

	tool_name: STRING is do Result := l_Object end;

	hole: OBJECT_HOLE;
			-- Hole caraterizing current

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showonce_command.make (format_bar, text_window);
			!!showattr_command.make (format_bar, text_window);
			format_bar.attach_top (showattr_command, 0);
			format_bar.attach_left (showattr_command, 0);
			format_bar.attach_top (showonce_command, 0);
			format_bar.attach_left_widget (showattr_command, showonce_command,0)
		end;

	build_widgets is
		do
			set_default_size;
			!!text_window.make (new_name, global_form, Current);
			!!edit_bar.make (new_name, global_form);
			build_bar;
			!!format_bar.make (new_name, global_form);
			build_format_bar;
			!!command_bar.make (new_name, global_form);
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

	command_bar: FORM;
			-- Bar with the command buttons

	build_command_bar is
		do
			!! current_target.make (command_bar, text_window);
			command_bar.attach_left (current_target, 0);
			command_bar.attach_bottom (current_target, 0)
			!! next_target.make (command_bar, text_window);
			command_bar.attach_left (next_target, 0);
			command_bar.attach_bottom_widget (current_target, next_target, 0);
			!! previous_target.make (command_bar, text_window);
			command_bar.attach_left (previous_target, 0);
			command_bar.attach_bottom_widget (next_target, previous_target, 0);
		end;

	showattr_command: SHOW_ATTR_VALUES;
	showonce_command: SHOW_ONCE_RESULTS;
	current_target: CURRENT_OBJECT;
	previous_target: PREVIOUS_TARGET;
	next_target: NEXT_TARGET;

	set_default_position is
		local
			i: INTEGER;
		do
			i := 10 * window_manager.object_windows_count;
			set_x_y (500 + i, 40 + i)
		end;
	
	default_format: FORMATTER is
			-- Default format shows attributes' values
		do
			Result := showattr_command
		end;

end
