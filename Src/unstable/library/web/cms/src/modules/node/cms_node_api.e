note
	description: "Summary description for {CMS_NODE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create
	make

feature -- Access: Node

	nodes_count: INTEGER_64
		do
			Result := storage.nodes_count
		end

	nodes: LIST [CMS_NODE]
			-- List of nodes.
		do
			Result := storage.nodes
		end

	recent_nodes (a_offset, a_rows: INTEGER): LIST [CMS_NODE]
			-- List of the `a_rows' most recent nodes starting from  `a_offset'.
		do
			Result := storage.recent_nodes (a_offset, a_rows)
		end

	node (a_id: INTEGER_64): detachable CMS_NODE
			-- Node by ID.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			Result := storage.node_by_id (a_id)
		end

feature -- Change: Node

	new_node (a_node: CMS_NODE)
			-- Add a new node `a_node'
		require
			no_id: not a_node.has_id
		do
			storage.new_node (a_node)
		end

	delete_node (a_node: CMS_NODE)
			-- Delete `a_node'.
		do
			if a_node.has_id then
				storage.delete_node (a_node)
			end
		end

	update_node (a_node: CMS_NODE)
			-- Update node `a_node' data.
		do
			storage.update_node (a_node)
		end

	update_node_title (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_title: READABLE_STRING_32)
			-- Update node title, with user identified by `a_id', with node id `a_node_id' and a new title `a_title'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_title (a_user_id, a_node_id, a_title)
		end

	update_node_summary (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_summary: READABLE_STRING_32)
			-- Update node summary, with user identified by `a_user_id', with node id `a_node_id' and a new summary `a_summary'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_summary (a_user_id, a_node_id, a_summary)
		end

	update_node_content (a_user_id: like {CMS_USER}.id; a_node_id: like {CMS_NODE}.id; a_content: READABLE_STRING_32)
			-- Update node content, with user identified by `a_user_id', with node id `a_node_id' and a new content `a_content'.
		do
			debug ("refactor_fixme")
				fixme ("Check preconditions")
			end
			storage.update_node_content (a_user_id, a_node_id, a_content)
		end


end
