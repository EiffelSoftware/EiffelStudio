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
			cluster_properties_by_id,
			cluster_properties,
			remove_cluster,
			add_cluster,
			store,
			cluster_tree,
			flat_clusters,
			change_cluster_name,
			get_cluster_fullname
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
					
			ace_accesser := an_ace_accesser
			cl := ace_accesser.root_ast.clusters
			if cl /= Void then
					-- Initialize tree with data from `ace_accesser'.
					-- We use `clusters_table' to remember position of
					-- parent cluster if any. 
					
					-- Initialize all cluster structures
					create clusters_table.make (cl.count)
					create cluster_table_by_id.make (cl.count)
					create renamed_clusters_table.make (10)
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
					create node.make_with_cluster_sd_and_ace_accesser (cluster, ace_accesser)
					if cluster.has_parent then
						parent_node := clusters_table.item (cluster.parent_name)
						if parent_node /= Void then
								-- If we do not find a parent, it means
								-- that parent has been wrongly specified
								-- in Ace file
							parent_node.add_child (node)
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
			end
		end

feature -- Access

	cluster_tree: CLUSTER_PROP_ENUMERATOR is
			-- Cluster tree.
		do
			if clusters_impl /= Void then
				create Result.make (clusters_impl)
			else
				create Result.make (clusters_impl)
			end
		end
		
	flat_clusters: CLUSTER_PROP_ENUMERATOR is
			-- Clusters in flat form
		do
			if clusters_table /= Void then
				create Result.make (clusters_table.linear_representation)
			end
		end
		
feature -- Basic Operations

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

--				-- Mark override cluster if set.
--			if has_override_cluster then
--				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.override_cluster,
--					override_cluster_name, False))
--			end
			
			ace_accesser.apply
		end

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
			-- `cluster_name' [in].  
			-- `parent_name' [in].  
			-- `cluster_path' [in].
		require else
			invalid_cluster_name: is_valid_name (cluster_name);
		local
			cluster_sd: CLUSTER_SD
			parent_id: ID_SD
			cluster_prop: CLUSTER_PROPERTIES
		do
			if parent_name /= Void and then not parent_name.is_empty then
				parent_id := new_id_sd (parent_name, False)
			end
			create cluster_sd.initialize (new_id_sd (cluster_name, False), 
										parent_id,
										new_id_sd (cluster_path, True),
										Void, False, False)
			create cluster_prop.make_with_cluster_sd_and_ace_accesser (cluster_sd, ace_accesser)
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

	remove_cluster (cluster_name: STRING) is
			-- Remove a cluster from the project.
			-- `cluster_name' [in].  
		local
			removed: BOOLEAN
			cluster: CLUSTER_PROPERTIES
		do
			cluster := clusters_table.item (cluster_name)
			cluster_table_by_id.remove (cluster.cluster_id)
			clusters_table.remove (cluster_name)
			from
				clusters_impl.start
			until
				removed or clusters_impl.after
			loop
				if clusters_impl.item.name.is_equal (cluster_name) then
					clusters_impl.remove
					removed := True
				elseif 
					clusters_impl.item.has_children and then
					clusters_impl.item.has_child (cluster_name) 
				then
					clusters_impl.item.remove_child (cluster_name)
					removed := True
				end
				clusters_impl.forth
			end
		end

	is_valid_name (a_name: STRING): BOOLEAN is
			-- Checks to see if the cluster name is valid.
		local
			i: INTEGER
		do
			Result := true
			
			if a_name.is_empty then
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
			
			-- check the reserved words
			if Result = true then
				if ace_accesser /= Void then
					from
						ace_accesser.reserved_keywords.start
					until
						ace_accesser.reserved_keywords.after or Result = false
					loop
						if ace_accesser.reserved_keywords.item.is_equal (a_name) then
							Result := false
						end	
						ace_accesser.reserved_keywords.forth
					end
					
				end
			end
		end	
		
	cluster_properties (cluster_name: STRING): CLUSTER_PROPERTIES is
			-- Cluster properties.
			-- `cluster_name' [in].  
		do
			Result := clusters_table.item (cluster_name)
		end

	cluster_properties_by_id (cluster_id: INTEGER): CLUSTER_PROPERTIES is
			-- Cluster properties.
			-- `cluster_id' [in].  
		do
			Result := cluster_table_by_id.item (cluster_id)
		end

	get_cluster_fullname (cluster_name: STRING): STRING is
			-- Get the clusters full name from its simple name
		local
			cluster: CLUSTER_PROPERTIES
			parent_name: STRING
		do
			Result := ""
			cluster ?= clusters_table.item (cluster_name)
			if cluster /= Void then
				Result := cluster_name.clone(cluster_name)
				if cluster.has_parent then
					Result.prepend_character('.')
					Result.prepend(get_cluster_fullname(cluster.parent_name))
				end				
			end
		end
		

feature -- Element change

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
			-- Renames and cluster
			-- 'a_name' [in]
			-- 'a_new_name' [in]
		require else
			invalid_cluster_name: is_valid_name (a_new_name);
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
		

feature {NONE} -- Implementation

	clusters_impl: ARRAYED_LIST [CLUSTER_PROPERTIES]
			-- List of clusters.
			
	renamed_clusters_table: HASH_TABLE [STRING, STRING]
			-- Hash table of the clusters that have been renamed
			
	clusters_table: HASH_TABLE [CLUSTER_PROPERTIES, STRING]
			-- Hash table of clusters.

	cluster_table_by_id: HASH_TABLE [CLUSTER_PROPERTIES, INTEGER]
			-- Hash table of clusters.
	
	ace_accesser: ACE_FILE_ACCESSER
			-- Ace file accesser.
	
	next_id: INTEGER
			-- Next cluster ID.
invariant
	non_void_clusters_list: clusters_impl /= Void
	non_void_clusters_table: clusters_table /= Void
	non_void_ace_accesser: ace_accesser /= Void
	non_void_rename_cluster_table: renamed_clusters_table /= Void

end -- class SYSTEM_CLUSTERS
