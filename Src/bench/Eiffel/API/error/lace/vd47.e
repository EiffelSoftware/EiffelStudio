indexing

	description: 
		"Error when class name listed twice in the first part %
		%of a renaming clause of a cluster adaptation.";
	date: "$Date$";
	revision: "$Revision $"

class VD47

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	old_name: ID_SD;
			-- Class name involved

	cluster: CLUSTER_I;
			-- Cluster containing classes renamed

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			st.add_string ("Cluster path: ");
			st.add_string (cluster.path);
			st.add_new_line;
			st.add_string ("Class name: ");
			st.add_string (old_name.as_upper);
			st.add_new_line
		end;

feature {CLUST_PROP_SD, CLUST_ADAPT_SD} -- Setting

	set_old_name (s: ID_SD) is
			-- Assign `s' to `old_name'.
		do
			old_name := s;
		end;

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end -- class VD47
