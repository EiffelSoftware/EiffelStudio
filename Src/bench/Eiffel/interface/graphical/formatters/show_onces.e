-- Command to display class onces.

class SHOW_ONCES 

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
			Result := bm_Showonces 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showonces end;

	title_part: STRING is do Result := l_Onces_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
		local
			cmd: EWB_ONCE
		do
			!!cmd.null;
			cmd.set_output_window (text_window);
			cmd.display (c.class_c);
		end

end
