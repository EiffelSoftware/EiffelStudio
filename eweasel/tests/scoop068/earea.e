note
	description: "{EAREA} provides an immutable area of memory."
	author: "Mischael Schill"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class
	EAREA

inherit
	PLATFORM
		export {NONE}
			copy
		redefine
			is_equal
		end

	MEMORY_MANAGER_ACCESS
		undefine
			is_equal, copy
		end

create
	default_create,
	copy_from_pointer

feature {NONE} -- Initialization
	copy_from_pointer (a_pointer: POINTER; a_length: INTEGER_32)
			-- Create a new area and copy data from `a_pointer'
		require
			a_length > 0
		local
			l_managed_pointer: separate MANAGED_POINTER
		do
			l_managed_pointer := allocate_memory (a_length)
			anchor := l_managed_pointer
			item := retrieve_item (l_managed_pointer)
			item.memory_copy (a_pointer, a_length)
			count := a_length
		ensure
			count = a_length
			a_pointer.memory_compare (item, a_length)
		end

feature -- Access

	count: INTEGER_32

	item: POINTER
		-- Pointer to position of area in memory

feature -- Access: Platform specific

	read_character (pos: INTEGER): CHARACTER
			-- Read CHARACTER at position `pos'.
		require
			pos_nonnegative: pos >= 0
			valid_position: (pos + Character_8_bytes) <= count
		do
			($Result).memory_copy (item + pos, Character_8_bytes)
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
		do
			if a_other.item = item then
				Result := True
			elseif count = a_other.count then
				Result := a_other.item.memory_compare (a_other.item, count)
			end
		end

feature {NONE} -- Implementation

	anchor: detachable separate MANAGED_POINTER

end
