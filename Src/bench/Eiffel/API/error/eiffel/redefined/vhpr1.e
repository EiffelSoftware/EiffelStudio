-- Error when the topological sort on classes finds a cycle

class VHPR1 

inherit

	SHARED_WORKBENCH;
	ERROR
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

	code: STRING is "VHPR1";
			-- Error code

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
			put_char ('%T');
			from
				involved_classes.start
			until
				involved_classes.after
			loop
				System.class_of_id (involved_classes.item).append_clickable_signature
																(error_window);
				put_string ("  ");
				involved_classes.forth;
			end;
			new_line;
		end;

end
