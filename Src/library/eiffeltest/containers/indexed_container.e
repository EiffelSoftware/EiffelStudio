indexing
	description:
		"Containers that provide index access"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INDEXED_CONTAINER [G] inherit

	BASIC_CONTAINER [G]

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- `i'-th item
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
		deferred
		ensure
			non_void_result: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class INDEXED_CONTAINER

