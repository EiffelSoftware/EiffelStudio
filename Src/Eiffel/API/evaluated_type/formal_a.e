indexing
	description: "Descripion of a formal generic type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_A

inherit
	NAMED_TYPE_A
		redefine
			is_formal,
			instantiation_in,
			has_formal_generic,
			is_loose,
			instantiated_in,
			evaluated_type_in_descendant,
			same_as,
			format,
			is_full_named_type,
			convert_to,
			check_const_gen_conformance,
			is_reference,
			is_expanded
		end

	REFACTORING_HELPER
create
	make

feature {NONE} -- Initialization

	make (is_ref: like is_reference; is_exp: like is_expanded; i: like position) is
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

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_formal_a (Current)
		end

feature -- Property

	is_formal: BOOLEAN is True
			-- Is the current actual type a formal generic type ?

	is_multi_constrained (a_context_class: CLASS_C): BOOLEAN is
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

	is_full_named_type: BOOLEAN is True
			-- Current is a named type.

	is_reference: BOOLEAN
			-- Is current constrained to be always a reference?

	is_expanded: BOOLEAN
			-- Is current constrained to be always an expanded?

	hash_code: INTEGER is
			--
		do
			Result := position
		end

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				is_reference = other.is_reference and then
				is_expanded = other.is_expanded
		end

feature -- Access

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

	constraint (a_context_class: CLASS_C): TYPE_A is
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


	constraints (a_context_class: CLASS_C): TYPE_SET_A is
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

	constraints_if_possible (a_context_class: CLASS_C): TYPE_SET_A is
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

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_formal: FORMAL_A
		do
			other_formal ?= other
			if other_formal /= Void then
				Result := is_equivalent (other_formal) and then
					has_attached_mark = other_formal.has_attached_mark and then
					has_detachable_mark = other_formal.has_detachable_mark
			end
		end

	associated_class: CLASS_C is
		do
			-- No associated class
		end

	position: INTEGER
			-- Position of the formal parameter in the
			-- generic class declaration

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (3)
			Result.append ("G#")
			Result.append_integer (position)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		local
			s: STRING
			l_class: CLASS_AS
		do
			if has_attached_mark then
				st.process_symbol_text (ti_exclamation)
			elseif has_detachable_mark then
				st.process_symbol_text (ti_question)
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
					st.add (Ti_generic_index)
					st.add_int (position)
				end
			else
				st.add (Ti_generic_index)
				st.add_int (position)
			end
		end

feature {COMPILER_EXPORTER} -- Type checking

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER) is
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

	has_formal_generic: BOOLEAN is
			-- Does the current actual type have formal generic type ?
		do
			Result := True
		end

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			l_constraints: TYPE_SET_A
		do
			Result := same_as (other.conformance_type)
			if not Result then
					-- We do not treat the case `is_expanded' as if it is an
					-- expanded then it does not conform to anything but itself
					-- so this is automatically taken care by `same_as' above.
				if not is_expanded then
						-- Check conformance of constrained generic type to `other'.
					fixme ("As soon as conform_to takes a context class as an argument, do no longer use System.current_class but the argument.")
					check
						has_generics: System.current_class.generics /= Void
						count_ok: System.current_class.generics.count >= position
					end
						-- Get the actual type for the formal generic parameter
					l_constraints := System.current_class.constraints_if_possible (position)
					Result := l_constraints.constraining_types (system.current_class).conform_to_type (other)
				end
			end
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
				-- Check conformance of constained generic type
				-- to `other'
			check
				has_generics: System.current_class.generics /= Void
				count_ok: System.current_class.generics.count >= position
			end

			create l_checker
			l_checker.check_formal_conversion (System.current_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		local
			class_type: CL_TYPE_A
		do
			class_type ?= type
			if class_type /= Void then
				Result := class_type.instantiation_of (Current, written_id)
			else
				Result := Current
			end
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := class_type.generics.item (position)
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): TYPE_A is
		local
			l_feat: TYPE_FEATURE_I
		do
				-- Get associated feature in parent.
			l_feat := a_ancestor.formal_at_position (position)
				-- Get associated feature in descendant.
			l_feat := a_descendant.generic_features.item (l_feat.rout_id_set.first)
			check l_feat_not_void: l_feat /= Void end
			Result := l_feat.type.actual_type
			if has_attached_mark then
				Result := Result.duplicate
				Result.set_attached_mark
			elseif has_detachable_mark then
				Result := Result.duplicate
				Result.set_detachable_mark
			end
		end

	type_i: FORMAL_I is
			-- C type
		do
			create Result.make (is_reference, is_expanded, position)
		end

	create_info: CREATE_FORMAL_TYPE is
			-- Create formal type info.
		do
			create Result.make (type_i)
		end

	format (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- reconstitute text
		do
			ctxt.process_generic_text (ctxt.formal_name (position))
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

end -- class FORMAL_A
