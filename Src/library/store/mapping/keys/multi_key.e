indexing
	description: "Multiple keys"
	author: "Lionel Moro"
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_KEY

feature -- Initialization

feature -- Access

	hash_code is
		do
		end

feature {NONE} -- Implementation

	items: ARRAY [BASIC_KEY]

end -- class MULTI_KEY
