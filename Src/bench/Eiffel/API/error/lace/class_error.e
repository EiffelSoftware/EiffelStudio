indexing

	description: 
		"Error for a class in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_ERROR

inherit

	CLUSTER_ERROR

feature -- Properties

	class_name: STRING;
			-- Class nam involved

feature -- Output

	put_class_name (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class name: ");
			st.add_string (class_name);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			put_class_name (st);
		end;

feature {AST_LACE, COMPILER_EXPORTER} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

end -- class CLASS_ERROR
