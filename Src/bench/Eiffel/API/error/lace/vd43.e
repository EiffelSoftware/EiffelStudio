indexing

	description: 
		"Warning for incompletely C compiled precompiled system.";
	date: "$Date$";
	revision: "$Revision $"

class VD43

inherit
	LACE_WARNING
		redefine
			build_explain
		end;

feature -- Properties

	path: STRING;
			-- path name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("File: ");
			st.add_string (path);
			st.add_new_line;
		end;

feature {REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'
		do
			path := s
		end;

end -- class VD43
