note
	description: "Summary description for {WIZARD_DIRECTORY_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DIRECTORY_QUESTION

inherit
	WIZARD_QUESTION

feature -- Access

	value: detachable PATH
		deferred
		end

feature -- Element change	

	set_value (v: detachable PATH)
		deferred
		end


end
