
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
