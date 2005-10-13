indexing
	description: "State machine to do string to integer/natural conversion"
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
			set_leading_separators (" ")
			set_trailing_separators (" ")
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
			part2 := 0
			sign := 0
			trailing_separators_acceptable := True
			leading_separators_acceptable := True
			conversion_type := type
		ensure
			last_state_set: last_state = state_0
			overflowed_set: not overflowed
			part1_set: part1 = 0
			part2_set: part2 = 0			
			sign_set: sign = 0
			trailing_separators_acceptable_set:
				trailing_separators_acceptable
			leading_separators_acceptable_set:
				leading_separators_acceptable
			conversion_type_set: conversion_type = type
		end
	
feature -- Status setting
		
	set_trailing_separators_acceptable (b: BOOLEAN) is
			-- Set `trailing_separators_acceptable' to `b'.
		do
			trailing_separators_acceptable := b
		ensure
			trailing_separators_acceptable_set: 
				trailing_separators_acceptable = b
		end
		
	set_leading_separators_acceptable (b: BOOLEAN) is
			-- Set `leading_separators_acceptable' to `b'.
		do
			leading_separators_acceptable := b
		ensure
			leading_separators_acceptable_set: 
				leading_separators_acceptable = b
		end	
		
	set_leading_separators (separators: STRING) is
			-- Set `leading_separators' with `separators'.
		require
			separators_not_void: separators /= Void
			separators_valid: separators_valid (separators)
		do
			create leading_separators.make_from_string (separators)
		ensure
			leading_separators_set: leading_separators.is_equal (separators)
		end
		
	set_trailing_separators (separators: STRING) is
			-- Set `trailing_separators' with `separators'.
		require
			separators_not_void: separators /= Void
			separators_valid: separators_valid (separators)
		do
			create trailing_separators.make_from_string (separators)
		ensure
			trailing_separators_set: trailing_separators.is_equal (separators)
		end
		
					
feature -- Status reporting

	separators_valid (separators: STRING): BOOLEAN is
			-- Are `separators' valid?
		require
			separators_not_void: separators /= Void
			separators_not_empty: not separators.is_empty
		local
			i: INTEGER
			l_c: INTEGER
			c: CHARACTER
			done: BOOLEAN
		do
			from
				i := 1
				l_c := separators.count
				done := False
				Result := True
			until
				i > l_c or done
			loop
				c := separators.item (i)
				if (c >='0' and c <= '9') or c ='+' or c = '-' then
					done := True
					Result := False
				end
				i := i + 1
			end
		end	
		
	trailing_separators_acceptable: BOOLEAN
		-- Are trailing white spaces acceptable?
		
	leading_separators_acceptable: BOOLEAN
		-- Are leading white spaces acceptable?

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
		-- Sign of this integer, 0: positive; 1: nagetive.
				
	conversion_type: INTEGER
		-- Expected number type of string stored in `char_buffer'
		-- See `INTEGER_NATURAL_INFORMATION' for more information.
		
	leading_separators: STRING
	
	trailing_separators: STRING
		
feature -- String parsing
		
	parse_string_with_type (s: STRING; type: INTEGER) is
			-- Parse `s' to see if it is a number with `type'.
			-- Call `is_integral_integer' or `is_part_of_integer' to see result.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
			l_c: INTEGER			
		do
			reset (type)
			from
				i := 1
				l_c := s.count
			until
				i > l_c or last_state = state_4 or last_state = state_5
			loop
				parse_character (s.item (i))
				i := i + 1
			end
		end

	parse_character (c: CHARACTER) is
			-- Parse `c'.
			-- Call `is_integral_integer' or `is_part_of_integer' to see result.
		local
			temp_p1: like max_natural_type
			temp_p2: like max_natural_type
		do
			if last_state /= state_4 and last_state /= state_5 then
				temp_p1 := (0).to_natural_64
				temp_p2 := (0).to_natural_64
				inspect last_state
				when state_0 then
						-- Let's find beginning of an integer, if any.
					if c.is_digit then
						last_state := state_2
						part1 := 0
						part2 := (c.code - 48).to_natural_64						
					elseif c = '-' or c = '+' then
						last_state := state_1
						if c = '-' then
							sign := 1
						else
							sign := 0
						end
					elseif leading_separators_acceptable and then leading_separators.has (c) then
					else
						last_state := state_4
					end
				when state_1 then
						-- Let's find first digit after sign.
					if c.is_digit then	
						part1 := 0
						part2 := (c.code - 48).to_natural_64									
						if conversion_type /= type_no_limitation then
							overflowed := overflow.will_overflow (part1, part2, conversion_type, sign)							
							if overflowed then
								part1 := temp_p1
								part2 := temp_p2
								last_state := state_5								
							end	
						end
						last_state := state_2
					else
						last_state := state_4
					end
				when state_2 then
						-- Let's find another digit or end of integer.
					if c.is_digit then
						temp_p1 := part1
						temp_p2 := part2
						part1 := part1*10 + part2
						part2 := (c.code - 48).to_natural_64					
						if conversion_type /= type_no_limitation then
							overflowed := overflow.will_overflow (part1, part2, conversion_type, sign)							
							if overflowed then
								last_state := state_5
								part1 := temp_p1
								part2 := temp_p2								
							end	
						end						
					elseif trailing_separators_acceptable and then trailing_separators.has (c) then					
						last_state := state_3				
					else
						last_state := state_4
					end
				when state_3 then
						-- Consume remaining white space.
					if trailing_separators_acceptable and then trailing_separators.has (c) then
					else
						last_state := state_4
					end
				end						
			end	
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
		
	is_integral_integer_state (state: INTEGER):BOOLEAN is
			-- Is `state' an integral integer state?
		do
			Result := (state = state_2) or (state = state_3)
		end
		
	overflowed: BOOLEAN
			-- Is integer overflowed?

	parsed_integer_8: INTEGER_8 is
			-- INTEGER_8 representation of parsed string
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
		local
			l1: NATURAL_8
		do
			l1 := part1.as_natural_8
			l1 := l1 * 10
			Result := l1 + part2.as_natural_8
		end	
					
	parsed_natural_16: NATURAL_16 is
			-- NATURAL_16 representation of parsed string
		local
			l1: NATURAL_16
		do
			l1 := part1.as_natural_16
			l1 := l1 * 10
			Result := l1 + part2.as_natural_16
		end	
				
	parsed_natural_32, parsed_natural: NATURAL_32 is
			-- NATURAL_32 representation of parsed string 
		local
			l1: NATURAL_32
		do
			l1 := part1.as_natural_32
			l1 := l1 * 10
			Result := l1 + part2.as_natural_32
		end	
		
	parsed_natural_64: NATURAL_64 is
			-- NATURAL_64 representation of parsed string
		local
			l1: NATURAL_64
		do
			l1 := part1.as_natural_64
			l1 := l1 * 10
			Result := l1 + part2.as_natural_64
		end	
		
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
		
feature{NONE} -- Implementation
	
	overflow: OVERFLOW_CHECKER is
			-- Overflow checker
		once
			create Result.make
		end
		
	part1, part2: like max_natural_type
			-- Naturals used for conversion	
						
end
