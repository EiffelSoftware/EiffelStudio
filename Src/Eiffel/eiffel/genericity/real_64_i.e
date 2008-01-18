indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	REAL_64_I

inherit
	BASIC_I
		redefine
			is_real_64,
			is_numeric,
			element_type,
			description, sk_value, hash_code,
			default_create, tuple_code
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of REAL_64_I.
		do
			make (system.real_64_class.compiled_class.class_id)
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_r8
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.real_64_tuple_code
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.real_64_ref_class.compiled_class.class_id)
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_real64
		end

	is_real_64: BOOLEAN is True
			-- Is the type a double type ?

	is_numeric: BOOLEAN is True
			-- Is the type a numeric one ?

	description: REAL_64_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	c_string: STRING is "EIF_REAL_64"
			-- String generated for the type.

	typed_field: STRING is "it_r8"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.real_64_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_real64
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_REAL64")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REAL64")
		end

	type_a: REAL_64_A is
		do
			Result := real_64_type
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_real64)
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
