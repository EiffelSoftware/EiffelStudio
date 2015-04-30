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

create
	make

feature {NONE} -- Implementation

	initialize
			-- <Precursor>
		do
			Precursor
			if attached {CMS_STORAGE_SQL_I} storage as l_storage_sql then
				create {CMS_NODE_STORAGE_SQL} node_storage.make (l_storage_sql)
			else
				create {CMS_NODE_STORAGE_NULL} node_storage.make
			end
			initialize_node_types
		end

	initialize_node_types
			-- Initialize content type system.
		local
			ct: CMS_PAGE_NODE_TYPE
		do
			create content_types.make (1)
			create content_type_webform_managers.make (1)
			create ct
			add_content_type (ct)
			add_content_type_webform_manager (create {CMS_PAGE_NODE_TYPE_WEBFORM_MANAGER}.make (ct))
		end

feature {CMS_MODULE} -- Access nodes storage.

	node_storage: CMS_NODE_STORAGE_I

feature -- Content type

	content_types: ARRAYED_LIST [CMS_CONTENT_TYPE]
			-- Available content types

	node_types: ARRAYED_LIST [attached like node_type]
			-- Node content types.
		do
			create Result.make (content_types.count)
			across
				content_types as ic
			loop
				if attached {like node_type} ic.item as l_node_type then
					Result.extend (l_node_type)
				end
			end
		end

	add_content_type (a_type: CMS_CONTENT_TYPE)
			-- Register content type `a_type'.
		do
			content_types.force (a_type)
		end

	content_type (a_name: READABLE_STRING_GENERAL): detachable CMS_CONTENT_TYPE
			-- Content type named `a_named' if any.
		do
			across
				content_types as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

	node_type (a_name: READABLE_STRING_GENERAL): detachable CMS_NODE_TYPE [CMS_NODE]
			-- Content type named `a_named' if any.
		do
			across
				content_types as ic
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

	content_type_webform_managers: ARRAYED_LIST [CMS_CONTENT_TYPE_WEBFORM_MANAGER]
			-- Available content types

	add_content_type_webform_manager (a_manager: CMS_CONTENT_TYPE_WEBFORM_MANAGER)
			-- Register webform manager `a_manager'.
		do
			content_type_webform_managers.force (a_manager)
		end

	content_type_webform_manager (a_content_type: CMS_CONTENT_TYPE): detachable CMS_CONTENT_TYPE_WEBFORM_MANAGER
			-- Web form manager for content type `a_content_type' if any.
		local
			l_type_name: READABLE_STRING_GENERAL
		do
			l_type_name := a_content_type.name
			across
				content_type_webform_managers as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not l_type_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
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
				Result := "/node/add/" + ct.name
			else
				Result := "/node/"
			end
		end

	node_path (a_node: CMS_NODE): STRING
			-- URI path for node `a_node'.
			-- using the /node/{nid} url.
		require
			a_node.has_id
		do
			Result := "/node/" + a_node.id.out
		end

	nodes_path: STRING
			-- URI path for list of nodes.
		do
			Result := "/nodes"
		end

feature -- Access: Node

	nodes_count: INTEGER_64
		do
			Result := node_storage.nodes_count
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			Result := node_storage.nodes
		end

	recent_nodes (a_offset, a_rows: INTEGER): LIST [CMS_NODE]
			-- List of the `a_rows' most recent nodes starting from  `a_offset'.
		do
			Result := node_storage.recent_nodes (a_offset, a_rows)
		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- Node by ID.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			Result := full_node (node_storage.node_by_id (a_id))
		end

	full_node (a_node: detachable CMS_NODE): detachable CMS_NODE
			-- If `a_node' is partial, return the full node from `a_node',
			-- otherwise return directly `a_node'.
		do
			if attached {CMS_PARTIAL_NODE} a_node as l_partial_node then
				if attached node_type_for (l_partial_node) as ct then
					Result := ct.new_node (l_partial_node)
					node_storage.fill_node (Result)
				else
					Result := l_partial_node
				end
			else
				Result := a_node
			end

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

feature -- Change: Node

	save_node (a_node: CMS_NODE)
			-- Save `a_node'.
		do
			node_storage.save_node (a_node)
		end

	new_node (a_node: CMS_NODE)
			-- Add a new node `a_node'
		require
			no_id: not a_node.has_id
		do
			node_storage.new_node (a_node)
		end

	delete_node (a_node: CMS_NODE)
			-- Delete `a_node'.
		do
			if a_node.has_id then
				node_storage.delete_node (a_node)
			end
		end

	update_node (a_node: CMS_NODE)
			-- Update node `a_node' data.
		do
			node_storage.update_node (a_node)
		end

--	update_node_title (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
--			-- Update node title, with user identified by `a_id', with node id `a_node_id' and a new title `a_title'.
--		do
--			debug ("refactor_fixme")
--				fixme ("Check preconditions")
--			end
--			node_storage.update_node_title (a_user_id, a_node_id, a_title)
--		end

--	update_node_summary (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
--			-- Update node summary, with user identified by `a_user_id', with node id `a_node_id' and a new summary `a_summary'.
--		do
--			debug ("refactor_fixme")
--				fixme ("Check preconditions")
--			end
--			node_storage.update_node_summary (a_user_id, a_node_id, a_summary)
--		end

--	update_node_content (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
--			-- Update node content, with user identified by `a_user_id', with node id `a_node_id' and a new content `a_content'.
--		do
--			debug ("refactor_fixme")
--				fixme ("Check preconditions")
--			end
--			node_storage.update_node_content (a_user_id, a_node_id, a_content)
--		end


end
