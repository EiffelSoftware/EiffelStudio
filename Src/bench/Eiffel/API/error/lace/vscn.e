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

	build_explain is
		do
			put_cluster_name;
			put_string ("Class name: `");
			put_string (first.class_name);
			put_char ('%'');
			new_line;
			put_string ("First file `");
			put_string (first.file_name);
			put_char ('%'');
			new_line;
			put_string ("Second file `");
			put_string (second.class_name);
			put_char ('%'');
			new_line;
		end;

end
