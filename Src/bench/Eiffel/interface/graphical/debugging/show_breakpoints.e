class SHOW_BREAKPOINTS

inherit

	FORMATTER;
	SHARED_DEBUG;

creation
	make


feature

	make (c: COMPOSITE; a_text_window: ROUTINE_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		end;

	symbol: PIXMAP is
		once
			!!Result.make;
			Result.read_from_file (bm_Breakpoint)
		end;

feature {NONE}

	display_info (i: INTEGER; f: FEATURE_STONE) is
		local
			ctxt: ROUTINE_CONTEXT;
		do
			debug_info.add_feature (f.feature_i);
			!!ctxt.make (f.feature_i);
			text_window.process_text (ctxt.text)
		end;	


	command_name: STRING is
		do
			Result := "Show breakpoints";
		end;

	title_part: STRING is
		do
			Result := "Breakpoints of ";
		end
	


end
