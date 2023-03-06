note
	description:
		"Enables Eiffel generic classes to hold references on SYSTEM_OBJECT classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_CELL [G -> detachable SYSTEM_OBJECT]

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	put

feature -- Access

	item: G
			-- Content of cell.

feature -- Element change

	put, replace (v: like item)
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			if attached item as l_item then
				Result := l_item.get_hash_code.hash_code
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_item, l_other: G
		do
			l_item := item
			l_other := other.item
			Result := l_item = l_other
			if not Result then
				Result := l_item /= Void and then l_item.equals_object (l_other)
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class CLI_CELL
