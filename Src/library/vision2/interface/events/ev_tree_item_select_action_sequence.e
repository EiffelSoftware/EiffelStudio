indexing
	description:
		"Action sequence for tree item selection events."
	status: "Generated!"
	keywords: "ev_tree_item_select"
	date: "Generated!"
	revision: "Generated!"

class
	EV_TREE_ITEM_SELECT_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_TREE_NODE]]
	-- EV_ACTION_SEQUENCE [TUPLE [item: EV_TREE_NODE]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_item: EV_TREE_NODE; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_item])
		end
end
