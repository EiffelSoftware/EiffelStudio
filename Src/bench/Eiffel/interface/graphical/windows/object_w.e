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
			make as normal_create
		redefine
			text_window, build_format_bar, hole,
			tool_name, set_default_position, default_format
		end
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole, default_format,
			tool_name, set_default_position, make
		select
			make
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
--			!!showtext_command.make (format_bar, text_window);
			!!showonce_command.make (format_bar, text_window);
			!!showattr_command.make (format_bar, text_window);
--			format_bar.attach_top (showtext_command, 0);
--			format_bar.attach_left (showtext_command, 0);
			format_bar.attach_top (showattr_command, 0);
			format_bar.attach_left (showattr_command, 0);
			format_bar.attach_top (showonce_command, 0);
			format_bar.attach_left_widget (showattr_command, showonce_command,0)
		end;

	showattr_command: SHOW_ATTR_VALUES;
	showonce_command: SHOW_ONCE_RESULTS;

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
