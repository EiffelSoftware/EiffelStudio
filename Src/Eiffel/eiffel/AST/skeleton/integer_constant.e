note
	description: "Node for integer constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	INTEGER_AS
		rename
			string_value as dump
		redefine
			adjust_type, has_constant_type
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
			size as byte_size,
			process as process_byte_node
		export
			{NONE} byte_real_type, byte_generate, byte_size
		redefine
			print_register,
			is_simple_expr, is_predefined,
			is_fast_as_local, is_constant_expression,
			evaluate
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

create
	make_with_value, make_from_string, make_from_hexa_string, make_from_octal_string, make_from_binary_string, make_from_type

feature {NONE} -- Initialization

	make_with_value (v: INTEGER)
			-- Create an integer constant of size 32.
		do
			is_initialized := True
			internal_constant_actual_type := Void
			if v > 0 then
				value := v.as_natural_64
				has_minus := False
			else
				value := (- v.as_integer_64).as_natural_64
				has_minus := True
			end
			compute_type
		ensure
			is_initialized: is_initialized
			has_integer: has_integer (32)
			default_type_set: default_type = integer_32_mask
			integer_32_value_set: integer_32_value = v
		end

	make_from_type (a_type: TYPE_A; is_neg: BOOLEAN; s: STRING)
			-- Create a new INTEGER AST node.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_iniialized' to false.
			-- (from INTEGER_AS)
			-- (export status {NONE})
		require -- from INTEGER_AS
			s_not_void: s /= Void
		do
			internal_constant_actual_type := a_type
			read_decimal_value (is_neg, s)
		ensure -- from INTEGER_AS
			constant_type_set: constant_actual_type = a_type
		end

feature -- Visitor

	process_byte_node (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_integer_constant (Current)
		end

feature -- Properties

	is_integer: BOOLEAN = True
			-- Is it an integer value?

	is_one: BOOLEAN
			-- Is constant equal to 1?
		do
			Result := value = 1 and then not has_minus
		end

	is_simple_expr: BOOLEAN = True
			-- A constant is a simple expression

	is_predefined: BOOLEAN = True
			-- A constant is a predefined structure.

	is_constant_expression: BOOLEAN = True
			-- A constant is a constant.

	has_constant_type: BOOLEAN
			-- Has constant an explicit type?
		do
			Result := constant_type /= Void or else internal_constant_actual_type /= Void
		ensure then
			constant_type_not_void: constant_type /= Void implies Result
		end

feature {NONE} -- Types

	constant_actual_type: TYPE_A
			-- Actual type of integer constant
		require
			has_constant_type: has_constant_type
		do
			Result := internal_constant_actual_type
			if Result = Void then
				Result := type_a_generator.evaluate_type (constant_type, system.current_class)
				internal_constant_actual_type := Result
			end
		ensure
			constant_actual_type_not_void: Result /= Void
			constant_actual_type_valid: Result.is_integer or Result.is_natural
		end

	internal_constant_actual_type: TYPE_A
			-- Once per object to store `actual_type' of `constant_type'.

feature -- Access

	type: TYPE_A
			-- Integer type
		do
			check
				is_initialized: is_initialized
			end
			inspect default_type
			when integer_8_mask then
				Result := integer_8_type
			when integer_16_mask then
				Result := integer_16_type
			when integer_32_mask then
				Result := integer_32_type
			when integer_64_mask then
				Result := integer_64_type
			when natural_8_mask then
				Result := natural_8_type
			when natural_16_mask then
				Result := natural_16_type
			when natural_32_mask then
				Result := natural_32_type
			when natural_64_mask then
				Result := natural_64_type
			end
		end

	manifest_type: TYPE_A
			-- Manifest integer type
		require
			is_initialized: is_initialized
		local
			compatibility_size: INTEGER_8
		do
			if has_constant_type then
				Result := constant_actual_type
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
					create {MANIFEST_INTEGER_A} Result.make_for_constant (32, types)
				when integer_64_mask then
					create {MANIFEST_INTEGER_A} Result.make_for_constant (64, types)
				when natural_64_mask then
					create {MANIFEST_NATURAL_64_A} Result.make_for_constant (has_integer (64))
				end
			end
		end

feature -- Evaluation

	evaluate: VALUE_I
			-- Evaluate current expression, if possible.
		do
			Result := Current
		end

feature -- Unary operators

	unary_minus: INTEGER_CONSTANT
			-- Apply `-' operator to Current.
		do
			Result := twin
			Result.negate
		end

feature -- Type checking

	valid_type (t: TYPE_A): BOOLEAN
			-- Is the current value compatible with `t'?
		do
			if t.is_integer or else t.is_natural then
					-- Check if possible types include a given one
				Result := (types & type_mask (t)) /= 0
			end
		end

	inspect_value (value_type: TYPE_A): INTERVAL_VAL_B
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
			elseif value_type.is_natural then

				check
					natural_type: value_type.is_natural
				end
				natural_a ?= value_type
				if natural_a.size = 64 then
					create {NAT64_VAL_B} Result.make (natural_value)
				else
					create {NAT_VAL_B} Result.make (natural_value.as_natural_32)
				end
			elseif value_type.is_enum then
				create {INT_VAL_B} Result.make (integer_value.as_integer_32)
			else
				check False end
			end
		end

feature -- Conveniences

	used (r: REGISTRABLE): BOOLEAN
		do
		end

feature -- Settings

	set_real_type (t: TYPE_A)
			-- Extract size information of `t' and assign it to Current.
			-- It will discard existing information, because it might be
			-- possible that we entered an INTEGER_8 constant value.
		do
			internal_constant_actual_type := t
			adjust_type
		ensure then
			is_initialized: is_initialized
			has_constant_type: has_constant_type
			default_type_set: default_type = type_mask (constant_actual_type)
		end

feature -- Generation

	print_register
			-- Print integer constant
			--| The '()' are present for the case where int_val=INT32_MIN,
			--| ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			generate (buffer)
		end

	generate (buf: GENERATION_BUFFER)
			-- Generate value in `buf'.
			-- The '()' are present for the case where lower=INT32_MIN,
			-- ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		local
			l_int: like integer_32_value
			l_int64: like integer_64_value
		do
			buf.put_character ('(')
			inspect default_type
			when integer_8_mask then
				integer_8_type.c_type.generate_cast (buf)
				buf.put_integer (integer_8_value)
				buf.put_character ('L')
			when integer_16_mask then
				integer_16_type.c_type.generate_cast (buf)
				buf.put_integer (integer_16_value)
				buf.put_character ('L')
			when integer_32_mask then
					-- Special treatment of `min_value' so that the C compiler
					-- does not complain as -2147483648 is treated as -(2147483648)
					-- as it is therefore an unsigned value we are trying to negate
					-- and the C compiler warns it is still unsigned, although at
					-- the end it is ok with the cast.
				integer_32_type.c_type.generate_cast (buf)
				l_int := integer_32_value
				if l_int = {INTEGER}.min_value then
					buf.put_hex_integer_32 (l_int)
				else
					buf.put_integer (integer_32_value)
				end
				buf.put_character ('L')
			when integer_64_mask then
					-- Special treatment of `min_value' so that the C compiler
					-- does not complain as -9223372036854775808 is treated as -(9223372036854775808)
					-- as it is therefore an unsigned value we are trying to negate
					-- and the C compiler warns it is still unsigned, although at
					-- the end it is ok with the cast.
				integer_64_type.c_type.generate_cast (buf)
				buf.put_string ({C_CONST}.rti64c)
				buf.put_character ('(')
				l_int64 := integer_64_value
				if l_int64 = {INTEGER_64}.min_value then
					buf.put_hex_integer_64 (l_int64)
				else
					buf.put_integer_64 (integer_64_value)
				end
				buf.put_character (')')
			when natural_8_mask then
				natural_8_type.c_type.generate_cast (buf)
				buf.put_natural_8 (natural_8_value)
				buf.put_character ('U')
			when natural_16_mask then
				natural_16_type.c_type.generate_cast (buf)
				buf.put_natural_16 (natural_16_value)
				buf.put_character ('U')
			when natural_32_mask then
				natural_32_type.c_type.generate_cast (buf)
				buf.put_natural_32 (natural_32_value)
				buf.put_character ('U')
			when natural_64_mask then
				natural_64_type.c_type.generate_cast (buf)
				buf.put_string ({C_CONST}.rtu64c)
				buf.put_character ('(')
				buf.put_natural_64 (natural_64_value)
				buf.put_character (')')
			end
			buf.put_character (')')
		end

	is_fast_as_local: BOOLEAN = True
			-- Is expression calculation as fast as loading a local?

	il_element_type: INTEGER_8
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

	generate_il
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

	make_byte_code (ba: BYTE_ARRAY)
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

feature {INTEGER_CONSTANT} -- Operations

	negate
			-- Perform negation of current value.
		do
			has_minus := not has_minus
				-- Size might be changed
			compute_type
		end

feature {NONE} -- Implementation

	type_mask (t: TYPE_A): like default_type
			-- Bit mask for the given type `t'
		local
			integer_a: INTEGER_A
			natural_a: NATURAL_A

		do
			if t.is_integer then
				integer_a ?= t
				Result := integer_mask (integer_a.size)
			elseif t.is_natural then
				natural_a ?= t
				Result := natural_mask (natural_a.size)
			end
		end

	adjust_type
			-- Make sure that this constant matches `constant_type' if possible.
			-- Set `is_initialized' to `False' otherwise.
		local
			mask: like default_type
		do
			mask := type_mask (constant_actual_type)
			if types & mask = 0 then
				is_initialized := False
			else
				default_type := mask
			end
		ensure then
			default_type_set: is_initialized implies default_type = type_mask (constant_actual_type)
		end

invariant
	constant_type_valid: has_constant_type implies
		(constant_actual_type.is_integer or constant_actual_type.is_natural)

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
