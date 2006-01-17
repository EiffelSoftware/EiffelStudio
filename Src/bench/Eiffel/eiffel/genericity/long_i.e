indexing
	description: "C type for integers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class INTEGER_I

inherit
	BASIC_I
		rename
			make as base_make
		redefine
			is_integer,
			is_numeric,
			same_as, element_type,
			description, sk_value, hash_code,
			heaviest, tuple_code,
			maximum_interval_value,
			minimum_interval_value
		end

	BYTE_CONST
		export
			{NONE} all
		end
		
	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of LONG_I represented by `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n.to_integer_8
			inspect
				n
			when 8 then base_make (system.integer_8_class.compiled_class.class_id)
			when 16 then base_make (system.integer_16_class.compiled_class.class_id)
			when 32 then base_make (system.integer_32_class.compiled_class.class_id)
			when 64 then base_make (system.integer_64_class.compiled_class.class_id)
			end
		ensure
			size_set: size = n
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			inspect size
			when 8 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i1
			when 16 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i2
			when 32 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i4
			when 64 then Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i8
			end
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			inspect
				size
			when 8 then Result := {SHARED_GEN_CONF_LEVEL}.integer_8_tuple_code
			when 16 then Result := {SHARED_GEN_CONF_LEVEL}.integer_16_tuple_code
			when 32 then Result := {SHARED_GEN_CONF_LEVEL}.integer_32_tuple_code
			when 64 then Result := {SHARED_GEN_CONF_LEVEL}.integer_64_tuple_code
			end
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			inspect
				size
			when 8 then create Result.make (system.integer_8_ref_class.compiled_class.class_id)
			when 16 then create Result.make (system.integer_16_ref_class.compiled_class.class_id)
			when 32 then create Result.make (system.integer_32_ref_class.compiled_class.class_id)
			when 64 then create Result.make (system.integer_64_ref_class.compiled_class.class_id)
			end
		end

feature -- Access

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
	level: INTEGER is
			-- Internal code for generation
		do
			inspect size
			when 8 then Result := C_int8
			when 16 then Result := C_int16
			when 32 then Result := C_int32
			when 64 then Result := C_int64
			end
		end

	is_integer: BOOLEAN is True
			-- Is the type a integer type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is
		local
			l_long: like Current
		do
			if other.is_real_64 or other.is_real_32 then
				Result := other
			else
				if other.is_integer then
					l_long ?= other
					if size >= l_long.size then
						Result := Current
					else
						Result := other
					end
				else
					Result := Current
				end
			end
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		local
			o: like Current
		do
			if other.is_integer then
				o ?= other
				Result := size = o.size
			end
		end

	description: INTEGER_DESC is
			-- Type description for skeleton
		do
			create Result.make (size)
		end

	c_string: STRING is
			-- String generated for the type.
		do
			inspect size
			when 8 then Result := String_integer_8
			when 16 then Result := String_integer_16
			when 32 then Result := String_integer_32
			when 64 then Result := String_integer_64
			end
		end

	union_tag: STRING is
			-- Union name to specify type for Agents
		do
			inspect size
			when 8 then Result := Union_tag_8
			when 16 then Result := Union_tag_16
			when 32 then Result := Union_tag_32
			when 64 then Result := Union_tag_64
			end
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			inspect size
			when 8 then Result := Integer_8_code
			when 16 then Result := Integer_16_code
			when 32 then Result := Integer_32_code
			when 64 then Result := Integer_64_code
			end
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			inspect size
			when 8 then Result := Sk_int8
			when 16 then Result := Sk_int16
			when 32 then Result := Sk_int32
			when 64 then Result := Sk_int64
			end
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("it_int")
			buffer.put_integer (size)
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_INT")
			buffer.put_integer (size)
		end

	type_a: INTEGER_A is
		do
			create Result.make (size)
		end

feature -- Code generation

	minimum_interval_value: INTERVAL_VAL_B is
			-- Minimum value in inspect interval for current type
		do
			if size = 64 then
				create {INT64_VAL_B} Result.make (({INTEGER_64} -1) |<< (size - 1))
			else
				check
					valid_size: size = 8 or size = 16 or size = 32
				end
				create {INT_VAL_B} Result.make ((-1) |<< (size - 1))
			end
		end

	maximum_interval_value: INTERVAL_VAL_B is
			-- Maximum value in inspect interval for current type
		do
			if size = 64 then
				create {INT64_VAL_B} Result.make ((({INTEGER_64} 1) |<< (size - 1)) - 1)
			else
				check
					valid_size: size = 8 or size = 16 or size = 32
				end
				create {INT_VAL_B} Result.make ((1 |<< (size - 1)) - 1)
			end
		end

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			inspect size
			when 8 then
				ba.append (Bc_int8)
				ba.append_integer_8 (0)
			when 16 then
				ba.append (Bc_int16)
				ba.append_integer_16 (0)
			when 32 then
				ba.append (Bc_int32)
				ba.append_integer_32 (0)
			when 64 then
				ba.append (Bc_int64)
				ba.append_integer_64 (0)
			end
		end 

feature {NONE} -- Constants for generation

	String_integer_8: STRING is "EIF_INTEGER_8"
	String_integer_16: STRING is "EIF_INTEGER_16"
	String_integer_32: STRING is "EIF_INTEGER_32"
	String_integer_64: STRING is "EIF_INTEGER_64"

	Union_tag_8: STRING is "i8arg"
	Union_tag_16: STRING is "i16arg"
	Union_tag_32: STRING is "i32arg"
	Union_tag_64: STRING is "i64arg"

invariant

	correct_size: size = 8 or size = 16 or size = 32 or size = 64

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
