-- Command to set break points

class SHOW_BREAKPOINTS

inherit

	FORMATTER
		rename
			format as old_format
		redefine
			dark_symbol, display_temp_header
		end;
	FORMATTER
		redefine
			dark_symbol, format, display_temp_header
		select
			format
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

	format (stone: FEATURE_STONE) is
			-- Show the "debug" format of `stone' if it is debuggable.
		local
			tool: BAR_AND_TEXT
		do
			if stone /= Void then
				if stone.feature_i.is_debuggable then
					old_format (stone)
				else
					tool ?= text_window.tool;
					if tool /= Void then
						tool.showtext_command.execute (stone)
					end
				end
			end
		end;
			
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
	
	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Computing stop point positions...")
		end;

end -- class SHOW_BREAKPOINTS
