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
			directory_name ?= yacc_arg (1);
			cluster_properties ?= yacc_arg (2)
		ensure then
			directory_name_exists: directory_name /= Void;
		end;

feature -- Lace recompilation

	build is
			-- Build the cluster
		local
			cluster, old_cluster: CLUSTER_I;
			clusters: LINKED_LIST [CLUSTER_I];
			cluster_file: DIRECTORY;
			vd01: VD01;
			path: STRING;
			fill_cluster: BOOLEAN;
		do
			path := Environ.interpret (directory_name);
			cluster := Universe.cluster_of_path (path);
			if cluster = Void then
					-- New cluster
				!!cluster.make (path);
				Universe.insert_cluster (cluster);
				fill_cluster := True;
			elseif cluster.changed then
				old_cluster := cluster;
				!!cluster.make (path);
				clusters := Universe.clusters;
				clusters.start;
				clusters.search_same (old_cluster);
				check
					not_after: not clusters.after
				end;
				clusters.replace (cluster);
				fill_cluster := True;
			end;
			cluster.set_cluster_name (cluster_name);

				-- Apply the pass zero on cluster `cluster' if new or
				-- changed.
			if fill_cluster then
					-- Check if the path is valid
				!!cluster_file.make (path);
				if not cluster_file.exists then
					!!vd01;
					vd01.set_path (path);
					Error_handler.insert_error (vd01);
					Error_handler.raise_error;
				end;
					-- Verbose
				io.error.putstring ("Pass 0 on cluster ");
				if cluster_name = Void then
					io.error.putstring (path);
				else
					io.error.putstring (cluster_name);
				end;
				io.error.new_line;
	
					-- Fill the class name table of the cluster
				cluster.fill (cluster_file, old_cluster);
			end
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
