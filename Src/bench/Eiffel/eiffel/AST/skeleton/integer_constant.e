indexing
	description: "Node for integer constant. Version for Bench."
	value: "[
		Integer constant denotes a value with a possible type defined as follows
		(i8 stands for INTEGER_8, n8 - for NATURAL_8 etc.):
		      Value     |             Possible type            | Default type
		----------------+--------------------------------------+--------------
		 -2^63..-2^31-1 |               i64                    | i64
		 -2^31..-2^15-1 |          i32, i64                    | i32
		 -2^15..-2^07-1 |     i16, i32, i64                    | i32
		 -2^07..-1      | i8, i16, i32, i64                    | i32
		     0.. 2^07-1 | i8, i16, i32, i64, n8, n16, n32, n64 | i32
		  2^07.. 2^08-1 |     i16, i32, i64, n8, n16, n32, n64 | i32
		  2^08.. 2^15-1 |     i16, i32, i64,     n16, n32, n64 | i32
		  2^15.. 2^16-1 |          i32, i64,     n16, n32, n64 | i32
		  2^16.. 2^31-1 |          i32, i64,          n32, n64 | i32
		  2^31.. 2^32-1 |               i64,          n32, n64 | i64
		  2^32.. 2^63-1 |               i64,               n64 | i64
		  2^63.. 2^64-1 |                                  n64 | n64
		In addition the following possible types can be denoted by unsigned
		hexadecimal numbers regardless of their value:
		 Number of digits | Additional possible type
		------------------+--------------------------
		         2        | i8
		         4        | i16
		         8        | i32
		        16        | i64
	]"
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
			generate, is_integer, inspect_value,
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
			is_initialized := True
			constant_type := Void
			if v > 0 then
				value := v.as_natural_64
				has_minus := False
			else
				value := (- v.as_integer_64).as_natural_64
				has_minus := True
			end
			default_type := integer_32_mask
			types := integer_32_mask
		ensure
			is_initialized: is_initialized
			has_integer: has_integer (32)
			default_type_set: default_type = integer_32_mask
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
			read_decimal_value (is_neg, s)
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
			read_hexadecimal_value (sign, s)
		ensure
			constant_type_set: constant_type = a_type
		end

feature -- Access

	constant_type: TYPE_A
			-- Actual type of integer constant if specified.

feature -- Properties

	is_initialized: BOOLEAN
			-- Is constant initialized to allowed value?

	is_integer: BOOLEAN is True
			-- Is it an integer value?

	is_one: BOOLEAN is
			-- Is constant equal to 1?
		do
			Result := value = 1 and then not has_minus
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

	natural_8_value: NATURAL_8 is
			-- 8-bit natural value
		require
			has_natural: has_natural (8)
		do
			Result := value.as_natural_8
		end

	natural_16_value: NATURAL_16 is
			-- 16-bit natural value
		require
			has_natural: has_natural (16)
		do
			Result := value.as_natural_16
		end

	natural_32_value: NATURAL_32 is
			-- 32-bit natural value
		require
			has_natural: has_natural (32)
		do
			Result := value.as_natural_32
		end

	natural_64_value: NATURAL_64 is
			-- 64-bit natural value
		require
			has_natural: has_natural (64)
		do
			Result := value
		end

	integer_8_value: INTEGER_8 is
			-- 8-bit integer value
		require
			has_integer: has_integer (8)
		do
			Result := value.as_integer_8
			if has_minus then
				Result := - Result
			end
		end

	integer_16_value: INTEGER_16 is
			-- 16-bit integer value
		require
			has_integer: has_integer (16)
		do
			Result := value.as_integer_16
			if has_minus then
				Result := - Result
			end
		end

	integer_32_value: INTEGER is
			-- 32-bit integer value
		require
			has_integer: has_integer (32)
		do
			Result := value.as_integer_32
			if has_minus then
				Result := - Result
			end
		end

	integer_64_value: INTEGER_64 is
			-- 64-bit integer value
		require
			has_integer: has_integer (64)
		do
			Result := value.as_integer_64
			if has_minus then
				Result := - Result
			end
		end

	has_integer (s: INTEGER_8): BOOLEAN is
			-- Is there INTEGER_nn type among possible constant types, where nn is `s'?
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			Result := types & integer_mask (s) /= 0
		ensure
			definition: Result = (types & integer_mask (s) /= 0)
		end

	has_natural (s: INTEGER_8): BOOLEAN is
			-- Is there NATURAL_nn type among possible constant types, where nn is `s'?
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			Result := types & natural_mask (s) /= 0
		ensure
			definition: Result = (types & natural_mask (s) /= 0)
		end

	type: TYPE_I is
			-- Integer type
		do
			check
				is_initialized: is_initialized
			end
			inspect default_type
			when integer_8_mask then
				create {INTEGER_I} Result.make (8)
			when integer_16_mask then
				create {INTEGER_I} Result.make (16)
			when integer_32_mask then
				create {INTEGER_I} Result.make (32)
			when integer_64_mask then
				create {INTEGER_I} Result.make (64)
			when natural_8_mask then
				create {NATURAL_I} Result.make (8)
			when natural_16_mask then
				create {NATURAL_I} Result.make (16)
			when natural_32_mask then
				create {NATURAL_I} Result.make (32)
			when natural_64_mask then
				create {NATURAL_I} Result.make (64)
			end
		end

	manifest_type: TYPE_A is
			-- Manifest integer type
		require
			is_initialized: is_initialized
		local
			compatibility_size: INTEGER_8
		do
			if constant_type /= Void then
				Result := constant_type
			else
				if has_integer (8) then
					compatibility_size := 8
				elseif has_integer (16) then
					compatibility_size := 16
				elseif has_integer (32) then
					compatibility_size := 32
				else
					compatibility_size := 64
				end
					-- Default can be only the following types: INTEGER_32, INTEGER_64, NATURAL_64
				inspect default_type
				when integer_32_mask then
					create {MANIFEST_INTEGER_A} Result.make_for_constant (32, compatibility_size, has_minus)
				when integer_64_mask then
					create {MANIFEST_INTEGER_A} Result.make_for_constant (64, compatibility_size, has_minus)
				when natural_64_mask then
					create {MANIFEST_NATURAL_64_A} Result.make_for_constant (has_integer (64))
				end
			end
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
			Result := value = other.value and then default_type = other.default_type and then types = other.types
		end

feature -- Type checking

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t'?
		do
			if t.is_integer or else t.is_natural then
					-- Check if possible types include a given one
				Result := (types & type_mask (t)) /= 0
			end
		end

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			ast_context.put (manifest_type)
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
			natural_a: NATURAL_A
			integer_value: INTEGER_64
			natural_value: NATURAL_64
		do
				-- Use default type to calculate constant value to take into account
				-- that "{INTEGER_8} 0xFF" is equivalent to "{INTEGER_8} -1" and that
				-- "{NATURAL_8} 0xFF" is equivalent to "{NATURAL_8} 255" that results
				-- in inspect values "-1" and "255" respectively when type of inspect
				-- expression is INTEGER.
			inspect default_type
			when integer_8_mask then
				integer_value := integer_8_value
				natural_value := integer_value.as_natural_64
			when integer_16_mask then
				integer_value := integer_16_value
				natural_value := integer_value.as_natural_64
			when integer_32_mask then
				integer_value := integer_32_value
				natural_value := integer_value.as_natural_64
			when integer_64_mask then
				integer_value := integer_64_value
				natural_value := integer_value.as_natural_64
			when natural_8_mask then
				fixme ("Remove explicit conversion from NATURAL_8 to NATURAL_64 after bootstrap.")
				natural_value := natural_8_value.as_natural_64
				integer_value := natural_value.as_integer_64
			when natural_16_mask then
				fixme ("Remove explicit conversion from NATURAL_16 to NATURAL_64 after bootstrap.")
				natural_value := natural_16_value.as_natural_64
				integer_value := natural_value.as_integer_64
			when natural_32_mask then
				fixme ("Remove explicit conversion from NATURAL_32 to NATURAL_64 after bootstrap.")
				natural_value := natural_32_value.as_natural_64
				integer_value := natural_value.as_integer_64
			when natural_64_mask then
				fixme ("Remove explicit conversion from NATURAL_64 to NATURAL_64 after bootstrap.")
				natural_value := natural_64_value.as_natural_64
				integer_value := natural_value.as_integer_64
			end
			if value_type.is_integer then
				integer_a ?= value_type
				if integer_a.size = 64 then
					create {INT64_VAL_B} Result.make (integer_value)
				else
					create {INT_VAL_B} Result.make (integer_value.as_integer_32)
				end
			else
				check
					natural_type: value_type.is_natural
				end
				natural_a ?= value_type
				if natural_a.size = 64 then
					create {NAT64_VAL_B} Result.make (natural_value)
				else
					create {NAT_VAL_B} Result.make (natural_value.as_natural_32)
				end
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

	set_real_type (t: TYPE_A) is
			-- Extract size information of `t' and assign it to Current.
			-- It will discard existing information, because it might be
			-- possible that we entered an INTEGER_8 constant value.
		local
			mask: like default_type
		do
			constant_type := t
			adjust_type
		ensure then
			is_initialized: is_initialized
			default_type_set: default_type = type_mask (constant_type)
		end

feature -- Output

	dump: STRING is
			-- String representation of manifest constant.
		do
			inspect default_type
			when integer_8_mask then Result := integer_8_value.out
			when integer_16_mask then Result := integer_16_value.out
			when integer_32_mask then Result := integer_32_value.out
			when integer_64_mask then Result := integer_64_value.out
			when natural_8_mask then Result := natural_8_value.out
			when natural_16_mask then Result := natural_16_value.out
			when natural_32_mask then Result := natural_32_value.out
			when natural_64_mask then Result := natural_64_value.out
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
		end

	generate (buf: GENERATION_BUFFER) is
			-- Generate value in `buf'.
			-- The '()' are present for the case where lower=INT32_MIN,
			-- ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		local
			l_int: like integer_32_value
		do
			buf.put_character ('(')
			inspect default_type
			when integer_8_mask then
				buf.put_string (integer_8_cast)
				buf.put_integer (integer_8_value)
				buf.put_character ('L')
			when integer_16_mask then
				buf.put_string (integer_16_cast)
				buf.put_integer (integer_16_value)				
				buf.put_character ('L')
			when integer_32_mask then
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
				buf.put_character ('L')
			when integer_64_mask then
				buf.put_string (integer_64_cast)
				buf.put_string ("RTI64C(")
				buf.put_string (integer_64_value.out)
				buf.put_character (')')
			when natural_8_mask then
				buf.put_string (natural_8_cast)
				buf.put_string (natural_8_value.out)
				buf.put_character ('U')
			when natural_16_mask then
				buf.put_string (natural_16_cast)
				buf.put_string (natural_16_value.out)
				buf.put_character ('U')
			when natural_32_mask then
				buf.put_string (natural_32_cast)
				buf.put_string (natural_32_value.out)
				buf.put_character ('U')
			when natural_64_mask then
				buf.put_string (natural_64_cast)
				buf.put_string ("RTU64C(")
				buf.put_string (natural_64_value.out)
				buf.put_character (')')
			end
			buf.put_character (')')
		end

	is_fast_as_local: BOOLEAN is True
			-- Is expression calculation as fast as loading a local?

	il_element_type: INTEGER_8 is
			-- Default IL element type matching this constant type
		do
			inspect default_type
			when integer_8_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_i1
			when integer_16_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_i2
			when integer_32_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_i4
			when integer_64_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_i8
			when natural_8_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u1
			when natural_16_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u2
			when natural_32_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u4
			when natural_64_mask then
				Result := {MD_SIGNATURE_CONSTANTS}.element_type_u8
			end
		end

	generate_il is
			-- Generate IL code for integer constant value.
		do
			inspect default_type
			when integer_8_mask then
				il_generator.put_integer_8_constant (integer_8_value)
			when integer_16_mask then
				il_generator.put_integer_16_constant (integer_16_value)
			when integer_32_mask then
				il_generator.put_integer_32_constant (integer_32_value)
			when integer_64_mask then
				il_generator.put_integer_64_constant (integer_64_value)
			when natural_8_mask then
				il_generator.put_natural_8_constant (natural_8_value)
			when natural_16_mask then
				il_generator.put_natural_16_constant (natural_16_value)
			when natural_32_mask then
				il_generator.put_natural_32_constant (natural_32_value)
			when natural_64_mask then
				il_generator.put_natural_64_constant (natural_64_value)
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			inspect default_type
			when integer_8_mask then
				ba.append (Bc_int8)
				ba.append_integer_8 (integer_8_value)
			when integer_16_mask then
				ba.append (Bc_int16)
				ba.append_integer_16 (integer_16_value)
			when integer_32_mask then
				ba.append (Bc_int32)
				ba.append_integer (integer_32_value)
			when integer_64_mask then
				ba.append (Bc_int64)
				ba.append_integer_64 (integer_64_value)
			when natural_8_mask then
				ba.append (Bc_uint8)
				ba.append_natural_8 (natural_8_value)
			when natural_16_mask then
				ba.append (Bc_uint16)
				ba.append_natural_16 (natural_16_value)
			when natural_32_mask then
				ba.append (Bc_uint32)
				ba.append_natural_32 (natural_32_value)
			when natural_64_mask then
				ba.append (Bc_uint64)
				ba.append_natural_64 (natural_64_value)
			end
		end

feature {INTEGER_CONSTANT} -- Storage

	value: NATURAL_64
			-- Constant value without sign

	has_minus: BOOLEAN
			-- Has constant a minus sign?

feature {INTEGER_CONSTANT} -- Operations

	negate is
			-- Perform negation of current value.
		do
			has_minus := not has_minus
				-- Size might be changed
			compute_type
		end
	
feature {INTEGER_CONSTANT} -- Types

	default_type: INTEGER
			-- Default type of integer constant

	types: like default_type
			-- Possible types of integer constant
			-- (Combination of bit masks `integer_..._mask' and `natural_..._mask')

feature {NONE} -- Types

	integer_8_mask:  INTEGER is 0x01
			-- Bit mask for INTEGER_8

	integer_16_mask: INTEGER is 0x02
			-- Bit mask for INTEGER_16

	integer_32_mask: INTEGER is 0x04
			-- Bit mask for INTEGER_32

	integer_64_mask: INTEGER is 0x08
			-- Bit mask for INTEGER_64

	natural_8_mask:  INTEGER is 0x10
			-- Bit mask for NATURAL_8

	natural_16_mask: INTEGER is 0x20
			-- Bit mask for NATURAL_16

	natural_32_mask: INTEGER is 0x40
			-- Bit mask for NATURAL_32

	natural_64_mask: INTEGER is 0x80
			-- Bit mask for NATURAL_64

	is_one_mask (mask: like default_type): BOOLEAN is
			-- Does `mask' represent one type mask?
		do
			if
				mask = integer_8_mask or mask = integer_16_mask or mask = integer_32_mask or mask = integer_64_mask or
				mask = natural_8_mask or mask = natural_16_mask or mask = natural_32_mask or mask = natural_64_mask
			then
				Result := true
			end
		ensure
			definition: Result =
				(mask = integer_8_mask or mask = integer_16_mask or mask = integer_32_mask or mask = integer_64_mask or
				mask = natural_8_mask or mask = natural_16_mask or mask = natural_32_mask or mask = natural_64_mask)
		end

	type_mask (t: TYPE_A): like default_type is
			-- Bit mask for the given type `t'
		require
			valid_type: t.is_integer or t.is_natural
		local
			integer_a: INTEGER_A
			natural_a: NATURAL_A
		do
			if t.is_integer then
				integer_a ?= t
				Result := integer_mask (integer_a.size)
			else
				natural_a ?= t
				Result := natural_mask (natural_a.size)
			end
		ensure
			valid_mask: is_one_mask (Result)
		end

	integer_mask (s: INTEGER_8): like default_type is
			-- Bit mask for integer type of size `s'
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			inspect s
			when 8 then Result := integer_8_mask
			when 16 then Result := integer_16_mask
			when 32 then Result := integer_32_mask
			when 64 then Result := integer_64_mask
			end
		ensure
			one_mask: is_one_mask (Result)
			definition:
				(s = 8 implies Result = integer_8_mask) and
				(s = 16 implies Result = integer_16_mask) and
				(s = 32 implies Result = integer_32_mask) and
				(s = 64 implies Result = integer_64_mask)
		end

	natural_mask (s: INTEGER_8): like default_type is
			-- Bit mask for natural type of size `s'
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			inspect s
			when 8 then Result := natural_8_mask
			when 16 then Result := natural_16_mask
			when 32 then Result := natural_32_mask
			when 64 then Result := natural_64_mask
			end
		ensure
			one_mask: is_one_mask (Result)
			definition:
				(s = 8 implies Result = natural_8_mask) and
				(s = 16 implies Result = natural_16_mask) and
				(s = 32 implies Result = natural_32_mask) and
				(s = 64 implies Result = natural_64_mask)
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

	read_hexadecimal_value (sign: CHARACTER; s: STRING) is
			-- Convert hexadecimal representation `s' with sign `sign' into an integer or natural value.
		require
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_large_enough: s.count > 2
		local
			i, j: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
			last_nat_64: NATURAL_64
			type_a: TYPE_A
			mask: like default_type
		do
			is_initialized := True
			j := s.count - 1
			area := s.area

			from
			until
				(j - i) < 2 or else i = 16
			loop
				val := area.item (j - i).lower
				if val >= 'a' then
					last_nat_64 := last_nat_64 | ((val.code - 87).as_natural_64 |<< (i * 4))
				else
					last_nat_64 := last_nat_64 | ((val.code - 48).as_natural_64 |<< (i * 4))
				end
				i := i + 1
			end
			
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
			if i > 16 then
					-- Number is too large
				is_initialized := False
			else
				has_minus := sign = '-'
				value := last_nat_64
				compute_type
				if sign = '%U' then
						-- Allow for integers to be specified using a hexadecimal representation regardless 
						-- of their value provided that number of digits matches integer length.
					inspect i
					when 2 then types := types | integer_8_mask
					when 4 then types := types | integer_16_mask
					when 8 then types := types | integer_32_mask
					when 16 then types := types | integer_64_mask
					else
						-- Do not change `types'.
					end
				end
			end
			if is_initialized and then constant_type /= Void then
					-- Adjust type to match `constant_type'.
				adjust_type
			end
		end

	largest_natural_64: STRING is "18446744073709551615"
			-- Largest string representation of 2^64 - 1

	read_decimal_value (is_neg: BOOLEAN; s: STRING) is
			-- Read integer or natural expressed in decimal representation.
		require
			s_not_void: s /= Void
			-- valid_decimal: for i in 1..s.count ("0123456789").has (s.item (i))
		local
			area: SPECIAL [CHARACTER]
			i, nb: INTEGER
			last_nat_64: NATURAL_64
			type_a: TYPE_A
			mask: like default_type
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
			
			if nb > 20 or else nb = 20 and then s > largest_natural_64 then
					-- Number is too large
				types := 0
				default_type := 0
				is_initialized := False
			else
				from
					area := s.area
					i := 0
				until
					i >= nb
				loop
					last_nat_64 := (last_nat_64 * 10) + (area.item (i).code - 48).as_natural_64
					i := i + 1
				end
				value := last_nat_64
				has_minus := is_neg
				compute_type
			end

			if is_initialized and then constant_type /= Void then
					-- Adjust type to match `constant_type'.
				adjust_type
			end
		end

	compute_type is
			-- Compute `types' and `default_type' from the value of the constant.
		local
			v: like value
		do
			v := value
			if has_minus and then v /= 0 then
					-- This is not a natural number
				if v <= 0x80 then
						-- -0x80..-1
					types := integer_8_mask | integer_16_mask | integer_32_mask | integer_64_mask
				elseif v <= 0x8000 then
						-- -0x8000..-0x81
					types := integer_16_mask | integer_32_mask | integer_64_mask
				elseif v <= (0x40000000).as_natural_64 * 2 then
					fixme ("Replace above with `v <= {NATURAL_64} 0x80000000' after bootstrap.")
						-- -0x80000000..-0x8001
					types := integer_32_mask | integer_64_mask
				elseif v <= (0x40000000).as_natural_64 * (0x40000000).as_natural_64 * 8 then
					fixme ("Replace above with `v <= {NATURAL_64} 0x8000000000000000' after bootstrap.")
						-- -0x8000000000000000..-0x80000001
					types := integer_64_mask
				else
						-- Number is too small
					types := 0
				end
			else
					-- This is either integer or natural number
				if v <= 0x7F then
						-- 0..0x7F
					types :=
						integer_8_mask | integer_16_mask | integer_32_mask | integer_64_mask |
						natural_8_mask | natural_16_mask | natural_32_mask | natural_64_mask
				elseif v <= 0xFF then
						-- 0x80..0xFF
					types :=
						integer_16_mask | integer_32_mask | integer_64_mask |
						natural_8_mask | natural_16_mask | natural_32_mask | natural_64_mask
				elseif v <= 0x7FFF then
						-- 0x100..0x7FFF
					types :=
						integer_16_mask | integer_32_mask | integer_64_mask |
						natural_16_mask | natural_32_mask | natural_64_mask
				elseif v <= 0xFFFF then
						-- 0x8000..0xFFFF
					types :=
						integer_32_mask | integer_64_mask |
						natural_16_mask | natural_32_mask | natural_64_mask
				elseif v <= 0x7FFFFFFF then
						-- 0x10000..0x7FFFFFFF
					types := integer_32_mask | integer_64_mask | natural_32_mask | natural_64_mask
				elseif v <= (0xFFFFFFF).as_natural_64 * 0x10 + 0xF then
					fixme ("Replace above with `v <= {NATURAL_64} 0xFFFFFFFF' after bootstrap.")
						-- 0x80000000..0xFFFFFFFF
					types := integer_64_mask | natural_32_mask | natural_64_mask
				elseif v <= 0x7FFFFFFFFFFFFFFF then
						-- 0x100000000..0x7FFFFFFFFFFFFFFF
					types := integer_64_mask | natural_64_mask
				else
						-- 0x8000000000000000..0xFFFFFFFFFFFFFFFF
					check
						v <= ((0xFFFFFFF).as_natural_64 * 0x10000000 + 0xFFFFFFF) * 0x100 + 0xFF
					end
					fixme ("Replace above with `v <= {NATURAL_64} 0xFFFFFFFFFFFFFFFF' after bootstrap.")
					types := natural_64_mask
				end
			end
			if types & integer_32_mask /= 0 then
				default_type := integer_32_mask
			elseif types & integer_64_mask /= 0 then
				default_type := integer_64_mask
			elseif types & natural_64_mask /= 0 then
				default_type := natural_64_mask
			else
				default_type := 0
				is_initialized := False
			end
		end

	adjust_type is
			-- Make sure that this constant matches `constant_type' if possible.
			-- Set `is_initialized' to `False' otherwise.
		require
			is_initialized: is_initialized
			constant_type_not_void: constant_type /= Void
		local
			mask: like default_type
		do
			mask := type_mask (constant_type)
			if types & mask = 0 then
				is_initialized := False
			else
				default_type := mask
			end
		ensure
			default_type_set: is_initialized implies default_type = type_mask (constant_type)
		end

invariant

	constant_type_valid: constant_type /= Void implies (constant_type.is_integer or constant_type.is_natural)
	is_initialized: is_initialized implies (default_type /= 0 and types /= 0)
	one_default_type: default_type /= 0 implies is_one_mask (default_type)
	default_type_from_types: default_type /= 0 implies types & default_type /= 0
	valid_types:
		types & (
			integer_8_mask | integer_16_mask | integer_32_mask | integer_64_mask |
			natural_8_mask | natural_16_mask | natural_32_mask | natural_64_mask
		).bit_not = 0
	integer_priority: 
		(has_integer (8) or has_integer (16) or has_integer (32) or has_integer (64)) implies
		(default_type = integer_mask (8) or default_type = integer_mask (16) or
		default_type = integer_mask (32) or default_type = integer_mask (64))
	non_negative_natural: (has_natural (8) or has_natural (16) or has_natural (32) or has_natural (64)) implies not has_minus

end
