
-- Command to change font in a text window

class SEARCH_STRING 

inherit

	ICONED_COMMAND


creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
		end;
	
feature {NONE}

	work (a_text_window: TEXT_WINDOW) is
			-- Change font in `a_text_window'.
		do
			search_window.call (a_text_window)
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Search) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Search end

end
