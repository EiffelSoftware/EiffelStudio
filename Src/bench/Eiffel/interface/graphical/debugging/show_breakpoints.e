-- Command to set break points

class SHOW_BREAKPOINTS

inherit

	FORMATTER
		redefine
			format, dark_symbol
		end;
	SHARED_DEBUG;

creation

	make


feature

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
		end; -- make

	symbol: PIXMAP is
		once
			Result := bm_Breakpoint
		end; -- symbol

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_breakpoint
		end;

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'.
		local
			ctxt: DEBUG_CONTEXT;
			feature_stone: FEATURE_STONE;
			feature_i: FEATURE_I;
			class_c: CLASS_C
		do
			if
				do_format or else
				(text_window.last_format /= Current or
				not equal (stone, text_window.root_stone))
			then
				feature_stone ?= stone;
				if feature_stone /= Void and feature_stone.is_valid then
					text_window.clean;
					display_header (stone);
					text_window.set_root_stone (stone);
					feature_i := feature_stone.feature_i;
					class_c := feature_stone.class_c;
					!! ctxt.make (class_c);
					ctxt.set_in_bench_mode;
					ctxt.execute (feature_i);
					text_window.process_text (ctxt.text);
					text_window.set_editable;
					text_window.show_image;
					text_window.set_read_only;
					text_window.set_last_format (Current)
				end
			end
		end;

feature {NONE}

	display_info (i: INTEGER; s: STONE) is do end;
			-- Useless here.

	command_name: STRING is
		do
			Result := l_Showstops
		end; -- command_name

	title_part: STRING is
		do
			Result := l_Stoppoints_of
		end; -- title_part
	
end -- class SHOW_BREAKPOINTS
