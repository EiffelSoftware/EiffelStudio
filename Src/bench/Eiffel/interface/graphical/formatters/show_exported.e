-- Command to display exported features of a class.

class SHOW_EXPORTED

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
			Result := bm_Showexported 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showexported 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showexported end;

	title_part: STRING is do Result := l_Exported_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
		local
			cmd: EWB_EXPORTED
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end

end
