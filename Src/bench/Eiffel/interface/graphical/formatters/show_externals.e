-- Command to display class external routines.

class SHOW_EXTERNALS 

inherit

	FORMATTER
		redefine
			dark_symbol
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
			Result := bm_Showexternals 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showexternals 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showexternals end;

	title_part: STRING is do Result := l_Externals_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
		local
			cmd: EWB_EXTERNALS
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end

end
