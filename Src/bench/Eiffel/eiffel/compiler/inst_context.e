-- Context for instantiation

class INST_CONTEXT 
	
feature 

	cluster: CLUSTER_I;
			-- Cluster where to find a class by its name

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end
