-- Command to display the homonyms of the routine.

class SHOW_HOMONYMS

inherit

	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header
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

	display_info (f: FEATURE_STONE)  is
			-- Display homonyms of the routine.
		local
			cmd: E_SHOW_ROUTINE_HOMONYMNS;
		do
			!! cmd.make (f.feature_i, f.class_c, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for homonyms...")
		end;

end -- class SHOW_HOMONYMS
