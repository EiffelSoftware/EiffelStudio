note
	description: "Integer values"
	external_name: "System.Int32"
	assembly: "mscorlib"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class INTEGER_32

inherit
	COMPARABLE

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

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current integer less than `other'?
		do
		end

feature -- Basic operations

	plus alias "+" (other: INTEGER_32): INTEGER_32
			-- Sum with `other'
		do
		end

	minus alias "-" (other: INTEGER_32): INTEGER_32
			-- Result of subtracting `other'
		do
		end

	product alias "*" (other: INTEGER_32): INTEGER_32
			-- Product by `other'
		do
		end

	quotient alias "/" (other: INTEGER_32): REAL_64
			-- Division by `other'
		do
		end

	identity alias "+": INTEGER_32
			-- Unary plus
		do
		end

	opposite alias "-": INTEGER_32
			-- Unary minus
		do
		end

	integer_quotient alias "//" (other: INTEGER_32): INTEGER_32
			-- Integer division of Current by `other'
		do
		end

	integer_remainder alias "\\" (other: INTEGER_32): INTEGER_32
			-- Remainder of the integer division of Current by `other'
		do
		end

	power alias "^" (other: REAL_64): REAL_64
			-- Integer power of Current by `other'
		do
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
