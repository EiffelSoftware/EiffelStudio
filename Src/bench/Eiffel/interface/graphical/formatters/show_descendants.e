
-- Command to display class descendants.

class SHOW_DESCENDANTS 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		ensure
			default_indent: indent = 4
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showdescendants 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showdescendants 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showdescendants end;

	title_part: STRING is do Result := l_Descendants_of end;

	display_info (c: CLASSC_STONE) is
			-- Display descendants of `c' in tree form.
		local
			cmd: E_SHOW_DESCENDANTS
		do
			!! cmd.make (c.class_c, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for descendants...")
		end;

	post_fix: STRING is "des";

end
