indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class CLUST_IGN_SD

inherit

	CLUST_ADAPT_SD
		redefine
			adapt
		end

feature {NONE} -- Initialization 

	set is
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower
		end;
		
feature {COMPILER_EXPORTER}

	adapt is
			-- Cluster adaptation
		local
			cluster: CLUSTER_I;
			ok: BOOLEAN;
		do
				-- First check cluster existence
			ok := good_cluster;
			if ok then
				cluster := Universe.cluster_of_name (cluster_name);
				context.current_cluster.insert_cluster_to_ignore (cluster);
			end;
		end;
	
end -- class CLUST_IGN_SD
