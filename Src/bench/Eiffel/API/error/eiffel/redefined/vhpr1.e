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
			io.error.putstring ("VHPR: point 1%N");
			io.error.putstring ("%T");
			from
				involved_classes.start
			until
				involved_classes.offright
			loop
				io.error.putstring
					(System.class_of_id (involved_classes.item).class_name);
				io.error.putstring ("  ");
				involved_classes.forth;
			end;
			io.error.new_line;
		end;

end
