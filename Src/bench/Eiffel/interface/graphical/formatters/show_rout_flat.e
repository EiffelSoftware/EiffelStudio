-- Command to flat of routine

class SHOW_ROUT_FLAT

inherit

	FORMATTER
		redefine
			format, dark_symbol
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
			Result := bm_Showflat
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_showflat
		end;

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text: STRING
			feature_stone: FEATURE_STONE
			feature_i: FEATURE_I
			class_c: CLASS_C
			ctxt: FORMAT_FEAT_CONTEXT
		do
			feature_stone ?= stone
			if feature_stone /= Void and then feature_stone.is_valid then
				text_window.clean
				display_header (stone)
				text_window.set_root_stone (stone)
				feature_i := feature_stone.feature_i
				class_c := feature_stone.class_c
				!! ctxt.make (class_c);
				ctxt.set_in_bench_mode;
				ctxt.execute (feature_i);
				text_window.process_text (ctxt.text)
				text_window.set_editable
				text_window.show_image
				text_window.set_read_only
				text_window.set_last_format (Current)
			end
		end

feature {NONE}

	title_part: STRING is do Result := l_Feature_flat_form_of end;

	command_name: STRING is do Result := l_Showflat end;
	display_info (i: INTEGER; d: STONE) is do end
			-- Useless here

end
