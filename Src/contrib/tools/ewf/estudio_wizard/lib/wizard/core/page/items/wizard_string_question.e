note
	description: "Summary description for {WIZARD_STRING_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_STRING_QUESTION

inherit
	WIZARD_QUESTION

feature -- Access

	value: detachable STRING_32
		deferred
		end

feature -- Element change	

	set_value (v: detachable READABLE_STRING_GENERAL)
		deferred
		end

end
