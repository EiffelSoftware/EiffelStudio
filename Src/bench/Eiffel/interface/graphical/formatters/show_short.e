-- Command to display the short version of a class

class SHOW_SHORT

inherit

	FORMATTER
		redefine
			dark_symbol
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showshort 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showshort 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showshort end;

	title_part: STRING is do Result := l_Short_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		do
			text_window.process_text (short_context (c).text)
		end

end
