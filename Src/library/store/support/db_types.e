note
	description: "Constants to identify types of entities."
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TYPES

feature -- Access

	unknown_type: INTEGER = -1
			-- Unknown type

	null_type: INTEGER = 0
			-- Null type

	string_type: INTEGER = 1
			-- String Eiffel type

	string_32_type: INTEGER = 2
			-- String Eiffel type

	integer_32_type: INTEGER = 3
			-- Integer Eiffel type

	integer_16_type: INTEGER = 4
			-- Integer Eiffel type

	integer_64_type: INTEGER = 5
			-- Integer Eiffel type

	date_type: INTEGER = 6
			-- Datetime Eiffel type

	time_type: INTEGER = 7
			-- Time Eiffel type

   	real_32_type: INTEGER = 8
			-- Real Eiffel type

	real_64_type: INTEGER = 9
			-- Float Eiffel type

	boolean_type: INTEGER = 10
			-- Boolean Eiffel type

	character_type: INTEGER = 11
			-- Character Eiffel type

	decimal_type: INTEGER = 12
			-- Decimal type

	binary_type: INTEGER = 13
			-- Binary type

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
