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
		end

feature -- Overflow checking
		
	will_overflow (part1: like max_natural_type; part2: like max_natural_type; type: INTEGER;	sign: INTEGER): BOOLEAN is
			-- Will `part1' * 10 + `part2' with `sign' overflow 
			-- if we convert it to an number of `type'?			
		require
			type_valid: type_valid (type)
		local
			l_index: INTEGER
		do	
			if type = type_no_limitation then
				Result := False
			else	
				if (type = type_integer_8) or
				   (type = type_integer_16) or
				   (type = type_integer_32) or
				   (type = type_integer_64)
				then
					l_index := sign * 4 + type
					Result := (part1 > integer_overflow_state1.item (l_index)) or
							  ((part1 = integer_overflow_state1.item (l_index)) and
	  				          (part2 > integer_overflow_state2.item (l_index)))
				else
					l_index := type - type_integer_natural_separator
					if sign = 1 then
						Result := (part1 > 0) or (part2 > 0)
					else
					
						Result := (part1 > natural_overflow_state1.item (l_index)) or
								  ((part1 = natural_overflow_state1.item (l_index)) and 
								  (part2 > natural_overflow_state2.item (l_index)))
				end	
			end					
		end
	end

feature{NONE} -- Implementation

	integer_overflow_state1: ARRAY [like max_natural_type] 		
	integer_overflow_state2: ARRAY [like max_natural_type]	
	natural_overflow_state1: ARRAY [like max_natural_type] 		
	natural_overflow_state2: ARRAY [like max_natural_type]
			-- Arrays to check conversion overflow
			
end
