-- Command to display the flat/short version of a class

class SHOW_FS 

inherit

	FILTERABLE
		rename
			filter_context_text as flatshort_context_text
		redefine
			dark_symbol, display_temp_header, post_fix
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
			Result := bm_Showfs 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showfs 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showfs end;

	title_part: STRING is do Result := l_Flatshort_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		do
			text_window.process_text (flatshort_context_text (c))
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring ancestors to produce flat-short form...")
		end;

	post_fix: STRING is "fsh";

end
