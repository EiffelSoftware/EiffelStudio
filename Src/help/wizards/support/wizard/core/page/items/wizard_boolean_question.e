note
	description: "Summary description for {WIZARD_BOOLEAN_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_BOOLEAN_QUESTION

inherit
	WIZARD_QUESTION

feature -- Access

	value: BOOLEAN
		deferred
		end

feature -- Element change	

	set_value (v: like value)
		deferred
		end

end
