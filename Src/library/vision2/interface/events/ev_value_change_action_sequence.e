indexing
	description:
		"Action sequence for change of integer value events."
	status: "Generated!"
	keywords: "ev_value_change"
	date: "Generated!"
	revision: "Generated!"

class
	EV_VALUE_CHANGE_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [INTEGER]]
	-- EV_ACTION_SEQUENCE [TUPLE [value: INTEGER]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_value: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_value])
		end
end
