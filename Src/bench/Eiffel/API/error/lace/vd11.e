-- Error when two files *.e with same class in the same cluster

class VD11 obsolete "Use VSCN"

inherit

    FILE_ERROR
        redefine
            build_explain, code
        end

feature

	a_class: CLASS_I;
			-- Class involved

	set_a_class (c: CLASS_I) is
			-- Assign `c' to `a_class'.
		do
			a_class := c;
		end;

	code: STRING is "VSCN";
			-- Error code

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

end
