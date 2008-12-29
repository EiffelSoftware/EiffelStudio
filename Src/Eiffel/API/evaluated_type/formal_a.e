note
	description: "Descripion of a formal generic type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_A

inherit
	NAMED_TYPE_A
		rename
			is_multi_constrained as has_multi_constrained
		redefine
			is_formal, is_explicit,
			instantiation_in,
			has_formal_generic,
			is_loose,
			instantiated_in,
			adapted_in,
			skeleton_adapted_in,
			evaluated_type_in_descendant,
			same_as,
			is_full_named_type,
			convert_to,
			check_const_gen_conformance,
			is_reference,
			is_expanded,
			is_initialization_required,
			internal_is_valid_for_class,
			description,
			generated_id,
			generate_cid, generate_cid_array, generate_cid_init,
			make_type_byte_code,
			generate_gen_type_il,
			generic_il_type_name,
			annotation_flags
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (is_ref: like is_reference; is_exp: like is_expanded; i: like position)
			-- Initialize new instance of FORMAL_A which is garanteed to
			-- be instantiated as a reference type if `is_ref'.
		do
			is_reference := is_ref
			is_expanded := is_exp
			position := i
		ensure
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
			position_set: position = i
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_formal_a (Current)
		end

feature -- Property

	is_formal: BOOLEAN = True
			-- Is the current actual type a formal generic type ?

	is_explicit: BOOLEAN = False
			-- Is type fixed at compile time without anchors or formals?

	is_multi_constrained (a_context_class: CLASS_C): BOOLEAN
			-- Is Current a multi constraint formal relative to current context class?
			--
			-- `a_context_class': Used to resolve formals to their constraints.		
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_generic and then a_context_class.is_valid_formal_position (position)
		local
			l_generics: EIFFEL_LIST[FORMAL_DEC_AS]
		do
			l_generics := a_context_class.generics
			Result := l_generics.i_th (position).is_multi_constrained (l_generics)
		end

	is_full_named_type: BOOLEAN = True
			-- Current is a named type.

	is_reference: BOOLEAN
			-- Is current constrained to be always a reference?

	is_expanded: BOOLEAN
			-- Is current constrained to be always an expanded?

	is_single_constraint_without_renaming (a_context_class: CLASS_C): BOOLEAN
			-- Is current type a formal type which is single constrained and the constraint has not a feature renaming?			
			--
			-- `a_context_class' is the context class where the type occurs in.
			--| G -> A -> True
			--| G -> A rename a as b end -> False
			--| G -> {A, B} -> False
			--| This means there is exactly one constraint class which can be directly used without applying a feature renaming.
		local
			l_generics: EIFFEL_LIST[FORMAL_DEC_AS]
		do
			l_generics := a_context_class.generics
			check l_generics_not_void: l_generics /= Void end
			Result := l_generics.i_th (position).is_single_constraint_without_renaming (l_generics)
		end

	is_initialization_required: BOOLEAN
			-- Is initialization required for this type in void-safe mode?
		do
			if not is_expanded and then not has_detachable_mark then
				Result := True
			end
		end

	annotation_flags: NATURAL_16
			-- <Precursor>
		do
				-- Unlike {TYPE_A}, we actually need to know if the formal is declared with
				-- an attachment mark and if it is which one. When there are no attachment mark
				-- at runtime, we will use the attachment mark of the actual generic parameter.
			if has_attached_mark then
				Result := {SHARED_GEN_CONF_LEVEL}.attached_type
			elseif has_detachable_mark then
				Result := {SHARED_GEN_CONF_LEVEL}.detachable_type
			end
-- To uncomment when variant/frozen proposal for generics is supported.
--			if is_frozen then
--				Result := Result | {SHARED_GEN_CONF_LEVEL}.frozen_type
--			end
		end

feature -- IL code generation

	generic_il_type_name (a_context_type: TYPE_A): STRING
			-- <Precursor>
		once
			Result := "REFERENCE"
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				is_reference = other.is_reference and then
				is_expanded = other.is_expanded
		end

feature -- Access

	hash_code: INTEGER
		do
			Result := {SHARED_HASH_CODE}.other_code + position
		end

	description: GENERIC_DESC
			-- Descritpion of type for skeletons.
		do
			create Result
			Result.set_type_i (Current)
		end

	constrained_type (a_context_class: CLASS_C): TYPE_A
			-- Constraint of Current.
		require
			a_context_class_attached: a_context_class /= Void
			not_multi_constraint: not is_multi_constrained (a_context_class)
		do
			Result := a_context_class.constrained_type (position)
		ensure
			Result_not_void: Result /= Void
			Result_is_named_but_not_formal:  (Result.is_none or Result.is_named_type) and not Result.is_formal
		end

	constrained_types (a_context_class: CLASS_C): TYPE_SET_A
			-- Constrained types of Current.
			--
			-- `a_context_class' is the context class where the formal occurs in.
			--| It is a list of class types which constraint the current Formal.
		require
			a_context_class_attached: a_context_class /= Void
		do
			Result := a_context_class.constrained_types (position)
		ensure
			Result_not_void_and_not_empty: Result /= Void and not Result.is_empty
		end

	constrained_type_if_possible (a_context_class: CLASS_C): TYPE_A
			-- Constraint of Current.
		require
			a_context_class_attached: a_context_class /= Void
			not_multi_constraint: not is_multi_constrained (a_context_class)
		local
			l_formal_type: FORMAL_A
		do
			from
					-- Unfold the chain of formal generics
				Result := Current
			until
				Result = Void or else not Result.is_formal
			loop
				l_formal_type ?= Result
				Result := a_context_class.constraint_if_possible (l_formal_type.position)
			end
		end

	constrained_types_if_possible (a_context_class: CLASS_C): TYPE_SET_A
			-- Constraint of Current.
		require
			a_context_class_attached: a_context_class /= Void
		do
			Result := constraints (a_context_class).constraining_types (a_context_class)
		end

	constraint (a_context_class: CLASS_C): TYPE_A
			-- Constraint type of `Current'.
			--| Return excatly what is written. For a formal like G -> H we return H.
			--| If you want to resolve formal chains use `constrained_type'.
			--| If there are several formals in the type set we merge the results.
		require
			a_a_context_classt_not_void: a_context_class /= Void
		do
			Result := a_context_class.constraint (position)
		ensure
			Result_sane: Result /= Void
		end


	constraints (a_context_class: CLASS_C): TYPE_SET_A
			-- Constraint types of `Current'.
			--| Return excatly what is written. For a formal like G -> {H,STRING} we return {H, STRING}.
			--| If there are several formals in the type set we merge the results.
			--| If you want to get rid of recursive formals call `constraining_types' on the resulting TYPE_SET_A.
		require
			a_a_context_classt_not_void: a_context_class /= Void
		do
			Result := a_context_class.constraints (position)
		ensure
			Result_sane: Result /= Void and then not Result.is_empty
		end

	constraints_if_possible (a_context_class: CLASS_C): TYPE_SET_A
			-- Constraint types of `Current'.
			--| Return excatly what is written. For a formal like G -> {H,STRING} we return {H, STRING}.
			--| If there are several formals in the type set we merge the results.
		require
			a_a_context_classt_not_void: a_context_class /= Void
		do
			Result := a_context_class.constraints_if_possible (position)
		ensure
			Result_sane: Result /= Void
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is `other' the same as Current ?
		local
			other_formal: like Current
		do
			other_formal ?= other
			if other_formal /= Void then
				Result := is_equivalent (other_formal) and then
					has_same_attachment_marks (other_formal)
			end
		end

	associated_class: CLASS_C
		do
			-- No associated class
		end

	position: INTEGER
			-- Position of the formal parameter in the
			-- generic class declaration

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
				-- Not really applicable.
			Result := {SHARED_GEN_CONF_LEVEL}.formal_type
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, Void)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid (buffer, final_mode)
			else
				buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.formal_type)
				buffer.put_character (',')
				buffer.put_integer (position)
				buffer.put_character (',')
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
		local
			dummy: INTEGER
		do
			generate_cid_prefix (buffer, idx_cnt)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.formal_type)
				buffer.put_character (',')
				buffer.put_integer (position)
				buffer.put_character (',')
				dummy := idx_cnt.next
				dummy := idx_cnt.next
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL)
		local
			dummy: INTEGER
		do
			generate_cid_prefix (Void, idx_cnt)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
			else
				dummy := idx_cnt.next
				dummy := idx_cnt.next
			end
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info : BOOLEAN; a_context_type: TYPE_A)
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			make_type_prefix_byte_code (ba)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.make_type_byte_code (ba)
			else
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.formal_type)
				ba.append_short_integer (position)
			end
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_type_feature_call_for_formal (position)
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		do
			create Result.make (3)
			Result.append ("G#")
			Result.append_integer (position)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C)
		local
			s: STRING
			l_class: CLASS_AS
		do
			if has_attached_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_exclamation)
			elseif has_detachable_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_question)
			end
			if c /= Void then
				l_class := c.ast
				if l_class.generics /= Void and then l_class.generics.valid_index (position) then
					s := l_class.generics.i_th (position).name.name.as_upper
					st.process_generic_text (s)
				else
						-- We are in case where actual generic position does not match
						-- any generics in written class of `f'. E.g: A [H, G] inherits
						-- from B [G], therefore in B, `G' at position 2 does not make sense.
						--| FIXME: Manu 05/29/2002: we cannot let this happen, the reason is
						-- due to bad initialization of `f' in wrong class.
					st.add ({SHARED_TEXT_ITEMS}.Ti_generic_index)
					st.add_int (position)
				end
			else
				st.add ({SHARED_TEXT_ITEMS}.Ti_generic_index)
				st.add_int (position)
			end
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
		do
			Result := a_class = Void or else (a_class.is_generic and then position <= a_class.generics.count)
		end

feature {COMPILER_EXPORTER} -- Type checking

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER)
			-- Is `Current' a valid generic parameter at position `i' of `gen_type'?
			-- For formal generic parameter, we do check that their constraint
			-- conforms to `a_target_type'.
		local
			l_is_ref, l_is_exp: BOOLEAN
		do
				-- We simply consider conformance as if current formal
				-- was constrained to be a reference type, it enables us
				-- to accept the following code:
				-- class B [G -> STRING]
				-- class A [G -> STRING, H -> B [G]]
			l_is_ref := is_reference
			l_is_exp := is_expanded
			is_reference := True
			is_expanded := False
			Precursor {NAMED_TYPE_A} (a_gen_type, a_target_type, a_class, i)
			is_reference := l_is_ref
			is_expanded := l_is_exp

				-- Note that even if the constraint is not valid, e.g.
				-- class B [reference G -> STRING]
				-- class A [expanded G -> STRING, H -> B [G]]
				-- we do not trigger an error. This is ok, because an
				-- error will be triggered when trying to write a generic
				-- derivation of A as none is possible.
		end

feature {COMPILER_EXPORTER}

	has_formal_generic: BOOLEAN = True
			-- Does the current actual type have formal generic type ?

	is_loose: BOOLEAN = True
			-- Does type depend on formal generic parameters and/or anchors?

	conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current conform to `other'?
		local
			l_constraints: TYPE_SET_A
			t: TYPE_A
		do
				-- Use `other.conformance_type' rather than `other' to get deanchored form.
			t := other.conformance_type
			Result := same_as (t)
			if not Result and then {c: like Current} t and then is_equivalent (c) then
					-- The rules are as follows, but we need to take care about implicit attachment status:
    				-- 1. !G conforms to G, ?G and !G.
					-- 2. G conforms to G and ?G.
    				-- 3. ?G only conforms to ?G.
				if is_implicitly_attached then
						-- Case 1.
						-- An (implicitly) attached type conforms to a type of any attachment status.
					Result := True
				elseif c.has_detachable_mark then
						-- Case 1-3.
						-- A type of any attachment status conforms to a detachable type.
					Result := True
				elseif not has_detachable_mark then
						-- Case 2.
						-- A type without the detachable mark conforms to the one without the detachable mark.
					Result := not c.is_attached
				end
			end
			if not Result then
					-- We do not treat the case `is_expanded' as if it is an
					-- expanded then it does not conform to anything but itself
					-- so this is automatically taken care by `same_as' above.
				if not is_expanded then
						-- Check conformance of constrained generic type to `other'.
						-- Get the actual type for the formal generic parameter
					l_constraints := a_context_class.constraints_if_possible (position)
					Result := l_constraints.constraining_types (a_context_class).to_other_attachment (Current).conform_to_type (a_context_class, other)
				end
			end
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
				-- Check conformance of constained generic type
				-- to `other'
			create l_checker
			l_checker.check_formal_conversion (a_context_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			if {l_cl_type: CL_TYPE_A} type.actual_type then
				Result := l_cl_type.instantiation_of (Current, written_id).to_other_attachment (Current)
			else
				Result := Current
			end
		end

	adapted_in (class_type: CLASS_TYPE): TYPE_A
		do
			Result := class_type.type.generics.item (position)
		end

	skeleton_adapted_in (class_type: CLASS_TYPE): TYPE_A
		local
			l_type: TYPE_A
		do
				-- For backward compatibility, if the associated actual
				-- generic parameter of `class_type' is a basic type, we keep
				-- it, otherwise we preserve the formal aspect of Current.
				--| See eweasel test#store013 for an example where changing
				--| `skeleton_adapted_in' to be similar to `adapted_in' would make
				--| it fail.
			l_type := class_type.type.generics.item (position)
			if not l_type.is_true_expanded then
				Result := l_type
			else
				Result := Current
			end
		end

	instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := class_type.generics.item (position).to_other_attachment (Current)
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): TYPE_A
		local
			l_feat: TYPE_FEATURE_I
		do
				-- Get associated feature in parent.
			l_feat := a_ancestor.formal_at_position (position)
				-- Get associated feature in descendant.
			l_feat := a_descendant.generic_features.item (l_feat.rout_id_set.first)
			check l_feat_not_void: l_feat /= Void end
			Result := l_feat.type.actual_type.to_other_attachment (Current)
		end

	create_info: CREATE_FORMAL_TYPE
			-- Create formal type info.
		do
			create Result.make (as_attachment_mark_free)
		end

	shared_create_info: CREATE_FORMAL_TYPE
			-- Same as `create_info' except that it is a shared instance.
		once
			create Result.make (Current)
		ensure
			shared_create_info_not_void: Result /= Void
		end

	initialize_info (an_info: like shared_create_info)
			-- Initialize `an_info' with current type data.
		do
			an_info.make (Current)
		end

note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class FORMAL_A
