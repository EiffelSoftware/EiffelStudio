indexing
	description: "Description of an actual class type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_A

inherit
	NAMED_TYPE_A
		redefine
			is_expanded, is_reference, is_separate, instantiation_in, valid_generic,
			duplicate, meta_type, same_as, good_generics, error_generics,
			has_expanded, internal_is_valid_for_class, convert_to, description,
			is_full_named_type, is_external, is_enum, is_conformant_to,
			hash_code, sk_value, is_optimized_as_frozen, generated_id,
			generate_cecil_value, element_type, adapted_in,
			il_type_name, generate_gen_type_il, is_generated_as_single_type,
			generic_derivation, associated_class_type, has_associated_class_type,
			internal_same_generic_derivation_as, internal_generic_derivation,
			has_associated_class, is_class_valid, instantiated_in, deep_actual_type
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER) is
		require
			valid_class_id: a_class_id > 0
		local
			l_class: like associated_class
		do
			class_id := a_class_id
			l_class := system.class_of_id (a_class_id)
			if l_class /= Void and then l_class.is_expanded then
				set_expanded_class_mark
			end
		ensure
			class_id_set: class_id = a_class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_cl_type_a (Current)
		end

feature -- Properties

	has_no_mark: BOOLEAN is
			-- Has class type no explicit mark?
		do
			Result := declaration_mark = no_mark
		ensure
			definition: Result = (declaration_mark = no_mark)
		end

	has_expanded_mark: BOOLEAN is
			-- Is class type explicitly marked as expanded?
		do
			Result := declaration_mark = expanded_mark
		ensure
			definition: Result = (declaration_mark = expanded_mark)
		end

	has_reference_mark: BOOLEAN is
			-- Is class type explicitly marked as reference?
		do
			Result := declaration_mark = reference_mark
		ensure
			definition: Result = (declaration_mark = reference_mark)
		end

	has_separate_mark: BOOLEAN is
			-- Is class type explicitly marked as reference?
		do
			Result := declaration_mark = separate_mark
		ensure
			definition: Result = (declaration_mark = separate_mark)
		end

	has_actual (a_type: TYPE_A): BOOLEAN is
			-- Is `a_type' an actual parameter of Current?
		require
			a_type_not_void: a_type /= Void
		do
			-- Ideally should be in GEN_TYPE_I
		end

	has_associated_class, is_class_valid: BOOLEAN is
		do
			Result := associated_class /= Void
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN is
		do
			if associated_class /= Void then
				Result := associated_class.types.has_type (a_context_type, Current)
			end
		end

	is_expanded: BOOLEAN is
			-- Is the type expanded?
		do
			Result := has_expanded_mark or else (has_no_mark and then associated_class.is_expanded)
		end

	is_reference: BOOLEAN is
			-- Is the type a reference type?
		do
			Result := has_reference_mark or else (has_no_mark and then not associated_class.is_expanded)
		end

	is_separate: BOOLEAN is
			-- Is the type separate?
		do
			Result := has_separate_mark
		end

	is_full_named_type: BOOLEAN is
			-- Current is a full named type.
		do
			Result := True
		end

	is_external: BOOLEAN is
			-- Is current type based on an external calss?
		local
			l_base_class: like associated_class
		do
			l_base_class := associated_class
			Result := is_basic or (not l_base_class.is_basic and l_base_class.is_external)
		end

	is_enum: BOOLEAN is
			-- Is the current actual type an external enum one?
		local
			l_base_class: like associated_class
		do
			l_base_class := associated_class
			Result := is_expanded and l_base_class.is_external and l_base_class.is_enum
		end

	is_system_object_or_any: BOOLEAN is
			-- Does current type represent SYSTEM_OBJECT or ANY?
		require
			il_generation: System.il_generation
		local
			l_class_id: like class_id
			l_system: like system
		do
			l_class_id := class_id
			l_system := system
			Result := l_class_id = l_system.system_object_class.compiled_class.class_id or
				l_class_id = l_system.any_class.compiled_class.class_id
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := declaration_mark = other.declaration_mark and then
				class_declaration_mark = other.class_declaration_mark and then
				is_attached = other.is_attached and then
				class_id = other.class_id
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other
			Result := other_class_type /= Void and then class_id = other_class_type.class_id
						and then is_expanded = other_class_type.is_expanded
						and then is_separate = other_class_type.is_separate
						and then has_same_attachment_marks (other_class_type)
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := class_id
		end

	class_id: INTEGER
			-- Class id of the associated class

	associated_class: CLASS_C is
			-- Associated class to the type
		do
			Result := System.class_of_id (class_id)
		end

	associated_class_type (context_type: TYPE_A): CLASS_TYPE is
		do
			Result := associated_class.types.search_item (context_type, Current)
		end

	deep_actual_type: like Current is
			-- <Precursor>
			--| Redefined for getting a more precise type.
		do
			Result := Current
		end

	sk_value (a_context_type: TYPE_A): INTEGER is
		do
			if is_expanded then
				Result := {SK_CONST}.sk_exp | (type_id (a_context_type) - 1)
			else
				Result := {SK_CONST}.sk_ref | (type_id (a_context_type) - 1)
			end
		end

	description: ATTR_DESC is
		local
			exp: EXPANDED_DESC
		do
			if is_expanded then
				create exp
				exp.set_type_i (Current)
				Result := exp
			else
				Result := Precursor
			end
		end

	generic_derivation: like Current is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := internal_generic_derivation (0)
		end

	instantiated_in (class_type: TYPE_A): CL_TYPE_A is
			-- <Precursor>
			--| Redefined for refining the return type.
		do
			Result := Current
		end

	meta_type: TYPE_A is
			-- Meta type of the type
		do
			Result := system.any_type
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := associated_class.generics = Void
		end

	error_generics: VTUG is
		do
				-- We could avoid having this check but the precondition does not tell us
				-- we can.
			if associated_class /= Void then
				create {VTUG2} Result
				Result.set_type (Current)
				Result.set_base_class (associated_class)
			end
		end

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in its declration ?
		do
			Result := is_expanded
		end

feature -- Output

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		do
			if has_attached_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_exclamation)
			elseif has_detachable_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_question)
			end
			if has_expanded_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_expanded_keyword, Void)
				st.add_space
			elseif has_reference_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_reference_keyword, Void)
				st.add_space
			elseif has_separate_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_separate_keyword, Void)
				st.add_space
			end
			associated_class.append_name (st)
		end

	dump: STRING is
			-- Dumped trace
		local
			class_name: STRING
			n: INTEGER
		do
			class_name := associated_class.name_in_upper
			n := class_name.count
			if has_attached_mark or else has_detachable_mark then
				n := n + 2
			end
			if not has_no_mark then
				n := n + 10
			end
			create Result.make (n)
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
			if has_expanded_mark then
				Result.append ("expanded ")
			elseif has_reference_mark then
				Result.append ("reference ")
			elseif has_separate_mark then
				Result.append ("separate ")
			end
			Result.append (class_name)
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16 is
		local
			l_id: INTEGER
		do
			if final_mode then
				l_id := type_id (a_context_type) - 1
			else
				l_id := static_type_id (a_context_type) - 1
			end
			Result := l_id.to_natural_16
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_class_type_instance (Current)
		end

feature -- IL code generation

	implemented_type (implemented_in: INTEGER_32): CL_TYPE_A
			-- Parent type that corresponds to the current one.
		require
			valid_implemented_in: implemented_in > 0
		do
			if class_id = implemented_in then
				Result := Current
			else
				Result := find_class_type (system.class_of_id (implemented_in))
			end
		end

	element_type: INTEGER_8 is
			-- Void element type
		do
			if is_expanded then
				Result := {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype
			else
				if class_id = System.system_string_class.compiled_class.class_id then
					Result := {MD_SIGNATURE_CONSTANTS}.Element_type_string
				elseif class_id = System.system_object_id or class_id = system.any_id then
						-- For ANY or SYSTEM_OBJECT, we always generate a System.Object
						-- signature since we can now assign SYSTEM_OBJECTs into ANYs.
					Result := {MD_SIGNATURE_CONSTANTS}.Element_type_object
				else
					Result := {MD_SIGNATURE_CONSTANTS}.Element_type_class
				end
			end
		end

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING is
			-- Class name of current type.
		local
			l_class_c: like associated_class
			l_cl_type: like associated_class_type
			l_alias_name: STRING
			l_dot_pos: INTEGER
		do
			l_class_c := associated_class
			if l_class_c.is_external and not l_class_c.is_basic then
				Result := l_class_c.external_class_name.twin
			else
				if l_class_c.is_precompiled then
						-- Reuse the name that was computed at precompilation time.
					l_cl_type := associated_class_type (a_context_type)
					if l_cl_type.is_precompiled then
						Result := l_cl_type.il_type_name (a_prefix)
					end
				end
				if Result = Void then
					if not has_no_mark or else is_basic or else l_class_c.external_class_name.is_equal (l_class_c.name) then
						Result := internal_il_type_name (l_class_c.name.twin, a_prefix)
					else
							-- Special case when an external name has been specified.
						Result := l_class_c.external_class_name.twin
						Result.left_adjust
						Result.right_adjust
							-- Remove leading `.' since it is not a valid .NET name.
						from
						until
							Result.is_empty or else Result.item (1) /= '.'
						loop
							Result.remove_head (1)
						end
							-- Remove trailing `.' since it is not a valid .NET name.
						from
						until
							Result.is_empty or else Result.item (Result.count) /= '.'
						loop
							Result.remove_tail (1)
						end
						if Result.is_empty then
								-- External name is invalid since empty, we use the normal
								-- way of generating the .Net name
							Result := internal_il_type_name (l_class_c.name.twin, a_prefix)
						else
							if a_prefix /= Void then
								l_dot_pos := Result.last_index_of ('.', Result.count)
								if l_dot_pos = 0 then
									Result.prepend_character ('.')
									Result.prepend (a_prefix)
								else
									check
											-- Because there are no more leading or trailing `.'.
										valid_l_dot_pos: l_dot_pos > 1 and l_dot_pos < Result.count
									end
									l_alias_name := Result.substring (l_dot_pos + 1, Result.count)
									check
										l_alias_name_not_empty: not l_alias_name.is_empty
									end
									Result.keep_head (l_dot_pos)
									l_alias_name := internal_il_base_type_name (l_alias_name)
									Result.append (a_prefix)
									Result.append_character ('.')
									Result.append (l_alias_name)
								end
							end
						end
					end
				end
			end
		end

	is_optimized_as_frozen: BOOLEAN
		do
			Result := associated_class.is_optimized_as_frozen
		end

	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		do
				-- External classes have only one type.
				-- Classes that inherits from external classes
				-- have only one generated type as well as expanded types.
			Result := is_true_external or associated_class.is_single or is_expanded
		end

feature {NONE} -- IL code generation

	frozen internal_il_type_name (a_base_name, a_prefix: STRING): STRING is
			-- Full type name of `a_base_name' using `a_prefix' in IL code generation
			-- with namespace specification
		require
			a_base_name_not_void: a_base_name /= Void
			a_base_name_not_empty: not a_base_name.is_empty
		do
			Result := internal_il_base_type_name (a_base_name)
				-- Result needs to be in lower case because that's
				-- what our casing conversion routines require to perform
				-- a good job.
			Result.to_lower
			Result := il_casing.type_name (associated_class.original_class.actual_namespace, a_prefix, Result, System.dotnet_naming_convention)
		ensure
			internal_il_type_name_not_void: Result /= Void
			internal_il_type_name_not_empty: not Result.is_empty
		end

	frozen internal_il_base_type_name (a_base_name: STRING): STRING is
			-- Given `a_base_name' provides its updated name depending on its usage.
		require
			a_base_name_not_void: a_base_name /= Void
			a_base_name_not_empty: not a_base_name.is_empty
		local
			l_base_class: like associated_class
		do
			l_base_class := associated_class
			if is_expanded and then not l_base_class.is_expanded then
				create Result.make (6 + a_base_name.count)
				Result.append ("value_")
			elseif not is_expanded and then l_base_class.is_expanded then
				create Result.make (10 + a_base_name.count)
				Result.append ("reference_")
			else
				create Result.make (a_base_name.count)
			end
			Result.append (a_base_name)
		ensure
			internal_il_base_type_name_not_void: Result /= Void
			internal_il_base_type_name_not_empty: not Result.is_empty
		end

feature -- C code generation

	generate_cecil_value (buffer: GENERATION_BUFFER; a_context_type: TYPE_A) is
			-- Generate type value for cecil.
		do
			if not is_expanded then
				buffer.put_string ({SK_CONST}.sk_ref_string)
			else
				buffer.put_string ({SK_CONST}.sk_exp_string)
			end
			buffer.put_three_character (' ', '+', ' ')
			buffer.put_type_id (type_id (a_context_type))
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN is
			-- Is Current still valid?
			-- I.e. its `associated_class' is still in system.
		local
			l_class: like associated_class
		do
			l_class := associated_class
				-- Check that current class still exists and that there are no
				-- generics.
				--| Ideally we could also check that if Current base class is expanded
				--| then it has the class_declaration_mark properly set, but it does not
				--| currently work when processing TYPED_POINTER which is currently interpreted
			Result := l_class /= Void and then l_class.generics = Void and then
				(l_class.is_expanded = (class_declaration_mark = expanded_mark))
		end

	internal_generic_derivation (a_level: INTEGER): CL_TYPE_A is
		local
			l_attachment: like attachment_bits
		do
			if attachment_bits = 0 then
				Result := Current
			else
					-- Clear the attachment mark.
				l_attachment := attachment_bits
				attachment_bits := 0
				Result := twin
				attachment_bits := l_attachment
			end
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER): BOOLEAN is
		do
			Result := same_type (other) and then {l_cl_type: !like Current} other and then
				l_cl_type.class_id = class_id and then
						-- 'class_id' is the same therefore we can compare 'declaration_mark'.
						-- If 'declaration_mark' is not the same for both then we have to make sure
						-- that both expanded and separate states are identical.
				(l_cl_type.declaration_mark /= declaration_mark implies
					(l_cl_type.is_expanded = is_expanded and then
					l_cl_type.is_separate = is_separate))
		end

feature {COMPILER_EXPORTER} -- Settings

	set_expanded_class_mark is
			-- Mark class declaration as expanded.
		do
			class_declaration_mark := expanded_mark
		ensure
			has_expanded_class_mark: class_declaration_mark = expanded_mark
		end

	set_expanded_mark is
			-- Set class type declaration as expanded.
		do
			declaration_mark := expanded_mark
		ensure
			has_expanded_mark: has_expanded_mark
		end

	set_reference_mark is
			-- Set class type declaration as reference.
		do
			declaration_mark := reference_mark
		ensure
			has_reference_mark: has_reference_mark
		end

	set_separate_mark is
			-- Set class type declaration as separate.
		do
			declaration_mark := separate_mark
		ensure
			has_separate_mark: has_separate_mark
		end

feature {COMPILER_EXPORTER} -- Conformance

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
			create l_checker
			l_checker.check_conversion (a_context_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_class_type: CL_TYPE_A
			l_other_type_set: TYPE_SET_A
		do
			other_class_type ?= other.conformance_type
			if other_class_type /= Void then
				if other_class_type.is_expanded then
						-- It should be the exact same base class for expanded.
					if is_expanded and then class_id = other_class_type.class_id then
						if is_typed_pointer then
								-- TYPED_POINTER should be exactly the same type.
							Result := same_as (other)
						else
							Result := other_class_type.valid_generic (Current)
						end
					end
				else
					Result :=
						associated_class.conform_to (other_class_type.associated_class) and then
						other_class_type.valid_generic (Current) and then
						is_attachable_to (other_class_type)
					if not Result and then system.il_generation and then system.system_object_class /= Void then
							-- Any type in .NET conforms to System.Object
						check
							system.system_object_class.is_compiled
						end
						Result := other_class_type.class_id = system.system_object_id
					end
				end
			elseif other.is_type_set then
				l_other_type_set ?= other.actual_type
				Result := to_type_set.conform_to (l_other_type_set.twin)
			end
		end

	is_conformant_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		local
			l_is_exp, l_other_is_exp: BOOLEAN
			l_other_class_type: CL_TYPE_A
			current_mark: like declaration_mark
			other_mark: like declaration_mark
		do
			Result := Current = other
			if not Result then
				l_other_class_type ?= other.actual_type
				if l_other_class_type /= Void then
						-- We perform conformance as if the two types were not
						-- expanded. So, if they are expanded, we remove their
						-- expanded flag to do the conformance check.
					l_is_exp := is_expanded
					l_other_is_exp := l_other_class_type.is_expanded
					if l_is_exp then
						current_mark := declaration_mark
						set_reference_mark
					end
					if l_other_is_exp then
						other_mark := l_other_class_type.declaration_mark
						l_other_class_type.set_reference_mark
					end

					Result := conform_to (other)

					if l_is_exp then
						set_mark (current_mark)
					end
					if l_other_is_exp then
						l_other_class_type.set_mark (other_mark)
					end
				end
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those
			-- of Current (none).
		do
			Result := True
		end

	generic_conform_to (gen_type: GEN_TYPE_A): BOOLEAN is
			-- Does Current conform to `gen_type' ?
		require
			good_argument: gen_type /= Void
			associated_class.conform_to (gen_type.associated_class)
		local
			i, count: INTEGER
			parent_actual_type: TYPE_A
			l_conforming_parents: FIXED_LIST [CL_TYPE_A]
			l_is_attached: like is_attached
			l_is_implicitly_attached: like is_implicitly_attached
		do
			from
				l_is_attached := is_attached
				l_is_implicitly_attached := is_implicitly_attached
				l_conforming_parents := associated_class.conforming_parents
				i := 1
				count := l_conforming_parents.count
			until
				i > count or else Result
			loop
				parent_actual_type := parent_type (l_conforming_parents.i_th (i))
				if l_is_attached and then not parent_actual_type.is_attached then
					parent_actual_type := parent_actual_type.as_attached
				elseif l_is_implicitly_attached and then not parent_actual_type.is_implicitly_attached then
					parent_actual_type := parent_actual_type.as_implicitly_attached
				end
				Result := parent_actual_type.conform_to (gen_type)
				i := i + 1
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type.
		require
			parent_not_void: parent /= Void
		do
			Result := parent.duplicate
		ensure
			result_not_void: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in `written_id'
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

	adapted_in (class_type: CLASS_TYPE): CL_TYPE_A is
			-- Redefined for covariant redefinition of result type.
		do
			Result := Current
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	instantiation_of (type: TYPE_A; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		local
			instantiation: TYPE_A
			gen_type: GEN_TYPE_A
		do
			if a_class_id = class_id then
					-- Feature is written in the class associated to the
					-- current actual class type
				instantiation := Current
			else
				instantiation := find_class_type (System.class_of_id (a_class_id))
			end
			Result := type.actual_type
			if instantiation.generics /= Void and instantiation.generics.count > 0 then
					-- Does not make sense to instantiate if `instantation' is
					-- a TUPLE with no arguments.
				gen_type ?= instantiation
				Result := gen_type.instantiate (Result)
			end
		end

	find_descendant_type (c: CLASS_C): CL_TYPE_A is
			-- If all the generic derivation of a class were created, the generic derivation
			-- that `c' would have for Current.
		require
			good_argument: c /= Void
			conformance: c.conform_to (associated_class) or else True --| FIXME Manu Add CLASS_C.ancestors_from routine for non-conforming inheritance.
		local
			l_generics, l_result_generics: like generics
			l_class: like associated_class
			l_formal, l_new_formal: FORMAL_A
			l_type_feat: TYPE_FEATURE_I
			i, nb: INTEGER
		do
			Result := c.actual_type
			if generics /= Void and Result.generics /= Void then
				from
					l_class := associated_class
					l_generics := generics
					i := l_generics.lower
					nb := l_generics.upper
					l_result_generics := Result.generics
				until
					i > nb
				loop
						-- Search the TYPE_FEATURE_I routine in `c' that corresponds to the `i-th'
						-- formal generic parameter of current.
					l_type_feat := c.generic_features.item (l_class.formal_at_position (i).rout_id_set.first)
					check l_type_feat_not_void: l_type_feat /= Void end
					if l_type_feat.is_formal then
						l_formal ?= l_type_feat.type
						check l_formal_not_void: l_formal /= Void end
							-- If `l_generics.item (i)' is a formal, we need to make sure that it is a valid
							-- formal for `Result' otherwise we simply keep the existing formal.
							-- This fixes eweasel test#final056.
						l_new_formal ?= l_generics.item (i).actual_type
						if l_new_formal = Void or else l_new_formal.is_valid_for_class (c) then
							l_result_generics.put (l_generics.item (i), l_formal.position)
						end
					end
					i := i + 1
				end
			end
		ensure
			find_descendant_type_not_void: Result /= Void
				-- Ideally this should be that way, but often we manipulate formals and when you have
				-- the ancestor A [G#1] and a descendant A2 (which inherits from A [DOUBLE]) the conformance
				-- query would fail because nothing can conform to a formal apart itself.
			conform_to: -- Result.conform_to (Current)
		end

	find_class_type (c: CLASS_C): CL_TYPE_A is
			-- Actual type of class of id `class_id' in current
			-- context
		require
			good_argument: c /= Void
			conformance: associated_class.conform_to (c) or else True --| FIXME IEK Add CLASS_C.inherits_from routine for non-conforming inheritance.
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent: CL_TYPE_A
			parent_class: CLASS_C
			i, count: INTEGER
			parent_class_type: CL_TYPE_A
		do
			from
				parents := associated_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result /= Void
			loop
				parent := parents.i_th (i)
				parent_class := parent.associated_class
				if parent_class = c then
						-- Class `c' is found
					Result ?= parent_type (parent)
				elseif parent_class.conform_to (c) then
						-- Iterate in the inheritance graph and
						-- conformance tables help to take the good
						-- way in the parents
					parent_class_type ?= parent_type (parent)
					Result := parent_class_type.find_class_type (c)
				end
				i := i + 1
			end
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := twin
		end

	reference_type: CL_TYPE_A is
			-- Reference counterpart of an expanded type
		do
			Result := duplicate
			Result.set_reference_mark
		end

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			create Result.make (Current)
		end

feature -- Debugging

	debug_output: STRING is
			-- Display name of associated class.
		do
			if is_class_valid then
				Result := dump
			else
				Result := "Class not in system anymore"
			end
		end

feature {CL_TYPE_A, TUPLE_CLASS_B, CIL_CODE_GENERATOR} --Class type declaration marks

	declaration_mark: NATURAL_8
			-- Declaration mark associated with a class type (if any)

	class_declaration_mark: NATURAL_8
			-- Declaration mark associated with class. Meaning that when this instance was
			-- created the base class had the same mark (currently only works for expanded).
			-- If Current has still the mark and not the base class, it simply means that
			-- Current is not valid.

	set_mark (mark: like declaration_mark) is
			-- Set `declaration_mark' to the given value `mark'.
		require
			valid_declaration_mark:
				mark = no_mark or mark = expanded_mark or
				mark = reference_mark or mark = separate_mark
		do
			declaration_mark := mark
		ensure
			declaration_mark_set: declaration_mark = mark
		end

	no_mark: NATURAL_8 is 0
			-- Empty declaration mark

	expanded_mark: NATURAL_8 is 1
			-- Expanded declaration mark

	reference_mark: NATURAL_8 is 2
			-- Reference declaration mark

	separate_mark: NATURAL_8 is 3
			-- Separate declaration mark

invariant
	class_id_positive: class_id > 0
	valid_declaration_mark:
		declaration_mark = no_mark or declaration_mark = expanded_mark or
		declaration_mark = reference_mark or declaration_mark = separate_mark
	valid_class_declaration_mark:
		class_declaration_mark = no_mark or class_declaration_mark = expanded_mark

indexing
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

end
