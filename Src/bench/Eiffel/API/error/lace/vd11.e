indexing

	description: 
		"Error when two files *.e with same class in the same cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VD11 obsolete "Use VSCN"

inherit

    FILE_ERROR
        redefine
            build_explain, code
        end

feature -- Properties

	a_class: CLASS_I;
			-- Class involved

	code: STRING is "VSCN";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			ow.put_string ("Class name: ");
			ow.put_string (a_class.class_name);
			ow.put_string ("%NFirst file: ");
			ow.put_string (file_name);
			ow.put_string ("%NSecond file: ");
			ow.put_string (a_class.file_name);
			ow.new_line
		end;

feature {CLUSTER_I} -- Setting

	set_a_class (c: CLASS_I) is
			-- Assign `c' to `a_class'.
		do
			a_class := c;
		end;

end -- class VD11
