-- Error for cluster

deferred class CLUSTER_ERROR

inherit

	ERROR

feature

	cluster: CLUSTER_I;
			-- Cluster involved

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end
