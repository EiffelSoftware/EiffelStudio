indexing
	description: "Typed version of POINTER_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TYPED_POINTER_I

inherit
	BASIC_I
		rename
			make as old_make
		undefine
			anchor_instantiation_in,
			is_equal, generate_cid, il_type_name, generic_il_type_name, generate_cid_array,
			generate_cid_init, is_anchored, is_explicit, is_standalone, is_consistent, is_valid,
			has_true_formal, is_identical, generate_gen_type_il, make_full_type_byte_code_parameters,
			has_actual, has_formal, same_as, make_gen_type_byte_code, duplicate,
			instantiation_in, meta_generic, true_generics, hash_code, base_class,
			debug_output, complete_instantiation_in, internal_generic_derivation
		redefine
			is_feature_pointer, name,
			description, sk_value,
			element_type, reference_type, true_reference_type, tuple_code, hash_code
		end

	ONE_GEN_TYPE_I
		rename
			instantiated_description as description,
			reference_type as true_reference_type
		undefine
			is_basic, is_reference, cecil_value, is_void, c_type, generate_cecil_value, dump
		redefine
			is_feature_pointer, description, sk_value,
			element_type, tuple_code, true_reference_type,
			name, hash_code, internal_generic_derivation
		end

create
	make

feature -- Access

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class
		local
			t: TYPE_I
		do
			t := true_generics.item (1)
			Result := t.il_type_name (a_prefix).twin
			Result.append ("&")
			if a_prefix /= Void and then t.is_external then
				Result.precede ('.')
				Result.prepend (a_prefix)
			end
		end

	generic_il_type_name: STRING is
			-- Name of current class
		do
			Result := true_generics.item (1).generic_il_type_name.twin
			Result.append ("&")
		end

	reference_type: CL_TYPE_I is
			-- Type to which we metamorphose. Because generation of
			-- metamorphose on generic basic types is not done properly
			-- we do this as a temporary solution.
		do
			create Result.make (system.pointer_ref_class.compiled_class.class_id)
		end

	true_reference_type: GEN_TYPE_I is
			-- Corresponding reference type
		do
			Result := duplicate
			create Result.make (class_id, Result.meta_generic, Result.true_generics)
			if cr_info /= Void then
				Result.set_cr_info (cr_info)
			end
			Result.set_reference_mark
		end

	element_type: INTEGER_8 is
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_byref
		end

	tuple_code: INTEGER_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.pointer_tuple_code
		end

	internal_generic_derivation (a_level: INTEGER): like Current is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_I
			-- which can be used to search its associated CLASS_TYPE.
		local
			c: like cr_info
		do
			if system.il_generation then
					-- We need to keep track of all generic derivation,
					-- thus we can keep current as a valid generic derivation.
				c := cr_info
					-- Remove creation information.
				cr_info := Void
				Result := twin
				cr_info := c
				Result.set_meta_generic (meta_generic.twin)
				Result.set_true_generics (true_generics.twin)
				Result.meta_generic.put (Result.meta_generic.item (1).internal_generic_derivation (a_level + 1), 1)
				Result.true_generics.put (Result.true_generics.item (1).internal_generic_derivation (a_level + 1), 1)
			else
				Result := Precursor {ONE_GEN_TYPE_I} (a_level)
			end
		end

feature

	level: INTEGER is
			-- Internal code for generation
		do
			Result := C_pointer
		end

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

	name: STRING is
			-- Debug purpose
		do
			create Result.make (32)
			Result.append ("expanded ")
			Result.append (meta_generic.item (1).name)
			Result.append_character (' ')
			Result.append_character ('*')
			Result.append_character (' ')
		end

	description: POINTER_DESC is
			-- Type description for skeleton
		do
			create Result
		end

	c_string: STRING is
			-- String generated for the type.
		local
			l_str: STRING
			l_type_c: TYPE_C
		do
			l_type_c ?= meta_generic.item (1)
			if l_type_c /= Void then
				l_str := l_type_c.c_string
			else
					-- Case where element type of TYPED_POINTER is expanded.
					-- We force it to be a reference.
				l_str := reference_c_type.c_type.c_string
			end
			create Result.make (l_str.count + 2)
			Result.append (l_str)
			Result.append_character ('*')
			Result.append_character (' ')
		end

	typed_field: STRING is "it_p"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.pointer_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_pointer
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
			buffer.put_string ("type = SK_POINTER")
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_POINTER")
		end

	type_a: TYPED_POINTER_A is
		do
			create {TYPED_POINTER_A} Result.make_typed (meta_generic.item (1).type_a)
		end

feature

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append (Bc_null_pointer)
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
