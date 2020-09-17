note
	description: "Actual type for typed pointer type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TYPED_POINTER_A

inherit
	BASIC_A
		rename
			make as cl_make
		undefine
			hash_code, generics, has_like, has_like_argument, parent_type,
			deep_actual_type, context_free_type, ext_append_to, internal_conform_to,
			has_formal_generic, is_loose, valid_generic, actual_argument_type,
			formal_instantiated_in, instantiated_in, good_generics, error_generics, check_constraints,
			expanded_deferred, valid_expanded_creation, update_dependance,
			has_expanded, dump, duplicate, reference_type,
			is_equivalent, instantiation_of, same_as, instantiation_in, recomputed_in,
			is_full_named_type, evaluated_type_in_descendant, is_explicit, is_known,
			generate_cid, generate_cid_array, generate_cid_init, has_actual,
			make_type_byte_code, generate_gen_type_il, internal_is_valid_for_class,
			adapted_in, skeleton_adapted_in, is_class_valid, is_valid_generic_derivation,
			dispatch_anchors, has_like_current, internal_generic_derivation,
			internal_same_generic_derivation_as, generic_derivation, check_labels,
			duplicate_for_instantiation, deanchored_form_marks_free
		redefine
			base_class,
			generic_il_type_name,
			il_type_name,
			is_typed_pointer,
			process
		end

	GEN_TYPE_A
		undefine
			cl_make,
			description,
			description_with_detachable_type,
			element_type,
			generate_cecil_value,
			has_reference,
			instantiated_description,
			is_basic,
			is_expanded_creation_possible,
			is_processor_attachable_to,
			meta_type,
			sk_value
		redefine
			base_class,
			c_type,
			generic_il_type_name,
			il_type_name,
			is_typed_pointer,
			process,
			reference_type
		end

create
	make_typed

feature {NONE} -- Initialization

	make_typed (a_type: TYPE_A)
			-- Set `pointed_type' with `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_generics: like generics
		do
			create l_generics.make (1)
			l_generics.extend (a_type)
			make (base_class.class_id, l_generics)
		ensure
			pointed_type_set: pointed_type = a_type
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_typed_pointer_a (Current)
		end

feature -- Property

	is_typed_pointer: BOOLEAN = True
			-- Is current type a typed pointer type?

	base_class: CLASS_C
			-- Class POINTER.
		once
			Result := System.typed_pointer_class.compiled_class
		end

	pointed_type: TYPE_A
			-- Type pointed by current if any.
		do
			Result := generics.first
		end

feature -- IL code generation

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING
			-- Name of current class.
		local
			t: TYPE_A
		do
			t := generics.first
			Result := t.il_type_name (a_prefix, a_context_type).twin
			Result.append ("&")
			if a_prefix /= Void and then t.is_external then
				Result.precede ('.')
				Result.prepend (a_prefix)
			end
		end

	generic_il_type_name (a_context_type: TYPE_A): STRING
			-- Name of current class.
		do
			Result := generics.first.generic_il_type_name (a_context_type).twin
			Result.append ("&")
		end

feature {COMPILER_EXPORTER} -- Access

	reference_type: GEN_TYPE_A
			-- Reference counterpart of an expanded type.
		do
			create Result.make (class_id, duplicate.generics)
			if class_declaration_mark ⊗ expanded_mark /= 0 then
				Result.set_expanded_class_mark
			end
			if class_declaration_mark ⊗ once_mark /= 0 then
				Result.set_once_class_mark
			end
			Result.set_reference_mark
		end

	c_type: TYPED_POINTER_I
			-- Pointer C type.
		do
			create Result.make (pointed_type.c_type)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
