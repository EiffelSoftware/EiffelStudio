indexing
	description:
		"Action sequence for new container item events."
	status: "Generated!"
	keywords: "ev_new_item"
	date: "Generated!"
	revision: "Generated!"

class
	EV_NEW_ITEM_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
	-- EV_ACTION_SEQUENCE [TUPLE [a_widget: EV_WIDGET]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, action))
		end

	wrapper (a_a_widget: EV_WIDGET; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_a_widget])
		end
end
