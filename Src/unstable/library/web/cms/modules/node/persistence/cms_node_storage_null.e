note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_STORAGE_NULL

inherit
	CMS_NODE_STORAGE_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create error_handler.make
		end

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.		

feature -- Access: node

	nodes_count: NATURAL_64
			-- Count of nodes.
		do
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	node_revisions (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Revisions of node `a_node'.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	trashed_nodes (a_user: detachable CMS_USER): LIST [CMS_NODE]
			-- <Precursor>.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	recent_nodes (a_offset: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of the `a_count' most recent nodes, starting from `a_offset'.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	recent_nodes_of_type (a_node_type: CMS_CONTENT_TYPE; a_offset: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- Recent `a_count` nodes of type `a_node_type` with an offset of `a_offset`.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	recent_published_nodes_of_type (a_node_type: CMS_CONTENT_TYPE; a_offset: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	recent_node_changes_before (a_offset: INTEGER; a_count: INTEGER; a_date: DATE_TIME): LIST [CMS_NODE]
			-- List of recent changes, before `a_date', according to `params' settings.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- <Precursor>
		do
		end

	node_by_id_and_revision (a_node_id, a_revision: INTEGER_64): detachable CMS_NODE
			-- <Precuror>
		do
		end

feature -- Node

	new_node (a_node: CMS_NODE)
			-- Add a new node
		do
		end

	delete_node_base (a_node: CMS_NODE)
			-- <Precursor>
		do
		end

	update_node (a_node: CMS_NODE)
			-- <Precursor>
		do
		end

	trash_node_by_id (a_id: INTEGER_64)
			-- <Precursor>
		do
		end

	restore_node_by_id (a_id: INTEGER_64)
			-- <Precursor>
		do
		end

--	update_node_title (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
--			-- <Precursor>
--		do
--		end

--	update_node_summary (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
--			-- <Precursor>
--		do
--		end

--	update_node_content (a_user_id: like {CMS_NODE}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
--			-- <Precursor>
--		do
--		end		

feature -- Helpers

	fill_node (a_node: CMS_NODE)
			-- Fill `a_node' with extra information from database.
			-- i.e: specific to each content type data.
		do
		end

end
