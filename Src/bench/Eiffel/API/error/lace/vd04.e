indexing

	description: 
		"Error when invalid class name in renaming clause%
		%of a cluster adaptation. NOT USED CURRENTLY";
	date: "$Date$";
	revision: "$Revision $"

class VD04

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	old_name: ID_SD;
			-- Class name involved

	cluster: CLUSTER_I;
			-- Cluster which doesn't know a class named `old_name'

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Debug purpose
		do
			ow.put_string ("Cluster path: ");
			ow.put_string (cluster.path);
			ow.put_string ("%NClass name: ");
			ow.put_string (old_name);
			ow.new_line
		end;

feature {CLUST_PROP_SD} -- Setting

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

end -- class VD04
