
-- Command to change font in a text window

class SEARCH_STRING 

inherit

	ICONED_COMMAND


creation

	make
	
feature 

	search_window: SEARCH_W;

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			!!search_window.make (c, a_text_window);
			init (c, a_text_window);
		end;
	
feature {NONE}

	work (arg: ANY) is
			-- Change font in `a_text_window'.
		do
			search_window.call 
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Search) ;
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Search end

end
