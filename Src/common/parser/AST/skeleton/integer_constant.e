indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	ATOMIC_AS
		redefine
			is_integer
		end

create
	make_default

feature {NONE} -- Initialization

	make_default is
			-- Create an integer constant of size 32.
		do
			size := 32
			compatibility_size := 32
		ensure
			size_set: size = 32
		end

feature -- Initialization

	initialize (is_negative: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
		do
			read_integer_value (is_negative , s)
		end

	initialize_from_hexa (s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing
			-- an integer in hexadecimal starting with the following sequence
			-- "0x".
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
			s_not_too_big: s.count <= 18
		do
			read_hexa_value (s)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_integer_constant_as (Current)
		end

feature -- Attributes

	value: INTEGER is
			-- Integer value if `size' is 32 bits.
		require
			valid_size: size <= 32
		do
			Result := lower
		end

	lower, upper: INTEGER
			-- Representation of integers.
	
	size: INTEGER_8
			-- Current is stored on `size' bits.
	
	compatibility_size: INTEGER_8
			-- Minimum integer size that can hold current.
			-- Used for manifest integers that are of size `32' or `64'
			-- by default, but their value might be able to fit
			-- on an integer of size `8' or `16' as well.


	is_integer: BOOLEAN is True
			-- Is it an integer value ?

	is_simple_expr: BOOLEAN is True;
			-- A constant is a simple expression

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := lower = other.lower and then upper = other.upper and then size = other.size
				and then compatibility_size = other.compatibility_size
		end

feature -- Conveniences

	to_integer_64: INTEGER_64 is
			-- Extract information about `upper' and `lower' to
			-- build an INTEGER_64.
		require
			valid_size: size = 64
		local
			l_lower_64: INTEGER_64
			l_lower: INTEGER
		do
				-- Since we are converting `lower' to an INTEGER_64, we do not want the
				-- sign bit to be reflected on the INTEGER_64 value. So first we need
				-- to detect it and if it is there, we are going to remove it, convert
				-- then to an INTEGER_64 and then add back the missing bit to the new
				-- INTEGER_64 value.
			
			l_lower := lower
			
			if (l_lower & 0x80000000 = 0x80000000) then
					-- Let's clear the sign bit.
				l_lower := l_lower & 0x7FFFFFFF
					
					-- Get the INTEGER_64 value and restore the bit sign at
					-- the appropriate location in `lower_64'.
				l_lower_64 := l_lower.to_integer_64 | 0x0000000080000000
			else
					-- `lower' is not negative we can safely
					-- convert it to an INTEGER_64.
				l_lower_64 := l_lower.to_integer_64
			end
			
			Result := (upper.to_integer_64 |<< 32) | l_lower_64
		end

feature -- Settings

	set_lower (i: INTEGER) is
			-- Assign `i' to `lower'.
		do
			lower := i
		ensure
			lower_set: lower = i
		end

feature -- Output

	string_value: STRING is
			-- String representation of manifest constant.
		do
			if size <= 32 then
				Result := lower.out
			else
				Result := to_integer_64.out
			end
		end	

feature -- Trace

	dump: STRING is
		do
			Result := lower.out
		end

feature {NONE} -- Code generation string constants

	integer_8_cast: STRING is "(EIF_INTEGER_8) "
	integer_16_cast: STRING is "(EIF_INTEGER_16) "
	integer_32_cast: STRING is "(EIF_INTEGER_32) "
	integer_64_cast: STRING is "(EIF_INTEGER_64) "
			-- String used to generate a cast.

feature {NONE} -- Translation

	read_hexa_value (s: STRING) is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			s_not_void: s /= Void
			s_large_enough: s.count > 2
		local
			i, j: INTEGER
			last_integer: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
		do
			area := s.area
			j := s.count - 1

			from
			until
				(j - i) < 2 or i = 8
			loop
				val := area.item (j - i).lower
				inspect
					val
				when 'a' then
					last_integer := last_integer | ((10).to_integer_32 |<< (i * 4))
				when 'b' then
					last_integer := last_integer | ((11).to_integer_32 |<< (i * 4))
				when 'c' then
					last_integer := last_integer | ((12).to_integer_32 |<< (i * 4))
				when 'd' then
					last_integer := last_integer | ((13).to_integer_32 |<< (i * 4))
				when 'e' then
					last_integer := last_integer | ((14).to_integer_32 |<< (i * 4))
				when 'f' then
					last_integer := last_integer | ((15).to_integer_32 |<< (i * 4))
				else
					last_integer := last_integer | ((val.code - 48) |<< (i * 4))
				end
				i := i + 1
			end
			
			lower := last_integer

			if j > 9 then
				from
					i := 0
					last_integer := 0
					j := j - 8
				until
					(j - i) < 2
				loop
					val := area.item (j - i).lower
					inspect
						val
					when 'a' then
						last_integer := last_integer | ((10).to_integer_32 |<< (i * 4))
					when 'b' then
						last_integer := last_integer | ((11).to_integer_32 |<< (i * 4))
					when 'c' then
						last_integer := last_integer | ((12).to_integer_32 |<< (i * 4))
					when 'd' then
						last_integer := last_integer | ((13).to_integer_32 |<< (i * 4))
					when 'e' then
						last_integer := last_integer | ((14).to_integer_32 |<< (i * 4))
					when 'f' then
						last_integer := last_integer | ((15).to_integer_32 |<< (i * 4))
					else
						last_integer := last_integer | ((val.code - 48) |<< (i * 4))
					end
					i := i + 1
				end
				upper := last_integer
				size := 64
				compatibility_size := 64
			else
					-- Force size of integer constant depending on number
					-- of hexadecimal character in hex string.
				if j <= 3 then
					compatibility_size := 8
				elseif j <= 5 then
					compatibility_size := 16
				else
					check j <= 9 end
					compatibility_size := 32
				end
				size := 32
			end
		end

	largest_integer_32: STRING is "2147483648"
			-- Largest string representation of 2^31.

	read_integer_value (is_negative: BOOLEAN; s: STRING) is
			-- Read integer expressed in decimal representation.
		require
			s_not_void: s /= Void
		local
			last_integer: INTEGER
			last_int_64: INTEGER_64
			area: SPECIAL [CHARACTER]
			i, nb: INTEGER
			is_32bits, done: BOOLEAN
		do
			area := s.area
			nb := s.count
	
			is_32bits := nb < 10
			if not is_32bits and then nb = 10 then
				if is_negative then
					is_32bits := s < largest_integer_32
					if not is_32bits and then s.is_equal (largest_integer_32) then
						done := True
						compatibility_size := 32
						size := 32
						lower := 0x80000000
					end
				else
					is_32bits := s < largest_integer_32
				end
			end

			if not done then
				if is_32bits then
					from
					until
						i >= nb
					loop
						last_integer := (last_integer * 10) + area.item (i).code - 48
						i := i + 1
					end
					if is_negative then
						last_integer := -last_integer
					end
					lower := last_integer

					if -128 <= lower and lower <= 127 then
						compatibility_size := 8
					elseif -32768 <= lower and lower <= 32767 then
						compatibility_size := 16
					elseif -2147483648 <= lower and lower <= 2147483647 then
						compatibility_size := 32
					else
						check False end
					end
					size := 32
				else
					from
					until
						i >= nb
					loop
						last_int_64 := (last_int_64 * 10) + area.item (i).code - 48
						i := i + 1
					end

					if is_negative then
						last_int_64 := -last_int_64
					end

					size := 64
					compatibility_size := 64
					lower := (last_int_64 & 0x00000000FFFFFFFF).to_integer
					upper := ((last_int_64 |>> 32) & 0x00000000FFFFFFFF).to_integer
				end
			end
		end

end -- class INTEGER_CONSTANT
