indexing
	description:
		"Action sequence for multi column list column click events."
	status: "Generated!"
	keywords: "ev_column_title_click"
	date: "Generated!"
	revision: "Generated!"

class
	EV_COLUMN_TITLE_CLICK_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [INTEGER]]
	-- EV_ACTION_SEQUENCE [TUPLE [a_column: INTEGER]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_a_column: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_a_column])
		end
end
