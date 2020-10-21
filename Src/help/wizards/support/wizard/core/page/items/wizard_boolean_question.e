note
	description: "Summary description for {WIZARD_BOOLEAN_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_BOOLEAN_QUESTION

inherit
	WIZARD_QUESTION


feature {NONE} -- Initialization

	initialize
		do
			create value_change_actions
		end

feature -- Access

	value: BOOLEAN
		deferred
		end

	on_value_changed
			-- `value` changed event.
		do
			value_change_actions.call ([Current])
		end

	value_change_actions: ACTION_SEQUENCE [TUPLE [WIZARD_BOOLEAN_QUESTION]]

feature -- Element change	

	set_value (v: like value)
		deferred
		end

end
