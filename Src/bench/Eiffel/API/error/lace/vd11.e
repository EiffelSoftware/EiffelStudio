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

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("Class name: ");
			st.add_string (a_class.name);
			st.add_new_line;
			st.add_string ("First file: ");
			st.add_string (file_name);
			st.add_new_line;
			st.add_string ("Second file: ");
			st.add_string (a_class.file_name);
			st.add_new_line
		end;

feature {CLUSTER_I} -- Setting

	set_a_class (c: CLASS_I) is
			-- Assign `c' to `a_class'.
		do
			a_class := c;
		end;

end -- class VD11
