indexing

	description: 
		"Command to display ancestores of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ANCESTORS 

inherit

	E_CLASS_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	execute is
		do
			!! displayed.make;
			current_class.append_clickable_signature (output_window);
			output_window.new_line;
			rec_display (1, current_class);
			displayed := Void;
		end;

feature {NONE} -- Implementation

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

	already_processed (t: CL_TYPE_A): BOOLEAN is
		do
			from
				displayed.start
			until
				Result or else displayed.after
			loop
				if displayed.item.same_as (t) then
					Result := True
				else
					displayed.forth
				end
			end
		end;

	rec_display (i: INTEGER; c: E_CLASS) is
			-- Display parents of `c' in tree form.
		local
			parents: FIXED_LIST [CL_TYPE_A];
			parent_class: E_CLASS;
		do
			if 
				(c.id /= Eiffel_system.any_id) or else
				(c = current_class)
			then
				parents := c.parents;
				if not parents.empty then
					from
						parents.start
					until
						parents.after
					loop
						parent_class := parents.item.associated_eclass;
						output_window.put_string (tabs (i));
						parent_class.append_clickable_signature (output_window);
						if already_processed (parents.item) then
							output_window.put_string ("...%N")
						else	
							output_window.new_line;
							displayed.extend (parents.item);
							rec_display (i+1, parent_class);
						end;			
						parents.forth
					end
				end
			end
		end;

end -- class E_SHOW_ANCESTORS
