note
	description: "Summary description for {WIZARD_STRING_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_STRING_QUESTION

inherit
	WIZARD_QUESTION
		redefine
			make
		end

feature {NONE} -- Initialization

	make (a_id: like id; a_title: READABLE_STRING_GENERAL; a_optional_description: detachable READABLE_STRING_GENERAL)
		do
			Precursor (a_id, a_title, a_optional_description)
		end

	initialize
		do
			create value_change_actions
		end

feature -- Access

	value: detachable STRING_32
		deferred
		end

	on_value_changed
			-- `value` changed event.
		do
			value_change_actions.call ([Current])
		end

	value_change_actions: ACTION_SEQUENCE [TUPLE [WIZARD_STRING_QUESTION]]

feature -- Element change	

	set_value (v: detachable READABLE_STRING_GENERAL)
		deferred
		end

end
