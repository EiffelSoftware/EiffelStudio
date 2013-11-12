note
	description: "A flat class containing all basic types."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	FLAT_CLASS

inherit

	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create
			-- Initialization for `Current'.
		do
			integer_8_max := integer_8_max.max_value
			integer_8_min := integer_8_min.min_value
			integer_16_max := integer_16_max.max_value
			integer_16_min := integer_16_min.min_value
			integer_32_max := integer_32_max.max_value
			integer_32_min := integer_32_min.min_value
			integer_64_max := integer_64_max.max_value
			integer_64_min := integer_64_min.min_value
			natural_8_max := natural_8_max.max_value
			natural_8_min := natural_8_min.min_value
			natural_16_max := natural_16_max.max_value
			natural_16_min := natural_16_min.min_value
			natural_32_max := natural_32_max.max_value
			natural_32_min := natural_32_min.min_value
			natural_64_max := natural_64_max.max_value
			natural_64_min := natural_64_min.min_value
			character_8_max := character_8_max.max_value.to_character_8
			character_8_min := character_8_min.min_value.to_character_8
			character_32_max := character_32_max.max_value.to_character_32
			character_32_min := character_32_min.min_value.to_character_32
			real_32_max := real_32_max.max_value
			real_32_min := real_32_min.min_value
			real_64_max := real_64_max.max_value
			real_64_min := real_64_min.min_value
			boolean := True
			pointer := default_pointer
		end

feature -- Access

	integer_8_max: INTEGER_8

	integer_8_min: INTEGER_8

	integer_16_max: INTEGER_16

	integer_16_min: INTEGER_16

	integer_32_max: INTEGER_32

	integer_32_min: INTEGER_32

	integer_64_max: INTEGER_64

	integer_64_min: INTEGER_64

	natural_8_max: NATURAL_8

	natural_8_min: NATURAL_8

	natural_16_max: NATURAL_16

	natural_16_min: NATURAL_16

	natural_32_max: NATURAL_32

	natural_32_min: NATURAL_32

	natural_64_max: NATURAL_64

	natural_64_min: NATURAL_64

	character_8_max: CHARACTER_8

	character_8_min: CHARACTER_8

	character_32_max: CHARACTER_32

	character_32_min: CHARACTER_32

	real_32_max: REAL_32

	real_32_min: REAL_32

	real_64_max: REAL_64

	real_64_min: REAL_64

	boolean: BOOLEAN

	pointer: POINTER

end
