indexing
	description: "Real data type for code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REAL_32_I

inherit
	BASIC_I
		redefine
			is_real_32,
			is_numeric,
			element_type,
			description, sk_value, hash_code,
			heaviest, default_create, tuple_code
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance of REAL_32_I.
		do
			make (system.real_32_class.compiled_class.class_id)
		end

feature -- Access

	description: REAL_32_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.real_32_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_real32
		end

	type_a: REAL_32_A is
		do
			Result := real_32_type
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_r4
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.real_32_tuple_code
		end

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_real32
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.real_32_ref_class.compiled_class.class_id)
		end

feature -- Status report

	is_real_32: BOOLEAN is True
			-- Is the type a REAL_32 type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	heaviest (other : TYPE_I) : TYPE_I is
			-- `other' if `other' is heavier than Current,
			-- Current otherwise.
		do
			if other.is_real_64 then
				Result := other
			else
				Result := Current
			end
		end

feature -- C code generation

	c_string: STRING is "EIF_REAL_32"
			-- String generated for the type.

	typed_field: STRING is "it_r4"
			-- Value field of a C structure corresponding to this type

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_REAL32")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REAL32")
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
				-- For precision purpose, `Bc_real32' accepts
				-- a double value.
			ba.append (Bc_real32)
			ba.append_double (0.0)
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
