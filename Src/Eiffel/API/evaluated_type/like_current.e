note
	description:"Actual type like Current."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_CURRENT

inherit
	LIKE_TYPE_A
		redefine
			actual_type, deep_actual_type, context_free_type,
			base_class, associated_class_type, internal_conform_to, conformance_type, convert_to,
			generics, has_associated_class, has_associated_class_type, formal_instantiated_in,
			instantiated_in, duplicate, set_separate_mark, recomputed_in,
			is_basic, is_expanded, is_external, is_like_current, is_none, is_reference, is_ephemeral,
			meta_type, set_actual_type, evaluated_type_in_descendant, is_tuple,
			set_attached_mark, set_detachable_mark, set_is_implicitly_attached,
			unset_is_implicitly_attached, description, description_with_detachable_type,
			c_type, is_explicit, is_implicitly_attached, is_attached,
			generated_id, generate_cid, generate_cid_array, generate_cid_init,
			make_type_byte_code, generate_gen_type_il, internal_is_valid_for_class,
			maximum_interval_value, minimum_interval_value, is_optimized_as_frozen,
			is_generated_as_single_type, heaviest, instantiation_in, adapted_in,
			hash_code, internal_generic_derivation, internal_same_generic_derivation_as,
			is_class_valid, skeleton_adapted_in, good_generics, has_like_current,
			set_frozen_mark
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: TYPE_A)
			-- Initialize Current and assign `a_type' to `conformance_type'.
		do
			set_actual_type (a_type)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_like_current (Current)
		end

feature -- Properties

	actual_type: LIKE_CURRENT
			-- Actual type of the anchored type in a given class

	deep_actual_type: TYPE_A
			-- <Precursor>
		do
			Result := conformance_type.deep_actual_type
		end

	context_free_type: like Current
			-- <Precursor>
		do
			create Result.make (conformance_type.context_free_type)
		end

	conformance_type: TYPE_A
			-- Type of the anchored type as specified in `set_actual_type'

	has_associated_class: BOOLEAN
			-- Does Current have an associated class?
		do
			Result := conformance_type /= Void and then conformance_type.has_associated_class
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN
			-- Does Current have an associated class?
		do
			if a_context_type /= Void then
				Result := True
			else
				Result := conformance_type /= Void and then conformance_type.has_associated_class_type (a_context_type)
			end
		end

	is_class_valid: BOOLEAN
		do
			Result := conformance_type /= Void and then conformance_type.is_class_valid
		end

	has_like_current, is_like_current: BOOLEAN = True
			-- Is the current type an anchored type on Current ?

	is_explicit: BOOLEAN = False
			-- Is type fixed at compile time without anchors or formals?
			--| Ideally, it is explicit if at runtime there is no descendants and
			--| that conformance_type is also explicit (to prevent case
			--| where like Current represents A [G] for which we can have
			--| many types) using the following code
			--|	Result := associated_class.direct_descendants.is_empty and then
			--|		conformance_type.is_explicit
			--| Unfortunately it does not work because code generation is still
			--| generating `dftype' instead which cannot be used in static array
			--| type initialization.

	is_expanded: BOOLEAN
			-- Is type expanded?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_expanded
			end
		end

	is_ephemeral: BOOLEAN
			-- <Precursor>
		do
			if attached conformance_type as t then
				Result := t.is_ephemeral
			end
		end

	is_reference: BOOLEAN
			-- Is type reference?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_reference
			end
		end

	is_tuple: BOOLEAN
			-- Is type reference?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_tuple
			end
		end

	is_external: BOOLEAN = False
			-- Is type external?

	is_none: BOOLEAN = False
			-- Is current actual type NONE?

	is_basic: BOOLEAN
			-- Is the current actual type a basic one?
		do
			if conformance_type /= Void then
				Result := conformance_type.is_basic
			end
		end

	is_attached: BOOLEAN
			-- Is type attached?
		do
			if is_directly_attached then
				Result := True
			elseif not has_detachable_mark and then attached conformance_type as t then
				Result := t.is_attached
			end
		end

	is_implicitly_attached: BOOLEAN
			-- <Precursor>
		do
			if is_directly_implicitly_attached then
				Result := True
			elseif not has_detachable_mark and then attached conformance_type as t then
				Result := t.is_implicitly_attached
			end
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		local
			l: LIKE_CURRENT
		do
			if other.is_like_current then
				l ?= other
				Result := has_same_marks (l)
			end
		end

	good_generics: BOOLEAN = True
			--| A current type always has the right number of generic parameter.

feature -- Access

	hash_code: INTEGER
		do
			Result := {SHARED_HASH_CODE}.other_code
		end

	base_class: CLASS_C
			-- Associated class
		do
			Result := conformance_type.base_class
		end

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE
			-- Associated class
		do
			if a_context_type /= Void then
				Result := a_context_type.associated_class_type (Void)
			else
				Result := conformance_type.associated_class_type (a_context_type)
			end
		end

	generics: ARRAYED_LIST [TYPE_A]
			-- Actual generic types
		do
			if conformance_type /= Void then
				Result := conformance_type.generics
			end
		end

	description: GENERIC_DESC
		do
			create Result
			Result.set_type_i (Current)
		end

	description_with_detachable_type: GENERIC_DESC
		do
			create Result
			Result.set_type_i (as_detachable_type)
		end

	c_type: TYPE_C
		do
			if conformance_type /= Void then
				Result := conformance_type.c_type
			else
				Result := reference_c_type
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
				-- Do not compare `has_attached_mark' because "like Current" is attached by default.
			Result :=
				other.has_detachable_mark = has_detachable_mark and then
				other.has_separate_mark = has_separate_mark
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := conformance_type.dump
			create Result.make (17 + actual_dump.count)
			Result.append_character ('[')
			dump_marks (Result)
			Result.append ("like Current] ")
			Result.append (actual_dump)
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_L_bracket)
			ext_append_marks (a_text_formatter)
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Like_keyword, Void)
			a_text_formatter.add_space
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Current, Void)
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_R_bracket)
			a_text_formatter.add_space
			conformance_type.ext_append_to (a_text_formatter, a_context_class)
		end

feature -- IL code generation

	minimum_interval_value: INTERVAL_VAL_B
		require else
			valid_type: conformance_type.is_integer or conformance_type.is_natural or conformance_type.is_character
		do
			Result := conformance_type.minimum_interval_value
		end

	maximum_interval_value: INTERVAL_VAL_B
		require else
			valid_type: conformance_type.is_integer or conformance_type.is_natural or conformance_type.is_character
		do
			Result := conformance_type.maximum_interval_value
		end

	heaviest (other: TYPE_A): TYPE_A
		do
			Result := conformance_type.heaviest (other)
		end

	is_optimized_as_frozen: BOOLEAN
		do
			Result := conformance_type.is_optimized_as_frozen
		end

	is_generated_as_single_type: BOOLEAN
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		do
			Result := conformance_type.is_generated_as_single_type
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.like_current_type
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A)
			-- Generate mode dependent sequence of type id's
			-- separated by commas. `use_info' is true iff
			-- we generate code for a creation instruction.
		do
			generate_cid_prefix (buffer, Void)
			if use_info then
				create_info.generate_cid (buffer, final_mode)
			else
				if a_context_type /= Void then
					a_context_type.generate_cid (buffer, final_mode, use_info, a_context_type)
				else
					conformance_type.generate_cid (buffer, final_mode, use_info, a_context_type)
				end
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, idx_cnt)
			if use_info then
				create_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				if a_context_type /= Void then
					a_context_type.generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
				else
					conformance_type.generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
				end
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A; a_level: NATURAL)
		do
			generate_cid_prefix (Void, idx_cnt)
			if use_info then
				create_info.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
			else
				if a_context_type /= Void then
					a_context_type.generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)
				else
					conformance_type.generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)
				end
			end
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			make_type_prefix_byte_code (ba)
			if use_info then
				create_info.make_type_byte_code (ba)
			else
				if a_context_type /= Void then
					a_context_type.make_type_byte_code (ba, use_info, a_context_type)
				else
					conformance_type.make_type_byte_code (ba, use_info, a_context_type)
				end
			end
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_current_as_reference
			il_generator.load_type
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			if
				attached {LIKE_CURRENT} other as a and then
				(a_context_class.lace_class.is_void_safe_conformance implies is_attachable_to (a)) and then
				is_processor_attachable_to (a) and then (a.has_frozen_mark implies has_frozen_mark)
			then
					-- Other is like Current that is compatible in terms of attachment status, separate status
					-- and variance status.
					--| Note that if other is frozen and we are not frozen, then we have to use the normal conformance rules.
				Result := True
			else
					-- Other is not `like Current' we apply normal rules of conformance.
				Result := conformance_type.internal_conform_to (a_context_class, other.conformance_type, a_in_generic)
			end
		end

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is current type valid?
		do
				-- If no `conformance_type' is specified, then `like Current' makes sense.
				-- If one is specified, then it should be correct.
			Result := conformance_type = Void or else conformance_type.internal_is_valid_for_class (a_class)
		end

	internal_generic_derivation (a_level: INTEGER_32): TYPE_A
		do
				-- We keep the same level since we are merely forwarding the call.
			Result := conformance_type.internal_generic_derivation (a_level)
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER_32): BOOLEAN
		do
				-- We keep the same level since we are merely forwarding the call.
				-- And because of `like Current', the underlying type is actually `current_type' if
				-- provided otherwise `conformance_type'.
			if current_type /= Void then
				Result := current_type.internal_same_generic_derivation_as (current_type, other, a_level)
			else
				Result := conformance_type.internal_same_generic_derivation_as (current_type, other, a_level)
			end
		end

feature {COMPILER_EXPORTER} -- Modification

	set_actual_type (a: TYPE_A)
			-- Assign `a' to `conformance_type'.
		do
				-- Remove any previously recorded actual type first
				-- since it can be used to compute attachment properties
				-- and give wrong results.
			conformance_type := Void
			actual_type := Void
				-- Promote separateness status if present.
			if has_separate_mark then
				conformance_type := a.to_other_immediate_attachment (Current).to_other_separateness (Current)
			else
				conformance_type := a.to_other_immediate_attachment (Current)
			end
			conformance_type := conformance_type.to_other_variant (Current)
			actual_type := Current
		end

	set_frozen_mark
			-- <Precursor>
		do
			Precursor
			conformance_type := conformance_type.to_other_variant (Current)
		end

	set_attached_mark
			-- Mark type declaration as having an explicit attached mark.
		do
			Precursor
			conformance_type := conformance_type.to_other_immediate_attachment (Current)
		end

	set_detachable_mark
			-- Set class type declaration as having an explicit detachable mark.
		do
			Precursor
			conformance_type := conformance_type.to_other_immediate_attachment (Current)
		end

	set_is_implicitly_attached
		local
			t: TYPE_A
		do
				-- Make sure `conformance_type' does not affect attachment status.
			t := conformance_type
			conformance_type := Void
			Precursor
			if attached t then
				conformance_type := t.to_other_immediate_attachment (Current)
			end
		end

	unset_is_implicitly_attached
		local
			t: TYPE_A
		do
				-- Make sure `conformance_type' does not affect attachment status.
			t := conformance_type
			conformance_type := Void
			Precursor
			if attached t then
				conformance_type := t.to_other_immediate_attachment (Current)
			end
		end

	set_separate_mark
			-- <Precursor>
		do
			Precursor
			if attached conformance_type as a then
				conformance_type := a.to_other_separateness (Current)
			end
		end

feature {COMPILER_EXPORTER} -- Duplication

	duplicate: LIKE_CURRENT
			-- Duplication
		do
			Result := Precursor
				-- Ensure `Result.actual_type = Result'
				-- that is expected when working with attachment properties
			Result.set_actual_type (conformance_type)
		end

feature {COMPILER_EXPORTER} -- Primitives

	recomputed_in (target_type: TYPE_A; context_id: INTEGER; constraint: TYPE_A; written_id: INTEGER): TYPE_A
			-- <Precursor>
		do
				-- Use original type.
			Result := instantiation_in (target_type, written_id)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
				-- Special cases for calls on a target which is a manifest integer
				-- that might be compatible with _8 or _16. The returned
				-- `actual_type' should not take into consideration the
				-- `compatibility_size' of `type', just its intrinsic type.
				-- Because manifest integers are by default 32 bits, when
				-- you apply a routine whose result is of type `like Current'
				-- then it should really be a 32 bits integer. Note that in the
				-- past we were keeping the size of the manifest integers and the
				-- following code was accepted:
				-- i16: INTEGER_16
				-- i8: INTEGER_8
				-- i16 := 0x00FF & i8
				-- Now the code is rejected because target expect an INTEGER_16
				-- and not an INTEGER, therefore the code needs to be fixed with:
				-- i16 := (0x00FF).to_integer_16 & i8
				-- or
				-- i16 := (0x00FF & i8).to_integer_16
			Result := type.intrinsic_type
			Result := Result.to_other_variant (Current)
			if is_attached then
					-- Adapt attachment marks as required.
				Result := Result.to_other_attachment (Current)
			elseif Result.is_attached then
					-- Remove explicit "attached" mark.
				Result := Result.duplicate
				Result.set_detachable_mark
			elseif Result.is_implicitly_attached then
				Result := Result.as_implicitly_detachable
			end
				-- Promote separateness status if present.
			if is_separate then
				Result := Result.to_other_separateness (Current)
			end
		end

	adapted_in, skeleton_adapted_in (a_class_type: CLASS_TYPE): CL_TYPE_A
			-- Instantiation of Current in context of `other'.
		do
			if a_class_type.is_basic then
				Result := a_class_type.basic_type
			else
				Result := a_class_type.type
			end
		end

	formal_instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			t: like Current
		do
			t := twin
			if conformance_type = Void then
					-- When you create an instance of Current, `conformance_type' is not set
					-- and this is what we do when generating the code of CURRENT_B.
				t.set_actual_type (class_type)
			else
				t.set_actual_type (conformance_type.formal_instantiated_in (class_type))
			end
			Result := t
		end

	instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			l_like: like Current
		do
			Result := class_type
			if Result.is_like_current then
					-- We cannot allow aliasing as otherwise we might end up updating
					-- `like Current' type that should not be updated (Allowing the
					-- aliasing would break eweasel test#valid218).
				create l_like.make (class_type.conformance_type)
				Result := l_like
			end
			Result := Result.to_other_attachment (Current)
			Result := Result.to_other_variant (Current)
				-- Promote separateness status if present.
			if is_separate then
				Result := Result.to_other_separateness (Current)
			end
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): LIKE_CURRENT
		do
			if a_ancestor /= a_descendant then
				create Result.make (a_descendant.actual_type)
				Result := Result.to_other_attachment (Current)
					-- Promote separateness status if present.
				if is_separate then
					Result := Result.to_other_separateness (Current)
				end
				Result := Result.to_other_variant (Current)
			else
				Result := Current
			end
		end

	create_info, shared_create_info: CREATE_CURRENT
			-- Byte code information for entity type creation
		once
			create Result
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		do
			Result := conformance_type.convert_to (a_context_class, a_target_type)
		end

	meta_type: LIKE_CURRENT
			-- Meta type.
		do
				-- Because `like Current' could possibly means a basic type
				-- when processing an inherited routine using `like Current'
				-- we keep LIKE_CURRENT for the metatype, but simply replace
				-- its `conformance_type' with its `meta_type'.
			create Result.make (conformance_type.meta_type)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
