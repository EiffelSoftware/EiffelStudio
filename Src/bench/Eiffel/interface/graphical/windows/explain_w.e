
class EXPLAIN_W 

inherit

	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole,
			tool_name, set_default_position
		end

creation

	make

feature {NONE}

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
        local
            i: INTEGER;
        do
            i := 10 * window_manager.explain_windows_count;
			set_x_y (600 + i, i)
		end;

end
