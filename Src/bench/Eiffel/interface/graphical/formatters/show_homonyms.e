-- Command to display the synonyms of the routine.

class SHOW_SYNONYMS

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
			Result := bm_Showsynonyms 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showsynonyms 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsynonyms end;

	title_part: STRING is do Result := l_Synonyms_of end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display Senders of `c'.
		local
			cmd: EWB_SYNONYMS;
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (f.feature_i, f.class_c);
		end;

end -- class SHOW_SYNONYMS
