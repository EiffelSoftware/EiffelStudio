note
	description: "Various constants used to represent abstract types used in {REFFLECTOR} and {OBJECT_PROXY}."
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTOR_CONSTANTS

feature -- Access

	none_type: INTEGER = -2
			-- Type ID representation for NONE.

	pointer_type: INTEGER = 0

	reference_type: INTEGER = 1

	character_8_type, character_type: INTEGER = 2

	boolean_type: INTEGER = 3

	integer_32_type, integer_type: INTEGER = 4

	real_32_type, real_type: INTEGER = 5

	real_64_type, double_type: INTEGER = 6

	expanded_type: INTEGER = 7

	bit_type: INTEGER = 8

	integer_8_type: INTEGER = 9

	integer_16_type: INTEGER = 10

	integer_64_type: INTEGER = 11

	character_32_type, wide_character_type: INTEGER = 12

	natural_8_type: INTEGER = 13

	natural_16_type: INTEGER = 14

	natural_32_type: INTEGER = 15

	natural_64_type: INTEGER = 16

	min_predefined_type: INTEGER = -2
	max_predefined_type: INTEGER = 16

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
