-- Command to display the homonyms of the routine.

class SHOW_HOMONYMS

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
			Result := bm_Showhomonyms 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showhomonyms 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showhomonyms end;

	title_part: STRING is do Result := l_Homonyms_of end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display homonyms of the routine.
		local
			cmd: EWB_HOMONYMS;
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (f.feature_i, f.class_c);
		end;

end -- class SHOW_HOMONYMS
