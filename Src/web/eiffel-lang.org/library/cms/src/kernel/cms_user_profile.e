note
	description: "Summary description for {CMS_USER_PROFILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_PROFILE

inherit
	TABLE_ITERABLE [READABLE_STRING_8, READABLE_STRING_8]

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make (0)
		end

feature -- Access

	item (k: READABLE_STRING_8): detachable READABLE_STRING_8
		do
			Result := items.item (k.as_string_8)
		end

feature -- Change

	force (v: READABLE_STRING_8; k: READABLE_STRING_8)
		do
			items.force (v, k.as_string_8)
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [READABLE_STRING_8, READABLE_STRING_8]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation				

	items: HASH_TABLE [READABLE_STRING_8, STRING_8]

invariant

end
