indexing

	description: 
		"Error when cluster name listed twice in the first part %
		%of a cluster renaming clause.";
	date: "$Date$";
	revision: "$Revision $"

class VD50

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	old_name: ID_SD;
			-- Cluster name involved

	path: ID_SD;
			-- Path of precompiled library

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line;
			st.add_string ("Cluster name: ");
			st.add_string (old_name);
			st.add_new_line
		end;

feature {D_PRECOMPILED_SD} -- Setting

	set_old_name (s: ID_SD) is
			-- Assign `s' to `old_name'.
		do
			old_name := s;
		end;

	set_path (s: ID_SD) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

end -- class VD50
