
-- Command to display class attributes.

class SHOW_ATTRIBUTES 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header
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
			Result := bm_Showattributes 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showattributes 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showattributes end;

	title_part: STRING is do Result := l_Attributes_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
		local
			cmd: EWB_ATTRIBUTES
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Finding attributes...")
		end;

end
