indexing
	description:
		"Action sequence for keyboard events."
	status: "Generated!"
	keywords: "ev_key_string"
	date: "Generated!"
	revision: "Generated!"

class
	EV_KEY_STRING_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [STRING]]
	-- EV_ACTION_SEQUENCE [TUPLE [keystring: STRING]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_keystring: STRING; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_keystring])
		end
end
