-- Cluster renamings

class RENAME_I 

creation

	make

	
feature 

	cluster: CLUSTER_I;
			-- Cluster from which classes are renamed

	renamings: EXTEND_TABLE [STRING, STRING];
			-- Renamings: key is new name, entry is the old one

	make is
		do
			!!renamings.make (1);
		end;

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end
