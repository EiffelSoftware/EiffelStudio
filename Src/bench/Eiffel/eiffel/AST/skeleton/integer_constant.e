indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	ATOMIC_AS
		rename
			context as ast_context
		undefine
			is_character, is_equal
		redefine
			is_integer, good_integer, is_equivalent,
			type_check, byte_node, value_i, make_integer
		end

	VALUE_I
		undefine
			string_value, is_equal
		redefine
			generate, is_integer,
			set_real_type, unary_minus
		end

	EXPR_B
		rename
			real_type as byte_real_type,
			generate as byte_generate,
			size as byte_size
		export
			{NONE} byte_real_type, byte_generate, byte_size
		undefine
			line_number, is_equal
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il,
			evaluate
		end

	COMPARABLE

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

feature -- Properties

	value: INTEGER is
			-- Integer value if `size' is 32 bits.
		require
			valid_size: size <= 32
		do
			inspect size
			when 8 then Result := lower.to_integer_8
			when 16 then Result := lower.to_integer_16
			else
				Result := lower
			end
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

	type: TYPE_I is
			-- Integer type
		do
			create {LONG_I} Result.make (size)
		end

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluate current expression, if possible.
		do
			Result := Current
		end

feature -- Unary operators

	unary_minus: INTEGER_CONSTANT is
			-- Apply `-' operator to Current.
		do
			Result := clone (Current)
			Result.negate
		end

feature {INTEGER_CONSTANT} -- Operations

	negate is
			-- Perform negation of current value.
		local
			i: INTEGER_64
		do
			if size <= 32 then
				lower := -value
			else
				i := -to_integer_64
				lower := (i & 0x00000000FFFFFFFF).to_integer
				upper := ((i |>> 32) & 0x00000000FFFFFFFF).to_integer
			end
		end
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := lower = other.lower and then upper = other.upper and then size = other.size
				and then compatibility_size = other.compatibility_size
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is `Current' smaller than `other'?
		do
			inspect size
			when 8, 16, 32 then Result := value < other.value
			when 64 then Result := to_integer_64 < other.to_integer_64
			end
		end

feature -- Type checking

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t'?
		local
			int_a: INTEGER_A
		do
			Result := t.is_integer 
			if Result then
				int_a ?= t
				Result := int_a.compatibility_size >= compatibility_size
			end
		end

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			ast_context.put (create {INTEGER_A}.make_for_constant (size, compatibility_size))
		end

	byte_node: INTEGER_CONSTANT is
			-- Associated byte code
		do
			Result := Current
		end

	make_integer: INT_VAL_B is
			-- Integer value for Intervals.
		do
			create Result.make (value)
		end

feature -- Conveniences

	value_i: INTEGER_CONSTANT is
			-- Interface value
		do
				-- Need to clone since 
			Result := clone (Current)
		end

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

	used (r: REGISTRABLE): BOOLEAN is
		do
		end;

feature -- Settings

	set_lower (i: INTEGER) is
			-- Assign `i' to `lower'.
		do
			lower := i
		ensure
			lower_set: lower = i
		end

	set_real_type (t: INTEGER_A) is
			-- Extract size information of `t' and assign it to Current.
			-- It will discard existing information, because it might be
			-- possible that we entered an INTEGER_8 constant value.
		do
			check
				compatible: t.compatibility_size >= compatibility_size
			end
			size := t.compatibility_size
		ensure then
			size_set: size = t.compatibility_size
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (create {NUMBER_TEXT}.make (string_value))
		end

feature -- Generation

	print_register is
			-- Print integer constant
			--| The '()' are present for the case where int_val=INT32_MIN,
			--| ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			generate (buffer)
		end;

	generate (buf: GENERATION_BUFFER) is
			-- Generate value in `buf'.
			-- The '()' are present for the case where lower=INT32_MIN,
			-- ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			if compatibility_size /= size then 
				inspect size
				when 8 then buf.putstring (integer_8_cast)
				when 16 then buf.putstring (integer_16_cast)
				when 32 then buf.putstring (integer_32_cast)
				when 64 then buf.putstring (integer_64_cast)
				end
			end

			buf.putchar ('(')
			if compatibility_size = 64 then
				buf.putstring (to_integer_64.out)
			else
				buf.putint (value)
			end
			buf.putchar ('L')
			buf.putchar (')')
		end

	generate_il is
			-- Generate IL code for integer constant value.
		do
			inspect compatibility_size
			when 8 then
				il_generator.put_integer_8_constant (value)
			when 16 then
				il_generator.put_integer_16_constant (value)
			when 32 then
				il_generator.put_integer_32_constant (value)
			when 64 then
				il_generator.put_integer_64_constant (to_integer_64)
			end

			if compatibility_size /= size then
				inspect size
				when 8 then
					il_generator.convert_to_integer_8
				when 16 then
					il_generator.convert_to_integer_16
				when 32 then
					il_generator.convert_to_integer_32
				when 64 then
					il_generator.convert_to_integer_64
				end
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			inspect compatibility_size
			when 8 then
				ba.append (Bc_int8)
				ba.append (lower.to_character)
			when 16 then
				ba.append (Bc_int16)
				ba.append_short_integer (lower)
			when 32 then
				ba.append (Bc_int32)
				ba.append_integer (lower)
			when 64 then
				ba.append (Bc_int64)
				ba.append_integer_64 (to_integer_64)
			end

			if compatibility_size /= size then
				ba.append (Bc_cast_long)
				ba.append_integer (size)
			end
		end

feature -- Trace

	dump: STRING is
		do
			Result := value.out
		end
	
feature {COMPILER_EXPORTER}

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			Result := size <= 32
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
