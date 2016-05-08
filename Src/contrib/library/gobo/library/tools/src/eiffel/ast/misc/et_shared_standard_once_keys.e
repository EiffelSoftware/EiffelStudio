note

	description:

		"Shared Eiffel standard once keys"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_SHARED_STANDARD_ONCE_KEYS

feature -- Access

	standard_once_keys: ET_STANDARD_ONCE_KEYS
			-- Shared standard once keys
		once
			create Result
		ensure
			standard_once_keys_not_void: Result /= Void
		end

end
