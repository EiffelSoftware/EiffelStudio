-- Command to display class onces.

class SHOW_ONCES 

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
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showonces 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showonces 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showonces end;

	title_part: STRING is do Result := l_Onces_of end;

	display_info (c: CLASSC_STONE) is
		local
			cmd: E_SHOW_ONCES
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for once routines...")
		end;

	post_fix: STRING is "onc";

end
