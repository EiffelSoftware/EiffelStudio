indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class REFERENCE_I

inherit
	TYPE_I
		redefine
			is_reference,
			same_as
		end

	TYPE_C
		undefine
			is_void, is_bit
		redefine
			is_pointer
		end

	SHARED_C_LEVEL

feature -- Status report

	element_type: INTEGER_8 is
			-- Reference element type.
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_object
		end

	tuple_code: INTEGER_8 is
			-- Tuple code
		do
			Result := {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_ref
		end

	is_pointer: BOOLEAN is True
			-- The C type is a reference type.

	is_reference: BOOLEAN is True
			-- is the C type a reference type ?

	name: STRING is "REFERENCE"
			-- Name of current class type

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		once
			Result := (create {CL_TYPE_I}.make (system.any_id)).il_type_name (Void)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := other.is_reference
		end

	c_type: TYPE_C is
			-- C type
		once
			Result := Current
		end

	description: REFERENCE_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	generate_cecil_value (f: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			generate_sk_value (f)
		end

	c_string: STRING is "EIF_REFERENCE"
			-- String generated for the type.

	typed_field: STRING is "it_r"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.reference_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_ref
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_REF")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_REF")
		end

	type_a: TYPE_A is
		do
			Result := System.any_class.compiled_class.actual_type
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
