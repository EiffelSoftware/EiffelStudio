indexing

	description:	
		"Window describing an explanation";
	date: "$Date$";
	revision: "$Revision$"

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

feature -- Creation

	make (a_screen: SCREEN) is
			-- Create a explain window tool
		do
			normal_create (a_screen);
			text_window.set_read_only
		end;

feature -- Graphical Interface

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
			!! showtext_command.make (format_bar, text_window);
			format_bar.attach_top (showtext_command, 0);
			format_bar.attach_left (showtext_command, 0);
		end;

feature -- Window Properties

	tool_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := l_Explain
		end;

	text_window: EXPLAIN_TEXT;
			-- A text window that displays the help file of an element
	
feature {NONE} -- Attributes; Forms And Holes

	hole: EXPLAIN_HOLE;
			-- Hole charaterizing current

end -- class EXPLAIN_W
