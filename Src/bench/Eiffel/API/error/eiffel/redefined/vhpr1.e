-- Error when the topological sort on classes finds a cycle

class VHPR1 

inherit

	SHARED_WORKBENCH;
	ERROR
		redefine
			build_explain, subcode
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

	subcode: INTEGER is 1;

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
			put_string ("Names of classes involved in cycle:%N");
			from
				involved_classes.start
			until
				involved_classes.after
			loop
				if involved_classes.item = involved_classes.first then
					put_string (", ");
				end;
				System.class_of_id (involved_classes.item)
							.append_clickable_name (error_window);
				involved_classes.forth;
			end;
			new_line;
		end;

end
