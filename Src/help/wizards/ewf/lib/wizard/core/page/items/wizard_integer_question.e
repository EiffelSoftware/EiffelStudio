note
	description: "Summary description for {WIZARD_INTEGER_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTEGER_QUESTION

inherit
	WIZARD_QUESTION

feature -- Access

	value: INTEGER
		deferred
		end

feature -- Element change	

	set_value (v: like value)
		deferred
		end

end
