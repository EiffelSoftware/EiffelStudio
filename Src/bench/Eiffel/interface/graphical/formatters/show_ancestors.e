
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
			indent := 4
		ensure
			default_indent: indent = 4
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
			parents: FIXED_LIST [CL_TYPE_A];
			p: CLASSC_STONE;
			class_c: CLASS_C
		do
			class_c := c.class_c;
			if 
				(class_c.id /= System.any_id) or else
				(c = formatted)
			then
				parents := class_c.parents;
				if not parents.empty then
					from
						parents.start
					until
						parents.after
					loop
						!!p.make (parents.item.associated_class);
						text_window.put_string (tabs (i));
						text_window.put_clickable_string (p, p.signature);
						text_window.put_string ("%N");
						display_info (i+1, p);
						parents.forth
					end
				end
			end
		end

end
