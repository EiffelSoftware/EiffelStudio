-- Command to display exported features of a class.

class SHOW_EXPORTED

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
			Result := bm_Showexported 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showexported 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showexported end;

	title_part: STRING is do Result := l_Exported_of end;

	display_info (c: CLASSC_STONE) is
		local
			cmd: E_SHOW_EXPORTED_ROUTINES
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for exported features...")
		end;

	post_fix: STRING is "exp";

end
