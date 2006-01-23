indexing
	description: "Abstract notions of a Windows data structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_STRUCTURE

inherit
	WEL_ANY
		redefine
			copy, is_equal
		end

feature {NONE} -- Initialization

	make is
			-- Allocate `item'
		local
			a_default_pointer: POINTER
		do
			item := item.memory_calloc (1, structure_size)
			if item = a_default_pointer then
					-- Memory allocation problem
				(create {EXCEPTIONS}).raise ("No more memory")
			end
			shared := False
		ensure
			not_shared: not shared
		end

feature -- Basic operations

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		local
			a_default_pointer: POINTER
		do
			if shared or item = a_default_pointer then
					-- We need to allocate a block of memory as we don't want other
					-- instances of WEL_STRUCTURE sharing the structure to get the
					-- copied item from `other'.
				item := item.memory_calloc (1, structure_size)
				if item = a_default_pointer then
						-- Memory allocation problem
					(create {EXCEPTIONS}).raise ("No more memory")
				end
				shared := False
			end
			memory_copy (other.item, structure_size)
		end
		
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := item.memory_compare (other.item, structure_size)
		end

	memory_copy (source_pointer: POINTER; length: INTEGER) is
			-- Copy `length' bytes from `source_pointer' to `item'.
		require
			length_small_enough: length <= structure_size
			length_large_enough: length > 0
			exists: exists
		do
			check
				source_pointer_exists: source_pointer /= default_pointer
			end
			item.memory_copy (source_pointer, length)
		end

	initialize is
			-- Fill Current with zeros.
		require
			exists: exists
		do
			initialize_with_character ('%U')
		end

	initialize_with_character (a_character: CHARACTER) is
			-- Fill current with `a_character'.
		require
			exists: exists
		do
			item.memory_set (a_character.code, structure_size)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		deferred
		ensure
			positive_result: Result > 0
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'
		local
			a_default_pointer: POINTER
		do
			if item /= a_default_pointer then
				item.memory_free
				item := a_default_pointer
			end
		end

feature {NONE} -- Externals

	c_calloc (a_num, a_size: INTEGER): POINTER is
			-- C calloc
		obsolete
			"Use `memory_calloc' from POINTER class instead."
		do
			Result := Result.memory_calloc (a_num, a_size)
		end

	c_free (ptr: POINTER) is
			-- C free
		obsolete
			"Use `memory_free' from POINTER class instead."
		do
			ptr.memory_free
		end

	c_memcpy (destination, source: POINTER; count: INTEGER) is
			-- C memcpy
		obsolete
			"Use `memory_free' from POINTER class instead."
		do
			destination.memory_copy (source, count)
		end

	c_enomem is
			-- Raise a "No more memory" exception.
		obsolete
			"Use facility of EXCEPTIONS class instead to raise %"No more memory%" exception"
		do
			(create {EXCEPTIONS}).raise ("No more memory")
		end

	c_memset (destination: POINTER; filling_char: CHARACTER; count: INTEGER) is
			-- C function 
		obsolete
			"Use `memory_set' from POINTER class instead."
		do
			destination.memory_set (filling_char.code, count)
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




end -- class WEL_STRUCTURE

