
-- Command to display class ancestors.

class SHOW_ANCESTORS 

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
			Result.read_from_file (bm_Showancestors) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showancestors end;

	title_part: STRING is do Result := l_Ancestors_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display parents of `c' in tree form.
		local
--			parents: FIXED_LIST [CL_TYPE_A];
--			d: CLASSC_STONE
		do
--			if c.id /= System.any_id then
--				from
--					parents := c.parents;
--					parents.start
--				until
--					parents.offright
--				loop
--					d := parents.item.associated_class;
--					text_window.put_string (tabs (i));
--					text_window.put_clickable_string (d, d.signature);
--					text_window.put_string ("%N");
--					display_info (i+1, d);
--					parents.forth
--				end
--			end
		end

end
