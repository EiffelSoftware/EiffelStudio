indexing

	description: 
		"Command to display ancestores of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ANCESTORS 

inherit

	E_CLASS_CMD;
	SHARED_EIFFEL_PROJECT

create

	make, do_nothing

feature -- Execution

	work is
		do
			create displayed.make;
			current_class.append_signature (structured_text, True);
			structured_text.add_new_line;
			rec_display (1, current_class, structured_text);
			displayed := Void;
		end;

feature {NONE} -- Implementation

	displayed: LINKED_LIST [CL_TYPE_A];

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

	rec_display (i: INTEGER; c: CLASS_C; st: STRUCTURED_TEXT) is
			-- Display parents of `c' in tree form.
		local
			parents: FIXED_LIST [CL_TYPE_A];
			parent_class: CLASS_C;
			any_id: INTEGER
		do
			any_id := Eiffel_system.system.any_id
			if (c.class_id /= any_id) or else (c = current_class) then
				parents := c.parents;
				if not parents.is_empty then
					from
						parents.start
					until
						parents.after
					loop
						parent_class := parents.item.associated_class;
						add_tabs (st, i);
						parent_class.append_signature (st, True);
						if
							already_processed (parents.item) and then
							parent_class.class_id /= any_id
						then
							st.add_string ("...");
							st.add_new_line;
						else	
							st.add_new_line;
							displayed.extend (parents.item);
							displayed.finish
							rec_display (i+1, parent_class, st);
						end;			
						parents.forth
					end
				end
			end
		end;

end -- class E_SHOW_ANCESTORS
