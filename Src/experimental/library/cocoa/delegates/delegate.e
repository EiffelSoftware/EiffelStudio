note
	description: "Summary description for {DELEGATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DELEGATE

inherit
	ANY
		undefine
			copy
		end

feature -- Access


feature {NS_OBJECT}

	item: POINTER
		deferred
		end

end
