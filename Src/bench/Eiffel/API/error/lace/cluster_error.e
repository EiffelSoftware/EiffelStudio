indexing

	description: 
		"Error for cluster.";
	date: "$Date$";
	revision: "$Revision $"

deferred class CLUSTER_ERROR

inherit

	LACE_ERROR

feature -- Property

	cluster: CLUSTER_I;
			-- Cluster involved

feature -- Output

	put_cluster_name (ow: OUTPUT_WINDOW) is
			-- Display the cluster name
		do
			ow.put_string ("Cluster name: ");
			ow.put_string (cluster.cluster_name);
			ow.new_line;
		end;

	put_cluster_path (ow: OUTPUT_WINDOW) is
			-- Display the cluster path
		do
			ow.put_string ("Path name: ");
			ow.put_string (cluster.path);
			ow.new_line;
		end;

feature {AST_LACE, COMPILER_EXPORTER}

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end -- class CLUSTER_ERROR
