
class EXPLAIN_W 

inherit

	BAR_AND_TEXT
		rename
			make as normal_create
		redefine
			text_window, build_format_bar, hole,
			tool_name, set_default_position
		end;
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole,
			tool_name, set_default_position, make
		select
			make
		end

creation

	make

feature {NONE}

	make (a_screen: SCREEN) is
			-- Create a explain window tool
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
		end;

	tool_name: STRING is do Result := l_Explain end;

	
feature 

	text_window: EXPLAIN_TEXT;
			-- A text window that display the help file of an element

	
feature {NONE}

	hole: EXPLAIN_HOLE;
			-- Hole caraterizing current

	set_default_position is
			-- Display the window a the cursor position.
		do
			set_x_y (screen.x, screen.y)
		end;

end
