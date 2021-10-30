note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIBRARY_DATABASE_QUERY

inherit
	TABLE_ITERABLE [ITERABLE [READABLE_STRING_32], LIBRARY_INFO]

feature {NONE} -- Initialization

	database: LIBRARY_DATABASE

	pattern: READABLE_STRING_32

feature -- Access

	pattern_has_wildchar: BOOLEAN

	items: HASH_TABLE [ITERABLE [READABLE_STRING_32], LIBRARY_INFO]
			-- Class names indexed by library information object.

	new_cursor: TABLE_ITERATION_CURSOR [ITERABLE [READABLE_STRING_32], LIBRARY_INFO]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Execution

	execute
		deferred
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
