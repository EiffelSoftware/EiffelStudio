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
			is_initialized := true
		ensure
			size_set: size = 32
		end

feature -- Initialization

	initialize (is_negative: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_iniialized' to false.
		do
			read_integer_value (is_negative , s)
		end

	initialize_from_hexa (sign: CHARACTER; s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing 
			-- an integer in hexadecimal starting with the following sequence "0x"
			-- and given `sign'.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_initialized' to false.
		require
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_long_enough: s.count >= 3
			s_has_hexadecimal_prefix: s.substring_index ("0x", 1) = 1
			s_has_hexadecimal_suffix: -- for all i in [3..s.count] ("0123456789ABCDEFabcdef").has (s.item (i))
		do
			read_hexa_value (sign, s)
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Is constant initialized to allowed value?

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_integer_constant_as (Current)
		end

feature {INTEGER_CONSTANT} -- Storage

	lower, upper: INTEGER
			-- Representation of integers
	
feature -- Properties

	value: INTEGER is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size <= 32
		do
			Result := lower
			if size = 8 then
				Result := Result.to_integer_8
			elseif size = 16 then
				Result := Result.to_integer_16
			end
		end

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

feature {NONE} -- Operations

	negate is
			-- Perform negation of current value.
		local
			i: INTEGER_64
		do
			if size <= 32 then
					-- Positive number will get minus sign in `upper'
				if lower = 0 or else upper < 0 then
					upper := 0
				else
					upper := -1
				end
				lower := -lower
			else
				i := -to_integer_64
				lower := (i & 0x00000000FFFFFFFF).to_integer
				upper := ((i |>> 32) & 0x00000000FFFFFFFF).to_integer
			end
				-- Size might be changed.
			compute_size
		end
	
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
				-- to detect it and if it is there, we need to mask it with lower 32 bits.

			l_lower := lower
			
			if l_lower < 0 then
					-- Mask sign extension bits.
				l_lower_64 := l_lower.to_integer_64 & 0x00000000FFFFFFFF
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
		require
			is_size_32: size = 32
			is_compatibility_size_32: compatibility_size = 32
		do
			lower := i
			if i > 0 then
				upper := 0
			else
				upper := -1
			end
		ensure
			lower_set: lower = i
			upper_set: (i >= 0 implies upper = 0) and then (i < 0 implies upper = -1)
		end

feature -- Output

	string_value: STRING is
			-- String representation of manifest constant.
		do
			if size <= 32 then
				Result := value.out
			else
				Result := to_integer_64.out
			end
		end	

feature -- Trace

	dump: STRING is
		do
			Result := to_integer_64.out
		end
	
feature {NONE} -- Translation

	read_hexa_value (sign: CHARACTER; s: STRING) is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_large_enough: s.count > 2
		local
			i, j: INTEGER
			last_integer: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
		do
			is_initialized := true
			j := s.count - 1
			area := s.area

			from
			until
				(j - i) < 2 or i = 8
			loop
				val := area.item (j - i).lower
				if val >= 'a' then
					last_integer := last_integer | ((val.code - 87) |<< (i * 4))
				else
					last_integer := last_integer | ((val.code - 48) |<< (i * 4))
				end
				i := i + 1
			end
			
			lower := last_integer

			if j > 9 then
				from
					last_integer := 0
				until
					(j - i) < 2 or i = 16
				loop
					val := area.item (j - i).lower
					if val >= 'a' then
						last_integer := last_integer | ((val.code - 87) |<< (i * 4))
					else
						last_integer := last_integer | ((val.code - 48) |<< (i * 4))
					end
					i := i + 1
				end
				upper := last_integer
			else
				upper := 0
			end

				-- Force size of integer constant depending on number of hexadecimal characters in string
				-- or on integer value:
				--   (s in 0x0         .. 0xFF)       or (value in -0x80       .. 0x7F)       => size = 8
				--   (s in 0x100       .. 0xFFFF)     or (value in -0x8000     .. 0x7FFF)     => size = 16
				--   (s in 0x10000     .. 0xFFFFFFFF) or (value in -0x80000000 .. 0x7FFFFFFF) => size = 32
				--   (s in 0x100000000 .. 0xFFFFFFFFFFFFFFFF) or (value in ...)               => size = 64

				-- Count leading zeroes
			from
				i := 3
			until
				i > j or else s.item (i) /= '0'
			loop
				i := i + 1
			end
				-- Set `i' to number of meanigful digits
			i := j - i + 2
			if i <= 2 and then (lower <= 0x7F or else sign = '-' and then lower = 0x80) then
					-- Value in -0x80 .. 0x7F
				compatibility_size := 8
				size := 8
			elseif sign = '%U' and then j <= 3 then
					-- Value in 0x80 .. 0xFF
				compatibility_size := 8
				size := 16
			elseif i <= 4 and then (lower <= 0x7FFF or else sign = '-' and then lower = 0x8000) then
					-- Value in -0x8000 .. 0x7FFF
				compatibility_size := 16
				size := 16
			elseif sign = '%U' and then j <= 5 then
					-- Value in 0x8000 .. 0xFFFF
				compatibility_size := 16
				size := 32
			elseif i <= 8 and then (lower >= 0 or else sign = '-' and then lower = 0x80000000) then
					-- Value in -0x80000000 .. 0x7FFFFFFF
				compatibility_size := 32
				size := 32
			elseif sign = '%U' and then j <= 9 then
					-- Value in 0x80000000 .. 0xFFFFFFFF
				compatibility_size := 32
				size := 64
			elseif i < 16 or else i = 16 and then (s.item (j - i + 2) <= '7' or else sign = '-' and then lower = 0 and then upper = 0x80000000) then
					-- Value in -0x8000000000000000 .. 0x7FFFFFFFFFFFFFFF
				compatibility_size := 64
				size := 64
			elseif sign = '%U' and then j <= 17 then
					-- Value in 0x8000000000000000 .. 0xFFFFFFFFFFFFFFFF
				compatibility_size := 64
				size := 64
			else
					-- Value is out of range
				compatibility_size := 64
				size := 64
				is_initialized := false
			end
				-- Set `size'
			if size < 32 then
				size := 32
			end
			if sign = '-' then
				negate
				check is_initialized implies (upper < 0 or else (upper = 0 and then lower = 0)) end
			end
		end

	largest_integer_32: STRING is "2147483648"
			-- Largest string representation of 2^31

	largest_integer_64: STRING is "9223372036854775808"
			-- Largest string representation of 2^64

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
			is_initialized := true
			nb := s.count
				-- Count leading zeroes
			from
				i := 1
			until
				i >= nb or else s.item (i) /= '0'
			loop
				i := i + 1
			end
				-- Remove leading zeroes
			i := i - 1
			s.remove_head (i)
			nb := nb - i

			area := s.area
	
			is_32bits := nb < 10
			if nb = 10 then
				is_32bits := s < largest_integer_32
				if not is_32bits and then is_negative and then s.is_equal (largest_integer_32) then
					done := True
					compatibility_size := 32
					size := 32
					lower := 0x80000000
					upper := -1
				end
			end

			if not done then
				if is_32bits then
					from
						i := 0
					until
						i >= nb
					loop
						last_integer := (last_integer * 10) + area.item (i).code - 48
						i := i + 1
					end
					if is_negative and then last_integer > 0 then
						last_integer := -last_integer
						upper := -1
					else
						upper := 0
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
				elseif nb < 19 or else nb = 19 and then (s < largest_integer_64 or else is_negative and then s.is_equal (largest_integer_64)) then
					from
						i := 0
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
				else
						-- Value is out of range
					size := 64
					compatibility_size := 64
					is_initialized := false
				end
			end
		end

	compute_size is
			-- Compute `size' and `compatibility_size' from the value of the constant.
		do
			size := 32
			if upper /= lower |>> 31 then
					-- Value does not fit 32 bits
				size := 64
				compatibility_size := 64
			elseif -128 <= lower and then lower <= 127 then
				compatibility_size := 8
			elseif -32768 <= lower and then lower <= 32767 then
				compatibility_size := 16
			else
				compatibility_size := 32
			end
		end

end
