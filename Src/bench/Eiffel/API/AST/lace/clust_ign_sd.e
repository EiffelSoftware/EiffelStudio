indexing
	description: "Ignore cluster adapt.";
	date: "$Date$";
	revision: "$Revision$"

class CLUST_IGN_SD

inherit
	CLUST_ADAPT_SD
		redefine
			adapt
		end

feature {CLUST_ADAPT_SD, LACE_AST_FACTORY} -- Initialization

	initialize (cn: like cluster_name) is
			-- Create a new CLUST_IGN AST node.
		require
			cn_not_void: cn /= Void
		do
			cluster_name := cn
			cluster_name.to_lower
		ensure
			cluster_name_set: cluster_name = cn
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result
			Result.initialize (cluster_name.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then cluster_name.same_as (other.cluster_name)
		end

feature -- Save 

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			cluster_name.save (st)
			st.putstring (": ignore")
			st.new_line
		end

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
