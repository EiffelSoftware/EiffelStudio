
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
		do
			recursive_display (i, c.class_c);
		end;

	recursive_display (i: INTEGER; c: CLASS_C) is
		local
			descendants: LINKED_LIST [CLASS_C];
			descendant: CLASS_C;
		do
			from
				descendants := c.descendants;
				descendants.start
			until
				descendants.after
			loop
				descendant := descendants.item;
				text_window.put_string (tabs(i));
				descendant.append_clickable_signature (text_window);
				text_window.new_line;
				recursive_display (i+1, descendant);
				descendants.forth
			end
		end

end
