note
	description: "Descritpion of an actual generical type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GEN_TYPE_A

inherit
	CL_TYPE_A
		rename
			make as cl_make
		redefine
			generics, valid_generic, parent_type, dump, ext_append_to,
			has_like, has_like_argument, has_like_current, is_loose, good_generics,
			error_generics, check_constraints, has_formal_generic, formal_instantiated_in,
			instantiated_in, recomputed_in,
			has_expanded, internal_is_valid_for_class, expanded_deferred, valid_expanded_creation,
			same_as, is_equivalent, description, description_with_detachable_type, instantiated_description, is_explicit,
			deep_actual_type, deanchored_form_marks_free, context_free_type, instantiation_in, has_actual,
			actual_argument_type, update_dependance, hash_code,
			is_full_named_type, is_known, process, evaluated_type_in_descendant,
			generate_cid, generate_cid_array, generate_cid_init,
			make_type_byte_code, il_type_name, generic_il_type_name,
			generate_gen_type_il, adapted_in, internal_generic_derivation,
			internal_same_generic_derivation_as, is_class_valid,
			is_valid_generic_derivation, skeleton_adapted_in, dispatch_anchors,
			check_labels, duplicate_for_instantiation
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER; g: like generics)
			-- Create Current with `g' types as generic parameter.
		require
			valid_class_id: a_class_id > 0
			has_generics: g /= Void
		do
			generics := g
			cl_make (a_class_id)
		ensure
			generics_set: generics = g
			class_id_set: class_id = a_class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_gen_type_a (Current)
		end

feature -- Properties

	has_actual (type: CL_TYPE_A): BOOLEAN
			-- Is `type' an (possibly nested) actual parameter of this type?
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				l_generics := generics
				i := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				if
					attached {CL_TYPE_A} l_generics.i_th (i) as l_cl_type and then
					(l_cl_type.same_as (type) or else l_cl_type.has_actual (type))
				then
					Result := True
					i := nb + 1
				else
					i := i + 1
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
			other_generics: like generics
		do
			if Precursor (other) then
				from
					i := 1
					nb := generics.count
					other_generics := other.generics
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := equivalent (generics.i_th (i), other_generics.i_th (i))
					i := i + 1
				end
			end
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		local
			i, nb: INTEGER
			other_generics: like generics
		do
			if
				attached {like Current} other as other_gen_type and then
				other_gen_type.class_id = class_id and then
				is_expanded = other_gen_type.is_expanded and then
				has_same_marks (other_gen_type)
			then
				from
					i := 1
					nb := generics.count
					other_generics := other_gen_type.generics
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := generics.i_th (i).same_as (other_generics.i_th (i))
					i := i + 1
				end
			end
		end

feature -- Access

	generics: ARRAYED_LIST [TYPE_A]
			-- Actual generical parameter

	hash_code: INTEGER
		local
			i: INTEGER
			l_generics: like generics
		do
			Result := Precursor
			l_generics := generics
			i := l_generics.count
			if i >= 0 then
				from
				until
					i = 0
				loop
					Result := combined_hash_code (Result, l_generics.i_th (i).hash_code)
					i := i - 1
				end
			end
		end

	description: ATTR_DESC
			-- Descritpion of type for skeletons.
		do
			if is_loose then
				create {GENERIC_DESC} Result.make (Current)
			else
				Result := Precursor {CL_TYPE_A}
			end
		end

	description_with_detachable_type: ATTR_DESC
		do
			if is_loose then
				create {GENERIC_DESC} Result.make (as_detachable_type)
			else
				Result := Precursor {CL_TYPE_A}
			end
		end

	instantiated_description: ATTR_DESC
		local
			exp: EXPANDED_DESC
			l_ref: REFERENCE_DESC
		do
			if is_expanded then
				create exp
				exp.set_type_i (Current)
				Result := exp
			else
				create l_ref
				l_ref.set_type_i (Current)
				Result := l_ref
			end
		end

feature -- Status Report

	is_explicit: BOOLEAN
			-- Is type fixed at compile time without anchors or formals?
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				i := 1
				l_generics := generics
				nb := l_generics.count
				Result := True
			until
				i > nb
			loop
				if not l_generics.i_th (i).is_explicit then
					Result := False
					i := nb + 1
				else
					i := i + 1
				end
			end
		end

	is_class_valid: BOOLEAN
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			if base_class /= Void then
				from
					i := 1
					l_generics := generics
					nb := l_generics.count
					Result := True
				until
					i > nb
				loop
					if not l_generics.i_th (i).is_class_valid then
						Result := False
						i := nb + 1
					else
						i := i + 1
					end
				end
			end
		end

	is_valid_generic_derivation: BOOLEAN
			-- A generic type is a valid derivation if and only if the class type
			-- being referenced are still expanded.
			--| This can happen when a generic class which was expanded and used in
			--| another generic class is not expanded anymore.
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				i := 1
				l_generics := generics
				nb := l_generics.count
				Result := True
			until
				i > nb
			loop
					-- If type is still expanded, we do the recursion in case it has a generic parameter which is
					-- itself generic and needs to be checked as well.
				if
					attached {CL_TYPE_A} l_generics.i_th (i) as l_type and then
					(not l_type.is_expanded or else not l_type.has_associated_class_type (Void))
				then
					Result := False
					i := nb + 1
				else
					i := i + 1
				end
			end
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		local
			i, count: INTEGER
		do
			Result := Precursor {CL_TYPE_A}

			count := generics.count

			-- TUPLE may have zero generic parameters

			if count > 0 then
				Result.append_character (' ')
				Result.append_character ('[')
				from
					i := 1
				until
					i > count
				loop
					Result.append (generics.i_th (i).dump)
					if i /= count then
						Result.append_character (',')
						Result.append_character (' ')
					end
					i := i + 1
				end
				Result.append_character (']')
			end
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		local
			i, count: INTEGER
			tuple_index: INTEGER
			is_comma_needed: BOOLEAN
			t: TYPE_A
		do
				-- Append classname "TUPLE"
			Precursor {CL_TYPE_A} (a_text_formatter, a_context_class)

				-- TUPLE may have zero generic parameters
			count := generics.count
				-- A type may also have a single tuple parameter without any actual generics.
			tuple_index := base_class.tuple_parameter_index
			if count > 0 and then
				(tuple_index /= 1 or else
				count > 1 or else
				not attached {TUPLE_TYPE_A} generics [1] as tt or else
				(attached tt.generics as g and then not g.is_empty))
			then
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_L_bracket)
				from
					i := 1
				until
					i > count
				loop
					if is_comma_needed then
						a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_Comma)
						a_text_formatter.add_space
					end
					is_comma_needed := True
					t := generics [i]
					if tuple_index = i then
							-- Fold the tuple parameter.
						if not t.is_tuple then
								-- The actual generic is not a tuple.
								-- This could be because a type formatter did not wrap the actual generic into a tuple.
								-- Preserve the actual parameter as is.
							t.ext_append_to (a_text_formatter, a_context_class)
						elseif not attached t.generics as g or else g.is_empty then
								-- Omit the parameter altogether.
							is_comma_needed := False
						elseif g.count = 1 and then g [1].is_tuple then
								-- Preserve tuple actual parameter for the cases like "A [TUPLE [TUPLE [...]]]".
							t.ext_append_to (a_text_formatter, a_context_class)
						else
								-- Remove tuple wrapping.
								-- If there is a parameter before tuple parameter, a comma is already printed.
							is_comma_needed := False
							across
								g as gg
							loop
								if is_comma_needed then
									a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_Comma)
									a_text_formatter.add_space
								end
								is_comma_needed := True
								gg.item.ext_append_to (a_text_formatter, a_context_class)
							end
						end
					else
							-- Apply general formatting rules.
						t.ext_append_to (a_text_formatter, a_context_class)
					end
					i := i + 1
				end
				a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_R_bracket)
			end
		end

feature -- Generic conformance

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN; a_context_type: TYPE_A)
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			Precursor (buffer, final_mode, use_info, a_context_type)
			from
				l_generics := generics
				i  := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).generate_cid (buffer, final_mode, use_info, a_context_type)
				i := i + 1
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			Precursor (buffer, final_mode, use_info, idx_cnt, a_context_type)

			from
				l_generics := generics
				i  := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
				i := i + 1
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A; a_level: NATURAL)
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			Precursor (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)

			from
				l_generics := generics
				i  := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)
				i := i + 1
			end
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info : BOOLEAN; a_context_type: TYPE_A)
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			Precursor (ba, use_info, a_context_type)

			from
				l_generics := generics
				i  := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).make_type_byte_code (ba, use_info, a_context_type)
				i := i + 1
			end
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		local
			i, nb : INTEGER
			l_generics: like generics
		do
			l_generics := generics

			generate_gen_type_instance (il_generator, l_generics.count)

			from
				i  := l_generics.lower
				check
					i_start_at_one: i = 1
				end
				nb := l_generics.upper
			until
				i > nb
			loop
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (i - 1)
				l_generics.i_th (i).generate_gen_type_il (il_generator, use_info)
				il_generator.generate_array_write ({IL_CONST}.il_ref, 0)
				i := i + 1
			end

			il_generator.generate_generic_type_settings (Current)
		end

	generate_gen_type_instance (il_generator: IL_CODE_GENERATOR; n: INTEGER)
			-- Generic runtime instance for Current
		require
			il_generator_not_void: il_generator /= Void
			n_non_negative: n >= 0
		do
			il_generator.generate_generic_type_instance (n)
		end

	frozen enumerate_interfaces (processor: PROCEDURE [CLASS_TYPE])
			-- Enumerate all class types for which an object of this type can be attached to.
			-- FIXME: To be put in GEN_TYPE_A when refactoring complete.
		require
			processor_attached: processor /= Void
		do
				-- TODO:
				-- 1. Rule out generic types with too many generic parameters to
				-- avoid explosure of artificially introduced types.
				-- 2. Ensure generated code works as expected.
				-- 3. Remove validity rule that prevents reattaching derivations
				-- with expanded parameters to derivations with reference parameters.
			enumerate_interfaces_recursively (processor, generics.count)
		end

feature -- CECIL code generation

	generate_cecil_values (buffer: GENERATION_BUFFER; a_context_type: TYPE_A)
			-- Generate CECIL metatypes for current generic derivation
		require
			buffer_not_void: buffer /= Void
			context_type_valid: a_context_type /= Void implies
				a_context_type.generic_derivation.same_as (a_context_type)
			context_type_class_valid: a_context_type /= Void implies
				(a_context_type.has_associated_class and then
					is_valid_for_class (a_context_type.base_class))
			has_associated_class_type: has_associated_class_type (a_context_type)
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				l_generics := generics
				i := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).generate_cecil_value (buffer, a_context_type)
				buffer.put_two_character (',', '%N')
				i := i + 1
			end
		end

	make_cecil_values (ba: BYTE_ARRAY; a_context_type: TYPE_A)
			-- Make byte code for cecil values
		require
			ba_not_void: ba /= Void
			context_type_valid: a_context_type /= Void implies
				a_context_type.generic_derivation.same_as (a_context_type)
			context_type_class_valid: a_context_type /= Void implies
				(a_context_type.has_associated_class and then
					is_valid_for_class (a_context_type.base_class))
			has_associated_class_type: has_associated_class_type (a_context_type)
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				l_generics := generics
				i := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				ba.append_natural_32 (l_generics.i_th (i).sk_value (a_context_type))
				i := i + 1
			end
		end

feature -- IL code generation

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING
			-- Name of current class
		local
			i, count: INTEGER
			sep, tmp: STRING
			l_generics: like generics
			l_class_c: like base_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
		do
			l_class_c := base_class
			l_is_precompiled := l_class_c.is_precompiled
			if l_is_precompiled then
				l_cl_type := associated_class_type (a_context_type)
				l_is_precompiled := l_cl_type.is_precompiled
				if l_is_precompiled then
					Result := l_cl_type.il_type_name (a_prefix)
				end
			end
			if not l_is_precompiled then
				Result := l_class_c.name.twin

				l_generics := generics

					-- Append generic information.
				count := l_generics.count
				if count > 0 then
					from
						i := 1
						sep := "_"
					until
						i > count
					loop
						Result.append (sep)
						tmp := l_generics.i_th (i).generic_il_type_name (a_context_type).twin
						tmp.remove_head (tmp.last_index_of ('.', tmp.count))
						Result.append (tmp)
						i := i + 1
					end
				end

				Result := internal_il_type_name (Result, a_prefix)
			end
		end

	generic_il_type_name (a_context_type: TYPE_A): STRING
			-- Associated name to for naming in generic derivation.
		do
			Result := il_type_name (Void, a_context_type)
		end

	dispatch_anchors (a_context_class: CLASS_C)
			-- <Original>
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				generics.i_th (i).dispatch_anchors (a_context_class)
				i := i + 1
			end
		end

feature {TYPE_A} -- Helpers

	valid_generic (a_context_class: CLASS_C; type: CL_TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Check generic parameters
		local
			i, count: INTEGER
			gen_type_generics: like generics
		do
			if class_id = type.class_id then
				if attached {GEN_TYPE_A} type as gen_type then
					from
						i := 1
						gen_type_generics := gen_type.generics
						count := generics.count
						Result := count = gen_type_generics.count
					until
						i > count or else not Result
					loop
						Result := gen_type_generics.i_th (i).
							internal_conform_to (a_context_class, generics.i_th (i), True)
						i := i + 1
					end
				end
			else
					-- `type' is a descendant type of Current: so we
					-- have to check the current generic parameters
				Result := type.generic_conform_to (a_context_class, Current, a_in_generic)
			end
		end

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
		local
			gs: like generics
		do
			gs := generics
			if
				attached base_class as l_class and then l_class.is_valid and then
				l_class.is_expanded = (class_declaration_mark ⊗ expanded_mark /= 0) and then
				l_class.is_once = (class_declaration_mark ⊗ once_mark /= 0) and then
				((attached l_class.generics as g and then g.count = gs.count) or is_tuple)
			then
				Result := ∀ g: gs ¦ g.internal_is_valid_for_class (a_class)
			end
		end

	enumerate_interfaces_recursively (processor: PROCEDURE [CLASS_TYPE]; n: INTEGER)
			-- Enumerate all class types for which an object of this type can be attached to
			-- using `n' as an upper bound for generic parameters that can be changed.
		require
			processor_attached: processor /= Void
			valid_n: 1 <= n and n <= generics.count
		local
			parameter: TYPE_A
			other_parameter: TYPE_A
			cl_type: CL_TYPE_A
			gen_type: GEN_TYPE_A
			l_types: TYPE_LIST
			cursor: ARRAYED_LIST_CURSOR
			i: INTEGER
		do
				-- Enumerate types where expanded parameters are replaced with reference ones.
				-- Take into account only registered generic derivations.
			if n > 4  then
					-- It's faster to scan registered class types rather than to generate conforming ones.
				from
					l_types := base_class.types
					cursor := l_types.cursor
					l_types.start
				until
					l_types.after
				loop
					cl_type := l_types.item.type
						-- Check only types that differ from current one.
					if cl_type /= Current then
						if
							attached {GEN_TYPE_A} cl_type as l_gen_type and then
							l_gen_type.is_reference -- Ensure the type is reference.
						then
							from
								i := generics.count
							until
								i <= 0
							loop
								parameter := generics.i_th (i)
								other_parameter := l_gen_type.generics.i_th (i)
								if
									parameter.same_as (other_parameter) or else
									parameter.is_expanded and then other_parameter.is_formal
								then
										-- Continue processing.
								else
										-- Types differ. Stop processing.
									i := 0
								end
								i := i - 1
							end
							if i = 0 then
								processor.call ([l_types.item])
							end
						else
							check is_gen_type: False end
						end
					end
					l_types.forth
				end
				l_types.go_to (cursor)
			else
				from
					i := n
				until
					i <= 0
				loop
					parameter := generics [i]
					if parameter.is_expanded then
						gen_type := duplicate_for_instantiation
						gen_type.set_reference_mark
							-- We replace the generics at position `i' by a FORMAL_A which simply
							-- states that this is the generic derivation with reference in it.
						gen_type.generics [i] := create {FORMAL_A}.make (False, False, i)
						if base_class.types.has_type (Void, gen_type) then
							processor.call ([gen_type.associated_class_type (Void)])
						end
						if i > 1 then
							gen_type.enumerate_interfaces_recursively (processor, i - 1)
						end
					end
					i := i - 1
				end
			end
		end

	internal_generic_derivation (a_level: INTEGER): like Current
			-- Precise generic derivation of current type.
		local
			i: INTEGER
			l_old_generics, l_new_generics: like generics
			l_new_type, l_prev_type: TYPE_A
		do
			Result := as_marks_free
			from
				l_old_generics := Result.generics
				i := l_old_generics.count
			until
				i <= 0
			loop
				l_prev_type := l_old_generics.i_th (i)
					-- For generic derivation we have to tweak the types so that
					-- they are either expandeds or formals.
				if l_prev_type.actual_type.is_formal or l_prev_type.is_reference then
					if a_level = 0 then
							-- We are now analyzing the B part in A [B]
						create {FORMAL_A} l_new_type.make (False, False, i)
					else
							-- We are now analyzing the X part in A [B [X]]
							-- which can only happen if B [X] is expanded. In that case, we
							-- cannot store the formal if there is one, we will simply use
							-- the constraint instead. If the constraint is a multi-constraint
							-- we put the first constraint in the list as we use this for sorting
							-- the CLASS_TYPE for code generation (See eweasel test#multicon060).
						if base_class.generics.i_th (i).is_multi_constrained (base_class.generics) then
							l_new_type := base_class.constrained_types (i).first.type
						else
							l_new_type := base_class.constrained_type (i)
						end
					end
				else
					l_new_type := l_prev_type
				end
					-- Recurse now.
				l_new_type := l_new_type.internal_generic_derivation (a_level + 1)
				if l_prev_type /= l_new_type then
					if l_new_generics = Void then
							-- Void modifying original type.
						if Result = Current then
							Result := Result.duplicate_for_instantiation
						else
							Result.set_generics (generics.twin)
						end
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_type, i)
				end
				i := i - 1
			end
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER): BOOLEAN
		local
			i, nb: INTEGER
			l_generics, l_other_generics: like generics
			l_type: TYPE_A
		do
			if
				same_type (other) and then attached {like Current} other as l_gen_type_i and then
				l_gen_type_i.class_id = class_id and then
						-- 'class_id' is the same therefore we can compare 'declaration_mark'.
						-- If 'declaration_mark' is not the same for both then we have to make sure
						-- that both expanded and separate states are identical.
				(l_gen_type_i.declaration_mark /= declaration_mark implies
					l_gen_type_i.is_expanded = is_expanded)
			then
				from
					i := 1
					l_generics := generics
					nb := l_generics.count
					l_other_generics := l_gen_type_i.generics
					Result := nb = l_other_generics.count
				until
					i > nb or else not Result
				loop
					l_type := l_generics [i]
						-- We use `actual_type' here because if this is an anchor, then we need to know
						-- if the anchor is a formal since it is crucial for the comparison.
					if
						l_type.actual_type.is_formal and
						current_type /= Void and then
							-- It is a formal, so we need to instantiate the formal in the
							-- context of the current type. For example, we are looking for
							-- the class type of A [G] in the context of B [INTEGER], thus
							-- G is INTEGER. If we were not doing that, we would have to
							-- create additional objects.
						attached {FORMAL_A} l_type.actual_type as l_formal
					then
						l_type := current_type.generics [l_formal.position]
					end
					if current_type /= Void and then attached {LIKE_CURRENT} l_type.actual_type as l_like_current then
						l_type := l_like_current.conformance_type
					end
					if l_type.actual_type.is_formal or l_type.is_reference then
						if a_level = 0 then
								-- We are now comparing the B part in A [B].
								-- Do not worry about formal position, because FOO [G, H] and FOO [H, G] share the same class type.
							Result := l_other_generics [i].is_formal
						else
								-- We are now analyzing the X part in A [B [X]]
								-- which can only happen if B [X] is expanded. In that case
								-- we just check that for X the corresponding actual in `other' is
								-- also a reference.
							Result := l_other_generics [i].is_reference
						end
					else
						Result := l_type.internal_same_generic_derivation_as (current_type, l_other_generics.i_th (i), a_level + 1)
					end
					i := i + 1
				end
			end
		end

feature -- Primitives

	generate_error_from_creation_constraint_list (a_context_class: CLASS_C; a_context_feature: FEATURE_I; a_location_as: LOCATION_AS)
			-- Generated a VTCG7 error if there are any constraint errors.
			-- Otherwise it does nothing.
		require
			not_constraint_error_list_is_void: constraint_error_list /= Void
		local
			l_vtcg7: VTCG7
		do
			if not constraint_error_list.is_empty then
					-- The feature listed in the creation constraint have
					-- not been declared in the constraint class.			
				create l_vtcg7
				if a_location_as /= Void then
					l_vtcg7.set_location (a_location_as)
				end
				if a_context_class /= Void then
					l_vtcg7.set_class (a_context_class)
				end
				l_vtcg7.set_error_list (constraint_error_list)
				l_vtcg7.set_parent_type (Current)
				if a_context_feature /= Void then
					l_vtcg7.set_feature (a_context_feature)
					l_vtcg7.set_written_class (a_context_feature.written_class)
				end
				Error_handler.insert_error (l_vtcg7)
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE)
			-- Update dependency for Dead Code Removal
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				generics.i_th (i).update_dependance (feat_depend)
				i := i + 1
			end
		end

	set_generics (g: like generics)
			-- Assign `g' to `generics'.
		require
			g_not_void: g /= Void
		do
			generics := g
		ensure
			generics_set: generics = g
		end

	has_expanded: BOOLEAN
			-- Are some expanded type in the current generic declaration ?
		local
			i, count: INTEGER
		do
			from
				Result := is_expanded
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.i_th (i).has_expanded
				i := i + 1
			end
		end

	is_full_named_type: BOOLEAN
			-- Is Current a fully named type?
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := generics.count + 1
				Result := True
			until
				i = nb
			loop
				if not generics.i_th (i).is_full_named_type then
					Result := False
					i := nb - 1
				end
				i := i + 1
			end
		end

	has_formal_generic: BOOLEAN
			-- Has type a formal generic parameter?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.i_th (i).has_formal_generic
				i := i + 1
			end
		end

	is_loose: BOOLEAN
			-- Does type depend on formal generic parameters and/or anchors?
		local
			g: like generics
			i: INTEGER
		do
			from
				g := generics
				i := g.count
			until
				i <= 0 or else Result
			loop
				Result := g.i_th (i).is_loose
				i := i - 1
			end
		end

	deep_actual_type: like Current
			-- Actual type of Current; recursive version for generics
		local
			i: INTEGER
			l_old_generics, l_new_generics: like generics
			l_prev_type, l_new_type: TYPE_A
		do
			Result := Current
			from
				l_old_generics := Result.generics
				i := l_old_generics.count
			until
				i <= 0
			loop
				l_prev_type := l_old_generics.i_th (i)
				l_new_type := l_prev_type.deep_actual_type
				if l_prev_type /= l_new_type then
					if l_new_generics = Void then
							-- Void modifying original type.
						Result := Result.duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_type, i)
				end
				i := i - 1
			end
		end

	deanchored_form_marks_free: like Current
			-- <Precursor>
		local
			i: INTEGER
			l_old_generics, l_new_generics: like generics
			l_prev_type, l_new_type: TYPE_A
		do
			Result := as_marks_free
			from
				l_old_generics := Result.generics
				i := l_old_generics.count
			until
				i <= 0
			loop
				l_prev_type := l_old_generics.i_th (i)
				l_new_type := l_prev_type.deanchored_form_marks_free
				if l_prev_type /= l_new_type then
					if l_new_generics = Void then
							-- Void modifying original type.
						if Result = Current then
							Result := Result.duplicate_for_instantiation
						else
							Result.set_generics (generics.twin)
						end
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_type, i)
				end
				i := i - 1
			end
		end

	context_free_type: like Current
			-- Actual type of Current; recursive version for generics
		local
			i: INTEGER
			l_old_generics, l_new_generics: like generics
			l_prev_type, l_new_type: TYPE_A
		do
			Result := Current
			from
				l_old_generics := Result.generics
				i := l_old_generics.count
			until
				i <= 0
			loop
				l_prev_type := l_old_generics.i_th (i)
				l_new_type := l_prev_type.context_free_type
				if l_prev_type /= l_new_type then
					if l_new_generics = Void then
							-- Void modifying original type.
						Result := Result.duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_type, i)
				end
				i := i - 1
			end
		end

	actual_argument_type (a_arg_types: ARRAYED_LIST [TYPE_A]): like Current
		local
			i: INTEGER
			l_old_generics, l_new_generics: like generics
			l_prev_type, l_new_type: TYPE_A
		do
			Result := Current
			from
				l_old_generics := Result.generics
				i := l_old_generics.count
			until
				i <= 0
			loop
				l_prev_type := l_old_generics.i_th (i)
				l_new_type := l_prev_type.actual_argument_type (a_arg_types)
				if l_prev_type /= l_new_type then
					if l_new_generics = Void then
							-- Void modifying original type.
						Result := Result.duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_type, i)
				end
				i := i - 1
			end
		end

	recomputed_in (target_type: TYPE_A; context_id: INTEGER; constraint: TYPE_A; written_id: INTEGER): like Current
			-- <Precursor>
		local
			i: INTEGER
			old_generics: like generics
			new_generics: like generics
			old_type: TYPE_A
			new_type: TYPE_A
		do
			Result := Current
			from
				old_generics := Result.generics
				i := old_generics.count
			until
				i <= 0
			loop
				old_type := old_generics.i_th (i)
				new_type := old_type.recomputed_in (target_type, context_id, constraint, written_id)
				if new_type /= old_type then
						-- Record a new type of a generic parameter.
					if new_generics = Void then
							-- Avoid modifying original type descriptor.
						Result := Result.duplicate_for_instantiation
						new_generics := Result.generics
					end
					new_generics.put_i_th (new_type, i)
				end
				i := i - 1
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): GEN_TYPE_A
			-- TODO: new comment
		local
			i: INTEGER
			old_generics: like generics
			new_generics: like generics
			old_type: TYPE_A
			new_type: TYPE_A
		do
			Result := Current
			from
				old_generics := Result.generics
				i := old_generics.count
			until
				i <= 0
			loop
				old_type := old_generics.i_th (i)
				new_type := old_type.instantiation_in (type, written_id)
				if new_type /= old_type then
						-- Record a new type of a generic parameter.
					if new_generics = Void then
							-- Avoid modifying original type descriptor.
						Result := Result.duplicate_for_instantiation
						new_generics := Result.generics
					end
					new_generics.put_i_th (new_type, i)
				end
				i := i - 1
			end
		end

	adapted_in (a_class_type: CLASS_TYPE): GEN_TYPE_A
		local
			i, nb: INTEGER
			l_generics, l_new_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			from
				l_generics := generics
				i := 1
				nb := l_generics.count
			until
				i > nb
			loop
				l_old_generic := l_generics.i_th (i)
				l_new_generic := l_old_generic.adapted_in (a_class_type)
				if l_old_generic /= l_new_generic then
					if Result = Void then
						Result := duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_generic, i)
				end
				i := i + 1
			end
			if Result = Void then
				Result := Current
			end
		end

	skeleton_adapted_in (a_class_type: CLASS_TYPE): GEN_TYPE_A
		local
			i, nb: INTEGER
			l_generics, l_new_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			from
				l_generics := generics
				i := 1
				nb := l_generics.count
			until
				i > nb
			loop
				l_old_generic := l_generics.i_th (i)
				l_new_generic := l_old_generic.skeleton_adapted_in (a_class_type)
				if l_old_generic /= l_new_generic then
					if Result = Void then
						Result := duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_generic, i)
				end
				i := i + 1
			end
			if Result = Void then
				Result := Current
			end
		end

	formal_instantiated_in (class_type: TYPE_A): GEN_TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			i, nb: INTEGER
			l_generics, l_new_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			from
				l_generics := generics
				i := 1
				nb := l_generics.count
			until
				i > nb
			loop
				l_old_generic := l_generics.i_th (i)
				l_new_generic := l_old_generic.formal_instantiated_in (class_type)
				if l_old_generic /= l_new_generic then
					if Result = Void then
						Result := duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_generic, i)
				end
				i := i + 1
			end
			if Result = Void then
				Result := Current
			end
		end

	instantiated_in (class_type: TYPE_A): GEN_TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			i, nb: INTEGER
			l_generics, l_new_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			from
				l_generics := generics
				i := 1
				nb := l_generics.count
			until
				i > nb
			loop
				l_old_generic := l_generics.i_th (i)
				l_new_generic := l_old_generic.instantiated_in (class_type)
				if l_old_generic /= l_new_generic then
					if Result = Void then
						Result := duplicate_for_instantiation
						l_new_generics := Result.generics
					end
					l_new_generics.put_i_th (l_new_generic, i)
				end
				i := i + 1
			end
			if Result = Void then
				Result := Current
			end
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): like Current
		local
			i, nb: INTEGER
			l_generics, l_new_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			if a_ancestor = a_descendant then
				Result := Current
			elseif is_loose then
				from
					l_generics := generics
					nb := l_generics.count
					i := 1
				until
					i > nb
				loop
					l_old_generic := l_generics.i_th (i)
					l_new_generic := l_old_generic.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature)
					if l_old_generic /= l_new_generic then
						if Result = Void then
							Result := duplicate_for_instantiation
							l_new_generics := Result.generics
						end
						l_new_generics.put_i_th (l_new_generic, i)
					end
					i := i + 1
				end
				if Result = Void then
					Result := Current
				end
			else
				Result := Current
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A
			-- Parent actual type in the current context
		do
			Result := instantiate (parent)
		end

	instantiate (type: TYPE_A): TYPE_A
			-- Instantiates `type'. Given that `type' may hold
			-- some formal generics, instantiate them with the
			-- generics from Current.	
		require
			good_argument: type /= Void
		local
			i, count: INTEGER
			gen_type_generics: like generics
			l_old_generic, l_new_generic: TYPE_A
		do
			if attached {FORMAL_A} type as formal_type then
					-- Instantiation of a formal generic
				Result := generics.i_th (formal_type.position).actual_type
			elseif type.is_like then
					-- We do not want to loose the fact that it is an anchor
					-- as otherwise we would break eweasel test exec206, but we
					-- still need to adapt its actual_type to the current context
					-- otherwise we would break valid168.
				if attached {LIKE_TYPE_A} type.duplicate as l_like_type then
					l_like_type.set_actual_type (instantiate (l_like_type.conformance_type))
					Result := l_like_type
				else
					check type_duplicate_is_like_type: False end
				end
			elseif type.has_generics and then attached {GEN_TYPE_A} type as gen_type then
					-- Instantiation of the generic parameter of `type'
				from
					i := 1
					gen_type_generics := gen_type.generics
					count := gen_type_generics.count
				until
					i > count
				loop
					l_old_generic := gen_type_generics [i]
					l_new_generic := instantiate (l_old_generic)
					if l_old_generic /= l_new_generic then
							-- If a new object is generated as a result of the generic type instantiation
							-- then we need to duplicate `gen_type'.
						if Result = Void then
							Result := gen_type.duplicate_for_instantiation
							gen_type_generics := Result.generics
						end
						gen_type_generics [i] := l_new_generic
					end
					i := i + 1
				end
			end
			if Result = Void then
				Result := type
			end
		end

	has_like: BOOLEAN
			-- Has the type anchored type in its definition ?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.i_th (i).has_like
				i := i + 1
			end
		end

	has_like_argument: BOOLEAN
			-- Has the type like argument in its definition?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.i_th (i).has_like_argument
				i := i + 1
			end
		end

	has_like_Current: BOOLEAN
			-- <Precursor>
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.i_th (i).has_like_current
				i := i + 1
			end
		end

	is_known: BOOLEAN
			-- <Precursor>
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
				Result := True
			until
				i > count or else not Result
			loop
				Result := generics.i_th (i).is_known
				i := i + 1
			end
		end

	duplicate_for_instantiation: like Current
			-- Duplication for instantiation routines.
		do
			Result := twin
				-- We do not need to duplicate types in generics as this is handled
				-- by the instantiation routines.
			Result.set_generics (generics.twin)
		end

	good_generics: BOOLEAN
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations?
		local
			base_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			i, generic_count: INTEGER
		do
			base_generics := base_class.generics
			if base_generics /= Void then
				generic_count := base_generics.count
				Result := generic_count = generics.count
				from
					i := 1
				until
					i > generic_count or else not Result
				loop
					Result := generics.i_th (i).good_generics
					i := i + 1
				end
			end
		end

	check_labels (a_context_class: CLASS_C; a_node: TYPE_AS)
			-- <Precursor>
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			from
				l_generics := generics
				i  := l_generics.lower
				nb := l_generics.upper
			until
				i > nb
			loop
				l_generics.i_th (i).check_labels (a_context_class, a_node)
				i := i + 1
			end
		end

	error_generics: VTUG
			-- Returns the first error regarding the number of generic parameters
			-- compared to the formal generic declarations.
			--| Recursion is done to find all errors.
		local
			base_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			i, generic_count: INTEGER
		do
				-- We could avoid having this check but the precondition does not tell us
				-- we can.
			if base_class /= Void then
				base_generics := base_class.generics
				if base_generics /= Void then
					generic_count := base_generics.count
					if generic_count = generics.count then
						from
							i := 1
						until
							i > generic_count or else (Result /= Void)
						loop
							if not generics.i_th (i).good_generics then
								Result := generics.i_th (i).error_generics
							end
							i := i + 1
						end
					end
				end
				if Result = Void then
					if base_generics = Void then
						create {VTUG1} Result
					else
						create {VTUG2} Result
					end
					Result.set_type (Current)
					Result.set_base_class (base_class)
				end
			end
		end

	check_constraints (a_type_context: CLASS_C; a_context_feature: FEATURE_I; a_check_creation_readiness: BOOLEAN)
			-- 	Check the constrained genericity validity rule
			--| We check for all generic parameters whether they fullfill their constraints:
			--| * conformance to all the constraining types
			--| * providing creations routines to meet all creation constraints
		local
			i, nb: INTEGER
		do
				-- Check all actual generic parameters against their constraining types.
			from
				i := 1
				nb := generics.count
			until
				i > nb
			loop
				check_one_constraint (a_type_context, a_context_feature, a_check_creation_readiness, i)
				i := i + 1
			end
		end

	check_one_constraint (a_type_context: CLASS_C; a_context_feature: FEATURE_I; a_check_creation_readiness: BOOLEAN; i: INTEGER)
			-- 	Check the constrained genericity validity rule for the `i'-th generic paramenter.
			--| We check that it fullfills its constraints:
			--| * conformance to all the constraining types
			--| * providing creations routines to meet all creation constraints
		local
			l_class: CLASS_C
			l_constraints: TYPE_SET_A
			l_constraint_item: TYPE_A
			l_generic_parameters: like generics
			l_formal_generic_parameter: FORMAL_A
			l_generic_parameter: TYPE_A
			l_conform: BOOLEAN
			l_formal_as: FORMAL_AS
			l_check_creation_readiness: BOOLEAN
			l_wrapped_into_tuple: BOOLEAN
			wrapped_actuals: ARRAYED_LIST [TYPE_A]
			tuple_actual: detachable TUPLE_TYPE_A
		do
			l_conform := True
			l_class := base_class
			l_generic_parameters := generics

			l_generic_parameter := l_generic_parameters.i_th(i)
			l_constraints := l_class.constraints (i)
			from
				l_constraints.start
			until
				l_constraints.after
			loop
				l_constraint_item := l_constraints.item.type
				if l_constraint_item.is_formal and attached {FORMAL_A} l_constraint_item as l_formal_constraint then
						-- Replace the formal with its 'instantiation' of the current generic derivation.
						--| `l_constraint_item' can indeed still be a formal, but now has to be resolved by using `a_type_context'
					l_constraint_item := l_generic_parameters.i_th (l_formal_constraint.position)
				elseif l_constraint_item.has_generics and then not l_constraint_item.generics.is_empty then
						-- We substitude all occurrences of formals in the constraint with the instantiation of the corresponding formal in our generic derivation.
					if attached {GEN_TYPE_A} l_constraint_item.deep_twin as l_generic_constraint then
						l_generic_constraint.substitute (l_generic_parameters)
						l_constraint_item := l_generic_constraint
					else
						check is_generic_constraint: False end
					end
				end
					--| Knowing that formals (FORMAL_A) just take of their "layers" and fall back to their constraints and ask and ask again until they match.
					--| Example: [G -> H, H -> I, I -> J] Question: Is G conform to J? Answer of `conform_to' is yes.
					--| Knowing that there is no recursion in such a case: X -> LIST[X] because either the input really matches LIST and then we _have_ to continue or then it does not and we stop.
				l_formal_as := l_class.generics.i_th (i).formal
				if
					l_generic_parameter.conformance_type.internal_conform_to (a_type_context, l_constraint_item, False) and then
					(l_formal_as.is_expanded implies l_generic_parameter.is_expanded) and then
					(l_formal_as.is_reference implies l_generic_parameter.is_reference) and then
					(not compiler_profile.is_frozen_variant_supported or else
						(l_formal_as.has_frozen_mark implies l_generic_parameter.is_frozen))
				then
						-- Everything is fine, the actual generic conforms to the formal generic.
				else
						-- The actual generic does not conform to the formal generic.
						-- It is possible this formal generic conforms to a tuple type, and there is only one such formal generic,
						-- then the actual generic can be wrapped in a tuple.
					if not l_wrapped_into_tuple and then l_class.tuple_parameter_index = i then
							-- Try to wrap the actrual parameter into a tuple and redo the conformance checks.
						l_wrapped_into_tuple := True
							-- Additional actual parameters may be converted to a tuple type.
						create wrapped_actuals.make (1)
						wrapped_actuals.extend (l_generic_parameter)
							-- Replace extra arguments with a tuple.
						create tuple_actual.make (system.tuple_id, wrapped_actuals)
						if not a_type_context.lace_class.is_void_unsafe then
								-- Do not set any marks for non-void safe code.
							tuple_actual.set_is_attached
						end
						l_generic_parameter := tuple_actual
						l_constraints.start
					else
							-- The actual generic does not conform to the constraint, report an error.
						if l_wrapped_into_tuple then
								-- The actual generic has been wrapped into a tuple, but it still does not conform to one of the constraints.
								-- Unwrap the actual parameter and report an error.
							l_generic_parameter := l_generic_parameters [i]
							tuple_actual := Void
							l_wrapped_into_tuple := False
						end
						l_conform := False
						generate_constraint_error (Current, l_generic_parameter.to_type_set, l_constraint_item.to_type_set, i, Void)
					end
				end

				l_constraints.forth
			end
			if l_conform then
					-- Replace an actual generic type with a tuple-folded one if required.
				if l_wrapped_into_tuple then
					l_generic_parameters [i] := l_generic_parameter
				end
					-- Check now for the validity of the creation constraint clause if
					-- there is one which can be checked, i.e. when `to_check' conforms
					-- to `constraint_type'.
				if attached {FORMAL_CONSTRAINT_AS} l_class.generics.i_th (i) as l_formal_dec_as then
					if l_formal_dec_as.has_creation_constraint and (system.check_generic_creation_constraint and a_check_creation_readiness) then
							-- If we are not in degree 3 (i.e. 4), we cannot have a
							-- complete check since if we are currently checking an attribute
							-- of TEST declared as A [TOTO], maybe TOTO has not yet been recompiled?
							-- So we store all the needed information and we will do a check at the
							-- end of the degree 4 (look at PASS2 for the code which does the checking).								
						if attached {FORMAL_A} l_generic_parameter.conformance_type as l_gen_param then
							l_formal_generic_parameter := l_gen_param
						else
							l_formal_generic_parameter := Void
						end
							-- We have a creation constraint so in case a check was requested we have to continue checking it.
						l_check_creation_readiness := a_check_creation_readiness
						if System.in_pass3 then
							creation_constraint_check (
									l_formal_dec_as, l_constraints, a_type_context,
									l_generic_parameter, i, l_formal_generic_parameter)
						else
							add_future_checking (a_type_context,
								agent delayed_creation_constraint_check (a_type_context, a_context_feature,
								l_generic_parameter, l_constraints, i, l_formal_generic_parameter))
						end
					else
							-- We do not have a creation constraint, so stop checking for it.
						l_check_creation_readiness := False
					end
				else
					check is_formal_constraint: False end
						-- We do not have a creation constraint, so stop checking for it.
					l_check_creation_readiness := False
				end
			end
			if l_generic_parameter.has_generics then
					-- Recursion
				l_generic_parameter.check_constraints (a_type_context, a_context_feature, l_check_creation_readiness)
			end
		end

	substitute (new_generics: like generics)
			-- Take the arguments from `new_generics' to create an
			-- effective representation of the current GEN_TYPE
		require
			new_generics_not_void: new_generics /= Void
		local
			i, count: INTEGER
			constraint_type: TYPE_A
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				constraint_type := generics.i_th (i)
				if constraint_type.is_formal and then attached {FORMAL_A} constraint_type as formal_type then
					generics [i] := new_generics [formal_type.position]
				elseif constraint_type.generics /= Void and then attached {GEN_TYPE_A} constraint_type as gen_type then
					gen_type.substitute (new_generics)
				end
				i := i + 1
			end
		end

	delayed_creation_constraint_check (
			context_class: CLASS_C;
			a_context_feature: FEATURE_I;
			to_check: TYPE_A
			constraint_type: TYPE_SET_A
			i: INTEGER;
			formal_type: FORMAL_A)
				-- Check that declaration of generic class is conform to
				-- defined creation constraint in delayed mode.
		require
			to_check_is_formal_implies_formal_type_not_void: to_check.conformance_type.is_formal implies formal_type /= Void
		do
			reset_constraint_error_list
				-- Some delay checks involves classes that are not in the system anymore,
				-- in that case there is nothing to check.
			if
				is_valid and then context_class.is_valid and then to_check /= Void and then to_check.is_valid and then
				base_class.generics.valid_index (i)
			then
				if attached {FORMAL_CONSTRAINT_AS} base_class.generics.i_th (i) as l_formal_dec_as then
					if l_formal_dec_as.has_creation_constraint then
						creation_constraint_check (l_formal_dec_as, constraint_type, context_class, to_check, i, formal_type)
						generate_error_from_creation_constraint_list (context_class, a_context_feature, l_formal_dec_as.start_location )
					end
				else
					check is_formal_dec_as: False end
				end
			end
		end

	creation_constraint_check (
			formal_dec_as: FORMAL_CONSTRAINT_AS
			a_constraint_types: TYPE_SET_A;
			context_class: CLASS_C;
			to_check: TYPE_A;
			i: INTEGER;
			formal_type: FORMAL_A)
				-- Check that declaration of generic class is conform to
				-- defined creation constraint.
		require
			formal_dec_as_not_void: formal_dec_as /= Void
			creation_constraint_exists: formal_dec_as.has_creation_constraint
			is_valid: is_valid
		local
			formal_crc_list, crc_list: LINKED_LIST [TUPLE [type_item: RENAMED_TYPE_A; feature_item: FEATURE_I]];
			creators_table: like {CLASS_C}.creators
			matched: BOOLEAN
			feat_tbl: FEATURE_TABLE
			class_c: CLASS_C
			other_feature_i, feature_i: FEATURE_I
			l_unmatched_features: LIST [FEATURE_I]
		do

				-- If there is a creation constraint we are facing two different cases:
				-- * case 1: the declaration is using a real type `to_check', we check that
				--           the creation procedures listed in the constraint are indeed
				--           creation procedures of `to_check'.
				-- * case 2: the declaration is using a formal type. Let's take an example and
				--           I will explain what we need to do:
				--           we have:
				--                A[G -> C create make_1, make_2,..., make_n end]
				--                B [H, K -> MY_C create my_make_1, my_make_2,...my_make_m end]
				--                MY_C inherits from C
				--           In B, we have `a: A[K]', which is valid if:
				--            * MY_C conforms to C (already established here)
				--            * m >= n
				--            * for each `make_i' where 1 <= i <= n, there is a `j' (1 <= j <= m)
				--              where `my_make_k' is a redefined/renamed version of `make_i'.
			crc_list := formal_dec_as.constraint_creation_list (base_class)
			if formal_type = Void then
					-- We're in the case of a class type.

					-- If it is a deferred class and the actual derivation uses like current
					-- we move the duty to check the creation constraint to the full class check to check
					-- the descendants of this deferred class, which can never be instantiated direclty.
					-- See bug#12464 and test#valid208/test#valid209 for more information.
				if to_check.is_like_current and context_class.is_deferred then
					-- We simply accept it.
				else

					if to_check.has_associated_class then
						-- `to_check' may not have an associated class if it represents NONE type, for
							-- example in PROCEDURE [ANY, NONE], we will check NONE against
							-- constraint of PROCEDURE which is `TUPLE create default_create end'.						
						class_c := to_check.base_class
						creators_table := class_c.creators
					end

						-- A creation procedure has to be specified, so if none is
						-- specified or if there is no creation procedure in the class
						-- corresponding to `to_check', this is not valid.
					if
						attached class_c and then
						class_c.is_once
					then
							-- An actual generic parameter cannot be based on a once class.
						generate_constraint_error (Current, to_check.to_type_set, a_constraint_types, i, Void)
					elseif
						attached creators_table and then
						not creators_table.is_empty
					then
						from
							crc_list.start
							feat_tbl := class_c.feature_table
						until
							crc_list.after
						loop
								-- Let's take one of the creation procedure defined in the constraint.
							feature_i := crc_list.item.feature_item

								-- Take the redefined/renamed version of the previous version in the
								-- descendant class `to_check'/`class_c'.
							other_feature_i := feat_tbl.feature_of_rout_id (feature_i.rout_id_set.first)

								-- Test if we found the specified feature name among the creation
								-- procedures of `class_c' and that it is exported to Current, since it
								-- it is Current that will create instances of the generic parameter.
							if
								attached creators_table [other_feature_i.feature_name_id] as e implies
								not e.valid_for (base_class)
							then
								if l_unmatched_features = Void then
									create {LINKED_LIST[FEATURE_I]} l_unmatched_features.make
								end
								l_unmatched_features.extend (feature_i)
							end
							crc_list.forth
						end
					else
							-- The class type does not have a creation clause:
							-- May be we are handling a case where the constraint only specfies
							-- `default_create', so let's check that the constraint defines
							-- `default_create' as creation procedure and that `creators_table'
							-- is Void (as empty means there is no way to create an instance of this
							-- class).
							-- At last we check that this class is not deferred.
						if
						 	creators_table = Void and then
							crc_list.count = 1 and then
							formal_dec_as.has_default_create
						then
								-- Ok, no error: We have no create clause which makes `default_create' available
								-- and the constraint demands only `default_create'
								-- But maybe it is a deferred class?					
							if attached class_c and then class_c.is_deferred then
								if l_unmatched_features = Void then
									create {LINKED_LIST[FEATURE_I]} l_unmatched_features.make
								end
								l_unmatched_features.extend (crc_list.first.feature_item)
							end
						else
								-- Generate list of features not matching constraint.
							from
								create {LINKED_LIST[FEATURE_I]} l_unmatched_features.make
								crc_list.start
							until
								crc_list.after
							loop
									-- If `creators_table' is not Void, it simply means we have an empty creation routine
									-- and therefore all the creation constraints are not met.
									-- If it is Void, then `{ANY}.default_create' is a valid creation routine, in that
									-- case we should not list `default_create' has not beeing met if listed in the creation
									-- constraint.
								feature_i := crc_list.item.feature_item
								if attached creators_table or else not feature_i.rout_id_set.has (system.default_create_rout_id) then
									l_unmatched_features.extend (feature_i)
								end
								crc_list.forth
							end
						end
					end
						-- We have an error if we have unmatched features.
					if l_unmatched_features /= Void then
						generate_constraint_error (Current, to_check.to_type_set, a_constraint_types, i, l_unmatched_features)
					end
				end
			else
					-- Check if there is a creation constraint clause
				if
					attached {FORMAL_CONSTRAINT_AS} context_class.generics.i_th (formal_type.position) as formal_type_dec_as and then
					formal_type_dec_as.has_creation_constraint
				then
						-- Check if we have m >= n as specified above.
					formal_crc_list := formal_type_dec_as.constraint_creation_list (context_class)
					if formal_crc_list.count >= crc_list.count then
						from
							crc_list.start
							matched := True
						until
							crc_list.after
						loop
							feature_i := crc_list.item.feature_item
								-- Check that all the creation procedures defined in the creation
								-- constraint clause `crc_list' are indeed present under a
								-- redefined/renamed version in the creation constraint clause
							from
								matched := False
								formal_crc_list.start
							until
								matched or else formal_crc_list.after
							loop
								matched := formal_crc_list.item.feature_item.rout_id_set.has (
											feature_i.rout_id_set.first)
								formal_crc_list.forth
							end
								-- If not matched save the feature to report a proper error.
							if not matched then
								if l_unmatched_features = Void then
									create {LINKED_LIST [FEATURE_I]} l_unmatched_features.make
								end
								l_unmatched_features.extend (feature_i)
							end
							crc_list.forth
						end
					else
						matched := False
					end
				else
					matched := False
				end

				if not matched then
					generate_constraint_error (Current, formal_type.to_type_set, a_constraint_types, i, l_unmatched_features)
				end
			end
		end

	expanded_deferred: BOOLEAN
			-- Are the expanded class types present in the current generic
			-- type not based on deferred classes ?
		local
			i, nb: INTEGER
			gen_param: TYPE_A
		do
			from
				Result := Precursor {CL_TYPE_A}
				i := 1
				nb := generics.count
			until
				i > nb or else Result
			loop
				gen_param := generics.i_th (i)
				if gen_param.has_expanded then
					Result := gen_param.expanded_deferred
				end
				i := i + 1
			end
		end

	valid_expanded_creation (a_class: CLASS_C): BOOLEAN
			-- Is the expanded type has an associated class with one
			-- creation routine with no arguments only ?
		local
			i, nb: INTEGER
			gen_param: TYPE_A
		do
			from
				Result := Precursor {CL_TYPE_A} (a_class)
				i := 1
				nb := generics.count
			until
				i > nb or else not Result
			loop
				gen_param := generics.i_th (i)
				if gen_param.has_expanded then
					Result := gen_param.valid_expanded_creation (a_class)
				end
				i := i + 1
			end
		end

invariant

		-- A generic class always has generic parameters
	generics_not_void: generics /= Void

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

end -- class GEN_TYPE_A
