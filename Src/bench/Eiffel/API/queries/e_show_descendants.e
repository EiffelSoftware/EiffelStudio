indexing

	description: 
		"Command to display descendants of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_DESCENDANTS 

inherit

	E_CLASS_CMD

creation

	make, do_nothing

feature -- Output

	work is
			-- Execute Current command.	
		do
			!! displayed.make;
			current_class.append_signature (structured_text);
			structured_text.add_new_line;
			rec_display (1, current_class, structured_text);
			displayed := Void
		end;

feature {NONE} -- Implementation

	displayed: LINKED_LIST [E_CLASS];

	rec_display (i: INTEGER; c: E_CLASS; st: STRUCTURED_TEXT) is
			-- Display parents of `c' in tree form.
		local
			descendants: LINKED_LIST [E_CLASS]
			descendant_class: E_CLASS;
		do
			descendants := c.descendants;
			if not descendants.empty then
				from
					descendants.start
				until
					descendants.after
				loop
					descendant_class := descendants.item;
					add_tabs (st, i);
					descendant_class.append_signature (st);
					if displayed.has (descendant_class) then
						if not descendant_class.descendants.empty then
							st.add_string ("...")
						end;
						st.add_new_line;
					else	
						st.add_new_line;
						displayed.extend (descendant_class);
						displayed.forth
						rec_display (i+1, descendant_class, st);
					end;			
					descendants.forth
				end
			end
		end;

end -- class E_SHOW_DESCENDANTS
