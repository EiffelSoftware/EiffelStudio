-- Command to display the flat/short version of a class

class SHOW_FS 

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
			!!Result.make; 
			Result.read_from_file (bm_Showfs) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showfs end;

	title_part: STRING is do Result := l_Flatshort_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
--		local
--			flat_class: FLAT_CLASS;
		do
--			!!flat_class.make (c);
--			flat_class.flat;
--			text_window.put_string (flat_class.flat_text);
--		  text_window.share (flat_class.click_list)
		end

end
