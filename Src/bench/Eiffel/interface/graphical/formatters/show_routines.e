-- Command to display class routines.

class SHOW_ROUTINES 

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
			Result := bm_Showroutines 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showroutines 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showroutines end;

	title_part: STRING is do Result := l_Routines_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
		local
			cmd: EWB_ROUTINES
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for routines...")
		end;

	post_fix: STRING is "rou";

end
