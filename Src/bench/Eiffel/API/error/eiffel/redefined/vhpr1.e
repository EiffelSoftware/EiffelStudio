indexing

	description: 
		"Error when the topological sort on classes finds a cycle.";
	date: "$Date$";
	revision: "$Revision $"

class VHPR1 

inherit

	SHARED_EIFFEL_PROJECT;
	ERROR
		redefine
			build_explain, subcode
		end
	
feature -- Properties

	involved_classes: LINKED_LIST [INTEGER];
			-- Id's of classes invloved in the inheritance graph

	code: STRING is "VHPR";
			-- Error code

	subcode: INTEGER is 1;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Names of classes involved in cycle:%N");
			from
				involved_classes.start
			until
				involved_classes.after
			loop
				if involved_classes.item /= involved_classes.first then
					ow.put_string (", ");
				end;
				Eiffel_system.class_of_id (involved_classes.item)
						.append_name (ow);
				involved_classes.forth;
			end;
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_involved_classes (l: LINKED_LIST [INTEGER]) is
			-- Assign `l' to `involved_classes'.
		do
			involved_classes := l;
		end;

end -- class VHPR1
