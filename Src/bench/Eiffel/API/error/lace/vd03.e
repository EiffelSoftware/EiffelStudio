indexing

	description: 
		"Error for an invalid cluster name specified in%
		%an adaptation clause.";
	date: "$Date$";
	revision: "$Revision $"

class VD03

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Property

	cluster_name: ID_SD;
			-- Cluster name not valid

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Unknown cluster name: ");
			st.add_string (cluster_name);
			st.add_new_line
		end;

feature {CLUST_ADAPT_SD} -- Setting

	set_cluster_name (s: ID_SD) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s;
		end;


end -- class VD03
