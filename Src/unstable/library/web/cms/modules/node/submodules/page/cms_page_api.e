note
	description: "API to handle nodes of type page. Extends the node API."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_API

inherit
	CMS_MODULE_API
		rename
			make as make_with_cms_api
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_node_api: CMS_NODE_API)
			-- (from CMS_MODULE_API)
			-- (export status {NONE})
		do
			node_api := a_node_api
			make_with_cms_api (a_api)
		end

	initialize
			-- <Precursor>
		do
			Precursor

----					l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_PAGE_EXTENSION}.make (l_node_api, l_sql_node_storage))

				-- Create the node storage for type blog
			if attached storage.as_sql_storage as l_storage_sql then
				create {CMS_PAGE_STORAGE_SQL} page_storage.make (l_storage_sql)
			else
				create {CMS_PAGE_STORAGE_NULL} page_storage.make
			end

			initialize_node_types
		end

	initialize_node_types
			-- Initialize content type system.
		local
			ct: CMS_PAGE_NODE_TYPE
		do
				-- Initialize node content types.			
			create ct
			page_content_type := ct
			node_api.add_node_type (ct)
			node_api.add_node_type_webform_manager (create {CMS_PAGE_NODE_TYPE_WEBFORM_MANAGER}.make (ct, Current))
		end

feature {CMS_API_ACCESS, CMS_MODULE, CMS_API} -- Restricted access		

	node_api: CMS_NODE_API

	page_content_type: CMS_PAGE_NODE_TYPE

feature -- Access

	pages: LIST [CMS_PAGE]
			-- All pages.
		do
			Result := nodes_to_pages (node_api.nodes_of_type (page_content_type))
		end

	pages_with_title (a_title: READABLE_STRING_GENERAL): LIST [CMS_PAGE]
			-- List of pages with title `a_title`.
		do
			Result := nodes_to_pages (node_api.nodes_of_type_with_title (page_content_type, a_title))
		end

feature -- Access: page/book outline

	children (a_node: CMS_NODE): detachable LIST [CMS_NODE]
			-- Children of node `a_node'.
			-- note: this is the partial version of the nodes.
		do
			Result := page_storage.children (a_node)
		end

	available_parents_for_node (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Potential parent nodes for node `a_node'.
			-- Ensure no cycle exists.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
			across page_storage.available_parents_for_node (a_node) as ic loop
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
				attached {CMS_PAGE} node_api.full_node (a_child) as l_child_page and then
				attached l_child_page.parent as l_parent
			then
				if l_parent.same_node (a_node) then
					Result := True
				else
					Result := is_node_a_parent_of (a_node, l_parent)
				end
			end
		end

feature -- Conversion

	full_page_node (a_page: CMS_PAGE): CMS_PAGE
			-- If `a_page' is partial, return the full page node from `a_page',
			-- otherwise return directly `a_page'.
		require
			a_page_set: a_page /= Void
		do
			if attached {CMS_PAGE} node_api.full_node (a_page) as l_full_page then
				Result := l_full_page
			else
				Result := a_page
			end
		end

feature -- Commit

	save_page (a_page: CMS_PAGE)
		do
			node_api.save_node (a_page)
		end

	import_page (a_page: CMS_PAGE)
			-- Save `a_page` without changing the modification date.
		do
			node_api.import_node (a_page)
		end

feature {CMS_MODULE} -- Access nodes storage.

	page_storage: CMS_PAGE_STORAGE_I

feature {NONE} -- Helpers

	nodes_to_pages (a_nodes: LIST [CMS_NODE]): ARRAYED_LIST [CMS_PAGE]
			-- Convert list of nodes into a list of page when possible.
		do
			create {ARRAYED_LIST [CMS_PAGE]} Result.make (a_nodes.count)

			if attached node_api as l_node_api then
				across
					a_nodes as ic
				loop
					if attached {CMS_PAGE} l_node_api.full_node (ic.item) as l_page then
						Result.force (l_page)
					end
				end
			end
		end

end
