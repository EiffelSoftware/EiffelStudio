
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


	displayed: LINKED_LIST [CL_TYPE_A];

	current_class: CLASS_C;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display parents of `c' in tree form.
		do
			!!displayed.make;
			current_class := c.class_c;
			rec_display (i, current_class);
			displayed := void;	
		end;

	rec_display (i: INTEGER; c: CLASS_C) is
			-- Display parents of `c' in tree form.
		local
			parents: FIXED_LIST [CL_TYPE_A];
			parent_class: CLASS_C;
		do
			if 
				(c.id /= System.any_id) or else
				(c = current_class)
			then
				parents := c.parents;
				if not parents.empty then
					from
						parents.start
					until
						parents.after
					loop
						parent_class := parents.item.associated_class;
						text_window.put_string (tabs (i));
						parent_class.append_clickable_signature (text_window);
						if displayed.has (parents.item) then
							text_window.put_string ("...%N")
						else	
							text_window.new_line;
							displayed.add (parents.item);
							rec_display (i+1, parent_class);
						end;			
						parents.forth
					end
				end
			end
		end;

end
