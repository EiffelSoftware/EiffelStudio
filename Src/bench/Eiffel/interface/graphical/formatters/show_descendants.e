
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
			indent := 5
		ensure
			default_indent: indent = 5
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showdescendants) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showdescendants end;

	title_part: STRING is do Result := l_Descendants_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display descendants of `c' in tree form.
--		local
--			descendants: LINKED_LIST [CLASSC_STONE];
--			d: CLASSC_STONE
		do
--			from
--				descendants := c.descendants;
--				descendants.start
--			until
--				descendants.offright
--			loop
--				d := descendants.item;
--				text_window.put_string (tabs(i));
--				text_window.put_clickable_string (d, d.signature);
--				text_window.put_string ("%N");
--				display_info (i+1, d);
--				descendants.forth
--			end
		end

end
