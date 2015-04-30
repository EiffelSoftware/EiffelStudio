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

	nodes_count: INTEGER_64
			-- Count of nodes.
		do
		end

	nodes: LIST[CMS_NODE]
			-- List of nodes.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
			-- List of the `a_count' most recent nodes, starting from `a_lower'.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	node_by_id (a_id: INTEGER_64): detachable CMS_NODE
			-- <Precursor>
		do
		end

	node_author (a_id: like {CMS_NODE}.id): detachable CMS_USER
			-- Node's author. if any.
		do
		end

	node_collaborators (a_id: like {CMS_NODE}.id): LIST [CMS_USER]
			-- Possible list of node's collaborator.
		do
			create {ARRAYED_LIST [CMS_USER]} Result.make (0)
		end

feature -- Node

	new_node (a_node: CMS_NODE)
			-- Add a new node
		do
		end

	delete_node_by_id (a_id: INTEGER_64)
			-- <Precursor>
		do
		end

	update_node (a_node: CMS_NODE)
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
