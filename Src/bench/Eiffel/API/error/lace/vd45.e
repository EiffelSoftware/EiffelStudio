indexing

	description: 
		"Error for precompiled systems that are not compatible.";
	date: "$Date$";
	revision: "$Revision $"

class VD45

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	path: STRING;
			-- Path of precompiled project

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line
		end;

feature {PRECOMP_R} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

end -- class VD45
