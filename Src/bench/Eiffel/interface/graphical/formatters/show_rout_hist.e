-- Command to display the the class history of a feature

class SHOW_ROUT_HIST

inherit

	FORMATTER
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
			Result := bm_Showhistory
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showhistory
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showhistory end;

	title_part: STRING is do Result := l_History end;

	display_info (f: FEATURE_STONE)  is
			-- Display history of `f;
		local
			cmd: E_SHOW_ROUTINE_IMPLEMENTERS;
		do
			!! cmd.make (f.e_feature, f.e_class, text_window);
			if cmd.has_valid_feature then
				cmd.execute
			end
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for implementers...")
		end;

end
