indexing

	description: 
		"Error when parent name of cluster does not exist in the Ace file.";
	date: "$Date$";
	revision: "$Revision $"

class VD51

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	parent_name: ID_SD;
			-- Cluster name involved

	cluster_name: ID_SD;
			-- Cluster with the invalid parent name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			st.add_string ("Invalid parent cluster name: ");
			st.add_string (parent_name);
			st.add_new_line;
			st.add_string ("Cluster name: ");
			st.add_string (cluster_name);
			st.add_new_line
		end;

feature {CLUSTER_SD} -- Setting

	set_parent_name (s: ID_SD) is
			-- Assign `parent_name' to `s'.
		do
			parent_name := s;
		end;

	set_cluster_name (s: ID_SD) is
			-- Assign `cluster_name' to `s'.
		do
			cluster_name := s;
		end;

end -- class VD51
