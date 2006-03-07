indexing
	description: "Node for integer constant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

class
	INTEGER_AS

inherit
	ATOMIC_AS
		undefine
			text
		redefine
			is_equivalent
		end

	INTEGER_TYPE_MASKS

	LEAF_AS
		redefine
			first_token
		end

create
	make_from_string, make_from_hexa_string

feature {NONE} -- Initialization

	make_from_string (a_type: like constant_type; is_neg: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_iniialized' to false.
		require
--			valid_type: a_type /= Void implies (a_type.actual_type.is_integer or a_type.actual_type.is_natural)
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
--			valid_type: a_type /= Void implies (a_type.actual_type.is_integer or a_type.actual_type.is_natural)
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_long_enough: s.count >= 3
			s_has_hexadecimal_prefix: s.as_lower.substring_index ("0x", 1) = 1
			s_has_hexadecimal_suffix: -- for all i in [3..s.count] ("0123456789ABCDEFabcdef").has (s.item (i))
		do
			constant_type := a_type
			read_hexadecimal_value (sign, s)
		ensure
			constant_type_set: constant_type = a_type
		end

feature -- Roundtrip

	sign_symbol: SYMBOL_AS
			-- Symbol "+" or "-" associated with this structure

	set_sign_symbol (s_as: SYMBOL_AS) is
			-- Set `sign_symbol' with `s_as'.
		do
			sign_symbol := s_as
		ensure
			sign_symbol_set: sign_symbol = s_as
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Current
			else
				if sign_symbol /= Void then
					Result := sign_symbol.first_token (a_list)
				else
					Result := Current
				end
			end
		end

feature -- Access

	constant_type: TYPE_AS
			-- Type of integer constant if specified.

	has_constant_type: BOOLEAN is
			-- Has constant an explicit type?
		do
			Result := constant_type /= Void
		ensure
			constant_type_not_void: constant_type /= Void implies Result
		end

feature -- Properties

	is_initialized: BOOLEAN
			-- Is constant initialized to allowed value?

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_integer_as (Current)
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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value and then default_type = other.default_type and then
				types = other.types
		end

feature -- Output

	string_value: STRING is
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

feature {INTEGER_AS} -- Storage

	value: NATURAL_64
			-- Constant value without sign

	has_minus: BOOLEAN
			-- Has constant a minus sign?

feature {INTEGER_AS, INSPECT_CONTROL} -- Types

	default_type: INTEGER
			-- Default type of integer constant

	types: like default_type
			-- Possible types of integer constant
			-- (Combination of bit masks `integer_..._mask' and `natural_..._mask')

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
			if is_initialized and then has_constant_type then
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

			if is_initialized and then has_constant_type then
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
			has_constant_type: has_constant_type
		do
			default_type := integer_32_mask
		end

invariant
	constant_type_valid: True -- It should be either an integer or a natural type if a constant type is specified
	is_initialized: is_initialized implies (default_type /= 0 and types /= 0)
	one_default_type: default_type /= 0 implies is_one_mask (default_type)
	default_type_from_types: default_type /= 0 implies types & default_type /= 0
	valid_types:
		types & (
			integer_8_mask | integer_16_mask | integer_32_mask | integer_64_mask |
			natural_8_mask | natural_16_mask | natural_32_mask | natural_64_mask
		).bit_not = 0
	integer_priority: has_constant_type or else
		((has_integer (8) or has_integer (16) or has_integer (32) or has_integer (64)) implies
		(default_type = integer_mask (8) or default_type = integer_mask (16) or
		default_type = integer_mask (32) or default_type = integer_mask (64) or
		default_type = natural_mask (64)))
	non_negative_natural: (has_natural (8) or has_natural (16) or has_natural (32) or has_natural (64)) implies not has_minus

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
