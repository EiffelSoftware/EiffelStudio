-- Command to flat of routine

class SHOW_ROUT_FLAT

inherit

	FORMATTER
		redefine
			dark_symbol
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

	display_info (i: INTEGER; stone: FEATURE_STONE) is 
			-- Display flat form of `stone'.
		do 
			text_window.process_text (rout_flat_context (stone).text)
		end

end
