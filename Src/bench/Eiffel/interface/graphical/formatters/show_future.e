-- Command to display the history of a feature

class SHOW_FUTURE

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
			Result.read_from_file (bm_Showdversions) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showfuture end;

	title_part: STRING is do Result := l_Future end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display history of `f;
		local
			ewb_future: EWB_FUTURE;
		do
			!! ewb_future.null;
			ewb_future.display_hist (text_window, f.feature_i, f.class_c);
		end;

end
