note
	description: "Containers that provide index access"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INDEXED_CONTAINER [G] inherit

	BASIC_CONTAINER [G]

feature -- Access

	item alias "@" (i: INTEGER): G
			-- `i'-th item
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
		deferred
		ensure
			non_void_result: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
