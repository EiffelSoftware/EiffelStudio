-- Command to display the routines clients

class SHOW_ROUTCLIENTS

inherit

	FORMATTER;
	SHARED_SERVER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showfs) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsenders end;

	title_part: STRING is do Result := l_Senders end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display Senders of `c'.
		do
			io.error.putstring ("Not implemented Yet%N");
		end;

end
