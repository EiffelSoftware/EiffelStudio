
-- Command to display flat form of a class

class SHOW_FLAT 

inherit

	FILTERABLE
		rename
			filter_context_text as flat_context_text
		redefine
			dark_symbol, display_temp_header, post_fix
		end;
	SHARED_SERVER;
	SHARED_FORMAT_TABLES

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showflat 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showflat 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showflat end;

	title_part: STRING is do Result := l_Flat_form_of end;

	display_info (c: CLASSC_STONE) is
			-- Display flat form of 'c'.
		do
			text_window.process_text (flat_context_text (c))
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring ancestors to produce flat form...")
		end;
	
	post_fix: STRING is "fla";

end
