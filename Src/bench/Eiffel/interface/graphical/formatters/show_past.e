-- Command to display the history of a feature

class SHOW_PAST

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
			Result := bm_Showaversions 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showaversions 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showpast end;

	title_part: STRING is do Result := l_Past end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display history of `f;
		local
			ewb_past: EWB_PAST;
		do
			!! ewb_past.null;
			ewb_past.set_output_window (text_window);
			ewb_past.display (f.feature_i, f.class_c);
		end;

end
