indexing

	description: 
		"Shared information when retrieving and%
		%storing a system view.";
	date: "$Date$";
	revision: "$Revision $"

class VIEW_INFO

feature -- Properties

	reverse_compressed_links: LINKED_LIST [CLI_SUP_DATA];
			-- List of compressed links that contain reverse links

	shared_handles: ARRAYED_LIST [HANDLE_DATA]
			-- List of handle data for storing/retrieving a view

	system_classes: HASH_TABLE [CLASS_DATA, INTEGER];
			-- List of class data hashed on view_id

	system_clusters: HASH_TABLE [CLUSTER_DATA, INTEGER];
			-- List of cluster data for retrieving a view

	are_new_relations: BOOLEAN;
			-- Are there new relations coming from
			-- the core structure (storage/common)

	view: SYSTEM_VIEW;
			-- System view being retrieved

	is_new_view: BOOLEAN;
			-- Is view a new view?

feature -- Removal

	clear is
			-- Clear data structures.
		do
			is_new_view := False;
			view := Void;
			shared_handles := Void;
			system_clusters := Void
			system_classes := Void;
			reverse_compressed_links := Void;
			are_new_relations := False;
		ensure
			void_view: view = Void;
			handles: shared_handles = Void;
			no_new_relations: not are_new_relations;
			void_reverse_links: reverse_compressed_links = Void
		end;

feature -- Retrieval

	set_is_new_view is
			-- Set `is_new_view' to True.
		do
			is_new_view := True
		ensure
			is_new_view: is_new_view
		end;

	initialize_for_retrieving (v: like view) is
			-- Set view to `v'.
		require
			valid_view: v /= Void;
		do
			view := v;
			!! system_clusters.make (10);
			!! system_classes.make (500);
			!! reverse_compressed_links.make;
		ensure
			valid_system_clusters: system_clusters /= Void;
			valid_system_classes: system_classes /= Void;
			view_set: view = v;
			no_new_relations: not are_new_relations
		end;

	retrieve_shared_handles is
			-- Retrieve shared handles.
		local
			view_shared_h: FIXED_LIST [REAL_HANDLE_VIEW]
		do
			if view /= Void then
				view_shared_h := view.shared_handles;
				!! shared_handles.make (view_shared_h.count);
				from
					view_shared_h.start
				until
					view_shared_h.after
				loop
					shared_handles.put_right (view_shared_h.item.data);
					shared_handles.forth;
					view_shared_h.forth
				end
			end
		end;

	set_are_new_relations is
			-- Set are_new_relations to True.
		do
			are_new_relations := True
		end;

	handle_data (i: INTEGER): HANDLE_DATA is
			-- Handle data for handle identifier `i'.
		require
			valid_handles: shared_handles /= Void;
			valid_identifier_min: i > 0;
			valid_identifier_max: i <= shared_handles.count
		local
			id: INTEGER;
		do
			Result := shared_handles.i_th (i);
		end;

	add_reverse_comp_link (a_link: CLI_SUP_DATA) is
		require
			valid_a_link: a_link /= Void;
		do
			reverse_compressed_links.put_front (a_link)
		end;

	retrieve_reverse_links is
			-- Retrieve reverse links for compressed links.
		local
			reverse_link, rel_data: CLI_SUP_DATA	
		do
			from
				reverse_compressed_links.start
			until	
				reverse_compressed_links.after
			loop
				rel_data := reverse_compressed_links.item;
				reverse_link := rel_data.supplier.client_link_of
						(rel_data.client);
				if reverse_link /= Void then
					rel_data.add_reverse_link (reverse_link)
				end
				reverse_compressed_links.forth
			end
		end;

feature -- Storage

	initialize_for_storing is
			-- Initialize shared handles.
		do
			!! shared_handles.make (10);
		ensure
			valid_shared_handles: shared_handles /= Void
		end;

	shared_handle_identifier (shared_handle: HANDLE_DATA): INTEGER is
			-- Record `shared_data' (if not recorded)
			-- and return its position in list.
		require
			valid_handle: shared_handle /= Void;
			is_shared: shared_handle.is_shared
		do
			shared_handles.start;
			shared_handles.search (shared_handle);
			if shared_handles.after then
				shared_handles.extend (shared_handle);
				Result := shared_handles.count
			else
				Result := shared_handles.index;
			end
		end;

	view_shared_handles: FIXED_LIST [REAL_HANDLE_VIEW] is
			-- Shared view handles formulated from
			-- shared_handles
		local
			handle_view: REAL_HANDLE_VIEW
		do
			!! Result.make_filled (shared_handles.count)
			from
				Result.start;
				shared_handles.start
			until
				shared_handles.after
			loop
				!! handle_view.make (shared_handles.item);
				Result.replace (handle_view);
				Result.forth;
				shared_handles.forth
			end
		end;

	cluster_of_view_id (id: INTEGER): CLUSTER_DATA is
			-- Cluster data with name `name'.
			-- Void, if not found
		require
			valid_id: id < 0;
			has_view: view /= Void
		do
			Result := system_clusters.item (id)
		end;

	linkable_of_view_id (view_id: INTEGER): LINKABLE_DATA is
			-- Linkable with `view_id'
		do
			if view_id > 0 then
				Result := system_classes.item (view_id)
			else
				Result := system_clusters.item (view_id)
			end
		end;

	add_cluster (cluster_data: CLUSTER_DATA) is
			-- Add `cluster_data' to system_clusters.
		require
			valid_cluster_data: cluster_data /= Void;
			not_have_cluster_id: not system_clusters.has 
					(cluster_data.view_id)
		do
			system_clusters.put (cluster_data, cluster_data.view_id)
		ensure
			have_cluster_id: system_clusters.has (cluster_data.view_id)
		end;

	process_icons is
			-- Process all icons in the system if there
			-- are_new_relations.
		local
			cluster: CLUSTER_DATA;
			compress_links: COMPRESS_LINKS_U;
		do
			if are_new_relations then
				from
					system_clusters.start
				until
					system_clusters.after
				loop
					cluster := system_clusters.item_for_iteration;
					if cluster.is_icon then
						!! compress_links.make (cluster, True);
					end;
					system_clusters.forth
				end;
			end;
		end;

end -- class VIEW_INFO
