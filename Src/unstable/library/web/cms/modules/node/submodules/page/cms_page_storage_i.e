note
	description: "Summary description for {CMS_PAGE_STORAGE_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_PAGE_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	children (a_node: CMS_NODE): detachable LIST [CMS_NODE]
			-- Children of node `a_node'.
			-- note: this is the partial version of the nodes.
		deferred
		end

	available_parents_for_node (a_node: CMS_NODE): LIST [CMS_NODE]
			-- Given the node `a_node', return the list of possible parent nodes id
		deferred
		ensure
			a_node_excluded: across Result as ic all not a_node.same_node (ic.item) end
		end

end
