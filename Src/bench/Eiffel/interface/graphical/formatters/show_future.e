-- Command to display the history of a feature

class SHOW_FUTURE

inherit

	FORMATTER
		redefine
			dark_symbol
		end;
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
			Result := bm_Showdversions 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showdversions 
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
			ewb_future.set_output_window (text_window);
			ewb_future.display (f.feature_i, f.class_c);
		end;

end
