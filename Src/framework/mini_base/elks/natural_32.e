note
	description: "Unsigned integer values coded on 32 bits."
	external_name: "System.UInt32"
	assembly: "mscorlib"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class NATURAL_32

feature -- Access

	item: like Current

feature -- Settings

	set_item (i: like Current)
			-- Make `i' the item value.
		do
			item := i
		ensure
			item_set: item = i
		end

feature -- Status report

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end

feature -- Conversion

	to_character_8: CHARACTER_8
			-- Returns corresponding ASCII character to `item' value.
		do
			Result := item.to_character_8
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
