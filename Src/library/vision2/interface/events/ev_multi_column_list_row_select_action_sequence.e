indexing
	description:
		"Action sequence for multi column list row selection events."
	status: "Generated!"
	keywords: "ev_multi_column_list_row_select"
	date: "Generated!"
	revision: "Generated!"

class
	EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_MULTI_COLUMN_LIST_ROW]]
	-- EV_ACTION_SEQUENCE [TUPLE [item: EV_MULTI_COLUMN_LIST_ROW]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_item: EV_MULTI_COLUMN_LIST_ROW; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_item])
		end
end
