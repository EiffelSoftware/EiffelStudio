note
	description: "Description of an actual class type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_A

inherit
	DEANCHORED_TYPE_A
		redefine
			is_expanded, is_reference, valid_generic, is_expanded_creation_possible,
			meta_type, same_as, good_generics, error_generics,
			has_expanded, internal_is_valid_for_class, convert_to,
			description, description_with_detachable_type,
			is_full_named_type, is_external, is_enum, is_conformant_to,
			sk_value, is_optimized_as_frozen, generated_id,
			generate_cecil_value, element_type, adapted_in, has_reference,
			il_type_name, generate_gen_type_il, is_generated_as_single_type,
			generic_derivation, associated_class_type, has_associated_class_type,
			internal_same_generic_derivation_as, internal_generic_derivation,
			has_associated_class, is_class_valid, instantiated_in, deep_actual_type,
			is_processor_attachable_to, deanchored_form_marks_free, has_same_marks
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER)
		require
			valid_class_id: a_class_id > 0
		local
			l_class: like base_class
		do
			class_id := a_class_id
			l_class := system.class_of_id (a_class_id)
			if attached l_class then
				if l_class.is_expanded then
					set_expanded_class_mark
				end
				if l_class.is_once then
					set_once_class_mark
				end
			end
		ensure
			class_id_set: class_id = a_class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_cl_type_a (Current)
		end

feature -- Properties

	has_no_mark: BOOLEAN
			-- Has class type no explicit mark?
		do
			Result := declaration_mark = no_mark
		ensure
			definition: Result = (declaration_mark = no_mark)
		end

	has_expanded_mark: BOOLEAN
			-- Is class type explicitly marked as expanded?
		do
			Result := declaration_mark = expanded_mark
		ensure
			definition: Result = (declaration_mark = expanded_mark)
		end

	has_reference_mark: BOOLEAN
			-- Is class type explicitly marked as reference?
		do
			Result := declaration_mark = reference_mark
		ensure
			definition: Result = (declaration_mark = reference_mark)
		end

	has_actual (a_type: TYPE_A): BOOLEAN
			-- Is `a_type' an actual parameter of Current?
		require
			a_type_not_void: a_type /= Void
		do
			-- Ideally should be in GEN_TYPE_I
		end

	has_associated_class, is_class_valid: BOOLEAN
		do
			Result := base_class /= Void
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN
		do
			if base_class /= Void then
				Result := base_class.types.has_type (a_context_type, Current)
			end
		end

	is_expanded, is_expanded_creation_possible: BOOLEAN
			-- Is the type expanded?
		local
			l_mark: like declaration_mark
		do
			l_mark := declaration_mark
			Result := l_mark = expanded_mark or else (l_mark = no_mark and then class_declaration_mark ⊗ expanded_mark /= 0)
		end

	is_reference: BOOLEAN
			-- Is the type a reference type?
		local
			l_mark: like declaration_mark
		do
			l_mark := declaration_mark
			Result := l_mark = reference_mark or else (l_mark = no_mark and then class_declaration_mark ⊗ expanded_mark = 0)
		end

	has_reference: BOOLEAN
			-- <Precursor>
		do
			if is_reference then
				Result := True
			elseif attached base_class.skeleton as s then
				across
					s as t
				until
					Result
				loop
					Result := t.item.type_i.instantiation_in (Current, class_id).has_reference
				end
			end
		end

	is_full_named_type: BOOLEAN
			-- Current is a full named type.
		do
			Result := True
		end

	is_external: BOOLEAN
			-- Is current type based on an external calss?
		local
			l_base_class: like base_class
		do
			l_base_class := base_class
			Result := is_basic or (not l_base_class.is_basic and l_base_class.is_external)
		end

	is_enum: BOOLEAN
			-- Is the current actual type an external enum one?
		local
			l_base_class: like base_class
		do
			l_base_class := base_class
			Result := is_expanded and l_base_class.is_external and l_base_class.is_enum
		end

	is_system_object_or_any: BOOLEAN
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

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := declaration_mark = other.declaration_mark and then
				class_declaration_mark = other.class_declaration_mark and then
				is_attached = other.is_attached and then
				class_id = other.class_id
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			Result :=
				attached {CL_TYPE_A} other as other_class_type and then
				class_id = other_class_type.class_id and then
				has_same_marks (other_class_type)
		end

	has_same_marks (other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
			if attached {CL_TYPE_A} other as l_cl_type then
				Result :=
					Precursor (l_cl_type) and then
					declaration_mark = l_cl_type.declaration_mark and then
					class_declaration_mark = l_cl_type.class_declaration_mark
			end
		end

	is_processor_attachable_to (other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
			if Precursor (other) then
					-- If `other' is not separate, the checks done by `Precursor' are sufficient.
				Result := True
				if other.is_separate and then is_expanded and then system.is_scoop and then attached base_class.skeleton as s then
						-- `other' is separate and current type is expanded,
						-- all attributes of the current type must be runnable in the context of `other' processor.
					across
						s as t
					until
						not Result
					loop
						Result := t.item.type_i.instantiation_in (Current, class_id).is_runnable_on_processor (other)
					end
				end
			end
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value.
		do
			Result := class_id
		end

	class_id: INTEGER
			-- Class id of the associated class

	base_class: CLASS_C
			-- Associated class to the type
		do
			Result := System.class_of_id (class_id)
		end

	associated_class_type (context_type: TYPE_A): CLASS_TYPE
		do
			Result := base_class.types.search_item (context_type, Current)
		end

	deep_actual_type: like Current
			-- <Precursor>
			--| Redefined for getting a more precise type.
		do
			Result := Current
		end

	deanchored_form_marks_free: like Current
			-- <Precursor>
			--| Redefined for getting a more precise type.
		do
			Result := as_marks_free
		end

	sk_value (a_context_type: TYPE_A): NATURAL_32
		do
			if is_expanded then
				Result := {SK_CONST}.sk_exp | (type_id (a_context_type) - 1).to_natural_32
			else
				Result := {SK_CONST}.sk_ref | (type_id (a_context_type) - 1).to_natural_32
			end
		end

	description: ATTR_DESC
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

	description_with_detachable_type: ATTR_DESC
		local
			exp: EXPANDED_DESC
		do
			if is_expanded then
				create exp
				exp.set_type_i (as_detachable_type)
				Result := exp
			else
				Result := Precursor
			end
		end

	generic_derivation: like Current
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := internal_generic_derivation (0)
		end

	instantiated_in (class_type: TYPE_A): CL_TYPE_A
			-- <Precursor>
			--| Redefined for refining the return type.
		do
			Result := Current
		end

	meta_type: TYPE_A
			-- Meta type of the type
		do
			Result := system.any_type
		end

	good_generics: BOOLEAN
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := base_class.generics = Void
		end

	error_generics: VTUG
		do
				-- We could avoid having this check but the precondition does not tell us
				-- we can.
			if base_class /= Void then
				create {VTUG2} Result
				Result.set_type (Current)
				Result.set_base_class (base_class)
			end
		end

	has_expanded: BOOLEAN
			-- Has the current type some expanded types in its declration ?
		do
			Result := is_expanded
		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			ext_append_marks (a_text_formatter)
			if has_expanded_mark then
				a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_expanded_keyword, Void)
				a_text_formatter.add_space
			elseif has_reference_mark then
				a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_reference_keyword, Void)
				a_text_formatter.add_space
			end
			base_class.append_name (a_text_formatter)
		end

	dump: STRING
			-- Dumped trace
		local
			class_name: STRING
			n: INTEGER
		do
			class_name := base_class.name_in_upper
			n := class_name.count
			if has_attached_mark or else has_detachable_mark then
				n := n + 2
			end
			if not has_no_mark then
				n := n + 10
			end
			create Result.make (n)
			dump_marks (Result)
			if has_expanded_mark then
				Result.append ({SHARED_TEXT_ITEMS}.ti_expanded_keyword)
				Result.append_character (' ')
			elseif has_reference_mark then
				Result.append ({SHARED_TEXT_ITEMS}.ti_reference_keyword)
				Result.append_character (' ')
			end
			Result.append (class_name)
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
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

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
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

	element_type: INTEGER_8
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

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING
			-- Class name of current type.
		local
			l_class_c: like base_class
			l_cl_type: like associated_class_type
			l_alias_name: STRING
			l_dot_pos: INTEGER
		do
			l_class_c := base_class
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
			Result := base_class.is_optimized_as_frozen
		end

	is_generated_as_single_type: BOOLEAN
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		do
				-- External classes have only one type.
				-- Classes that inherits from external classes
				-- have only one generated type as well as expanded types.
			Result := is_true_external or base_class.is_single or is_expanded
		end

feature {NONE} -- IL code generation

	frozen internal_il_type_name (a_base_name, a_prefix: STRING): STRING
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
			Result := il_casing.type_name (base_class.original_class.actual_namespace, a_prefix, Result, System.dotnet_naming_convention)
		ensure
			internal_il_type_name_not_void: Result /= Void
			internal_il_type_name_not_empty: not Result.is_empty
		end

	frozen internal_il_base_type_name (a_base_name: STRING): STRING
			-- Given `a_base_name' provides its updated name depending on its usage.
		require
			a_base_name_not_void: a_base_name /= Void
			a_base_name_not_empty: not a_base_name.is_empty
		local
			l_base_class: like base_class
		do
			l_base_class := base_class
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

	generate_cecil_value (buffer: GENERATION_BUFFER; a_context_type: TYPE_A)
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

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			if attached {CL_TYPE_A} other.conformance_type as other_class_type then
				if other_class_type.is_expanded then
						-- It should be the exact same base class for expanded.
					if is_expanded and then class_id = other_class_type.class_id then
						Result := other_class_type.valid_generic (a_context_class, Current, a_in_generic)
						if Result and then is_typed_pointer then
								-- TYPED_POINTER should be exactly the same type.
							Result := valid_generic (a_context_class, other_class_type, a_in_generic)
						end
					end
				else
					if a_in_generic and then a_context_class.lace_class.is_catcall_conformance then
						if other.is_frozen then
							Result := is_frozen and then base_class = other_class_type.base_class
						elseif not other.is_variant then
							Result := not is_variant and then base_class = other_class_type.base_class
						else
							check is_variant: other.is_variant end
							Result := base_class.conform_to (other_class_type.base_class)
						end
					else
							-- Note for the reader who wonder why we allow any descendants of X to conform to frozen X.
							-- This is because we want to allow redefinition of routines such as `f (a: frozen A)' to
							-- `f (a: frozen B)'. Note that if `other' is `frozen', we need to be frozen, the way around is ok.
							-- It is only in expression conformance that we check that an expression of type `frozen A'
							-- is used as actual argument to `f' when using the `frozen A' version above.
							-- See commit rev#95174 for when that change occurred.
						Result := base_class.conform_to (other_class_type.base_class) and (other.is_frozen implies is_frozen)
					end
					Result := Result and then other_class_type.valid_generic (a_context_class, Current, a_in_generic)
					if not Result and then system.il_generation and then system.system_object_class /= Void then
							-- Any type in .NET conforms to System.Object
						check
							system.system_object_class.is_compiled
						end
						Result := other_class_type.class_id = system.system_object_id
					end
					if Result and then a_context_class.lace_class.is_void_safe_conformance then
							-- We should still verify that the attachment marks are taken into account.
						Result := is_attachable_to (other_class_type)
					end
					if Result then
						Result := is_processor_attachable_to (other)
					end
				end
			end
		end

	valid_generic (a_context_class: CLASS_C; type: CL_TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Do the generic parameter of `type' conform to those
			-- of Current (none).
		do
			Result := True
		end

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is Current still valid?
			-- I.e. its `associated_class' is still in system.
		local
			l_class: like base_class
		do
			l_class := base_class
				-- Check that current class still exists and that there are no
				-- generics.
				--| Ideally we could also check that if Current base class is expanded
				--| then it has the class_declaration_mark properly set, but it does not
				--| currently work when processing TYPED_POINTER which is currently interpreted
			Result :=
				attached l_class and then
				l_class.is_valid and then
				not attached l_class.generics and then
				l_class.is_expanded = (class_declaration_mark ⊗ expanded_mark /= 0) and then
				l_class.is_once = (class_declaration_mark ⊗ once_mark /= 0)
		end

	internal_generic_derivation (a_level: INTEGER): like Current
			-- <Precursor>
		do
			Result := deanchored_form_marks_free
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER): BOOLEAN
		do
			Result := same_type (other) and then attached {like Current} other as l_cl_type and then
				l_cl_type.class_id = class_id and then
						-- 'class_id' is the same therefore we can compare 'declaration_mark'.
						-- If 'declaration_mark' is not the same for both then we have to make sure
						-- that both expanded and separate states are identical.
				(l_cl_type.declaration_mark /= declaration_mark implies
					(l_cl_type.is_expanded = is_expanded))
		end

feature {COMPILER_EXPORTER} -- Settings

	set_expanded_class_mark
			-- Mark class declaration as expanded.
		do
			class_declaration_mark := expanded_mark
		ensure
			has_expanded_class_mark: class_declaration_mark = expanded_mark
		end

	set_once_class_mark
			-- Mark class declaration as once.
		do
			class_declaration_mark := once_mark
		ensure
			has_once_class_mark: class_declaration_mark = once_mark
		end

	set_expanded_mark
			-- Set class type declaration as expanded.
		do
			if is_reference then
				if base_class.is_expanded then
					declaration_mark := no_mark
				else
					declaration_mark := expanded_mark
				end
			end
		ensure
			is_expanded: is_expanded
		end

	set_reference_mark
			-- Set class type declaration as reference.
		do
			if is_expanded then
				if base_class.is_expanded then
					declaration_mark := reference_mark
				else
					declaration_mark := no_mark
				end
			end
		ensure
			is_reference: is_reference
		end

feature {COMPILER_EXPORTER} -- Conformance

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
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

	is_conformant_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current conform to other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		local
			l_is_exp, l_other_is_exp: BOOLEAN
			current_mark: like declaration_mark
			other_mark: like declaration_mark
		do
			Result := Current = other
			if
				not Result and then
				attached {CL_TYPE_A} other.actual_type as l_other_class_type
			then
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

				Result := conform_to (a_context_class, other)

				if l_is_exp then
					set_mark (current_mark)
				end
				if l_other_is_exp then
					l_other_class_type.set_mark (other_mark)
				end
			end
		end

	generic_conform_to (a_context_class: CLASS_C; gen_type: GEN_TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Does Current conform to `gen_type' ?
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			good_argument: gen_type /= Void
			valid_type: base_class.conform_to (gen_type.base_class)
		local
			i, count: INTEGER
			parent_actual_type: TYPE_A
			l_conforming_parents: FIXED_LIST [CL_TYPE_A]
			l_is_attached: like is_attached
			l_is_implicitly_attached: like is_implicitly_attached
			l_is_frozen: like is_frozen
		do
			from
				l_is_attached := is_attached
				l_is_implicitly_attached := is_implicitly_attached
				l_is_frozen := has_frozen_mark
				l_conforming_parents := base_class.conforming_parents
				i := 1
				count := l_conforming_parents.count
			until
				i > count or else Result
			loop
				parent_actual_type := parent_type (l_conforming_parents.i_th (i))

					-- Update parent to have the same attachment marks as Current.
				if l_is_attached and then not parent_actual_type.is_attached then
					parent_actual_type := parent_actual_type.as_attached_type
				elseif l_is_implicitly_attached and then not parent_actual_type.is_implicitly_attached then
					parent_actual_type := parent_actual_type.as_implicitly_attached
				end

					-- Update parent to have the same variance marks as Current.
				if l_is_frozen and then not parent_actual_type.is_frozen then
					parent_actual_type := parent_actual_type.as_same_variant_bits (variant_bits)
				end

					-- Check if parent conforms.
				Result := parent_actual_type.internal_conform_to (a_context_class, gen_type, a_in_generic)
				i := i + 1
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A
			-- Parent actual type.
		require
			parent_not_void: parent /= Void
		do
			Result := parent
		ensure
			result_not_void: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	adapted_in (class_type: CLASS_TYPE): CL_TYPE_A
			-- Redefined for covariant redefinition of result type.
		do
			Result := Current
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	instantiation_of (type: TYPE_A; a_class_id: INTEGER): TYPE_A
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		local
			instantiation: TYPE_A
		do
			if a_class_id = class_id then
					-- Feature is written in the class associated to the
					-- current actual class type
				instantiation := Current
			else
				instantiation := find_class_type (System.class_of_id (a_class_id))
			end
			Result := type.actual_type
			if attached instantiation.generics as l_generics and then l_generics.count > 0 then
					-- Does not make sense to instantiate if `instantation' is
					-- a TUPLE with no arguments.
				if attached {GEN_TYPE_A} instantiation as gen_type then
					Result := gen_type.instantiate (Result)
				else
					check is_generic: False end
				end
			end
		end

	find_descendant_type (c: CLASS_C): CL_TYPE_A
			-- Find the type of Current would have in descendant `c'. If no such type
			-- can be found, return Void (this happens when `c' introduces a new formal
			-- generic parameter that does not exist in `Current').
		require
			good_argument: c /= Void
			conformance: c.inherits_from (base_class)
		local
			l_class: like base_class
			i, nb, l_pos: INTEGER
			l_type_feat: TYPE_FEATURE_I
			l_result_generics: like generics
			l_quick_positions: NATURAL_64
			l_slow_positions: PACKED_BOOLEANS
		do
			l_class := base_class
			if l_class = c then
					-- Same class, nothing to do.
				Result := Current
			else
				Result := c.actual_type
				l_result_generics := Result.generics
				if l_result_generics /= Void then
					nb := l_result_generics.count
						-- To verify that all the positions have been processed we use a bit flag if there is less
						-- than 64 formal generics, otherwise we use a PACKED_BOOLEAN structure.
					if nb >= 64 then
						create l_slow_positions.make (nb + 1)
					end
					if not attached generics as l_parent_generics then
							-- Descendant is generic but not parent, clearly we have to exclude it.
						Result := Void
					else
							-- We reset `l_result_generics' to Void since we are using Void as a signaling
							-- value to duplicate `Result.generics' in case we perform a substitution.
						l_result_generics := Void
						across
							c.generic_features as g
						loop
							l_type_feat := g.item
								-- When we encounter a formal generic parameter in the descendant,
								-- we search for it in the ancestor, if none is found, we continue,
								-- otherwise we replace the descendant formal generic with the parent one.
							if
								attached {FORMAL_A} l_type_feat.type as l_formal and then
								attached l_class.generic_features.item (g.key) as l_feat and then
								attached {FORMAL_A} l_feat.type as l_parent_formal
							then
									-- We cannot override `Result' because it is coming from {CLASS_C}.actual_type
									-- and this is an attribute that is set only once.
								if l_result_generics = Void then
									Result := Result.duplicate_for_instantiation
									l_result_generics := Result.generics
								end
								l_pos := l_formal.position
								l_result_generics.put_i_th (l_parent_generics.i_th (l_parent_formal.position), l_pos)
									-- Mark that we have done `l_pos'.
								if nb < 64 then
									l_quick_positions := l_quick_positions | ({NATURAL_64} 1 |<< l_pos)
								else
									l_slow_positions.put (True, l_pos)
								end
							end
						end
							-- Check now that all the bits are set.
						if nb < 64 then
							if (l_quick_positions |>> 1) /= ({NATURAL_64} 1 |<< nb)  - {NATURAL_64} 1 then
									-- Some formal generics of `Result' were not found in Current, we have to exclude it.
								Result := Void
							end
						else
							from
								i := 1
								nb := l_slow_positions.count
							until
								i > nb
							loop
								if not l_slow_positions.item (i) then
									Result := Void
									i := nb
								end
								i := i + 1
							end
						end
					end
				end
			end
		ensure
				-- Ideally this should be that way, but often we manipulate formals and when you have
				-- the ancestor A [G#1] and a descendant A2 (which inherits from A [DOUBLE]) the conformance
				-- query would fail because nothing can conform to a formal apart itself.
			conform_to: -- Result /= Void implies Result.conform_to (Current)
		end

	find_class_type (c: CLASS_C): CL_TYPE_A
			-- Actual type of class of id `class_id' in current
			-- context. If `c' does not inherit from `associated_class',
			-- we simply return Void.
		require
			good_argument: c /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent: CL_TYPE_A
			i, count: INTEGER
		do
			from
				parents := base_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result /= Void
			loop
				parent := parents [i]
				if parent.base_class = c then
						-- Class `c' is found
					if attached {CL_TYPE_A} parent_type (parent) as ta then
						Result := ta
					end
				elseif attached {CL_TYPE_A} parent_type (parent) as parent_class_type then
					Result := parent_class_type.find_class_type (c)
				else
					check parent_type_is_cl_type_a: False end
				end
				i := i + 1
			end
		end

	duplicate_for_instantiation: like Current
			-- Duplication for instantiation routines.
		do
			Result := twin
		end

	reference_type: CL_TYPE_A
			-- Reference counterpart of an expanded type
		local
			l_decl: like declaration_mark
		do
			if is_expanded then
				if base_class.is_expanded then
					Result := duplicate
					Result.set_reference_mark
				else
					l_decl := declaration_mark
					declaration_mark := no_mark
					Result := duplicate
					declaration_mark := l_decl
				end
			else
				Result := Current
			end
		end

	create_info: CREATE_TYPE
			-- Byte code information for entity type creation
		do
			create Result.make (Current)
		end

feature -- Debugging

	debug_output: STRING
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
			-- created the base class had the same mark (current marks include "expanded" and "once").
			-- If Current has still the mark and not the base class, it simply means that
			-- Current is not valid.

	set_mark (mark: like declaration_mark)
			-- Set `declaration_mark' to the given value `mark'.
		require
			valid_declaration_mark:
				mark = no_mark or mark = expanded_mark or
				mark = reference_mark
		do
			declaration_mark := mark
		ensure
			declaration_mark_set: declaration_mark = mark
		end

	no_mark: NATURAL_8 = 0
			-- Empty declaration mark

	expanded_mark: NATURAL_8 = 1
			-- Expanded declaration mark.

	reference_mark: NATURAL_8 = 2
			-- Reference declaration mark.

	once_mark: NATURAL_8 = 4
			-- Once declaration mark.

invariant
	class_id_positive: class_id > 0
	valid_declaration_mark:
		declaration_mark = no_mark or
		declaration_mark = expanded_mark or
		declaration_mark = reference_mark
	valid_class_declaration_mark:
		class_declaration_mark = no_mark or
		class_declaration_mark = expanded_mark or
		class_declaration_mark = once_mark

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
