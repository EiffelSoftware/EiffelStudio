indexing
	description:
		"Action sequence for proximity in/out events."
	status: "Generated!"
	keywords: "ev_proximity"
	date: "Generated!"
	revision: "Generated!"

class
	EV_PROXIMITY_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE []]
	-- EV_ACTION_SEQUENCE [TUPLE []]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (action))
		end

	wrapper (action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([])
		end
end
