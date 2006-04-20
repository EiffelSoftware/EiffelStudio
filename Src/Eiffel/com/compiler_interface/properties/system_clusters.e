indexing
    description: "System clusters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class
    SYSTEM_CLUSTERS

inherit
    IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB
        redefine
            get_cluster_tree,
            get_all_clusters,
            get_cluster_full_name,
            get_cluster_full_namespace,
            get_cluster_properties,
            get_cluster_properties_by_id,
            change_cluster_name,
            add_cluster,
            remove_cluster,
            store,
            is_cluster_name_available,
            is_valid_cluster_name
        end
    
    LACE_AST_FACTORY
        export
            {NONE} all
        end
        
	IL_CASING_CONVERSION
		export
			{NONE} all
		end
	
	SHARED_EIFFEL_PROJECT
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

    get_cluster_tree: CLUSTER_PROP_ENUMERATOR is
            -- Cluster tree.
        do
            create Result.make (clusters_impl)
        end
        
    get_all_clusters: CLUSTER_PROP_ENUMERATOR is
            -- Clusters in flat form
        do
            create Result.make (clusters_table.linear_representation)
        end

    get_cluster_full_name (cluster_name: STRING): STRING is
            -- Get the clusters full name from 'cluster_name' cluster
        require else
            non_void_cluster_name: cluster_name /= Void
            valid_cluster_name: is_valid_cluster_name (cluster_name)
            has_cluster: has_cluster (cluster_name)
        local
            cluster: CLUSTER_PROPERTIES
        do
            cluster ?= clusters_table.item (cluster_name)
            if cluster /= Void then
                Result := cluster_name.twin
                if cluster.has_parent then
                    Result.prepend_character('.')
                    Result.prepend (get_cluster_full_name (cluster.parent_name))
                end             
            end
        end
        
	get_cluster_full_namespace (cluster_name: STRING): STRING is
			-- gets full cluster namespace
        require else
            non_void_cluster_name: cluster_name /= Void
            valid_cluster_name: is_valid_cluster_name (cluster_name)
            has_cluster: has_cluster (cluster_name)
		local
            cluster: CLUSTER_PROPERTIES
        do
            cluster ?= clusters_table.item (cluster_name)
            if cluster /= Void then
            	if cluster.cluster_namespace /= Void and not cluster.cluster_namespace.is_empty then
	                Result := cluster.cluster_namespace.twin
	            else
	            	Result := cluster.name.twin
	            end
            	if ace_accesser.dot_net_naming_convention then
            		--| FIXME We should only need to convert cluster.name to .Net naming
            		--| The compiler incorrect converts cluster_namespace as well
	            	Result := namespace_casing (True, Result)
				end
                if cluster.has_parent then
                    Result.prepend_character('.')
                    if ace_accesser.dot_net_naming_convention then
	                    Result.prepend (get_cluster_full_namespace (namespace_casing (True, cluster.parent_name.as_lower)))
	                else
	                	Result.prepend (get_cluster_full_namespace (cluster.parent_name))
	                end
                elseif ace_accesser.default_namespace /= Void and then not ace_accesser.default_namespace.is_empty then
					Result.prepend_character('.')
					if ace_accesser.dot_net_naming_convention then
						Result.prepend (namespace_casing (True, ace_accesser.default_namespace.as_lower))
					else
						Result.prepend (ace_accesser.default_namespace)	
					end
                end
            end			
		end
        
    get_cluster_properties (a_name: STRING): CLUSTER_PROPERTIES is
            -- Cluster properties.
            -- `a_name' [in].
        require else
        	non_void_name: a_name /= Void
        	valid_name: is_valid_cluster_name (a_name)
        do
        	Result := clusters_table.item (a_name)
        end

	get_cluster_properties_by_id (cluster_id: INTEGER): CLUSTER_PROPERTIES is
        -- Cluster properties.
        -- `cluster_id' [in].
	    require else
	        index_big_enough: cluster_id > 0
	    do
	        Result := cluster_table_by_id.item (cluster_id)
	    end
    
feature -- Basic Operations

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
	        -- Renames and cluster
	        -- 'a_name' [in]
	        -- 'a_new_name' [in]
	    require else
	        non_void_name: a_name /= Void
	        non_void_new_name: a_new_name /= Void
	        invalid_name: is_valid_cluster_name (a_name);
	        invalid_cluster_name: is_valid_cluster_name (a_new_name);
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
	
	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
	        -- Add a cluster to the project.
	        -- `cluster_name' [in].  
	        -- `parent_name' [in].  
	        -- `cluster_path' [in].
	    require else
	        non_void_cluster_name: cluster_name /= Void
	        valid_cluster_name: not cluster_name.is_empty
	        non_void_cluster_path: cluster_path /= Void
	        cluster_name_available: is_cluster_name_available (cluster_name)
	    local
	        cluster_sd: CLUSTER_SD
	        parent_id: ID_SD
	        cluster_prop: CLUSTER_PROPERTIES
	        parent_cluster: CLUSTER_PROPERTIES
	    do
	        if parent_name /= Void and then not parent_name.is_empty then
	            parent_id := new_id_sd (parent_name, False)
	            parent_cluster := clusters_table.item (parent_name)
	        end
	        create cluster_sd.initialize (new_id_sd (cluster_name, True), 
	                                    parent_id,
	                                    new_id_sd (cluster_path, True),
	                                    Void, False, False)
	        create cluster_prop.make_with_cluster_sd_and_ace_accesser (cluster_sd, parent_cluster, ace_accesser)
	        if parent_name /= Void and then not parent_name.is_empty then
	            clusters_table.item (parent_name).add_child (cluster_prop)
	        else
	        	-- only add cluster to impl list if there is no parent
	            clusters_impl.extend (cluster_prop)
	        end
	        clusters_table.put (cluster_prop, cluster_name)
	        cluster_prop.set_id (next_id)
	        cluster_table_by_id.put (cluster_prop, next_id)
	        next_id := next_id + 1
	    end
	    
	remove_cluster (cluster_name: STRING) is
	        -- Remove 'cluster_name' cluster from the project.
	        -- `cluster_name' [in].  
	    require else
	        non_void_cluster_name: cluster_name /= Void
	        valid_cluster_name: is_valid_cluster_name (cluster_name)
	        has_cluster: has_cluster (cluster_name)
	    local
	        removed: BOOLEAN
	        cluster: CLUSTER_PROPERTIES
	    do
	        cluster := clusters_table.item (cluster_name)
	        cluster_table_by_id.remove (cluster.cluster_id)
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
	            if not removed then
	                clusters_impl.forth                 
	            end
	        end 
	        if clusters_table.item (cluster_name).override then
	            ace_accesser.set_override_cluster (Void)
	        end
	        clusters_table.remove (cluster_name)
	    end
	    
	store is
	        -- Save changes.
	    local
	        l_clusters: LACE_LIST [CLUSTER_SD]
	    do
	        -- clear all clusters from list         
	        create l_clusters.make (0)
	        ace_accesser.root_ast.set_clusters (l_clusters)
	
	        -- store clusters
	        from
	            clusters_impl.start
	        until
	            clusters_impl.after
	        loop
	            store_recusively (clusters_impl.item)
	            clusters_impl.forth
	        end
	
	        ace_accesser.apply
	    end

feature {NONE} -- Basic Operations
	    
	store_recusively (a_cluster: CLUSTER_PROPERTIES) is
	        -- stores all clusters recursively
	    require
	        non_void_cluster: a_cluster /= Void
	        non_void_cluster_sd_list: ace_accesser.root_ast.clusters /= Void
	    local
	        l_sub_clust: CLUSTER_PROP_ENUMERATOR
	        l_clust_count: INTEGER
	        l_idx: INTEGER
	        l_cluster: CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
	        l_cluster_prop: like a_cluster
	    do
	    	ace_accesser.root_ast.clusters.extend (a_cluster.cluster_sd)
	        a_cluster.store
	        if a_cluster.has_children then
	            l_sub_clust := a_cluster.subclusters
	            l_clust_count := l_sub_clust.count
	            from
	                l_idx := 1
	            until
	                l_idx > l_clust_count
	            loop
	                create l_cluster
	                l_sub_clust.ith_item (l_idx, l_cluster)
	                if l_cluster.item /= Void then
	                    l_cluster_prop ?= l_cluster.item
	                    if l_cluster_prop /= Void then
	                        store_recusively (l_cluster_prop)
	                    end
	                end
	                l_idx := l_idx + 1
	            end
	        end
	    end
    
feature -- Validation

	is_cluster_name_available (a_cluster_name: STRING): BOOLEAN is
	        -- is 'a_cluster_name' available for a cluster name?
	    require else
	        non_void_cluster_name: a_cluster_name /= Void
	        valid_cluter_name: is_valid_cluster_name (a_cluster_name)
	    do
	        Result := eiffel_universe.cluster_of_name (a_cluster_name) = Void
	    end
	    
	is_valid_cluster_name (a_name: STRING): BOOLEAN is
	        -- Checks to see if 'a_name' is a valid cluster name.
	    require else
	        non_void_name: a_name /= Void
	    do
	        Result := not a_name.is_empty
	    end 
	    
	has_cluster (a_cluster_name: STRING): BOOLEAN is
	        -- does cluster 'a_cluster_name' exists?
	    do
	        Result := not is_cluster_name_available (a_cluster_name)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class SYSTEM_CLUSTERS
