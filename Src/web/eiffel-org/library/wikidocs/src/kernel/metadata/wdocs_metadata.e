note
	description: "Summary description for {WDOCS_METADATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_METADATA

inherit
	TABLE_ITERABLE [READABLE_STRING_32, READABLE_STRING_GENERAL]

feature -- Access

	item (a_key: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Metadata value associated with `a_key'.
		deferred
		end

	count: INTEGER
			-- Items count.
		deferred
		end

feature -- Element change

	force (a_value: READABLE_STRING_32; a_key: READABLE_STRING_GENERAL)
			-- Associated `a_value' with `a_key'.
		deferred
		end

feature -- Status report

	is_empty: BOOLEAN
			-- No item available?
		do
			Result := count = 0
		end

end
