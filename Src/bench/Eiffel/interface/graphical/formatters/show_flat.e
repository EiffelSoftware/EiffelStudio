
-- Command to display flat form of a class

class SHOW_FLAT 

inherit

	FORMATTER
		redefine
			dark_symbol
		end;
	SHARED_SERVER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
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

	command_name: STRING is do Result := l_Showflat end;

	title_part: STRING is do Result := l_Flat_form_of end;

	old_display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat form of `c'.
		local
			flat_class: FLAT_CLASS;
		do
			!!flat_class.make (c.class_c);
			flat_class.flat;
			text_window.put_string (flat_class.flat_text);
			-- text_window.share (flat_class.click_list);
		end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat form pf 'c'.
		local
			ctxt: FORMAT_CONTEXT;
		do
			!!ctxt.make (c.class_c);
			ctxt.set_in_bench_mode;
			ctxt.execute;
			text_window.process_text (ctxt.text);	
		end;
 
end
