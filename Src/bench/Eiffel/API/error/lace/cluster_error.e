-- Error for cluster

deferred class CLUSTER_ERROR

inherit

	LACE_ERROR

feature

	cluster: CLUSTER_I;
			-- Cluster involved

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

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

end
