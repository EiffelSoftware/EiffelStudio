
class EXPLAIN_W 

inherit

	BAR_AND_TEXT
		rename
			make as normal_create
		redefine
			text_window, build_format_bar, hole,
			tool_name, build_text_window
		end;
	BAR_AND_TEXT
		redefine
			text_window, build_format_bar, hole,
			tool_name, make, build_text_window
		select
			make
		end;

creation

	make

feature {NONE}

	make (a_screen: SCREEN) is
			-- Create a explain window tool
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;

	build_text_window is
			-- Create `text_window' different ways whether
			-- the tabulation mecanism is disable or not
		do
			if tabs_disabled then
				!! text_window.make (new_name, global_form, Current)
			else
				!EXPLAIN_TAB_TEXT! text_window.make (new_name, global_form, Current)
			end
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

end
