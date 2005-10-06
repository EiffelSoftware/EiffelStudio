indexing
	description: "String - Integer/Natural conversion overflow checker"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OVERFLOW_CHECKER
	
inherit
	INTEGER_NATURAL_INFORMATION

create
	make

feature{NONE} -- Initialization

	make is
			-- 
		do
			create integer_overflow_state1.make (1, type_count * 2)
			create integer_overflow_state2.make (1, type_count * 2)			
			
			integer_overflow_state1.put (({INTEGER_8}.max_value // 10).to_natural_64, 1)
			integer_overflow_state2.put (({INTEGER_8}.max_value \\ 10).to_natural_64, 1)
			integer_overflow_state1.put (({INTEGER_16}.max_value // 10).to_natural_64, 2)
			integer_overflow_state2.put (({INTEGER_16}.max_value \\ 10).to_natural_64, 2)
			integer_overflow_state1.put (({INTEGER}.max_value // 10).to_natural_64, 3)
			integer_overflow_state2.put (({INTEGER}.max_value \\ 10).to_natural_64, 3)
			integer_overflow_state1.put (({INTEGER_64}.max_value // 10).to_natural_64, 4)
			integer_overflow_state2.put (({INTEGER_64}.max_value \\ 10).to_natural_64, 4)

			integer_overflow_state1.put ((-({INTEGER_8}.min_value // 10)).to_natural_64, 5)
			integer_overflow_state2.put ((-({INTEGER_8}.min_value \\ 10)).to_natural_64, 5)		
			integer_overflow_state1.put ((-({INTEGER_16}.min_value // 10)).to_natural_64, 6)
			integer_overflow_state2.put ((-({INTEGER_16}.min_value \\ 10)).to_natural_64, 6)		
			integer_overflow_state1.put ((-({INTEGER}.min_value // 10)).to_natural_64, 7)
			integer_overflow_state2.put ((-({INTEGER}.min_value \\ 10)).to_natural_64, 7)		
			integer_overflow_state1.put ((-({INTEGER_64}.min_value // 10)).to_natural_64, 8)
			integer_overflow_state2.put ((-({INTEGER_64}.min_value \\ 10)).to_natural_64, 8)

			create natural_overflow_state1.make (1, type_count)
			create natural_overflow_state2.make (1, type_count)
			
			natural_overflow_state1.put (({NATURAL_8}.max_value // 10).to_natural_64, 1)
			natural_overflow_state2.put (({NATURAL_8}.max_value \\ 10).to_natural_64, 1)
			natural_overflow_state1.put (({NATURAL_16}.max_value // 10).to_natural_64, 2)
			natural_overflow_state2.put (({NATURAL_16}.max_value \\ 10).to_natural_64, 2)
			natural_overflow_state1.put (({NATURAL_32}.max_value // 10).to_natural_64, 3)
			natural_overflow_state2.put (({NATURAL_32}.max_value \\ 10).to_natural_64, 3)
			natural_overflow_state1.put (({NATURAL_64}.max_value // 10).to_natural_64, 4)
			natural_overflow_state2.put (({NATURAL_64}.max_value \\ 10).to_natural_64, 4)			
		
			create integer_string_length.make (1, type_count * 2)
			create natural_string_length.make (1, type_count)

			integer_string_length.put ({INTEGER_8}.max_value.out.count - 1  , 1)
			integer_string_length.put ({INTEGER_16}.max_value.out.count - 1 , 2)
			integer_string_length.put ({INTEGER}.max_value.out.count - 1    , 3)
			integer_string_length.put ({INTEGER_64}.max_value.out.count - 1 , 4)
			integer_string_length.put ({INTEGER_8}.min_value.out.count - 2  , 5)
			integer_string_length.put ({INTEGER_16}.min_value.out.count - 2 , 6)
			integer_string_length.put ({INTEGER}.min_value.out.count - 2    , 7)
			integer_string_length.put ({INTEGER_64}.min_value.out.count - 2 , 8)
			
			natural_string_length.put ({NATURAL_8}.max_value.out.count  - 1, 1)
			natural_string_length.put ({NATURAL_16}.max_value.out.count - 1, 2)
			natural_string_length.put ({NATURAL_32}.max_value.out.count - 1, 3)
			natural_string_length.put ({NATURAL_64}.max_value.out.count - 1, 4)									
		end

	integer_string_length: ARRAY [INTEGER]
	natural_string_length: ARRAY [INTEGER]
	integer_overflow_state1: ARRAY [like max_natural_type] 		
	integer_overflow_state2: ARRAY [like max_natural_type]	
	natural_overflow_state1: ARRAY [like max_natural_type] 		
	natural_overflow_state2: ARRAY [like max_natural_type]
			-- Arrays to check conversion overflow

feature 
	
	will_integer_overflow (part1: like max_natural_type; part2: like max_natural_type; type: INTEGER; sign: INTEGER): BOOLEAN is
			-- Will `part1' * 10 + `part2' with `sign' overflow 
			-- if we convert it to an integer of `type'?
		require
			integer_type_valid: integer_type_valid (type)
		local
			l_index: INTEGER
		do
			l_index := sign * 4 + type
			Result := (part1 > integer_overflow_state1.item (l_index)) or
					  ((part1 = integer_overflow_state1.item (l_index)) and
  			          (part2 > integer_overflow_state2.item (l_index)))
		end
		
	will_natural_overflow (part1: like max_natural_type; part2: like max_natural_type; type: INTEGER;	sign: INTEGER): BOOLEAN is
			-- Will `part1' * 10 + `part2' with `sign' overflow 
			-- if we convert it to an natural of `type'?
		require
			natural_type_valid: natural_type_valid (type)
		local
			l_index: INTEGER
		do
			l_index := type - type_integer_natural_separator
			if sign = 1 then
				Result := (part1 > 0) or (part2 > 0)
			else
				
				Result := (part1 > natural_overflow_state1.item (l_index)) or
							((part1 = natural_overflow_state1.item (l_index)) and 
							(part2 > natural_overflow_state2.item (l_index)))
			end
		end
		
	will_overflow (part1: like max_natural_type; part2: like max_natural_type; type: INTEGER;	sign: INTEGER): BOOLEAN is
			-- Will `part1' * 10 + `part2' with `sign' overflow 
			-- if we convert it to an number of `type'?			
		require
			type_valid: type_valid (type)		
		do	
			if type < type_integer_natural_separator then
				Result := will_integer_overflow (part1, part2, type, sign)
			else
				Result := will_natural_overflow (part1, part2, type, sign)				
			end
		end
		
	can_new_digit_be_added (part1: like max_natural_type; part1_length:INTEGER; type: INTEGER; sign: INTEGER): BOOLEAN is
			-- Can we add another digit to number `part1' * 10 + `part2' with `sign', of `type'
			-- without leaving it overflowed?
			-- `a_part1_length' is length of string representation of `part1'.
		require
			type_valid: type_valid (type)
		local
			l_index: INTEGER
			l_length: INTEGER
			l_count: INTEGER
		do
			if type >type_integer_natural_separator then
				l_index := type - type_integer_natural_separator
				l_length := natural_string_length.item (l_index)
			else
				l_index := type + sign * 4
				l_length := integer_string_length.item (l_index)
			end
			l_count := part1.out.count
		
			Result := part1_length < l_length
		end
end
