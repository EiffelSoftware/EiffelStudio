

class EWB_ANCESTORS 

inherit

	EWB_CLASS
		rename
			name as ancestors_cmd_name,
			help_message as ancestors_help,
			abbreviation as ancestors_abb
		end

creation

	make, null

feature

	display (a_class: CLASS_C) is
		do
			!!displayed.make;
			current_class := a_class;
			a_class.append_clickable_signature (output_window);
			output_window.new_line;
			rec_display (1, a_class);
			displayed := void;	
		end;

	displayed: LINKED_LIST [CL_TYPE_A];

	tabs (i: INTEGER): STRING is
		local
			j: INTEGER
		do
			from
				j := 1;
				!!Result.make (i)
			until
				j > i
			loop
				Result.append_character ('%T');
				j := j + 1
			end;
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
						output_window.put_string (tabs (i));
						parent_class.append_clickable_signature (output_window);
						if displayed.has (parents.item) then
							output_window.put_string ("...%N")
						else	
							output_window.new_line;
							displayed.add (parents.item);
							rec_display (i+1, parent_class);
						end;			
						parents.forth
					end
				end
			end
		end;

end
