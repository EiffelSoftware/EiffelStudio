note
	description:
		"Containers that have a current position"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACTIVE_CONTAINER [G] inherit

	BASIC_CONTAINER [G]

feature -- Access

	item: G
			-- Current item
		require
			not_empty: not is_empty
		deferred
		ensure
			non_void_result: Result /= Void
		end

	i_th alias "[]" (i: INTEGER): like item assign put_i_th
			-- `i'-th item
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
		deferred
		ensure
			index_unchanged: index = old index
		end

	index: INTEGER
			-- Current index
		deferred
		end

feature -- Element change

	put_i_th (v: like i_th; i: INTEGER_32)
			-- Replace `i'-th entry, if in index interval, by `v'.
		deferred
		end

feature -- Status setting

	go_i_th (i: INTEGER)
			-- Go to `i'-th position.
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
		deferred
		ensure
			index_set: index = i
		end

invariant

	index_in_range: not is_empty implies valid_index (index)

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ACTIVE_CONTAINER

