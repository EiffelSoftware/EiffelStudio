indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	ATOMIC_AS
		rename
			context as ast_context,
			is_valid_inspect_value as valid_type
		redefine
			is_equivalent,
			type_check, byte_node, value_i, valid_type, inspect_value
		end

	VALUE_I
		redefine
			generate, is_integer, is_natural, inspect_value,
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
			line_number
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il,
			is_fast_as_local,
			evaluate
		end;
	
	REFACTORING_HELPER

create
	make_with_value, make_from_string, make_from_hexa_string

feature {NONE} -- Initialization

	make_with_value (v: INTEGER) is
			-- Create an integer constant of size 32.
		do
			size := 32
			is_integer := True
			compatibility_size := 32
			is_initialized := True
			constant_type := Void
			lower := v
		ensure
			size_set: size = 32
			is_integer_set: is_integer
			is_initialized_set: is_initialized
			integer_32_value_set: integer_32_value = v
		end

feature {NONE} -- Initialization

	make_from_string (a_type: like constant_type; is_neg: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_iniialized' to false.
		require
			valid_type: a_type /= Void implies (a_type.is_integer or a_type.is_natural)
			s_not_void: s /= Void
		do
			constant_type := a_type
			is_integer := a_type = Void or else a_type.is_integer
			if is_integer then
				read_integer_value (is_neg, s)
			else
				if not is_neg then
					read_natural_value (s)
				else
						-- We are trying to read a negative natural, it does not make sense.
					is_initialized := False
				end
			end
		ensure
			constant_type_set: constant_type = a_type
		end

	make_from_hexa_string (a_type: like constant_type; sign: CHARACTER; s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing 
			-- an integer in hexadecimal starting with the following sequence "0x"
			-- and given `sign'.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_initialized' to false.
		require
			valid_type: a_type /= Void implies (a_type.is_integer or a_type.is_natural)
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_long_enough: s.count >= 3
			s_has_hexadecimal_prefix: s.substring_index ("0x", 1) = 1
			s_has_hexadecimal_suffix: -- for all i in [3..s.count] ("0123456789ABCDEFabcdef").has (s.item (i))
		do
			constant_type := a_type
			is_integer := a_type = Void or else a_type.is_integer
			if is_integer then
				read_integer_hexa_value (sign, s)
			else
				if sign /= '-' then
					read_natural_hexa_value (sign, s)
				else
						-- We are trying to read a negative natural, it does not make sense.
					is_initialized := False
				end
			end
		ensure
			constant_type_set: constant_type = a_type
		end

feature -- Access

	constant_type: TYPE_A
			-- Actual type of integer constant if specified.

feature -- Properties

	is_initialized: BOOLEAN
			-- Is constant initialized to allowed value?

	is_integer: BOOLEAN
			-- Is it an integer value ?

	is_natural: BOOLEAN is
			-- Is it an integer value ?
		do
			Result := not is_integer
		end

	is_negative: BOOLEAN is
			-- Is current value a negative one?
		do
			if is_integer then
				Result := (upper = 0 and then lower < 0) or (upper < 0)
			end
		end
		
	is_one: BOOLEAN is
			-- Is constant equal to 1?
		do
			Result := lower = 1 and then upper = 0
		end

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expression

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_integer_constant_as (Current)
		end

feature -- Status report

	natural_8_value: INTEGER_8 is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size = 8
			is_natural: is_natural
		do
			fixme ("Update to NATURAL_XX after bootstrap")
			Result := lower.to_integer_8
		end

	natural_16_value: INTEGER_16 is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size <= 16
			is_natural: is_natural
		do
			fixme ("Update to NATURAL_XX after bootstrap")
			Result := lower.to_integer_16
		end

	natural_32_value: INTEGER is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size <= 32
			is_natural: is_natural
		do
			fixme ("Update to NATURAL_XX after bootstrap")
			Result := lower
		end

	natural_64_value: INTEGER_64 is
			-- Extract information about `upper' and `lower' to
			-- build an INTEGER_64.
		require
			valid_size: size <= 64
			is_natural: is_natural
		local
			l_lower_64: INTEGER_64
			l_lower: INTEGER
		do
			fixme ("Update to NATURAL_XX after bootstrap")
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

	integer_8_value: INTEGER_8 is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size = 8
			is_integer: is_integer
		do
			Result := lower.to_integer_8
		end

	integer_16_value: INTEGER_16 is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size <= 16
			is_integer: is_integer
		do
			Result := lower.to_integer_16
		end

	integer_32_value: INTEGER is
			-- Integer value if `size' is 32 bits
		require
			valid_size: size <= 32
			is_integer: is_integer
		do
			Result := lower
		end

	integer_64_value: INTEGER_64 is
			-- Extract information about `upper' and `lower' to
			-- build an INTEGER_64.
		require
			valid_size: size <= 64
			is_integer: is_integer
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

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
	compatibility_size: INTEGER_8
			-- Minimum integer size that can hold current.
			-- Used for manifest integers that are of size `32' or `64'
			-- by default, but their value might be able to fit
			-- on an integer of size `8' or `16' as well.

	type: TYPE_I is
			-- Integer type
		do
			create {INTEGER_I} Result.make (size)
		end
		
	manifest_type: MANIFEST_INTEGER_A is
			-- Associated manifest integer
		require
			is_integer: is_integer
		do
			create Result.make_for_constant (size, compatibility_size, is_negative)
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
			Result := twin
			Result.negate
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := lower = other.lower and then upper = other.upper and then size = other.size
				and then compatibility_size = other.compatibility_size
		end

feature -- Type checking

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t'?
		local
			int_a: INTEGER_A
			l_nat: NATURAL_A
		do
			if is_integer then
				Result := t.is_integer
				if Result then
					int_a ?= t
					Result := int_a.size >= compatibility_size
				end
			else
				Result := t.is_natural
				if Result then
					l_nat ?= t
					Result := l_nat.size = size
				end
			end
		end

	type_check is
			-- Type check an integer type
		do
			if constant_type /= Void then
				ast_context.put (constant_type)
			else
					-- Put onto the type stack an integer actual type
				ast_context.put (manifest_type)
			end
		end

	byte_node: INTEGER_CONSTANT is
			-- Associated byte code
		do
			Result := Current
		end

	inspect_value (value_type: TYPE_A): INTERVAL_VAL_B is
			-- Inspect value of the given `value_type'
		local
			integer_a: INTEGER_A
		do
			integer_a ?= value_type
			if integer_a.size <= 32 then
				create {INT_VAL_B} Result.make (integer_32_value)
			else
				check
					integer_64: integer_a.size = 64
				end
				create {INT64_VAL_B} Result.make (integer_64_value)
			end
		end

feature -- Conveniences

	value_i: INTEGER_CONSTANT is
			-- Interface value
		do
				-- FIXME: Previous comment said we needed to `twin' but
				-- I don't remember why since the comment was cut off at
				-- the first revision of Current class.
			Result := twin
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
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

	set_real_type (t: TYPE_A) is
			-- Extract size information of `t' and assign it to Current.
			-- It will discard existing information, because it might be
			-- possible that we entered an INTEGER_8 constant value.
		local
			l_int: INTEGER_A
		do
			if is_integer then
				l_int ?= t
				check
					is_integer: l_int /= Void
					compatible: l_int.size >= compatibility_size
				end
				size := l_int.size
				inspect	size
				when 8 then
					lower := lower.to_integer_8
					if lower >= 0 then
						upper := 0
					else
						upper := -1
					end
				when 16 then
					lower := lower.to_integer_16
					if lower >= 0 then
						upper := 0
					else
						upper := -1
					end
				else
				end
			end
		end

feature -- Output

	dump: STRING is
			-- String representation of manifest constant.
		do
			if is_integer then
				inspect size
				when 8 then Result := integer_8_value.out
				when 16 then Result := integer_16_value.out
				when 32 then Result := integer_32_value.out
				when 64 then Result := integer_64_value.out
				end
			else
				inspect size
				when 8 then Result := natural_8_value.out
				when 16 then Result := natural_16_value.out
				when 32 then Result := natural_32_value.out
				when 64 then Result := natural_64_value.out
				end
			end
		end	

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if constant_type /= Void then
				ctxt.put_text_item (ti_l_curly)
				constant_type.format (ctxt)
				ctxt.put_text_item (ti_r_curly)
				ctxt.put_space
			end
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
		local
			l_int: like integer_32_value
		do
			if is_integer then
				buf.put_character ('(')
				if size = 64 then
					buf.put_string (integer_64_cast)
					buf.put_string ("RTI64C(")
					buf.put_string (integer_64_value.out)
					buf.put_character (')')
				else
					inspect size
					when 8 then buf.put_string (integer_8_cast) buf.put_integer (integer_8_value)
					when 16 then buf.put_string (integer_16_cast) buf.put_integer (integer_16_value)
					when 32 then
							-- Special treatment of `min_value' so that the C compiler
							-- does not complain as -2147483648 is treated as -(2147483648)
							-- as it is therefore an unsigned value we are trying to negate
							-- and the C compiler warns it is still unsigned, although at
							-- the end it is ok with the cast.
						buf.put_string (integer_32_cast)
						l_int := integer_32_value
						if l_int = {INTEGER}.min_value then
							buf.put_string ("0x")
							buf.put_string (l_int.to_hex_string)
						else
							buf.put_integer (integer_32_value)
						end
					end
					buf.put_character ('L')
				end
				buf.put_character (')')
			else
				fixme ("No need to treat the negative value after bootstrapping the compiler")
				buf.put_character ('(')
				if size = 64 then
					buf.put_string (natural_64_cast)
					buf.put_string ("RTU64C(")
					if natural_64_value < 0 then
						buf.put_string ("0x")
						buf.put_string (natural_64_value.to_hex_string)
					else
						buf.put_string (natural_64_value.out)
					end
					buf.put_character (')')
				else
					inspect size
					when 8 then
						buf.put_string (natural_8_cast)
						if natural_8_value < 0 then
							buf.put_string ("0x")
							buf.put_string (natural_8_value.to_hex_string)
						else
							buf.put_integer (natural_8_value)
						end
					when 16 then
						buf.put_string (natural_16_cast)
						if natural_16_value < 0 then
							buf.put_string ("0x")
							buf.put_string (natural_16_value.to_hex_string)
						else
							buf.put_integer (natural_16_value)
						end
					when 32 then
						buf.put_string (natural_32_cast)
						if natural_32_value < 0 then
							buf.put_string ("0x")
							buf.put_string (natural_32_value.to_hex_string)
						else
							buf.put_integer (natural_32_value)
						end
					end
					buf.put_character ('U')
				end
				buf.put_character (')')
			end
		end

	is_fast_as_local: BOOLEAN is True
			-- Is expression calculation as fast as loading a local?

	generate_il is
			-- Generate IL code for integer constant value.
		do
			if is_integer then
				inspect size
				when 8 then
					il_generator.put_integer_8_constant (integer_8_value)
				when 16 then
					il_generator.put_integer_16_constant (integer_16_value)
				when 32 then
					il_generator.put_integer_32_constant (integer_32_value)
				when 64 then
					il_generator.put_integer_64_constant (integer_64_value)
				end
			else
				inspect size
				when 8 then
					il_generator.put_natural_8_constant (natural_8_value)
				when 16 then
					il_generator.put_natural_16_constant (natural_16_value)
				when 32 then
					il_generator.put_natural_32_constant (natural_32_value)
				when 64 then
					il_generator.put_natural_64_constant (natural_64_value)
				end
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			if is_integer then
				inspect size
				when 8 then
					ba.append (Bc_int8)
					ba.append_integer_8 (integer_8_value)
				when 16 then
					ba.append (Bc_int16)
					ba.append_integer_16 (integer_16_value)
				when 32 then
					ba.append (Bc_int32)
					ba.append_integer (integer_32_value)
				when 64 then
					ba.append (Bc_int64)
					ba.append_integer_64 (integer_64_value)
				end
			else
				inspect size
				when 8 then
					ba.append (Bc_uint8)
					ba.append_natural_8 (natural_8_value)
				when 16 then
					ba.append (Bc_uint16)
					ba.append_natural_16 (natural_16_value)
				when 32 then
					ba.append (Bc_uint32)
					ba.append_natural_32 (natural_32_value)
				when 64 then
					ba.append (Bc_uint64)
					ba.append_natural_64 (natural_64_value)
				end
			end
		end

feature {INTEGER_CONSTANT} -- Storage

	lower, upper: INTEGER
			-- Representation of integers
	
feature {INTEGER_CONSTANT} -- Operations

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
				i := -integer_64_value
				lower := (i & 0x00000000FFFFFFFF).to_integer
				upper := ((i |>> 32) & 0x00000000FFFFFFFF).to_integer
			end
				-- Size might be changed.
			compute_size
		end
	
feature {NONE} -- Code generation string constants

	natural_8_cast: STRING is "(EIF_NATURAL_8) "
	natural_16_cast: STRING is "(EIF_NATURAL_16) "
	natural_32_cast: STRING is "(EIF_NATURAL_32) "
	natural_64_cast: STRING is "(EIF_NATURAL_64) "
	integer_8_cast: STRING is "(EIF_INTEGER_8) "
	integer_16_cast: STRING is "(EIF_INTEGER_16) "
	integer_32_cast: STRING is "(EIF_INTEGER_32) "
	integer_64_cast: STRING is "(EIF_INTEGER_64) "
			-- String used to generate a cast.

feature {NONE} -- Translation

	read_natural_hexa_value (sign: CHARACTER; s: STRING) is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_large_enough: s.count > 2
			constant_type_not_void: constant_type /= Void
			constant_type_is_natural: constant_type.is_natural
		local
			i, j: INTEGER
			last_integer: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
			l_natural: NATURAL_A
		do
			l_natural ?= constant_type
			size := l_natural.size
			j := s.count - 1

				-- Compute leading zeros:
			from
				i := 3
			until
				i > j or else s.item (i) /= '0'
			loop
				i := i + 1
			end
				-- Set `i' to number of meanigful digits
			i := j - i + 2

				-- Ensures that manifest constant fits for `constant_type'
			is_initialized := (i // 2) <= (size // 8)

			if is_initialized then
				from
					area := s.area
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

				if i <= 2 then
						-- Value in 0x00 .. 0xFF
					compatibility_size := 8
				elseif i <= 4 then
						-- Value in 0x0000 .. 0xFFFF
					compatibility_size := 16
				elseif i <= 8 then
						-- Value in 0x00000000 .. 0xFFFFFFFF
					compatibility_size := 32
				elseif i <= 16 then
						-- Value in 0x0000000000000000 .. 0xFFFFFFFFFFFFFFFF
					compatibility_size := 64
				else
					check
							-- Out of range values should have been checked above when computing
							-- value for `is_initialized'.
						False
					end
				end
			end
		end

	read_integer_hexa_value (sign: CHARACTER; s: STRING) is
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
			l_integer: INTEGER_A
		do
			is_initialized := True
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
				is_initialized := False
			end
				-- Set `size'
			if size < 32 then
				size := 32
			end
			if sign = '-' then
				negate
				check is_initialized implies (upper < 0 or else (upper = 0 and then lower = 0)) end
			end
			if is_initialized then
					-- Check that we have a constant that matches `constant_type'.
				l_integer ?= constant_type
				if l_integer /= Void then
					is_initialized := compatibility_size <= size
					size := l_integer.size
				end
			end
		end

	largest_integer_32: STRING is "2147483648"
			-- Largest string representation of 2^31

	largest_integer_64: STRING is "9223372036854775808"
			-- Largest string representation of 2^63

	largest_natural_32: STRING is "4294967295"
			-- Largest string representation of 2^32 - 1

	largest_natural_64: STRING is "18446744073709551615"
			-- Largest string representation of 2^64 - 1

	read_natural_value (s: STRING) is
			-- Read natural expressed in decimal representation.
		require
			s_not_void: s /= Void
			constant_type_not_void: constant_type /= Void
			constant_type_is_natural: constant_type.is_natural
		local
			last_int_64: INTEGER_64
			area: SPECIAL [CHARACTER]
			i, nb: INTEGER
			l_natural: NATURAL_A
		do
				-- Find wich type of constant we are trying to read.
			l_natural ?= constant_type
			size := l_natural.size

				-- Count leading zeroes
			from
				nb := s.count
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
	
			if size = 64 and then s > largest_natural_64 then
				compatibility_size := 64
				is_initialized := False
			else
				if nb < 10 or else (nb = 10 and then s <= largest_natural_32) then
					from
						i := 0
					until
						i >= nb
					loop
						last_int_64 := (last_int_64 * 10) + area.item (i).code - 48
						i := i + 1
					end
					check
						last_int_64_non_negative: last_int_64 >= 0
					end

					if last_int_64 <= 255 then
						compatibility_size := 8
					elseif last_int_64 <= 65535 then
						compatibility_size := 16
					elseif last_int_64 <= 4294967295 then
						compatibility_size := 32
					else
						check False end
					end

					lower := last_int_64.to_integer_32
						-- Ensure that the requested size matches what we computed.
					is_initialized := compatibility_size <= size
				elseif nb < 20 or else (nb = 20 and then s <= largest_natural_64) then
					from
						i := 0
					until
						i >= nb
					loop
						last_int_64 := (last_int_64 * 10) + area.item (i).code - 48
						i := i + 1
					end

					compatibility_size := 64
					lower := (last_int_64 & 0x00000000FFFFFFFF).to_integer_32
					upper := ((last_int_64 |>> 32) & 0x00000000FFFFFFFF).to_integer_32
					is_initialized := compatibility_size <= size
				else
					compatibility_size := 64
					is_initialized := False
				end
			end
		end

	read_integer_value (is_neg: BOOLEAN; s: STRING) is
			-- Read integer expressed in decimal representation.
		require
			s_not_void: s /= Void
		local
			last_integer: INTEGER
			last_int_64: INTEGER_64
			area: SPECIAL [CHARACTER]
			i, nb: INTEGER
			is_32bits, done: BOOLEAN
			l_integer: INTEGER_A
		do
			is_initialized := True

				-- Count leading zeroes
			from
				nb := s.count
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
				if not is_32bits and then is_neg and then s.is_equal (largest_integer_32) then
					done := True
					compatibility_size := 32
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
					if is_neg and then last_integer > 0 then
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
				elseif nb < 19 or else nb = 19 and then (s < largest_integer_64 or else is_neg and then s.is_equal (largest_integer_64)) then
					from
						i := 0
					until
						i >= nb
					loop
						last_int_64 := (last_int_64 * 10) + area.item (i).code - 48
						i := i + 1
					end

					if is_neg then
						last_int_64 := -last_int_64
					end

					compatibility_size := 64
					lower := (last_int_64 & 0x00000000FFFFFFFF).to_integer
					upper := ((last_int_64 |>> 32) & 0x00000000FFFFFFFF).to_integer
				else
						-- Value is out of range
					compatibility_size := 64
					is_initialized := False
				end
			end
			if is_initialized then
					-- Check that we have a constant that matches `constant_type'.
				l_integer ?= constant_type
				if l_integer /= Void then
					size := l_integer.size
					is_initialized := compatibility_size <= size
				else
					if compatibility_size = 64 then
						size := 64
					else
						size := 32
					end
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

invariant
	constant_type_valid: constant_type /= Void implies (constant_type.is_integer or constant_type.is_natural)
end
