indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BOOLEAN_I

inherit
	BASIC_I
		redefine
			is_boolean,
			element_type,
			description, hash_code, sk_value,
			default_create, tuple_code
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of BOOLEAN_I
		do
			make (system.boolean_class.compiled_class.class_id)
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_boolean
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.boolean_tuple_code
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		do
			create Result.make (system.boolean_ref_class.compiled_class.class_id)
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_char
		end

	is_boolean: BOOLEAN is True
			-- Type is a boolean one.

	description: BOOLEAN_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	c_string: STRING is "EIF_BOOLEAN"
			-- String generated for the type.

	typed_field: STRING is "it_b"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := {SHARED_HASH_CODE}.boolean_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_bool
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_BOOL")
		end

	type_a: BOOLEAN_A is
		do
			Result := boolean_type
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_BOOL")
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_bool)
			ba.append ('%U')
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
