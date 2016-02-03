note
	description: "[
			API to manage CMS Nodes
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create {CMS_NODE_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_node_storage: CMS_NODE_STORAGE_I)
		do
			node_storage := a_node_storage
			make (a_api)
--			error_handler.add_synchronization (a_node_storage.error_handler)
		end

	initialize
			-- <Precursor>
		do
			Precursor
			initialize_node_types
		end

	initialize_node_types
			-- Initialize content type system.
		local
			ct: CMS_PAGE_NODE_TYPE
		do
				-- Initialize node content types.			
			create ct
				--| For now, add all available formats to content type `ct'.
			across
				cms_api.formats as ic
			loop
				ct.extend_format (ic.item)
			end
			add_node_type (ct)
			add_node_type_webform_manager (create {CMS_PAGE_NODE_TYPE_WEBFORM_MANAGER}.make (ct, Current))
		end

feature {CMS_MODULE} -- Access nodes storage.

	node_storage: CMS_NODE_STORAGE_I

feature -- Content type

	add_node_type (a_type: CMS_NODE_TYPE [CMS_NODE])
			-- Register node content type `a_type'.
		do
			cms_api.add_content_type (a_type)
		end

	node_types: ARRAYED_LIST [attached like node_type]
			-- Node content types.
		do
			create Result.make (cms_api.content_types.count)
			across
				cms_api.content_types as ic
			loop
				if attached {like node_type} ic.item as l_node_type then
					Result.extend (l_node_type)
				end
			end
		end

	node_type (a_name: READABLE_STRING_GENERAL): detachable CMS_NODE_TYPE [CMS_NODE]
			-- Content type named `a_named' if any.
		do
			across
				cms_api.content_types as ic
			until
				Result /= Void
			loop
				if
					attached {like node_type} ic.item as l_node_type and then
					a_name.is_case_insensitive_equal (l_node_type.name)
				then
					Result := l_node_type
				end
			end
		end

	node_type_for (a_node: CMS_NODE): like node_type
			-- Content type for node `a_node' if any.
		local
			l_type_name: READABLE_STRING_8
		do
			l_type_name := a_node.content_type
			Result := node_type (l_type_name)
		end

feature -- Content type webform

	content_type_webform_managers: ARRAYED_LIST [CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]]
			-- Available content types
		do
			Result := cms_api.content_type_webform_managers
		end

	add_node_type_webform_manager (a_manager: CMS_NODE_TYPE_WEBFORM_MANAGER [CMS_NODE])
			-- Register webform manager `a_manager'.
		do
			cms_api.add_content_type_webform_manager (a_manager)
		end

	node_type_webform_manager (a_node_type: CMS_CONTENT_TYPE): detachable CMS_NODE_TYPE_WEBFORM_MANAGER_I [CMS_NODE]
			-- Web form manager for node type `a_node_type' if any.
		local
			l_type_name: READABLE_STRING_GENERAL
		do
			l_type_name := a_node_type.name
			across
				content_type_webform_managers as ic
			until
				Result /= Void
			loop
				if
					attached {like node_type_webform_manager} ic.item as l_manager and then
					l_type_name.is_case_insensitive_equal (l_manager.name)
				then
					Result := l_manager
				end
			end
		end

feature -- URL

	new_content_path (ct: detachable CMS_CONTENT_TYPE): STRING
			-- URI path for new content of type `ct'
			-- or URI of path for selection of new content possibilities if ct is Void.
		do
			if ct /= Void then
				Result := "node/add/" + ct.name
			else
				Result := "node/"
			end
		end

	node_link (a_node: CMS_NODE): CMS_LOCAL_LINK
			-- CMS link for node `a_node'.
		require
			a_node.has_id
		do
			create Result.make (a_node.title, cms_api.location_alias (node_path (a_node)))
		end

	node_path (a_node: CMS_NODE): STRING
			-- URI path for node `a_node'.
			-- using the /node/{nid} url.
		require
			a_node.has_id
		do
			Result := "node/" + a_node.id.out
		end

	nodes_path: STRING
			-- URI path for list of nodes.
		do
			Result := "nodes"
		end

feature -- Access: Node

	nodes_count: NATURAL_64
		do
			Result := node_storage.nodes_count
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			Result := node_storage.nodes
		end

	node_revisions (a_node: CMS_NODE): LIST [CMS_NODE]
			-- List of revisions for node `a_node'.
		do
			Result := node_storage.node_revisions (a_node)
			Result := full_nodes (Result)
		end

	trashed_nodes (a_user: detachable CMS_USER): LIST [CMS_NODE]
			-- List of nodes with status in {CMS_NODE_API}.trashed.
			-- if `a_user' is set, return nodes related to this user.
		do
			Result := node_storage.trashed_nodes (a_user)
		end

	recent_nodes (params: CMS_DATA_QUERY_PARAMETERS): ITERABLE [CMS_NODE]
			-- List of most recent nodes according to `params.offset' and `params.size'.
		do
			Result := node_storage.recent_nodes (params.offset.to_integer_32, params.size.to_integer_32)
		end

	recent_node_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME): ITERABLE [CMS_NODE]
			-- List of recent changes, before `a_date', according to `params' settings.
		do
			Result := node_storage.recent_node_changes_before (params.offset.to_integer_32, params.size.to_integer_32, a_date)
		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- Node by ID.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			Result := safe_full_node (node_storage.node_by_id (a_id))
		end

	revision_node (a_node_id: INTEGER_64; a_revision_id: INTEGER_64): detachable CMS_NODE
		do
			Result := safe_full_node (node_storage.node_by_id_and_revision (a_node_id, a_revision_id))
		end

	safe_full_node (a_node: detachable CMS_NODE): detachable CMS_NODE
		do
			if a_node /= Void then
				Result := full_node (a_node)
			end
		end

	full_node (a_node: CMS_NODE): CMS_NODE
			-- If `a_node' is partial, return the full node from `a_node',
			-- otherwise return directly `a_node'.
		require
			a_node_set: a_node /= Void
		do
			if attached {CMS_PARTIAL_NODE} a_node as l_partial_node then
				if attached node_type_for (l_partial_node) as ct then
					Result := ct.new_node (l_partial_node)
					node_storage.fill_node (Result)
				else
					Result := l_partial_node
				end
					-- Update link with aliasing.
				if Result /= Void and then Result.has_id then
					Result.set_link (node_link (Result))
				end
			else
				Result := a_node
				if Result.has_id and Result.link = Void then
					Result.set_link (node_link (Result))
				end
			end
			check has_link: Result.has_id implies attached Result.link as lnk and then lnk.location.same_string (node_link (Result).location) end

				-- Update partial user if needed.
			if
				Result /= Void and then
				attached {CMS_PARTIAL_USER} Result.author as l_partial_author
			then
				if attached cms_api.user_api.user_by_id (l_partial_author.id) as l_author then
					Result.set_author (l_author)
				else
					check
						valid_author_id: False
					end
				end
			end
		end

	full_nodes (a_nodes: LIST [CMS_NODE]): LIST [CMS_NODE]
			-- Convert list of nodes into a list of nodes when possible.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (a_nodes.count)

			across
				a_nodes as ic
			loop
				if attached full_node (ic.item) as l_full then
					Result.force (l_full)
				end
			end
		end

	is_author_of_node (u: CMS_USER; a_node: CMS_NODE): BOOLEAN
			-- Is the user `u' owner of the node `n'.
		do
			Result := u.same_as (a_node.author)
		end

	nodes_of_type (a_node_type: CMS_CONTENT_TYPE): LIST [CMS_NODE]
			-- List of nodes of type `a_node_type'.
		do
			Result := node_storage.nodes_of_type (a_node_type)
		ensure
			expected_type: across Result as ic all ic.item.content_type.same_string (a_node_type.name) end
		end

feature -- Access: page/book outline

	children (a_node: CMS_NODE): detachable LIST [CMS_NODE]
			-- Children of node `a_node'.
			-- note: this is the partial version of the nodes.
		do
			Result := node_storage.children (a_node)
		end

	available_parents_for_node (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Potential parent nodes for node `a_node'.
			-- Ensure no cycle exists.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
			across node_storage.available_parents_for_node (a_node) as ic loop
				check distinct: not a_node.same_node (ic.item) end
				if not is_node_a_parent_of (a_node, ic.item) then
					Result.force (ic.item)
				end
			end
		ensure
			no_cycle: across Result as c all not is_node_a_parent_of (a_node, c.item) end
		end

	is_node_a_parent_of (a_node: CMS_NODE; a_child: CMS_NODE): BOOLEAN
			-- Is `a_node' a direct or indirect parent of node `a_child'?
		require
			distinct_nodes: not a_node.same_node (a_child)
		do
			if
				attached {CMS_PAGE} full_node (a_child) as l_child_page and then
				attached l_child_page.parent as l_parent
			then
				if l_parent.same_node (a_node) then
					Result := True
				else
					Result := is_node_a_parent_of (a_node, l_parent)
				end
			end
		end

feature -- Permission Scope: Node

	has_permission_for_action_on_node (a_action: READABLE_STRING_8; a_node: CMS_NODE; a_user: detachable CMS_USER; ): BOOLEAN
			-- Has permission to execute action `a_action' on node `a_node', by eventual user `a_user'?
		local
			l_type_name: READABLE_STRING_8
		do
			l_type_name := a_node.content_type
			Result := cms_api.user_has_permission (a_user, a_action + " any " + l_type_name)
			if not Result and a_user /= Void then
				if is_author_of_node (a_user, a_node) then
					Result := cms_api.user_has_permission (a_user, a_action + " own " + l_type_name)
				end
			end
		end

feature -- Change: Node

	save_node (a_node: CMS_NODE)
			-- Save `a_node'.
		do
			reset_error
			node_storage.save_node (a_node)
			error_handler.append (node_storage.error_handler)
		end

	new_node (a_node: CMS_NODE)
			-- Add a new node `a_node'
		require
			no_id: not a_node.has_id
		do
			reset_error
			node_storage.new_node (a_node)
			error_handler.append (node_storage.error_handler)
		end

	delete_node (a_node: CMS_NODE)
			-- Delete `a_node'.
			--! remove the node from the storage.
		do
			reset_error
			if a_node.has_id then
				node_storage.delete_node (a_node)
				error_handler.append (node_storage.error_handler)
			end
		end

	update_node (a_node: CMS_NODE)
			-- Update node `a_node' data.
		do
			reset_error
			node_storage.update_node (a_node)
			error_handler.append (node_storage.error_handler)
		end

	trash_node (a_node: CMS_NODE)
			-- Trash node `a_node'.
			-- Soft delete
		do
			reset_error
			node_storage.trash_node (a_node)
			error_handler.append (node_storage.error_handler)
		end

	restore_node (a_node: CMS_NODE)
			-- Restore node `a_node'.
			-- From {CMS_NODE_API}.trashed to {CMS_NODE_API}.not_published.
		do
			reset_error
			node_storage.restore_node (a_node)
			error_handler.append (node_storage.error_handler)
		end

feature -- Node status

	Not_published: INTEGER = 0
			-- The node is not published.

	Published: INTEGER = 1
			-- The node is published.

	Trashed: INTEGER = -1
			-- The node is trashed (soft delete), ready to be deleted/destroyed from storage.

end
