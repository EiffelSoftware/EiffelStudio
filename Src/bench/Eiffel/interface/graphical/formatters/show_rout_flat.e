-- Command to flat of routine

class SHOW_ROUT_FLAT

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER;
	SHARED_FORMAT_TABLES

creation

	make

feature

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is
		once
			Result := bm_Showflat
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_showflat
		end;

feature {NONE}

	title_part: STRING is do Result := l_Feature_flat_form_of end;

	command_name: STRING is do Result := l_Showflat end;

	display_info (stone: FEATURE_STONE) is 
			-- Display flat form of `stone'.
		do 
			text_window.process_text (rout_flat_context_text (stone))
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring ancestors to produce flat form...")
		end;

end
