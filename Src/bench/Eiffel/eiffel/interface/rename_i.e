-- Cluster renamings

class RENAME_I 

create

	make

	
feature 

	cluster: CLUSTER_I;
			-- Cluster from which classes are renamed

	renamings: HASH_TABLE [STRING, STRING];
			-- Renamings: key is new name, entry is the old one

	make is
		do
			create renamings.make (1);
			renamings.compare_objects
		end;

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

end
