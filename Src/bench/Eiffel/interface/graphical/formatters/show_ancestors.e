
-- Command to display class ancestors.

class SHOW_ANCESTORS 

inherit

	FORMATTER
		redefine
			dark_symbol
		end

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
			Result := bm_Showancestors 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showancestors
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showancestors end;

	title_part: STRING is do Result := l_Ancestors_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display parents of `c' in tree form.
		local
			cmd: EWB_ANCESTORS
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end;


end
