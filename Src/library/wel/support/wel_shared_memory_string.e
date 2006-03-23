indexing
	description: "Represents windows shared memory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_MEMORY_STRING

inherit
	WEL_SHARED_MEMORY

create
	make_from_handle,
	make_from_string

feature -- Initialization

	make_from_string (a_string: STRING_GENERAL) is
			-- Create `Current' from `a_string'.
		do
			create internal_string.make (a_string)
			make_from_handle (global_alloc (gmem_moveable, internal_string.capacity))
			lock
			item.memory_copy (internal_string.item, internal_string.capacity)
			unlock
		end

feature -- Access

	last_string: STRING_32
			-- String created from shared memory.
			-- Only valid after a call to `retrieve_string'
			-- Note: Changes to this object will not be
			-- reflected in the shared memory

feature -- Element change

	retrieve_string is
		do
			lock
			check
				memory_locked: accessible
			end
			last_string := (create {WEL_STRING}.share_from_pointer (item)).string
			unlock
		end

feature {NONE} -- Access

	internal_string: WEL_STRING;
			-- Wrapper around non-moveable buffer.

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

end -- class WEL_SHARED_MEMORY

