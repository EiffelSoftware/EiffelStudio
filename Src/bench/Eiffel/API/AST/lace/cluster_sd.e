-- Cluster_clause          : /* empty */
--                         | Cluster_tag Name Cluster_properties
--                         ;
-- 
-- Cluster_tag             : Name LEX_COLUMN
--                         ;

class CLUSTER_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_ENV;

feature -- Attributes

	cluster_name: ID_SD;
			-- Cluster name

	directory_name: ID_SD;
			-- Path to the cluster

	cluster_properties: CLUST_PROP_SD;
			-- Cluster properties

feature -- Initialization

	set is
			-- Yacc initialization
		do
			cluster_name ?= yacc_arg (0);
			cluster_name.to_lower;
			directory_name ?= yacc_arg (1);
			cluster_properties ?= yacc_arg (2)
		ensure then
			directory_name_exists: directory_name /= Void;
			cluster_name_exists: cluster_name /= Void;
		end;

feature -- Lace recompilation

	build is
			-- Build the cluster
		local
			cluster, old_cluster: CLUSTER_I;
			cluster_of_name, cluster_of_path: CLUSTER_I;
			clusters: LINKED_LIST [CLUSTER_I];
			vd28: VD28;
			vdcn: VDCN;
			path: STRING;
		do
			path := Environ.interpret (directory_name);
			cluster_of_name := Universe.cluster_of_name (cluster_name);
			cluster_of_path := Universe.cluster_of_path (path);
			old_cluster := Lace.old_universe.cluster_of_path (path);
			if cluster_of_name /= Void then
				if cluster_of_name.is_precompiled then
						-- Precompiled clusters may be moved without
						-- forcing a precompilation,
					if 
						(cluster_of_path /= Void) and then
						cluster_of_path /= cluster_of_name
					then
						!!vd28;
						vd28.set_cluster (cluster_of_name);
						vd28.set_second_cluster_name (cluster_of_path.cluster_name);
						Error_handler.insert_error (vd28);
						Error_handler.raise_error;
					else
						cluster_of_name.set_dollar_path (directory_name);
						cluster := cluster_of_name;
					end;
				else
					!!vdcn;
					vdcn.set_cluster (cluster_of_name);
					Error_handler.insert_error (vdcn);
					Error_handler.raise_error;
				end;
			elseif cluster_of_path /= Void then
				!!vd28;
				vd28.set_cluster (cluster_of_path);
				vd28.set_second_cluster_name (cluster_name);
				Error_handler.insert_error (vd28);
				Error_handler.raise_error;
			elseif old_cluster = Void then
					-- New cluster
				!!cluster.make (directory_name);
				cluster.set_cluster_name (cluster_name);
				Universe.insert_cluster (cluster);
				cluster.fill;
			else
				cluster := old_cluster.new_cluster (cluster_name);
			end;
		end;

	adapt_use is
			-- Check Use file for current cluster
		require
			Universe.has_cluster_of_path (Environ.interpret (directory_name));
		local
			cluster: CLUSTER_I;
		do
			if cluster_properties /= Void then 
				cluster := Universe.cluster_of_path
										(Environ.interpret (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.adapt_use;
			end;
		end;

	adapt is
			-- Adapt cluster with the cluster properties
		require else
			Universe.has_cluster_of_path (Environ.interpret (directory_name));
		local
			cluster: CLUSTER_I;
		do
			if cluster_properties /= Void then
				cluster := Universe.cluster_of_path
										(Environ.interpret (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.adapt;
			end;
		end;

	process_options is
			-- Process use options declated in a use file of the current
			-- cluster description
		require
			Universe.has_cluster_of_path (Environ.interpret (directory_name));
		local
			cluster: CLUSTER_I;
		do
			if cluster_properties /= Void then
				cluster := Universe.cluster_of_path
										(Environ.interpret (directory_name));
				context.set_current_cluster (cluster);
				cluster_properties.process_options;
			end;
		end;

end
