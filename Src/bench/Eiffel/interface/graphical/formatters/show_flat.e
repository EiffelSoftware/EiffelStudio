
-- Command to display flat form of a class

class SHOW_FLAT 

inherit

	FILTERABLE
		rename
			filter_context as flat_context
		redefine
			dark_symbol
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

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat form of 'c'.
		do
			text_window.process_text (flat_context (c).text)
		end;

end
