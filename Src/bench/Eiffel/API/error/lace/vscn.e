indexing

	description: 
		"Error when name clash in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VSCN

inherit

	CLUSTER_ERROR

feature -- Properties

	first: CLASS_I;
			-- First class in conflict

	second: CLASS_I;
			-- Second class in conflict with first

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("Class name: ");
			ow.put_string (first.class_name);
			ow.new_line;
			ow.put_string ("First file: ");
			ow.put_string (first.file_name);
			ow.new_line;
			ow.put_string ("Second file: ");
			ow.put_string (second.file_name);
			ow.new_line;
		end;

feature {UNIVERSE_I, CLUSTER_I} -- Setting

	set_first (c: CLASS_I) is
			-- Assign `c' to `first'.
		do
			first := c;
		end;

	set_second (c: CLASS_I) is
			-- Assing `c' to `second'.
		do
			second := c;
		end;

end -- class VSCN
