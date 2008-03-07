indexing
	description: "Representation of an anchored type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIKE_TYPE_A

inherit
	ATTACHABLE_TYPE_A
		undefine
			same_as
		redefine
			actual_type,
			conformance_type,
			convert_to,
			has_associated_class,
			has_like_current,
			associated_class_type,
			has_associated_class_type,
			has_like,
			good_generics,
			error_generics,
			instantiated_in,
			is_class_valid,
			is_explicit,
			is_attached,
			is_basic,
			is_expanded,
			is_external,
			is_like,
			is_loose,
			is_none,
			is_reference,
			is_type_set,
			internal_is_valid_for_class,
			meta_type,
			set_attached_mark,
			set_detachable_mark,
			description,
			c_type,
			generics,
			generated_id,
			generate_cid, generate_cid_array, generate_cid_init,
			make_gen_type_byte_code, generate_gen_type_il,
			maximum_interval_value, minimum_interval_value, is_optimized_as_frozen,
			is_generated_as_single_type, heaviest, instantiation_in, adapted_in,
			internal_generic_derivation, internal_same_generic_derivation_as,
			skeleton_adapted_in
		end

feature -- Properties

	actual_type: TYPE_A
			-- Actual type of the anchored type in a given class

	conformance_type: TYPE_A is
			-- Type which is used to check conformance
		do
				-- `conformance_type' has to be called because
				-- `actual_type' may yield yet another anchored type.
			Result := actual_type.conformance_type
			if has_attached_mark and then not Result.is_attached then
				Result := Result.as_attached
			elseif has_detachable_mark and then Result.is_attached then
				Result := Result.as_detachable
			end
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then
				actual_type.has_associated_class
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then actual_type.has_associated_class_type (a_context_type)
		end

	has_like: BOOLEAN is True
			-- Does the type have anchored type in its definition ?

	has_like_current: BOOLEAN is
			-- <Precursor>
		do
			Result := actual_type.has_like_current
		end

	is_class_valid: BOOLEAN is
		do
			Result := actual_type /= Void and then actual_type.is_class_valid
		end

	is_like: BOOLEAN is True
			-- Is the type anchored one ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

	is_explicit: BOOLEAN is
		do
				-- By definition an anchor is never explicit.
		end

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

	is_external: BOOLEAN is
			-- Is current type based on an external class?
		do
			Result := actual_type.is_external
		end

	is_reference: BOOLEAN is
			-- Is current actual type a reference one?
		do
			Result := actual_type.is_reference
		end

	is_expanded: BOOLEAN is
			-- Is current actual type an expanded one?
		do
			Result := actual_type.is_expanded
		end

	is_none: BOOLEAN is
			-- Is current actual type NONE?
		do
			Result := actual_type.is_none
		end

	is_type_set: BOOLEAN is
			-- <Precursor>
		do
			Result := actual_type.is_type_set
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		deferred
		end

	is_attached: BOOLEAN is
			-- Is type attached?
		do
			if Precursor then
				Result := True
			elseif not has_detachable_mark then
				Result := conformance_type.is_attached
			end
		end

	good_generics: BOOLEAN is
			-- <Original>
		do
			Result := actual_type.good_generics
		end

	error_generics: VTUG is
			-- <Original>
			--| No need to redefine it in LIKE_CURRENT since `good_generics' is always True.
		do
			Result := actual_type.error_generics
				-- We override the `type' set above since it is `actual_type'
				-- and we want to see the anchor instead.
			Result.set_type (Current)
		end

feature -- Access

	hash_code: INTEGER is
		do
			Result := actual_type.hash_code
		end

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_class
		end

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE is
		do
			Result := actual_type.associated_class_type (a_context_type)
		end

	generics: ARRAY [TYPE_A] is
			-- <Precursor>
		do
			Result := actual_type.generics
		end

	description: ATTR_DESC is
		do
			Result := actual_type.description
		end

	c_type: TYPE_C is
		do
			Result := actual_type.c_type
		end

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			if has_attached_mark then
				if not a.is_attached then
					actual_type := a.as_attached
				else
					actual_type := a
				end
			elseif has_detachable_mark then
				if not a.is_expanded and then a.is_attached then
					actual_type := a.as_detachable
				else
					actual_type := a
				end
			else
				actual_type := a
			end
		end

	instantiation_in (type: TYPE_A written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiation_in (type, written_id))
			Result := t
		end

	adapted_in (a_class_type: CLASS_TYPE): TYPE_A is
		do
			Result := actual_type.adapted_in (a_class_type)
		end

	skeleton_adapted_in (a_class_type: CLASS_TYPE): TYPE_A is
		do
			Result := actual_type.skeleton_adapted_in (a_class_type)
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiated_in (class_type))
			Result := t
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does `actual_type' conform to `other'?
		do
			Result := actual_type.conform_to (other.conformance_type)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := actual_type.convert_to (a_context_class, a_target_type)
		end

	meta_type: TYPE_A is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end

feature -- Modification

	set_attached_mark is
			-- Mark type declaration as having an explicit attached mark.
		local
			a: like actual_type
		do
			Precursor
			a := actual_type
			if a /= Void and then not a.is_attached then
				actual_type := a.as_attached
			end
		end

	set_detachable_mark is
			-- Set class type declaration as having an explicit detachable mark.
		local
			a: like actual_type
		do
			Precursor
			a := actual_type
			if not is_expanded and then a /= Void and then actual_type.is_attached then
				actual_type := a.as_detachable
			end
		end

feature -- IL code generation

	minimum_interval_value: INTERVAL_VAL_B is
		require else
			valid_type: actual_type.is_integer or actual_type.is_natural or actual_type.is_character
		do
			Result := actual_type.minimum_interval_value
		end

	maximum_interval_value: INTERVAL_VAL_B is
		require else
			valid_type: actual_type.is_integer or actual_type.is_natural or actual_type.is_character
		do
			Result := actual_type.maximum_interval_value
		end

	heaviest (other: TYPE_A): TYPE_A
		do
			Result := actual_type.heaviest (other)
		end

	is_optimized_as_frozen: BOOLEAN is
		do
			Result := actual_type.is_optimized_as_frozen
		end

	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		do
			Result := actual_type.is_generated_as_single_type
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16 is
			-- Id of a `like xxx'.
		do
			Result := actual_type.generated_id (final_mode, a_context_type)
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A) is
		do
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid (buffer, final_mode)
			else
				actual_type.generate_cid (buffer, final_mode, use_info, a_context_type)
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A) is
		do
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				actual_type.generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL) is
		do
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
			else
				actual_type.generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_level)
			end
		end

	make_gen_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A) is
		do
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.make_gen_type_byte_code (ba)
			else
				actual_type.make_gen_type_byte_code (ba, use_info, a_context_type)
			end
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_il_type
			else
				actual_type.generate_gen_type_il (il_generator, use_info)
			end
		end

	initialize_info (an_info: like shared_create_info) is
			-- Initialize `shared_create_info'.
		do
		end

	shared_create_info: CREATE_INFO is
			-- Same as `create_info' except that it is a shared instance.
		deferred
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN is
			-- Is current type valid?
		do
			Result := actual_type /= Void and then actual_type.internal_is_valid_for_class (a_class)
		end

	internal_generic_derivation (a_level: INTEGER_32): TYPE_A is
		do
				-- We keep the same level since we are merely forwarding the call.
			Result := actual_type.internal_generic_derivation (a_level)
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER_32): BOOLEAN is
		do
				-- We keep the same level since we are merely forwarding the call.
			Result := actual_type.internal_same_generic_derivation_as (current_type, other, a_level)
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

end -- class LIKE_TYPE_A
