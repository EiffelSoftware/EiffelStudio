-- Command to set break points

class SHOW_BREAKPOINTS

inherit

	FORMATTER
		redefine
			dark_symbol
		end;
	SHARED_DEBUG;
	SHARED_FORMAT_TABLES

creation

	make


feature

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
		end; -- make

	symbol: PIXMAP is
		once
			Result := bm_Breakpoint
		end; -- symbol

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_breakpoint
		end;

feature {NONE}

	display_info (i: INTEGER; s: FEATURE_STONE) is
			-- Display debug format of `stone'.
		do
			text_window.process_text (debug_context (s).text)
		end;

	command_name: STRING is
		do
			Result := l_Showstops
		end; -- command_name

	title_part: STRING is
		do
			Result := l_Stoppoints_of
		end; -- title_part
	
end -- class SHOW_BREAKPOINTS
