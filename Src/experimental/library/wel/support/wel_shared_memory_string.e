note
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
	make_from_string,
	make_from_string_with_newline_conversion

feature -- Initialization

	make_from_string (a_string: READABLE_STRING_GENERAL)
			-- Create `Current' from `a_string'.
		require
			a_string: a_string /= Void
		local
			l_internal_string: like internal_string
		do
			create l_internal_string.make (a_string)
				-- Keep a GC reference to allocated block of memory
			internal_string := l_internal_string
			make_from_handle (global_alloc (gmem_moveable, l_internal_string.capacity))
			lock
			item.memory_copy (l_internal_string.item, l_internal_string.capacity)
			unlock
		end

	make_from_string_with_newline_conversion (a_string: READABLE_STRING_GENERAL)
			-- Create `Current' from `a_string' guaranteeing that all newline (linefeed) characters '%N'
			-- are prepended with a carriage return character '%R'.
		require
			a_string: a_string /= Void
		local
			l_internal_string: like internal_string
		do
			create l_internal_string.make_with_newline_conversion (a_string)
				-- Keep a GC reference to allocated block of memory
			internal_string := l_internal_string
			make_from_handle (global_alloc (gmem_moveable, l_internal_string.capacity))
			lock
			item.memory_copy (l_internal_string.item, l_internal_string.capacity)
			unlock
		end

feature -- Access

	last_string: detachable STRING_32
			-- String created from shared memory.
			-- Only valid after a call to `retrieve_string'
			-- Note: Changes to this object will not be
			-- reflected in the shared memory

feature -- Element change

	retrieve_string
			-- Set `last_string' to contents of shared memory.
		do
			lock
			check
				memory_locked: accessible
			end
			last_string := (create {WEL_STRING}.share_from_pointer (item)).string
			unlock
		ensure
			last_string_set: last_string /= Void
		end

	retrieve_string_discarding_carriage_return
			-- Set `last_string' to contents of shared memory discarding carriage return characters.
		do
			lock
			check
				memory_locked: accessible
			end
			last_string := (create {WEL_STRING}.share_from_pointer (item)).string_discarding_carriage_return
			unlock
		ensure
			last_string_set: last_string /= Void
		end

feature {NONE} -- Access

	internal_string: detachable WEL_STRING;
			-- Wrapper around non-moveable buffer.

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class WEL_SHARED_MEMORY

