indexing
	description: "System clusters."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_CLUSTERS

inherit
	IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB
		redefine
			is_valid_name,
			is_valid_name_user_precondition,
			cluster_properties_by_id,
			cluster_properties_by_id_user_precondition,
			cluster_properties,
			cluster_properties_user_precondition,
			remove_cluster,
			remove_cluster_user_precondition,
			add_cluster,
			add_cluster_user_precondition,
			store,
			cluster_tree,
			flat_clusters,
			change_cluster_name,
			change_cluster_name_user_precondition,
			get_cluster_fullname,
			get_cluster_fullname_user_precondition
		end
	
	LACE_AST_FACTORY
		export
			{NONE} all
		end

create
	make
	
feature -- Initialization

	make (an_ace_accesser: ACE_FILE_ACCESSER) is
			-- Initialize with all data taken from `ace_accesser'.
		require
			non_void_ace_accesser: an_ace_accesser /= Void
		local
			cl: LACE_LIST [CLUSTER_SD]
			cluster: CLUSTER_SD
			node, parent_node: CLUSTER_PROPERTIES
			cl_name: ID_SD
		do
			create clusters_impl.make (10)
			create cluster_table_by_id.make (10)		
			create clusters_table.make (10)
			create renamed_clusters_table.make (10)
			ace_accesser := an_ace_accesser
			cl := ace_accesser.root_ast.clusters
			if cl /= Void then
					-- Initialize tree with data from `ace_accesser'.
					-- We use `clusters_table' to remember position of
					-- parent cluster if any. 
					
					-- Initialize all cluster structures
				from
						-- Detached store information from original.
					cl := cl.duplicate

						-- Initialize cluster list
					cl.start
					next_id := 1
				until
					cl.after
				loop
					cluster := cl.item
					cl_name := cluster.cluster_name
					create node.make_with_cluster_sd_and_ace_accesser (cluster, Void, ace_accesser)
					if cluster.has_parent then
						parent_node := clusters_table.item (cluster.parent_name)
						if parent_node /= Void then
								-- If we do not find a parent, it means
								-- that parent has been wrongly specified
								-- in Ace file
							parent_node.add_child (node)
							node.set_parent_cluster (parent_node)
						end
					else
						clusters_impl.extend (node)
					end
					clusters_table.put (node, cl_name)
					node.set_id (next_id)
					cluster_table_by_id.put (node, next_id)
					next_id := next_id + 1
					cl.forth
				end
			else
				next_id := 1
			end
		end

feature -- Access

	cluster_tree: CLUSTER_PROP_ENUMERATOR is
			-- Cluster tree.
		do
			create Result.make (clusters_impl)
		end
		
	flat_clusters: CLUSTER_PROP_ENUMERATOR is
			-- Clusters in flat form
		do
			create Result.make (clusters_table.linear_representation)
		end
		
feature -- Basic Operations

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
			-- `cluster_name' [in].  
			-- `parent_name' [in].  
			-- `cluster_path' [in].
		require else
			non_void_cluster_name: cluster_name /= Void
			non_void_cluster_path: cluster_path /= Void
			valid_cluster_name: is_valid_name (cluster_name);
			cluster_already_exists: not has_cluster (cluster_name)
		local
			cluster_sd: CLUSTER_SD
			parent_id: ID_SD
			cluster_prop: CLUSTER_PROPERTIES
			temp_cluster_path: STRING
			parent_cluster: CLUSTER_PROPERTIES
		do
			--| Fix Me PAUL
			temp_cluster_path := clone (cluster_path)
			if temp_cluster_path.is_empty then
				temp_cluster_path := "."
			end
			if parent_name /= Void and then not parent_name.is_empty then
				parent_id := new_id_sd (parent_name, False)
				parent_cluster := clusters_table.item (parent_name)
			end
			create cluster_sd.initialize (new_id_sd (cluster_name, False), 
										parent_id,
										new_id_sd (temp_cluster_path, True),
										Void, False, False)
			create cluster_prop.make_with_cluster_sd_and_ace_accesser (cluster_sd, parent_cluster, ace_accesser)
			if parent_name /= Void and then not parent_name.is_empty then
				clusters_table.item (parent_name).add_child (cluster_prop)
			else
				clusters_impl.extend (cluster_prop)
			end
			clusters_table.put (cluster_prop, cluster_name)
			cluster_prop.set_id (next_id)
			cluster_table_by_id.put (cluster_prop, next_id)
			next_id := next_id + 1
		end

	cluster_properties (cluster_name: STRING): CLUSTER_PROPERTIES is
			-- Cluster properties.
			-- `cluster_name' [in].
		require else
			non_void_cluster_name: cluster_name /= Void
			valid_cluster_name: is_valid_name (cluster_name)
		do
			Result := clusters_table.item (cluster_name)
		end

	cluster_properties_by_id (cluster_id: INTEGER): CLUSTER_PROPERTIES is
			-- Cluster properties.
			-- `cluster_id' [in].
		require else
			index_big_enough: cluster_id > 0
		do
			Result := cluster_table_by_id.item (cluster_id)
		end

	get_cluster_fullname (cluster_name: STRING): STRING is
			-- Get the clusters full name from 'cluster_name' cluster
		require else
			non_void_cluster_name: cluster_name /= Void
			valid_cluster_name: is_valid_name (cluster_name)
			has_cluster: has_cluster (cluster_name)
		local
			cluster: CLUSTER_PROPERTIES
		do
			cluster ?= clusters_table.item (cluster_name)
			if cluster /= Void then
				Result := cluster_name.clone(cluster_name)
				if cluster.has_parent then
					Result.prepend_character('.')
					Result.prepend(get_cluster_fullname(cluster.parent_name))
				end				
			end
		end
		
	remove_cluster (cluster_name: STRING) is
			-- Remove 'cluster_name' cluster from the project.
			-- `cluster_name' [in].  
		require else
			non_void_cluster_name: cluster_name /= Void
			valid_cluster_name: is_valid_name (cluster_name)
			has_cluster: has_cluster (cluster_name)
		local
			removed: BOOLEAN
			cluster: CLUSTER_PROPERTIES
			cluster_list: ARRAYED_LIST [CLUSTER_PROPERTIES]
		do
			cluster := clusters_table.item (cluster_name)
			cluster_table_by_id.remove (cluster.cluster_id)
			clusters_table.remove (cluster_name)
			from
				cluster_list := clusters_table.linear_representation
				cluster_list.start
			until
				removed or cluster_list.after
			loop
				if cluster_list.item.name.is_equal (cluster_name) then
					cluster_list.remove
					removed := True
				elseif 
					cluster_list.item.has_children and then
					cluster_list.item.has_child (cluster_name) 
				then
					cluster_list.item.remove_child (cluster_name)
					removed := True
				end
				if not removed then
					cluster_list.forth					
				end
			end				
		end
		
	store is
			-- Save changes.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			l_clusters: LACE_LIST [CLUSTER_SD]
			copy_clusters: like clusters_table
			clus_name: ID_SD
		do
				-- Default options
			defaults := ace_accesser.root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (10)
				ace_accesser.root_ast.set_defaults (defaults)
			end

				-- Save clusters
			copy_clusters := clone (clusters_table)
			from
				copy_clusters.start
			until
				copy_clusters.after
			loop
				copy_clusters.item_for_iteration.store
				copy_clusters.forth
			end
			
			l_clusters := ace_accesser.root_ast.clusters
			if l_clusters = Void then
					-- No cluster option, we need to create them
				create l_clusters.make (copy_clusters.count)
				ace_accesser.root_ast.set_clusters (l_clusters)
			end

				-- Insert cluster in the order in which they were entered
				-- originally.
			from
				l_clusters.start
			until
				l_clusters.after
			loop
				clus_name := l_clusters.item.cluster_name
				
					-- check to see if the cluster has been renamed. If so the
					-- subsitute the old name for the new. This will preserve the
					-- original order of the clusters
				if renamed_clusters_table.has (clus_name)  then
					create clus_name.initialize (renamed_clusters_table.item (clus_name))
				end
				if copy_clusters.has (clus_name) then
					l_clusters.put (copy_clusters.item (clus_name).cluster_sd)
					copy_clusters.remove (clus_name)
					l_clusters.forth
				else
					l_clusters.remove
				end
			end

				-- Insert at the end new clusters.
			if not copy_clusters.is_empty then
				from
					copy_clusters.start
				until
					copy_clusters.after
				loop
					l_clusters.extend (copy_clusters.item_for_iteration.cluster_sd)
					copy_clusters.forth
				end
			end
			
			ace_accesser.apply
		end

feature -- Element change

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
			-- Renames and cluster
			-- 'a_name' [in]
			-- 'a_new_name' [in]
		require else
			non_void_name: a_name /= Void
			non_void_new_name: a_new_name /= Void
			invalid_name: is_valid_name (a_name);
			invalid_cluster_name: is_valid_name (a_new_name);
			has_cluster: has_cluster (a_name)
		local
			cluster: CLUSTER_PROPERTIES
			replaced: BOOLEAN
		do
			cluster ?= clusters_table.item (a_name)
			if cluster /= Void then
				-- check to see if the cluster has already been renamed.
				from
					renamed_clusters_table.start
				until
					renamed_clusters_table.after or replaced
				loop
					if renamed_clusters_table.item_for_iteration.is_equal (a_name) then
						renamed_clusters_table.replace (a_new_name, renamed_clusters_table.key_for_iteration)
						replaced := true;
					end
					renamed_clusters_table.forth
				end	
				-- if it has not been renamed then added it to the renamed table
				if renamed_clusters_table.after then
					renamed_clusters_table.put (a_new_name, a_name)
				end
				clusters_table.replace_key (a_new_name, a_name)
				cluster.set_name (a_new_name);
			end
		end
		
feature {NONE} -- User Preconditions

	is_valid_name_user_precondition (a_name: STRING): BOOLEAN is 
			-- 'is_valid_name' precondition
		do
			Result := False
		end

	add_cluster_user_precondition (cluster_name: STRING; parent_name: STRING; cluster_path: STRING): BOOLEAN is
			-- 'add_cluster' precondition
		do
			Result := False
		end

	change_cluster_name_user_precondition (a_name: STRING; a_new_name: STRING): BOOLEAN is
			-- 'change_cluster_name' preconditions
		do
			Result := False
		end

	cluster_properties_user_precondition (cluster_name: STRING): BOOLEAN is
			-- 'cluster_properties' preconditions
		do
			Result := False
		end
		
	cluster_properties_by_id_user_precondition (cluster_id: INTEGER): BOOLEAN is
			-- 'cluster_properties_by_id' precondition
		do
			Result := False
		end
		
	get_cluster_fullname_user_precondition (cluster_name: STRING): BOOLEAN is
			-- 'get_cluster_fullname' precondition
		do
			Result := False
		end

	remove_cluster_user_precondition (cluster_name: STRING): BOOLEAN is
			-- 'remove_cluster' precondition
		do
			Result := False
		end

feature -- Validation

	has_cluster (a_cluster_name: STRING): BOOLEAN is
			-- has 'a_cluster_name' already been added to project?
		require
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluter_name: is_valid_name (a_cluster_name)
		do
			Result := clusters_table.has (a_cluster_name)
		end
		
	is_valid_name (a_name: STRING): BOOLEAN is
			-- Checks to see if 'a_name' is a valid cluster name.
		require else
			non_void_name: a_name /= Void
		local
			i: INTEGER
			lower_name: STRING
		do
			if not a_name.is_empty then
				Result := true
				
				if a_name.is_empty or a_name = Void then
					Result := false
				end
				
				-- check for illegal characters
				from 
					i := 1
				until
					i > a_name.count or Result = false
				loop
					inspect a_name.item (i)
					when 'A'..'Z', 'a'..'z' then
						Result := true
					when '0'..'9', '_' then
						if i > 1 then
							Result := true
						else
							Result := false
						end
					else
						Result := false
					end
					i := i + 1
				end
				
				lower_name := a_name.clone (a_name)
				lower_name.to_lower
				
				-- check the reserved words
				if Result = true then
					if ace_accesser /= Void then
						from
							ace_accesser.reserved_keywords.start
						until
							ace_accesser.reserved_keywords.after or Result = false
						loop
							if ace_accesser.reserved_keywords.item.is_equal (lower_name) then
								Result := false
							end	
							ace_accesser.reserved_keywords.forth
						end
						
					end
				end	
			else
				Result := False
			end
		end	

feature {NONE} -- Implementation

	clusters_impl: ARRAYED_LIST [CLUSTER_PROPERTIES]
			-- List of clusters at top level (does not include sub-clusters).
			
	renamed_clusters_table: HASH_TABLE [STRING, STRING]
			-- Hash table of the clusters that have been renamed
			
	clusters_table: HASH_TABLE [CLUSTER_PROPERTIES, STRING]
			-- Hash table of all clusters.

	cluster_table_by_id: HASH_TABLE [CLUSTER_PROPERTIES, INTEGER]
			-- Hash table of clusters.
	
	ace_accesser: ACE_FILE_ACCESSER
			-- Ace file accesser.
	
	next_id: INTEGER
			-- Next cluster ID.
invariant
	non_void_clusters_list: clusters_impl /= Void
	non_void_clusters_table: clusters_table /= Void
	non_void_cluster_table_by_id: cluster_table_by_id /= Void
	non_void_ace_accesser: ace_accesser /= Void
	non_void_rename_cluster_table: renamed_clusters_table /= Void

end -- class SYSTEM_CLUSTERS
