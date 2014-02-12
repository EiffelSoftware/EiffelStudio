note
	description: "[
		Sequences of 32-bit characters, accessible through integer indices
		in a contiguous range.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_32

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create area.make_empty (n)
		end

feature -- Status report

	is_empty: BOOLEAN

	area: SPECIAL [CHARACTER_32]

	set_count (n: INTEGER)
		do

		end

	internal_hash_code: INTEGER

	count: INTEGER
			-- Actual number of characters making up the string

;note
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
