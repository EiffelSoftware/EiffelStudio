indexing

	description: 
		"Error when root class name is invalid.";
	date: "$Date$";
	revision: "$Revision $"

class VD30

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	root_class_name: STRING;
			-- Invalid root class name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Invalid class name: ");
			st.add_string (root_class_name);
			st.add_new_line
		end;

feature {ROOT_SD} -- Setting

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

end -- class VD30
