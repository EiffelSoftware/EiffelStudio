-- Error when name clash in a cluster

class VSCN


inherit

	CLUSTER_ERROR
		redefine
			code
		end

feature

	first: CLASS_I;
			-- First class in conflict

	second: CLASS_I;
			-- Second class in conflict with first

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

	code: STRING is "VSCN";
			-- Error code

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

end
