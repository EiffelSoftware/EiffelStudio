-- Command to display the short version of a class

class SHOW_SHORT

inherit

	FORMATTER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showfs 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showfs end;

	title_part: STRING is do Result := l_Flatshort_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		local
			ctxt: FORMAT_CONTEXT;
		do
			!!ctxt.make (c.class_c);
			ctxt.set_in_bench_mode;
			ctxt.set_is_short;
			ctxt.set_current_class_only;
			ctxt.execute;
			text_window.process_text (ctxt.text);	
		end

end
