indexing
	description: "Syatem clusters."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_CLUSTERS

inherit
	IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB
		redefine
			cluster_properties_by_id,
			cluster_properties,
			remove_cluster,
			add_cluster,
			store,
			cluster_tree
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
			ace_accesser := an_ace_accesser
			cl := ace_accesser.root_ast.clusters
			if cl /= Void then
					-- Initialize tree with data from `ace_accesser'.
					-- We use `clusters_table' to remember position of
					-- parent cluster if any. 
				from
						-- Detached store information from original.
					cl := cl.duplicate

						-- Initialize cluster list
					create clusters_table.make (cl.count)
					create cluster_table_by_id.make (cl.count)
					create clusters_impl.make (10)
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
		local
			cluster_sd: CLUSTER_SD
			parent_id: ID_SD
			cluster_prop: CLUSTER_PROPERTIES
		do
			if parent_name /= Void and then not parent_name.is_empty then
				parent_id := new_id_sd (parent_name, False)
			end
			cluster_sd := new_cluster_sd (new_id_sd (cluster_name, False), 
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

feature {NONE} -- Implementation

	clusters_impl: ARRAYED_LIST [CLUSTER_PROPERTIES]
			-- List of clusters.
			
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

end -- class SYSTEM_CLUSTERS
