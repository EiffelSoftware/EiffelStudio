note
	description: "Representation of an anchored type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIKE_TYPE_A

inherit
	TYPE_A
		undefine
			same_as
		redefine
			actual_type,
			adapted_in,
			annotation_flags,
			as_attachment_mark_free,
			as_same_variant_bits,
			associated_class_type,
			c_type,
			conformance_type,
			context_free_type,
			convert_to,
			deanchored_form_marks_free,
			deep_actual_type,
			description,
			description_with_detachable_type,
			error_generics,
			formal_instantiated_in,
			generate_cid,
			generate_cid_array,
			generate_cid_init,
			generate_gen_type_il,
			generated_id,
			generics,
			good_generics,
			has_associated_class,
			has_associated_class_type,
			has_like,
			has_like_current,
			has_reference,
			heaviest,
			instantiated_in,
			instantiation_in,
			internal_generic_derivation,
			internal_is_valid_for_class,
			internal_same_generic_derivation_as,
			is_attached,
			is_basic,
			is_class_valid,
			is_expanded,
			is_explicit,
			is_external,
			is_frozen,
			is_generated_as_single_type,
			is_implicitly_attached,
			is_initialization_required,
			is_like,
			is_loose,
			is_none,
			is_optimized_as_frozen,
			is_reference,
			is_separate,
			is_variant,
			make_type_byte_code,
			maximum_interval_value,
			meta_type,
			minimum_interval_value,
			recomputed_in,
			set_attached_mark,
			set_detachable_mark,
			set_frozen_mark,
			set_is_implicitly_attached,
			set_is_implicitly_frozen,
			set_separate_mark,
			skeleton_adapted_in,
			unset_is_implicitly_attached
		end

feature -- Properties

	actual_type: TYPE_A
			-- Actual type of the anchored type in a given class

	deep_actual_type: TYPE_A
			-- <Precursor>
		do
			Result := actual_type.deep_actual_type
		end

	deanchored_form_marks_free: TYPE_A
			-- <Precursor>
		do
			Result := actual_type.deanchored_form_marks_free
		end

	context_free_type: TYPE_A
			-- <Precursor>
		do
			Result := actual_type.context_free_type
		end

	conformance_type: TYPE_A
			-- Type which is used to check conformance
		do
				-- `conformance_type' has to be called because
				-- `actual_type' may yield yet another anchored type.
			Result := actual_type.conformance_type.to_other_attachment (Current).to_other_variant (Current)
		end

feature -- Status report

	has_associated_class: BOOLEAN
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then
				actual_type.has_associated_class
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN
			-- Does Current have an associated class?
		do
			Result := actual_type /= Void and then actual_type.has_associated_class_type (a_context_type)
		end

	has_like: BOOLEAN
			-- Does the type have anchored type in its definition?
		do
			Result := True
		end

	has_like_current: BOOLEAN
			-- <Precursor>
		do
			Result := actual_type.has_like_current
		end

	is_class_valid: BOOLEAN
		do
			Result := actual_type /= Void and then actual_type.is_class_valid
		end

	is_like: BOOLEAN = True
			-- Is the type anchored one ?

	is_loose: BOOLEAN
			-- Does type depend on formal generic parameters and/or anchors?
		do
				-- True for anchored types by default.
			Result := True
		end

	is_explicit: BOOLEAN
		do
				-- By definition an anchor is never explicit.
		end

	is_basic: BOOLEAN
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

	is_external: BOOLEAN
			-- Is current type based on an external class?
		do
			Result := actual_type.is_external
		end

	is_reference: BOOLEAN
			-- Is current actual type a reference one?
		do
			Result := attached actual_type as a and then a.is_reference
		end

	has_reference: BOOLEAN
			-- <Precursor>
		do
			Result := attached conformance_type as t implies t.has_reference
		end

	is_expanded: BOOLEAN
			-- Is current actual type an expanded one?
		do
			Result := attached actual_type as a and then a.is_expanded
		end

	is_none: BOOLEAN
			-- Is current actual type NONE?
		do
			Result := actual_type.is_none
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		deferred
		end

	is_separate: BOOLEAN
			-- Is type separate?
		do
			if Precursor then
				Result := True
			elseif attached conformance_type as t then
				Result := t.is_separate
			end
		end

	is_attached: BOOLEAN
			-- <Precursor>
		do
			if is_directly_attached then
				Result := True
			elseif attached actual_type as t then
				Result :=
					t.is_expanded or else
					(not has_detachable_mark and then t.is_attached)
			end
		end

	is_implicitly_attached: BOOLEAN
			-- <Precursor>
		do
			if is_directly_implicitly_attached then
				Result := True
			elseif attached actual_type as t then
				Result :=
					t.is_expanded or else
					(not has_detachable_mark and then t.is_implicitly_attached)
			end
		end

	is_initialization_required: BOOLEAN
			-- Is initialization required for this type in void-safe mode?
		do
			if Precursor then
				Result := True
			elseif not has_detachable_mark then
				Result := conformance_type.is_initialization_required
			end
		end

	is_frozen: BOOLEAN
			-- <Precursor>
		do
			if Precursor then
				Result := True
			elseif not has_variant_mark and then attached conformance_type as t then
				Result := t.is_frozen
			end
		end

	is_variant: BOOLEAN
			-- <Precursor>
		do
			if Precursor then
				Result := True
			elseif not has_frozen_mark and then attached conformance_type as t then
				Result := t.is_variant
			end
		end

	good_generics: BOOLEAN
			-- <Original>
		do
			Result := actual_type.good_generics
		end

	error_generics: VTUG
			-- <Original>
			--| No need to redefine it in LIKE_CURRENT since `good_generics' is always True.
		do
			Result := actual_type.error_generics
				-- We override the `type' set above since it is `actual_type'
				-- and we want to see the anchor instead.
			Result.set_type (Current)
		end

feature -- Access

	hash_code: INTEGER
		do
			Result := combined_hash_code ({SHARED_GEN_CONF_LEVEL}.like_feature_type, actual_type.hash_code)
		end

	base_class: CLASS_C
			-- Associated class
		do
			Result := actual_type.base_class
		end

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE
		do
			Result := actual_type.associated_class_type (a_context_type)
		end

	generics: ARRAYED_LIST [TYPE_A]
			-- <Precursor>
		do
			if attached actual_type as a then
				Result := a.generics
			end
		end

	description: ATTR_DESC
		do
			Result := actual_type.description
		end

	description_with_detachable_type: ATTR_DESC
		do
			Result := actual_type.description_with_detachable_type
		end

	c_type: TYPE_C
		do
			Result := actual_type.c_type
		end

feature -- Primitives

	set_actual_type (a: TYPE_A)
			-- Assign `a' to `actual_type'.
		do
				-- Remove any previously recorded actual type first
				-- since it can be used to compute attachment properties
				-- and give wrong results.
			actual_type := Void
				-- Promote separateness status if present.
			if has_separate_mark then
				actual_type := a.to_other_immediate_attachment (Current).to_other_separateness (Current)
			else
				actual_type := a.to_other_immediate_attachment (Current)
			end
			actual_type := actual_type.to_other_variant (Current)
		end

	recomputed_in (target_type: TYPE_A; context_id: INTEGER; constraint: TYPE_A; written_id: INTEGER): TYPE_A
			-- <Precursor>
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.recomputed_in (target_type, context_id, constraint, written_id))
			Result := t
		end

	instantiation_in (type: TYPE_A written_id: INTEGER): TYPE_A
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiation_in (type, written_id))
			Result := t
		end

	adapted_in (a_class_type: CLASS_TYPE): TYPE_A
		do
			Result := actual_type.adapted_in (a_class_type)
		end

	skeleton_adapted_in (a_class_type: CLASS_TYPE): TYPE_A
		do
			Result := actual_type.skeleton_adapted_in (a_class_type)
		end

	formal_instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.formal_instantiated_in (class_type).actual_type)
			Result := t
		end

	instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiated_in (class_type).actual_type)
			Result := t
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := actual_type.convert_to (a_context_class, a_target_type)
		end

	meta_type: TYPE_A
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end

feature -- Modification

	set_frozen_mark
			-- <Precursor>
		do
			Precursor
			if attached actual_type as l_type and then l_type /= Current then
				actual_type := l_type.to_other_variant (Current)
			end
		end

	set_attached_mark
			-- Mark type declaration as having an explicit attached mark.
		do
			Precursor
			if attached actual_type as a then
				actual_type := a.to_other_immediate_attachment (Current)
			end
		end

	set_detachable_mark
			-- Set class type declaration as having an explicit detachable mark.
		do
			Precursor
			if attached actual_type as a then
				actual_type := a.to_other_immediate_attachment (Current)
			end
		end

	set_is_implicitly_attached
		local
			t: like actual_type
		do
				-- Make sure `actual_type' does not affect attachment status.
			t := actual_type
			actual_type := Void
			Precursor
			if attached t then
				actual_type := t.to_other_immediate_attachment (Current)
			end
		end

	unset_is_implicitly_attached
		local
			t: like actual_type
		do
				-- Make sure `actual_type' does not affect attachment status.
			t := actual_type
			actual_type := Void
			Precursor
			if attached t then
				actual_type := t.to_other_immediate_attachment (Current)
			end
		end

	set_separate_mark
			-- <Precursor>
		do
			Precursor
			if attached actual_type as a then
				actual_type := a.to_other_separateness (Current)
			end
		end

	set_is_implicitly_frozen
			-- <Precursor>
		do
			Precursor
			if attached actual_type as a and then a /= Current then
				actual_type := a.to_other_variant (Current)
			end
		end

	as_same_variant_bits (a_bits: like variant_bits): like Current
			-- <Precursor>
		local
			c: like actual_type
		do
			if attached actual_type as t and then t /= Current then
				c := t.as_same_variant_bits (a_bits)
				if c /= t then
						-- We have a modified version of `actual_type',
						-- so we need to duplicate Current if not previously done.
					actual_type := c
					Result := Precursor (a_bits)
					if Result = Current then
						Result := duplicate
					else
							-- Nothing to do because current was duplicated
							-- with a copy of `conformance_type'.
					end
						-- Restore former `actual_type'
					actual_type := t
				else
						-- No change in `actual_type', we just call the ancestor
					Result := Precursor (a_bits)
				end
			else
				Result := Precursor (a_bits)
			end
		end

	as_attachment_mark_free: like Current
			-- Same as Current but without any attachment mark
		local
			l_bits: like attachment_bits
			l_actual_type, l_old_actual_type: like actual_type
		do
			l_bits := attachment_bits
			l_actual_type := actual_type.as_attachment_mark_free
			if l_bits = 0 and then l_actual_type = actual_type then
				Result := Current
			else
				attachment_bits := 0
				l_old_actual_type := actual_type
				actual_type := l_actual_type
				Result := duplicate
				attachment_bits := l_bits
				actual_type := l_old_actual_type
			end
		end

feature -- IL code generation

	minimum_interval_value: INTERVAL_VAL_B
		require else
			valid_type: actual_type.is_integer or actual_type.is_natural or actual_type.is_character
		do
			Result := actual_type.minimum_interval_value
		end

	maximum_interval_value: INTERVAL_VAL_B
		require else
			valid_type: actual_type.is_integer or actual_type.is_natural or actual_type.is_character
		do
			Result := actual_type.maximum_interval_value
		end

	heaviest (other: TYPE_A): TYPE_A
		do
			Result := actual_type.heaviest (other)
		end

	is_optimized_as_frozen: BOOLEAN
		do
			Result := actual_type.is_optimized_as_frozen
		end

	is_generated_as_single_type: BOOLEAN
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		do
			Result := actual_type.is_generated_as_single_type
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16
			-- <Precursor>
		do
				-- Unlike {TYPE_A}, and similarely as {FORMAL_A}, we actually need to know if
				-- the type is declared with a mark and if it is which one. When there are no
				-- mark at runtime, we will use the mark of the anchor.
			if lace.is_void_safe then
				if has_attached_mark then
					Result := {SHARED_GEN_CONF_LEVEL}.attached_type
				elseif has_detachable_mark then
					Result := {SHARED_GEN_CONF_LEVEL}.detachable_type
				end
			end

			if system.is_scoop and then has_separate_mark then
				Result := Result | {SHARED_GEN_CONF_LEVEL}.separate_type
			end

				-- The code below will not generate annotation when
				-- `{COMPILER_PROFILE}.is_frozen_variant_supported' is not set
				-- as to not break existing code, since `has_frozen_mark' and
				-- `has_variant_mark' will always be False.
			check consistent: not compiler_profile.is_frozen_variant_supported implies (not has_frozen_mark and not has_variant_mark) end
			if has_frozen_mark then
				Result := Result | {SHARED_GEN_CONF_LEVEL}.frozen_type
			elseif has_variant_mark then
				Result := Result | {SHARED_GEN_CONF_LEVEL}.variant_type
			end
		end

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
			Result := actual_type.generated_id (final_mode, a_context_type)
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, Void)
			if use_info then
				initialize_info
				shared_create_info.generate_cid (buffer, final_mode)
			else
				actual_type.generate_cid (buffer, final_mode, use_info, a_context_type)
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, idx_cnt)
			if use_info then
				initialize_info
				shared_create_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				actual_type.generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A; a_level: NATURAL)
		do
			generate_cid_prefix (Void, idx_cnt)
			if use_info then
				initialize_info
				shared_create_info.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
			else
				actual_type.generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)
			end
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			make_type_prefix_byte_code (ba)
			if use_info then
				initialize_info
				shared_create_info.make_type_byte_code (ba)
			else
				actual_type.make_type_byte_code (ba, use_info, a_context_type)
			end
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			if use_info then
				initialize_info
				shared_create_info.generate_il_type
			else
				actual_type.generate_gen_type_il (il_generator, use_info)
			end
		end

	initialize_info
			-- Initialize `shared_create_info` using current data.
		do
		end

	shared_create_info: CREATE_INFO
			-- Same as `create_info' except that it is a shared instance.
		deferred
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := actual_type.internal_conform_to (a_context_class, other.conformance_type, a_in_generic)
		end

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is current type valid?
		do
			Result := attached actual_type as l_actual_type and then l_actual_type.internal_is_valid_for_class (a_class)
		end

	internal_generic_derivation (a_level: INTEGER_32): TYPE_A
		do
				-- We keep the same level since we are merely forwarding the call.
			Result := actual_type.internal_generic_derivation (a_level)
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER_32): BOOLEAN
		do
				-- We keep the same level since we are merely forwarding the call.
			Result := actual_type.internal_same_generic_derivation_as (current_type, other, a_level)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class LIKE_TYPE_A
