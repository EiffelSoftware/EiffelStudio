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

	execute is
			-- Execute Current command.	
		do
			!! displayed.make;
			current_class.append_signature (output_window);
			output_window.new_line;
			rec_display (1, current_class);
			displayed := Void;	
		end;

feature {NONE} -- Implementation

	displayed: LINKED_LIST [E_CLASS];

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

	rec_display (i: INTEGER; c: E_CLASS) is
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
					output_window.put_string (tabs (i));
					descendant_class.append_signature (output_window);
					if displayed.has (descendant_class) then
						if not descendant_class.descendants.empty then
							output_window.put_string ("...")
						end;
						output_window.new_line;
					else	
						output_window.new_line;
						displayed.extend (descendant_class);
						rec_display (i+1, descendant_class);
					end;			
					descendants.forth
				end
			end
		end;

end -- class E_SHOW_DESCENDANTS
