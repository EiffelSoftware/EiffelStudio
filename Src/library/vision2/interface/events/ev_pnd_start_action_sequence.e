indexing
	description:
		"Action sequence for pick and drop transport start events."
	status: "Generated!"
	keywords: "ev_pnd_start"
	date: "Generated!"
	revision: "Generated!"

class
	EV_PND_START_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]]
	-- EV_ACTION_SEQUENCE [TUPLE [x, y: INTEGER]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, ?, action))
		end

	wrapper (a_x: INTEGER; a_y: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_x, a_y])
		end
end
