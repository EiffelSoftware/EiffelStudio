-- Error when the topological sort on classes finds a cycle

class VHPR1 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature 

	involved_classes: LINKED_LIST [INTEGER];
			-- Id's of classes invloved in the inheritance graph

	set_involved_classes (l: LINKED_LIST [INTEGER]) is
			-- Assign `l' to `involved_classes'.
		do
			involved_classes := l;
		end;

	code: STRING is "VHPR";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
			a_clickable.put_string ("VHPR: point 1%N%T");
			from
				involved_classes.start
			until
				involved_classes.offright
			loop
				System.class_of_id (involved_classes.item).append_clickable_signature
																(a_clickable);
				a_clickable.put_string ("  ");
				involved_classes.forth;
			end;
			a_clickable.new_line;
		end;

end
