
-- Command to display class descendants.

class SHOW_DESCENDANTS 

inherit

	FORMATTER

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		ensure
			default_indent: indent = 4
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showdescendants 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showdescendants end;

	title_part: STRING is do Result := l_Descendants_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display descendants of `c' in tree form.
		local
			cmd: EWB_DESCENDANTS
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end;

end
