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

	put_cluster_name is
			-- Display the cluster name
		do
			put_string ("Cluster name: `");
			put_string (cluster.cluster_name);
			put_string ("%'%N");
		end;

	put_cluster_path is
			-- Display the cluster path
		do
			put_string ("Cluster path: `");
			put_string (cluster.path);
			put_string ("%'%N");
		end;

end
