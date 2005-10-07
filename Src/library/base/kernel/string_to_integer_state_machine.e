indexing
	description: "State machine to do string to integer/natural transition"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TO_INTEGER_STATE_MACHINE
	
inherit
	INTEGER_NATURAL_INFORMATION
	
create 
	make

feature{NONE} -- Initialization

	make is
			-- 
		do
			reset (type_no_limitation)
		end
		
feature	-- State machine setting

	reset (type: INTEGER) is
			-- Reset this state machine to initial state.
			-- Always call this feature before every new parsing.
		require
			type_valid: type_valid (type)			
		do
			last_state := state_0
			overflowed := False
			part1 := 0
			part1_length := 0			
			part2 := 0
			sign := 0
			trailing_white_spaces_acceptable := True
			leading_white_spaces_acceptable := True
			conversion_type := type
		ensure
			last_state_set: last_state = state_0
			overflowed_set: not overflowed
			part1_set: part1 = 0
			part2_set: part2 = 0
			part1_length_set: part1_length = 0			
			sign_set: sign = 0
			trailing_white_spaces_acceptable_set:
				trailing_white_spaces_acceptable
			leading_white_spaces_acceptable_set:
				leading_white_spaces_acceptable
			conversion_type_set: conversion_type = type
		end
	
feature -- Status setting
		
	set_trailing_white_spaces_acceptable (b: BOOLEAN) is
			-- Set `trailing_white_spaces_acceptable' to `b'.
		require
			state_machine_on_valid_state: last_state /= state_3
		do
			trailing_white_spaces_acceptable := b
		ensure
			trailing_white_spaces_acceptable_set: 
				trailing_white_spaces_acceptable = b
		end
		
	set_leading_white_spaces_acceptable (b: BOOLEAN) is
			-- Set `leading_white_spaces_acceptable' to `b'.
		require
			state_machine_on_valid_state: last_state /= state_0
		do
			leading_white_spaces_acceptable := b
		ensure
			leading_white_spaces_acceptable_set: 
				leading_white_spaces_acceptable = b
		end	
					
feature -- Status reporting

	stop_position: INTEGER
		-- Position where last `parse' stopped.
		
	trailing_white_spaces_acceptable: BOOLEAN
		-- Are trailing white spaces acceptable?
		
	leading_white_spaces_acceptable: BOOLEAN
		-- Are leading white spaces acceptable?

	character_count: INTEGER
		-- Number of characters stored in `char_buffer'

	last_state: INTEGER
		-- Last state of this state machine
	
	too_large: BOOLEAN is
			-- Is number overflowed because it is too large?
		do
			Result := (overflowed and then sign = 0)
		end
			
	too_small: BOOLEAN is
			-- Is number overflowed because it is too small?
		do
			Result := (overflowed and then sign = 1)
		end
			
	sign: INTEGER
		-- Sign of this integer, 0 positive; 1 nagetive.
				
	conversion_type: INTEGER
		-- Expected number type of string stored in `char_buffer'
		-- See `INTEGER_NATURAL_INFORMATION' for more information.	
		
feature -- String parsing
		
	parse (s: STRING; start_position:INTEGER; end_position: INTEGER) is
		-- Parse `s' from `start_position' to `end_position'.
		require
			s_not_void: s /= Void
			--s_not_empty: not s.is_empty
			start_position_valid: start_position > 0
			--start_position_small_enough: start_position <= s.count
			--start_position_not_larger_then_end_position: start_position <= end_position
			end_position_small_enough: end_position <= s.count
		local
			i: INTEGER
			l_c: CHARACTER
		do
			from
				i := start_position
			until
				i > end_position or last_state = state_4 or last_state = state_5
			loop
				l_c := s.item (i)
				i := i + 1
				inspect last_state
				when state_0 then
						-- Let's find beginning of an integer, if any.
					if l_c.is_digit then

						last_state := state_2
						if conversion_type /= type_no_limitation then
							part1 := 0
									-- Note: If max length of an integer is not 64,
									-- this would change to another proper feature,
									-- for example, to_natural_128.
							part2 := (l_c.code - 48).to_natural_64	
						end						
					elseif l_c = '-' or l_c = '+' then
						last_state := state_1
						if l_c = '-' then
							sign := 1
						else
							sign := 0
						end
					elseif l_c = ' ' then
						if not leading_white_spaces_acceptable then
							last_state := state_4
						end							
					else
						last_state := state_4
					end
				when state_1 then
						-- Let's find first digit after sign.
					if l_c.is_digit then						
						if conversion_type /= type_no_limitation then
							part1 := 0
									-- Note: If max length of an integer is not 64,
									-- this would change to another proper feature,
									-- for example, to_natural_128.
							part2 := (l_c.code - 48).to_natural_64	
							overflowed := overflow.will_overflow (part1, part2, conversion_type, sign)						
							if overflowed then
								last_state := state_5
							end						
						end
						last_state := state_2
					else
						last_state := state_4
					end
				when state_2 then
						-- Let's find another digit or end of integer.
					if l_c.is_digit then
						if conversion_type /= type_no_limitation then
							if not overflow.can_new_digit_be_added (part1, part1_length, conversion_type, sign) then
								overflowed := True
								last_state := state_5
							else
								if not (part1 = 0 and part2 = 0) then
									part1_length := part1_length + 1
									part1 := part1 * 10
								end
								part1 := part1 + part2
										-- Note: If max length of an integer is not 64,
										-- this would change to another proper feature,
										-- for example, to_natural_128.
								part2 := (l_c.code - 48).to_natural_64
								overflowed := overflow.will_overflow (part1, part2, conversion_type, sign)							
								if overflowed then
									last_state := state_5
								end	
							end							
						end						
					elseif l_c = ' ' then
						if trailing_white_spaces_acceptable then
							last_state := state_3
						else
							last_state := state_4
						end					
					else
						last_state := state_4
					end
				when state_3 then
						-- Consume remaining white space.
					if l_c /= ' ' then
						last_state := state_4
					end
				end
			end
			stop_position := i - 1
		end
		
feature -- Status reporting

	is_part_of_integer: BOOLEAN is
			-- Is string parsed so far a valid start part of an integer?
		do
			Result := (last_state = state_0) or (last_state = state_1) or
					  (last_state = state_2) or (last_state = state_3)			
		end
		
	is_integral_integer: BOOLEAN is
			-- Is string parsed so far a valid integral integer? 
		do
			Result := (last_state = state_2) or (last_state = state_3)
		end
		
	overflowed: BOOLEAN
			-- Is integer overflowed?

	parsed_integer_8: INTEGER_8 is
			-- INTEGER_8 representation of parsed string
		require
			type_valid: conversion_type = type_integer_8
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: INTEGER_8
		do

			l1 := part1.as_integer_8
			l1 := l1 * 10
			if sign = 1 then
				Result := - l1 - part2.as_integer_8
			else
				Result := l1 + part2.as_integer_8
			end
		end		
	parsed_integer_16: INTEGER_16 is
			-- INTEGER_16 representation of parsed string
		require
			type_valid: conversion_type = type_integer_16
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: INTEGER_16
		do
			l1 := part1.as_integer_16
			l1 := l1 * 10
			if sign = 1 then
				Result := - l1 - part2.as_integer_16
			else
				Result := l1 + part2.as_integer_16
			end
		end
		
	parsed_integer_32, parsed_integer: INTEGER is
			-- INTEGER representation of parsed string
		require
			type_valid: conversion_type = type_integer_32
			integer_is_integral: is_integral_integer
			not_overflowed: not overflowed
		local
			l1: INTEGER
		do
			l1 := part1.as_integer_32
			l1 := l1 * 10
			if sign = 1 then
				Result := - l1 - part2.as_integer_32
			else
				Result := l1 + part2.as_integer_32
			end
		end	
		
	parsed_integer_64: INTEGER_64 is
			-- INTEGER_64 representation of parsed string 
		require
			type_valid: conversion_type = type_integer_64
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: INTEGER_64
		do
			l1 := part1.as_integer_64
			l1 := l1 * 10
			if sign = 1 then
				Result := - l1 - part2.as_integer_64
			else
				Result := l1 + part2.as_integer_64
			end
		end			
	
	parsed_natural_8: NATURAL_8 is
			-- NATURAL_8 representation of parsed string
		require
			type_valid: conversion_type = type_natural_8
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: NATURAL_8
		do
			l1 := part1.as_natural_8
			l1 := l1 * 10
			Result := l1 + part2.as_natural_8
		end	
			
	parsed_natural_16: NATURAL_16 is
			-- NATURAL_16 representation of parsed string
		require
			type_valid: conversion_type = type_natural_16
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: NATURAL_16
		do
			l1 := part1.as_natural_16
			l1 := l1 * 10
			Result := l1 + part2.as_natural_16
		end	
		
	parsed_natural_32, parsed_natural: NATURAL_32 is
			-- NATURAL_32 representation of parsed string 
		require
			type_valid: conversion_type = type_natural_32
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: NATURAL_32
		do
			l1 := part1.as_natural_32
			l1 := l1 * 10
			Result := l1 + part2.as_natural_32
		end				

	parsed_natural_64: NATURAL_64 is
			-- NATURAL_64 representation of parsed string
		require
			type_valid: conversion_type = type_natural_64
			integer_is_integral: is_integral_integer			
			not_overflowed: not overflowed
		local
			l1: NATURAL_64
		do
			l1 := part1.as_natural_64
			l1 := l1 * 10
			Result := l1 + part2.as_natural_64
		end	
		
feature{NONE} -- Implementation
	
	overflow: OVERFLOW_CHECKER is
			-- Overflow checker
		once
			create Result.make
		end
		
	part1, part2: like max_natural_type
	
	part1_length: INTEGER	
		
feature	-- States

	state_0: INTEGER is 0
			-- state 0: waiting sign or first digit

	state_1: INTEGER is 1
			-- state 1 : sign read, waiting first digit
	
	state_2: INTEGER is 2
			-- state 2 : in the number
	
	state_3: INTEGER is 3
			-- state 3 : trailing white spaces	
	
	state_4: INTEGER is 4
			-- state 4 : error state	
	
	state_5: INTEGER is 5
			-- state 5 : overflow state
			
end
