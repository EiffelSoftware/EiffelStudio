indexing

	description: 
		"Error for an invalid cluster name specified in%
		%the first part of cluster renaming clause.";
	date: "$Date$";
	revision: "$Revision $"

class VD48

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Property

	path: ID_SD;
			-- Path of precompiled library

	cluster_name: ID_SD;
			-- Cluster name not valid

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line;
			st.add_string ("Unknown cluster name: ");
			st.add_string (cluster_name);
			st.add_new_line
		end;

feature {D_PRECOMPILED_SD} -- Setting

	set_path (s: ID_SD) is
			-- Assign `s' to `path'.
		do
			path := s
		end

	set_cluster_name (s: ID_SD) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s;
		end;


end -- class VD48
