indexing

	description: 
		"Command to display descendants of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_DESCENDANTS 

inherit

	E_CLASS_CMD

create

	make, do_nothing

feature -- Output

	work is
			-- Execute Current command.	
		do
			create displayed.make;
			current_class.append_signature (structured_text, True);
			structured_text.add_new_line;
			rec_display (1, current_class, structured_text);
			displayed := Void
		end;

feature {NONE} -- Implementation

	displayed: LINKED_LIST [CLASS_C];

	rec_display (i: INTEGER; c: CLASS_C; st: STRUCTURED_TEXT) is
			-- Display parents of `c' in tree form.
		local
			descendants: ARRAYED_LIST [CLASS_C]
			descendant_class: CLASS_C;
		do
			descendants := c.descendants;
			if not descendants.is_empty then
				from
					descendants.start
				until
					descendants.after
				loop
					descendant_class := descendants.item;
					add_tabs (st, i);
					descendant_class.append_signature (st, True);
					if displayed.has (descendant_class) then
						if not descendant_class.descendants.is_empty then
							st.add_string ("...")
						end;
						st.add_new_line;
					else	
						st.add_new_line;
						displayed.extend (descendant_class);
						displayed.finish
						rec_display (i+1, descendant_class, st);
					end;			
					descendants.forth
				end
			end
		end;

end -- class E_SHOW_DESCENDANTS
