-- Cluster_ignore          : Name LEX_COLUMN LEX_IGNORE
--                         ;

class CLUST_IGN_SD

inherit

	CLUST_ADAPT_SD
		redefine
			adapt
		end

feature

	set is
		do
			cluster_name ?= yacc_arg (0)
		end;
		
	adapt is
			-- Cluster adaptation
		local
			cluster: CLUSTER_I;
			ok: BOOLEAN;
		do
--| Note: this should really be done in the
--| `set' routine but that would cause a 
--| refreezing. Do it later
cluster_name.to_lower;
				-- First check cluster existence
			ok := good_cluster;
			if ok then
				cluster := Universe.cluster_of_name (cluster_name);
				context.current_cluster.insert_cluster_to_ignore (cluster);
			end;
		end;
	
end
