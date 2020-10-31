note
	description: "Actual type description."
	EIS: "name=code_review", "src=http://docs.google.com/Doc?id=dd7kn5vj_93ng9v6cg", "tag=review, type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_A

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	SHARED_TYPE_I
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_GENERIC_CONSTRAINT

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	HASHABLE

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_COMPILER_PROFILE

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		require
			v_not_void: v /= Void
			v_is_valid: v.is_valid
		deferred
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16
			-- Flags for annotations of Current.
			-- Currently only `!' and `frozen' are supported
		do
				-- Only if a type is not expanded do we need to generate the
				-- attached annotation since by default expanded implies attached.
			if lace.is_void_safe and then is_attached and then not is_expanded then
				Result := {SHARED_GEN_CONF_LEVEL}.attached_type
			end

			if system.is_scoop and then is_separate then
				Result := Result | {SHARED_GEN_CONF_LEVEL}.separate_type
			end

				-- The code below will not generate annotation when
				-- `{COMPILER_PROFILE}.is_frozen_variant_supported' is not set
				-- as to not break existing code, since `is_frozen' will always be
				-- False, is_variant always True.
			check consistent: not compiler_profile.is_frozen_variant_supported implies (not is_frozen and is_variant) end
			if is_frozen then
				if not is_type_frozen then
					Result := Result | {SHARED_GEN_CONF_LEVEL}.frozen_type
				end
			elseif is_variant then
				-- Nothing to do because due to backward compatibility with
				-- old storables, nothing means variant.
			else
				check frozen_variant_supported: compiler_profile.is_frozen_variant_supported end
				Result := Result | {SHARED_GEN_CONF_LEVEL}.poly_type
			end
		end

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Mode dependent type id - just for convenience
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := {SHARED_GEN_CONF_LEVEL}.terminator_type       -- Invalid type id.
			check
				not_called: False
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A)
			-- Generate mode dependent sequence of type id's
			-- separated by commas. `use_info' is true iff
			-- we generate code for a creation instruction.
		require
			valid_file : buffer /= Void
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			generate_cid_prefix (buffer, Void)
			buffer.put_integer (generated_id (final_mode, a_context_type))
			buffer.put_character (',')
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
			-- Generate mode dependent sequence of type id's
			-- separated by commas. `use_info' is true iff
			-- we generate code for a creation instruction.
			-- 'idx_cnt' holds the index in the array for
			-- this entry.
		require
			valid_file : buffer /= Void
			valid_counter : idx_cnt /= Void
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		local
			dummy : INTEGER
		do
			generate_cid_prefix (buffer, idx_cnt)
			buffer.put_integer (generated_id (final_mode, a_context_type))
			buffer.put_character (',')

				-- Increment counter
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A; a_level: NATURAL)
			-- Generate mode dependent initialization of
			-- cid array. `use_info' is true iff
			-- we generate code for a creation instruction.
			-- 'idx_cnt' holds the index in the array for
			-- this entry.
		require
			valid_file : buffer /= Void
			valid_counter : idx_cnt /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		local
			dummy : INTEGER
		do
			generate_cid_prefix (Void, idx_cnt)
				-- Increment counter
			dummy := idx_cnt.next
		end

	frozen make_full_type_byte_code (ba: BYTE_ARRAY; a_context_type: TYPE_A)
			-- Append full type info for the current type to `ba'
			-- following the format for locals, creation expressions, etc.
		require
			ba_attached: ba /= Void
			a_context_type_not_void: a_context_type /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			make_type_byte_code (ba, True, a_context_type)
			ba.append_short_integer (-1)
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A)
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		require
			ba_attached: ba /= Void
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			make_type_prefix_byte_code (ba)
			ba.append_natural_16 (generated_id (False, a_context_type))
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		require
			il_generator_not_void: il_generator /= Void
		do
		end

feature {NONE} -- Generic conformance

	generate_cid_prefix (buffer: detachable GENERATION_BUFFER; idx_cnt: COUNTER)
			-- Generate prefix to a type specification if `buffer' specified.
			-- Increment `idx_cnt' accordingly if specified.
		local
			l_annotation: like annotation_flags
			l_dummy: INTEGER
		do
			l_annotation := annotation_flags
			if l_annotation /= 0 then
					-- If `buffer' was provided, outputs annotation.
				if buffer /= Void then
					buffer.put_hex_natural_16 (l_annotation)
					buffer.put_character (',')
				end
					-- If counter was provided, increments it.
				if idx_cnt /= Void then
					l_dummy := idx_cnt.next
				end
			end
		end

	make_type_prefix_byte_code (ba: BYTE_ARRAY)
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		require
			ba_attached: ba /= Void
		local
			l_annotation: like annotation_flags
		do
			l_annotation := annotation_flags
			if l_annotation /= 0 then
				ba.append_natural_16 (l_annotation)
			end
		end

feature -- C code generation

	generate_cecil_value (buffer: GENERATION_BUFFER; a_context_type: TYPE_A)
			-- Generate type value for cecil.
		require
			buffer_not_void: buffer /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			c_type.generate_sk_value (buffer)
		end

feature -- IL code generation

	element_type: INTEGER_8
			-- Type of current element. See MD_SIGNATURE_CONSTANTS for
			-- all possible values.
		do
			Result := c_type.element_type
		end

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING
			-- Name of current class type in IL generation.
		require
			in_il_generation: System.il_generation
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := name
		ensure
			il_type_name_not_void: Result /= Void
			il_type_name_not_empty: not Result.is_empty
		end

	generic_il_type_name (a_context_type: TYPE_A): STRING_8
			-- Associated name to for naming in generic derivation.
		require
			in_il_generation: system.il_generation
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := name
		ensure
			il_type_name_not_void: Result /= Void
			il_type_name_not_empty: not Result.is_empty
		end

	minimum_interval_value: INTERVAL_VAL_B
			-- Minimum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_character
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
		end

	maximum_interval_value: INTERVAL_VAL_B
			-- Maximum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_character
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
		end

	is_optimized_as_frozen: BOOLEAN
			-- Is current type optimizable as a frozen one in .NET code generation?
		do
		end

	is_generated_as_single_type: BOOLEAN
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		require
			il_generation: System.il_generation
			valid_type: is_valid
		do
		end

	heaviest (other: TYPE_A): TYPE_A
			-- Heaviest of two numeric types.
		do
			Result := Current
		end

	dispatch_anchors (a_context_class: CLASS_C)
			-- If `Current' is an anchor to a feature, we need to record this anchoring
			-- in `a_context_class'.
			-- We do not check that `Current' is valid because this routine simply looks
			-- for the `routine_id' of `{LIKE_FEATURE}' and nothing else.
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			is_valid: is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
		do
		end

feature -- Properties

	has_associated_class: BOOLEAN
			-- Does Current have an associated class?
		do
			Result := not (is_void or else is_formal or else is_none)
		ensure
			Yes_if_is: Result implies not (is_void or else
								is_formal or else is_none)
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN
			-- Does Current have an associated class in `a_context_type'?
		require
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := has_associated_class
		end

	generics: ARRAYED_LIST [TYPE_A]
			-- Actual generic types
		do
			-- Void
		end

	is_frozen: BOOLEAN
			-- Is type frozen?
		do
			if compiler_profile.is_frozen_variant_supported then
				Result := has_frozen_mark or else is_implicitly_frozen or else is_type_frozen
			end
		end

	is_implicitly_frozen: BOOLEAN
			-- Is type frozen?
		do
			if compiler_profile.is_frozen_variant_supported then
				Result := (variant_bits & is_implicitly_frozen_mask) /= 0
			end
		end

	is_type_frozen: BOOLEAN
			-- Is type implicitly frozen?
			--| Case of a frozen class or an expanded class.
		do
			Result := (attached base_class as l_base_class and then l_base_class.is_frozen) or else is_expanded
		end

	is_variant: BOOLEAN
			-- Is type marked `variant'.
		do
				-- Either we have the variant mark or we are in traditional mode.
			Result := has_variant_mark or else not compiler_profile.is_frozen_variant_supported
		end

	is_valid_generic_derivation: BOOLEAN
			-- Is current still a valid type to be used as a generic derivation?
			-- Note that Current has to be a generic derivation, unfortunately
			-- we cannot use the usual precondition `same_as (generic_derivation)'
			-- as we might be working on types that have changed their expanded
			-- status and thus the query `generic_derivation' may yield a different value.
		require
			is_valid: is_valid
			is_generic_derivation: -- same_as (generic_derivation)
		do
			Result := True
		end

	is_class_valid: BOOLEAN
			-- Are all types referenced by current type part of the system?
		do
			Result := True
		end

	frozen is_valid: BOOLEAN
			-- Is current a valid declaration by itself?
		do
			Result := internal_is_valid_for_class (Void)
		ensure
			true_implication: is_valid implies is_class_valid
			false_implication: not is_class_valid implies not is_valid
		end

	frozen is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is current valid for a declaration in `a_class'?
		require
			a_class_not_void: a_class /= Void
			a_class_valid: a_class.is_valid
		do
			Result := internal_is_valid_for_class (a_class)
		end

	frozen is_valid_context_type (a_type: TYPE_A): BOOLEAN
			-- Is `a_type' a valid context type for current type?
			--| It is assumed that `a_type' is the type coming from
			--| a CLASS_TYPE (see first check below).
			--| If `a_context_type' is Void, it means that current can be resolved
			--| without a context. However one has to be careful to not pass Void
			--| all the time because if there are FORMAL_A in it, they
			--| won't be properly resolved, or more precisely the reference
			--| version will be taken which might not be the expected result.
		do
			if a_type /= Void then
				Result :=
						-- First, type should be the one from a generic derivation.
					a_type.generic_derivation.same_as (a_type) and then
						-- Second, it should be valid for Current type.
					(a_type.has_associated_class and then is_valid_for_class (a_type.base_class))
			else
				Result := True
			end
		end

	is_integer: BOOLEAN
			--  Is the current actual type an integer type?
		do
			-- Do nothing
		end

	is_natural: BOOLEAN
			-- Is current actual type a natural type?
		do
			-- Do nothing
		end

	is_real_32: BOOLEAN
			-- Is the current actual type a real 32 bits type ?
		do
			-- Do nothing
		end

	is_real_64: BOOLEAN
			-- Is the current actual type a real 64 bits type ?
		do
			-- Do nothing
		end

	is_character: BOOLEAN
			-- Is the current actual type a character type ?
		do
			-- Do nothing
		end

	is_character_32: BOOLEAN
			-- Is the current actual type a character 32 bits type ?
		do
			-- Do nothing
		end

	is_boolean: BOOLEAN
			-- Is the current actual type a boolean type ?
		do
			-- Do nothing
		end

	is_formal: BOOLEAN
			-- Is the current actual type a formal generic ?
		do
			-- Do nothing
		end

	is_expanded: BOOLEAN
			-- Is the current actual type an expanded one ?
		do
			-- Do nothing
		end

	is_expanded_creation_possible: BOOLEAN
			-- Can this type become expanded in a descendant or generic derivation?
		do
		end

	is_enum: BOOLEAN
			-- Is the current actual type an external enum one?
		do
			-- Do nothing
		end

	is_reference: BOOLEAN
			-- Is current actual type a reference one?
		do
			Result := not is_expanded
		end

	has_reference: BOOLEAN
			-- Can values of this type reference other objects?
		do
				-- It is safe to assume there is a reference.
			Result := True
		end

	is_true_expanded: BOOLEAN
			-- Is current actual type an expanded one which is not basic?
		do
			Result := is_expanded and not is_basic
		end

	is_basic: BOOLEAN
			-- Is the current actual type a basic type ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN
			-- Is current type based on an external one?
		do
		end

	is_true_external: BOOLEAN
			-- Is Current type based solely on an external one?
		local
			l_class: CLASS_C
		do
			l_class := base_class
			if l_class /= Void then
				Result := l_class.is_external_class_c
			end
		end

	is_separate: BOOLEAN
			-- Is the current actual type a separate one ?
		do
			Result := has_separate_mark and then not is_expanded
		end

	is_none: BOOLEAN
			-- Is the current actual type a none type ?
		do
			-- Do nothing
		end

	is_like: BOOLEAN
			-- Is the current type an anchored one ?
		do
			-- Do nothing
		end

	is_like_argument: BOOLEAN
			-- Is the current type a like argument?
		do
			-- Do nothing
		end

	is_multi_constrained: BOOLEAN
			-- Is the current actual type a formal generic type representing a multiconstraint?
		do
		end

	is_named_tuple: BOOLEAN
			-- Is the current type a tuple with labels?
		do
			-- Do nothing
		end

	is_pointer: BOOLEAN
			-- Is the current type a pointer type ?
		do
			-- Do nothing
		end

	is_typed_pointer: BOOLEAN
			-- Is current type a typed pointer type ?
		do
			-- Do nothing
		end

	is_tuple: BOOLEAN
			-- Is it a TUPLE type
		do
			-- Do nothing
		end

	is_named_type: BOOLEAN
			-- Is it a named type?
		do
		end

	is_full_named_type: BOOLEAN
			-- Is it a full named type?
		do
		ensure
			is_full_named_type_consistent: Result implies is_named_type
		end

	has_like: BOOLEAN
			-- Has the type anchored type in its definition ?
		do
			-- Do nothing
		end

	has_like_current: BOOLEAN
			-- Has the type `like Current' in its definition?
		require
			is_valid: is_valid
		do
		end

	has_like_argument: BOOLEAN
			-- Has the type like argument in its definition?
		do
			-- Do nothing	
		end

	has_formal_generic: BOOLEAN
			-- Has type a formal generic parameter?
		do
			-- False for non-generic type.
		end

	is_loose: BOOLEAN
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		end

	is_explicit: BOOLEAN
			-- Is type fixed at compile time without anchors or formals?	
		do
			Result := True
		end

	is_void: BOOLEAN
			-- Is the type void (procedure type) ?
		do
		end

	is_like_current: BOOLEAN
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end

	is_attached: BOOLEAN
			-- Is type attached?
		do
			Result := is_directly_attached or else is_expanded
		end

	is_implicitly_attached: BOOLEAN
			-- Is type (implicitly) attached?
			-- True means it's safe to attach value of this type
			-- to an attached entity without compromizing its
			-- attachment status.
		do
			Result := is_directly_implicitly_attached or else is_expanded
		end

	is_initialization_required: BOOLEAN
			-- Is initialization required for this type in void-safe mode?
		do
			if not is_expanded and then is_attached then
				Result := True
			end
		end

	is_standalone: BOOLEAN
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?
		do
			Result := not is_loose
		end

	is_known: BOOLEAN
			-- Is this type known? (Rather than being computed.)
		do
			Result := True
		end

	is_computable: BOOLEAN
			-- Can this type be computed as a result of direct type analysis or type inference?
			-- (`False' means the type cannot be computed because of an error or insufficient information.)
		do
				-- `True' by default.
			Result := True
		ensure
			known_is_computable: is_known implies Result
		end

feature -- Annotations: status report

	has_attached_mark: BOOLEAN
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_attached_mark_mask /= 0
		end

	has_detachable_mark: BOOLEAN
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_detachable_mark_mask /= 0
		end

	is_directly_attached: BOOLEAN
			-- Is type attached because of its declaration
			-- without checking its anchor (if any)?
		do
			Result := attachment_bits & is_attached_mask /= 0
		end

	is_directly_implicitly_attached: BOOLEAN
			-- Is type implicitly attached because of its use
			-- without checking its anchor (if any)?
		do
			Result := attachment_bits & (is_attached_mask | is_implicitly_attached_mask) /= {NATURAL_8} 0
		end

	is_attachable_to (other: TYPE_A): BOOLEAN
			-- Does type preserve attachment status of other?
		do
			Result := other.is_attached implies is_implicitly_attached
		end

	has_separate_mark: BOOLEAN
			-- Is type explicitly marked as separate?

	has_frozen_mark: BOOLEAN
			-- Is type explicitly marked as frozen?
		do
			Result := variant_bits & has_frozen_mark_mask /= 0
		end

	has_variant_mark: BOOLEAN
			-- Is type explicitly marked as variant?
		do
			Result := variant_bits & has_variant_mark_mask /= 0
		end

feature -- Annotations: modification

	set_attached_mark
			-- Mark type declaration as having an explicit attached mark.
		do
			attachment_bits := has_attached_mark_mask | is_attached_mask
		ensure
			has_attached_mark: has_attached_mark
			is_attached: is_attached
		end

	set_detachable_mark
			-- Mark type declaration as having an explicit detachable mark.
		do
			attachment_bits := has_detachable_mark_mask
		ensure
			has_detachable_mark: has_detachable_mark
			not_is_attached: not is_expanded implies not is_attached
		end

	set_frozen_mark
			-- Mark type declaration as having an explicit `frozen' mark.
		do
				-- Frozen variant is only understood if enabled in the compiler.
			if compiler_profile.is_frozen_variant_supported then
				variant_bits := has_frozen_mark_mask
			end
		ensure
			has_frozen_mark_set: compiler_profile.is_frozen_variant_supported implies has_frozen_mark
		end

	set_variant_mark
			-- Mark type declaration as having an explicit `variant' mark.
		do
				-- Frozen variant is only understood if enabled in the compiler.
			if compiler_profile.is_frozen_variant_supported then
				variant_bits := has_variant_mark_mask
			end
		ensure
			has_variant_mark_set: compiler_profile.is_frozen_variant_supported implies has_variant_mark
		end

	set_is_implicitly_frozen
			-- Mark type as being implicitly frozen, meaning that it only conforms to itself.
		do
			if compiler_profile.is_frozen_variant_supported then
				variant_bits := variant_bits | is_implicitly_frozen_mask
			end
		ensure
			is_implicitly_frozen: Compiler_profile.is_frozen_variant_supported implies is_implicitly_frozen
		end

	set_is_attached
			-- Set attached type property.
		require
			not_has_detachable_mark: is_expanded or else not has_detachable_mark
		do
			attachment_bits := attachment_bits | is_attached_mask
		ensure
			is_attached: is_attached
		end

	set_is_implicitly_attached
			-- Mark type as being implicitly attached, so that
			-- it is allowed to be attached to an attached type.
		do
			attachment_bits := attachment_bits | is_implicitly_attached_mask
		ensure
			is_implicitly_attached: is_implicitly_attached
		end

	unset_is_implicitly_attached
			-- Mark type as being implicitly detachable, so that
			-- it is not allowed to be attached to an attached type.
		require
			not_is_attached: not is_attached
			is_implicitly_attached: is_implicitly_attached
		do
			attachment_bits := attachment_bits.bit_xor (is_implicitly_attached_mask)
		ensure
			not_is_implicitly_attached: not is_implicitly_attached
		end

	set_separate_mark
			-- Mark type declaration as having an explicit separate mark.
		do
			has_separate_mark := True
		end

	reset_separate_mark
			-- Mark type declaration as having no separate mark.
		do
			has_separate_mark := False
		end

	set_marks_from (other: TYPE_A)
			-- Set attachment marks as they are set in `other'.
		require
			other_attached: attached other
		do
			if other.has_attached_mark then
				set_attached_mark
			elseif other.has_detachable_mark then
				set_detachable_mark
			end
			if other.has_separate_mark then
				set_separate_mark
			end
			if other.has_variant_mark then
				set_variant_mark
			elseif other.has_frozen_mark then
				set_frozen_mark
			end
		end


feature -- Comparison

	frozen is_safe_equivalent (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			if other /= Void and then other.same_type (Current) then
				Result := is_valid and then attached {like Current} other as l_other and then
					l_other.is_valid and then is_equivalent (l_other)
			end
		end;

	frozen equivalent (o1, o2: TYPE_A): BOOLEAN
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		require
			o1_is_valid: o1 /= Void
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o1.is_safe_equivalent (o2)
			end
		end

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		require
			is_valid: is_valid
			arg_non_void: other /= Void
			same_type: same_type (other)
			other_is_valid: other.is_valid
		deferred
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		require
			other_attached: other /= Void
		do
			-- Do nothing
		end

	same_generic_derivation_as (current_type, other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' in the context of `current_type'?
		require
			other_not_void: other /= Void
			other_derived: other.generic_derivation.same_as (other)
		do
			Result := internal_same_generic_derivation_as (current_type, other, 0)
		ensure
				-- Only if `current_type' is Void, can we ensure that a True results means that they have
				-- the same generic derivation.
			definition: (Result and then current_type = Void) implies generic_derivation.same_as (other.generic_derivation)
		end

	is_syntactically_equal (other: TYPE_A): BOOLEAN
			-- Does `other' represent the same syntax construct as `Current'?
		require
			other_attached: attached other
		do
			Result := same_as (other)
		end

	is_processor_attachable_to (other: TYPE_A): BOOLEAN
			-- May processor of current type be used as a processor of type `other'?
		do
			Result := (is_separate and system.is_scoop) implies other.is_separate
		end

	has_same_marks (other: TYPE_A): BOOLEAN
			-- Are type marks of `Current' and `other' the same?
		require
			other_attached: other /= Void
		do
			Result :=
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark and then
				has_separate_mark = other.has_separate_mark and then
				has_frozen_mark = other.has_frozen_mark and then
				has_variant_mark = other.has_variant_mark
		end

feature {CL_TYPE_A} -- Comparison

	is_runnable_on_processor (other: TYPE_A): BOOLEAN
			-- Can current type run on processor of `other'?
		require
			other_attached: attached other
			other_separate: other.is_separate
		do
			if is_separate then
					-- Separate type can run on the processor of `other'.
				Result := True
			elseif is_expanded then
					-- Verify that all the attributes of the expanded type can run on the processor of `other'.
				Result := is_processor_attachable_to (other)
			end
		end

feature -- Access

	base_class: detachable CLASS_C
			-- Base class of current type (if exists).
		deferred
		ensure
			definition: (Result /= Void) = has_associated_class
		end

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE
			-- Class associated to the current type.
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
		end

	actual_type: TYPE_A
			-- Actual type of the interpreted type
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	conformance_type: TYPE_A
			-- Type which is used to check conformance
		do
			Result := actual_type
		ensure
			Result_not_void: Result /= Void
		end

	deep_actual_type: TYPE_A
			-- Actual type; recursive on generic types
			-- NOTE by M.S: Needed for ROUTINEs - perhaps
			--              this is the intended meaning
			--              of 'actual_type' - but 'actual_type'
			--              does not recurs on generics(?)!
		do
			Result := Current
		end

	context_free_type: TYPE_A
			-- Type where all anchors to features are removed.
		do
			Result := Current
		end

	has_generics: BOOLEAN
			-- Has the current type generics types ?
		do
			Result := generics /= Void
		end

	intrinsic_type: TYPE_A
			-- Default type of a manifest constant.
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	renaming: RENAMING_A
			-- Renaming of current type.
		do
			-- Result := Void
		end

feature -- Duplication

	duplicate: like Current
			-- Shallow duplication.
		do
			Result := twin
		end

	frozen as_separate: like Current
			-- Separate version of this type.
		require
			not_separate: not is_separate
		do
			Result := duplicate
			Result.set_separate_mark
		end

	frozen as_non_separate: like Current
			-- Non-separate version of this type.
		require
			is_separate: is_separate
		do
			Result := duplicate
			Result.reset_separate_mark
		end

	frozen as_attached_type: like Current
			-- Attached variant of the current type.
		require
			not_is_attached: not is_attached
		do
			Result := duplicate
			Result.set_attached_mark
		ensure
			result_attached: Result /= Void
		end

	frozen as_implicitly_attached: like Current
			-- Implicitly attached type.
		require
			not_is_attached: not is_attached
			not_is_implicitly_attached: not is_implicitly_attached
		do
			Result := duplicate
			Result.set_is_implicitly_attached
		ensure
			result_attached: Result /= Void
			result_not_attached: not Result.is_attached
			result_is_implicitly_attached: Result.is_implicitly_attached
			result_is_attachable_to_attached: Result.is_attachable_to (as_attached_type)
		end

	frozen as_attached_in (c: CLASS_C): like Current
			-- Attached or implicitly attached variant of current type depending on the void safety status of contextual class `c'.
			-- Consider using `as_normally_attached` instead.
		require
			c_attached: c /= Void
		do
			Result := Current
			if not is_attached then
				if c.lace_class.is_void_safe_conformance then
					Result := as_attached_type
				elseif not is_implicitly_attached then
					Result := as_implicitly_attached
				end
			end
		ensure
			result_attached: Result /= Void
			result_is_attached: not is_none implies (c.lace_class.is_void_safe_conformance implies Result.is_attached)
			result_is_implicitly_attached: not is_none implies (Result.is_attached or else Result.is_implicitly_attached)
		end

	frozen as_normally_attached (c: CLASS_C): like Current
			-- Attached or implicitly attached variant of current type depending on the void safety status of contextual class `c'.
			-- Same as `as_attached_in` except that it does not add an explicit attachment mark to the type
		require
			c_attached: c /= Void
		do
			if is_attached then
				Result := Current
			elseif c.lace_class.is_void_safe_conformance then
				if c.lace_class.is_attached_by_default then
						-- Mark the type as attached without adding an explicit attachment mark.
					Result := as_attachment_mark_free
					Result.set_is_attached
				else
						-- Mark the type as attached with an explicit attachment mark.
					Result := as_attached_type
				end
			elseif not is_implicitly_attached then
					-- Mark the type as implicitly attached in void-unsafe mode.
				if has_detachable_mark then
					Result := as_attachment_mark_free
					Result.set_is_implicitly_attached
				else
					Result := as_implicitly_attached
				end
			else
				Result:= Current
			end
		end

	frozen as_implicitly_detachable: like Current
			-- Implicitly detachable type.
		do
			if not is_attached and then is_implicitly_attached then
				Result := duplicate
				Result.unset_is_implicitly_attached
			else
				Result := Current
			end
		ensure
			result_attached: Result /= Void
		end

	frozen as_detachable_type: like Current
			-- Detachable type.
		do
			if not has_detachable_mark and then not is_expanded then
				Result := duplicate
				Result.set_detachable_mark
			else
				Result := Current
			end
		end

	as_attachment_mark_free: like Current
			-- Same as `Current' but without any attachment mark.
		local
			l_bits: like attachment_bits
		do
			l_bits := attachment_bits
			if l_bits = 0 then
				Result := Current
			else
				attachment_bits := 0
				Result := duplicate
				attachment_bits := l_bits
			end
		ensure
			as_attachment_mark_free_not_void: Result /= Void
			result_has_no_attached_mark: not Result.has_attached_mark
			result_has_no_detachable_mark: not Result.has_detachable_mark
		end

	frozen as_marks_free: like Current
			-- Same as `Current' but without any attachment, separate, variant marks.
		local
			a: like attachment_bits
			s: BOOLEAN
			b: like variant_bits
		do
			a := attachment_bits
			s := has_separate_mark
			b := variant_bits
			if a = 0 and then not s and b = 0 then
				Result := Current
			else
				has_separate_mark := False
				attachment_bits := 0
				variant_bits := 0
				Result := duplicate
				attachment_bits := a
				has_separate_mark := s
				variant_bits := b
			end
		ensure
			as_marks_free_attached: attached Result
			result_has_no_attached_mark: not Result.has_attached_mark
			result_has_no_detachable_mark: not Result.has_detachable_mark
			result_has_no_separate_mark: not Result.has_separate_mark
			result_has_no_variance_mark: not Result.has_variant_mark
			result_has_no_frozen_mark: not Result.has_frozen_mark and not Result.is_implicitly_frozen
		end

	deanchored_form_marks_free: TYPE_A
			-- Deanchored form of current without any marks.
		do
			Result := as_marks_free
		ensure
			as_marks_free_attached: attached Result
			result_has_no_attached_mark: not Result.has_attached_mark and then (attached Result.generics as l_gen implies across l_gen as l_actual all not l_actual.item.has_attached_mark end)
			result_has_no_detachable_mark: not Result.has_detachable_mark and then (attached Result.generics as l_gen implies across l_gen as l_actual all not l_actual.item.has_detachable_mark end)
			result_has_no_separate_mark: not Result.has_separate_mark and then (attached Result.generics as l_gen implies across l_gen as l_actual all not l_actual.item.has_separate_mark end)
			result_has_no_variance_mark: not Result.has_variant_mark and then (attached Result.generics as l_gen implies across l_gen as l_actual all not l_actual.item.has_variant_mark end)
			result_has_no_frozen_mark: (not Result.has_frozen_mark and not Result.is_implicitly_frozen) and then
				(attached Result.generics as l_gen implies across l_gen as l_actual all not l_actual.item.has_frozen_mark and not l_actual.item.is_implicitly_frozen end)
		end

	as_same_variant_bits (a_bits: like variant_bits): like Current
			-- Attached variant of the current type.
		local
			a: like variant_bits
		do
			if variant_bits = a_bits then
				Result := Current
			else
				a := variant_bits
				variant_bits := a_bits
				Result := duplicate
				variant_bits := a
			end
		ensure
			result_attached: Result /= Void
		end

	as_variant_free: like Current
			-- Same as `Current' but without any variance mark.
		do
			Result := as_same_variant_bits (0)
		ensure
			has_no_variance_mark: not Result.has_variant_mark and not Result.has_frozen_mark
		end

	to_other_attachment (other: TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied.
		require
			other_attached: other /= Void
		local
			c: TYPE_A
			o: TYPE_A
		do
			Result := Current
			if other /= Result then
				if other.is_like_current then
					c := other.conformance_type
				else
					c := other.actual_type
				end
				if c /= Void and then c /= Result then
						-- Apply attachment settings of anchor if applicable and current type has none.
					o := c
				else
					o := other
				end
				Result := to_other_immediate_attachment (o)
			end
		ensure
			result_attached: Result /= Void
		end

	to_other_immediate_attachment (other: TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
			-- without taking into consideration attachment status of an anchor (if any).
		require
			other_attached: other /= Void
		do
			Result := Current
			if other.has_attached_mark then
				if not has_attached_mark then
					Result := duplicate
					Result.set_attached_mark
				end
			elseif other.is_implicitly_attached then
				if not is_attached and then not is_implicitly_attached then
					Result := as_implicitly_attached
				end
			elseif other.has_detachable_mark then
				if not is_expanded and then not has_detachable_mark then
					Result := duplicate
					Result.set_detachable_mark
				end
			elseif not other.is_implicitly_attached and then is_implicitly_attached then
				Result := as_implicitly_detachable
			end
		ensure
			result_attached: Result /= Void
		end

	to_other_separateness (other: TYPE_A): like Current
			-- Current type to which separateness status of `other' is applied.
		require
			other_attached: other /= Void
		do
			Result := Current
			if other /= Result then
				if not other.is_separate then
					if is_separate then
						Result := as_non_separate
					end
				elseif other.has_separate_mark then
					if not is_expanded and then not has_separate_mark then
						Result := duplicate
						Result.set_separate_mark
					end
				elseif not is_separate then
					Result := as_separate
				end
			end
		ensure
			result_attached: Result /= Void
		end

	to_other_variant (other: TYPE_A): like Current
			-- Current type to which frozen/variant status is applied.
		require
			other_attached: other /= Void
		local
			l_other_is_frozen: BOOLEAN
		do
			Result := Current
				-- Only do something if supported.
			if other /= Result and then compiler_profile.is_frozen_variant_supported then
				if other.is_like_current then
					l_other_is_frozen := other.has_frozen_mark or other.is_implicitly_frozen or else other.conformance_type.is_frozen
				else
					l_other_is_frozen := other.actual_type.is_frozen
				end
				if not is_frozen and l_other_is_frozen then
					Result := duplicate
					Result.set_frozen_mark
				else
					Result := Current
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Output

	frozen append_to (a_text_formatter: TEXT_FORMATTER)
			-- Append `Current' to `a_text_formatter'.
		do
			ext_append_to (a_text_formatter, Void)
		end

	frozen name: STRING
		do
			Result := dump
		end

	dump: STRING
			-- Dumped trace
		deferred
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- Append `Current' to `a_text_formatter'.
			-- `a_context_class' is used to retrieve the generic type name for a
			-- formal generic parameter written in `a_context_class'.
			-- This replaces the "G#2" text by the actual formal generic parameter name.
			-- Actually used in FORMAL_A.
			--| Note: It used to handle LIKE_ARGUMENT as well by changing "arg#1" by the
			--| actual argument name, but this was dropped when we started to only use
			--| `a_context_class'.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		deferred
		end

	dump_marks (s: STRING)
			-- Append leading type marks to `s'.
		require
			s_attached: attached s
		do
			if has_frozen_mark then
				s.append ("frozen ")
			elseif has_variant_mark then
				s.append ("variant ")
			end

			if has_attached_mark then
				s.append_character ('!')
			elseif has_detachable_mark then
				s.append_character ('?')
			end

			if has_separate_mark then
				s.append ({SHARED_TEXT_ITEMS}.ti_separate_keyword)
				s.append_character (' ')
			end
		end

	ext_append_marks (f: TEXT_FORMATTER)
			-- Append leading type marks using formatter `t'.
		require
			f_attached: attached f
		do
			if has_frozen_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_frozen_keyword, Void)
				f.add_space
			elseif has_variant_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_variant_keyword, Void)
				f.add_space
			end

			if has_attached_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_attached_keyword, Void)
				f.add_space
			elseif has_detachable_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_detachable_keyword, Void)
				f.add_space
			end

			if has_separate_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_separate_keyword, Void)
				f.add_space
			end
		end

feature -- Conversion

	to_type_set: TYPE_SET_A
			-- Create a type set containing one element which is `Current'.
		do
			create Result.make (1)
			Result.extend (create {RENAMED_TYPE_A}.make (Current, Void))
		ensure
			to_type_set_not_void: Result /= Void
		end

feature -- Access

	sk_value (a_context_type: TYPE_A): NATURAL_32
			-- SK value associated to the current type.
		require
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := c_type.sk_value
		end

	has_expanded: BOOLEAN
			-- Has the current type some expanded types in itself ?
		do
			-- Do nothing
		end

	type_id (a_context_type: TYPE_A): INTEGER
			-- Type ID of the corresponding class type
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).type_id
		end

	static_type_id (a_context_type: TYPE_A): INTEGER
			-- Static type ID of the corresponding class type.
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).static_type_id
		end

	external_id (a_context_type: TYPE_A): INTEGER
			-- External type id of `Current' (or `static_type_id' for pure Eiffel type).
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).external_id
		end

	implementation_id (a_context_type: TYPE_A): INTEGER
			-- Return implementation id of `Current'.
		require
			il_generation: System.il_generation
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
--			if has_associated_class_type (a_context_type) then
				Result := associated_class_type (a_context_type).implementation_id
--			else
--				check
--					is_reference_at_least: is_reference
--				end
--				Result := System.system_object_class.compiled_class.types.first.implementation_id
--			end
		ensure
			valid_result: Result > 0
		end

	description: ATTR_DESC
			-- Description of type for skeletons
		local
			l_ref: REFERENCE_DESC
		do
			create l_ref
			l_ref.set_type_i (Current)
			Result := l_ref
		end

	description_with_detachable_type: ATTR_DESC
			-- Description of type for skeletons
			-- but with detachable type if possible
		local
			l_ref: REFERENCE_DESC
		do
			create l_ref
			l_ref.set_type_i (as_detachable_type)
			Result := l_ref
		end

	instantiated_description: ATTR_DESC
			-- Description of type when SKELETON is instantiated in the context of
			-- a CLASS_TYPE.
		do
			Result := description
		end

	c_type: TYPE_C
			-- Corresponding C type
		do
			Result := reference_c_type
		ensure
			result_not_void: Result /= Void
		end

	meta_type: TYPE_A
			-- Meta type
		do
			Result := Current
		end

	generic_derivation: TYPE_A
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := internal_generic_derivation (0)
		ensure
			generic_derivation_not_void: Result /= Void
		end

	is_numeric: BOOLEAN
			-- Is the current actual type a numeric type ?
		do
			-- Do nothing
		end

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER)
			-- Is `Current' a valid generic parameter at position `i' of `gen_type'?
		require
			a_gen_type_not_void: a_gen_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_class_not_void: a_class /= Void
			i_non_negative: i > 0
		local
			l_vtcg7: VTCG7
			l_target_type: TYPE_A
		do
			if a_target_type.is_formal then
					-- If we find a formal, then we get the actual generic at its position
					-- and check wheter Current conforms to it.
					-- Example: 	class A [G -> H, H] end
					--				B[G -> A[STRING, COMPARABLE]]
					--			`Current' is STRING
					-- 			`a_target_type' is H
					-- Note: We loop over all constraints of `G' an call `check_const_gen_conformance'.
					-- We replace `H' with `COMPARABLE' and check whether `STRING' conforms to `COMPARABLE'.					
				if attached {FORMAL_A} a_target_type as l_formal_a then
					l_target_type := a_gen_type.generics.i_th (l_formal_a.position)
				else
					check indeed_a_formal_a: False end
				end
			else
				l_target_type := a_target_type
			end

			if not conform_to (a_class, l_target_type) then
					-- FIXME: Manu 02/04/2004 We should be checking convertibility here,
					-- but for the moment it is not yet possible because this check is done
					-- before we do degree 4. What we need to implement is the ability
					-- to check converitibility without having to go through a full
					-- degree 4
				reset_constraint_error_list
				generate_constraint_error (a_gen_type, to_type_set, l_target_type.to_type_set, i, Void)
				create l_vtcg7
				l_vtcg7.set_in_constraint (True)
				l_vtcg7.set_class (a_class)
				l_vtcg7.set_error_list (constraint_error_list)
				l_vtcg7.set_parent_type (a_gen_type)
				Error_handler.insert_error (l_vtcg7)
			end
		end

	frozen conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current conform to `other' in `a_context_class'?
		require
			is_valid: is_valid
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			other_not_void: other /= Void
			other_is_valid: other.is_valid
			a_context_valid_for_other: other.is_valid_for_class (a_context_class)
		do
			Result := internal_conform_to (a_context_class, other, False)
		end

	backward_conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does `other' conform to `Current' in `a_context_class'?
			-- The only difference with `conform_to' is that type information is collected for `Current'.
		require
			is_valid: is_valid
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			other_not_void: other /= Void
			other_is_valid: other.is_valid
			a_context_valid_for_other: other.is_valid_for_class (a_context_class)
		do
			Result := other.internal_conform_to (a_context_class, Current, False)
		end

	frozen conforms_to_array: BOOLEAN
			-- Does current conform to ARRAY regardless of the context.
		do
			Result := has_associated_class and then base_class.conform_to (system.array_class.compiled_class)
		end

	is_conformant_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current inherit from other as seen from `a_context_class'?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		require
			is_valid: is_valid
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		do
			Result := conform_to (a_context_class, other)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			a_target_type_not_void: a_target_type /= Void
			a_target_type_valid: a_target_type.is_valid
		do
			Result := False
			context.set_last_conversion_info (Void)
		ensure
			context_set: Result implies context.last_conversion_info /= Void
		end

	actual_argument_type (a_arg_types: ARRAYED_LIST [TYPE_A]): TYPE_A
			-- Type including like argument process based on `a_arg_types'.
		require
			a_arg_types_not_void: a_arg_types /= Void
		do
			Result := Current
		ensure
			actual_argument_type_attached: Result /= Void
			actual_argument_type_maintained: has_like_argument xor Result = Current
		end

	recomputed_in (target_type: TYPE_A; context_id: INTEGER; constraint: TYPE_A; written_id: INTEGER): TYPE_A
			-- Current type written in the class of id `written_id' as seen in the class of id `context_id'
			-- when used on the target type `target_type' with possible constraint `constraint'.
			-- This applies to a call of a feature of type `Current' on a target of type `target_type'
			-- in the class identified by `context_id' given that `Current' is written
			-- in the class identified by `written_id' with the constraint `constraint':
			--    class WRITTEN_CLASS feature f: CURRENT_TYPE ... end
			--    class CONTEXT_CLASS [TARGET_TYPE -> CONSTRAINT] feature x: TARGET_TYPE ... x.f ... end
			--       -- The result is the type of x.f in CONTEXT_CLASS.
		require
			target_type_attached: attached target_type
			positive_context_id: context_id > 0
			constraint_attached: constraint /= Void
			constraint_not_formal: not constraint.is_formal
			positive_id: written_id > 0
		do
			Result := Current
		ensure
			result_attached: attached Result
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A
			-- Instantiation of Current in the context of `type'
			-- assuming that Current is written in the class of id `written_id'.
		require
			good_argument: type /= Void
			positive_id: written_id > 0
		do
			Result := Current
		end

	formal_instantiated_in (a_type: TYPE_A): TYPE_A
			-- Instantiation of formals, if any, of Current in the context of `a_type'.
			--| Unlike `instantiated_in' it preserves the anchors while updating
			--| the `actual_type'/`conformance_type'.
		require
			valid: is_valid
			a_type_valid: a_type /= Void
			a_type_valid: a_type.is_valid
		do
			Result := Current
		end

	instantiated_in (class_type: TYPE_A): TYPE_A
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		require
			good_argument: class_type /= Void
		do
			Result := Current
		ensure
			instantiated_in_not_void: Result /= Void
		end

	adapted_in (class_type: CLASS_TYPE): TYPE_A
			-- See `TYPE_I.instantiation_in'.
		require
			class_type_not_void: class_type /= Void
			class_type_valid: class_type.associated_class.is_valid
			class_type_valid_for_current: is_valid_for_class (class_type.associated_class)
		do
			Result := Current
		ensure
			adapted_in_not_void: Result /= Void
		end

	skeleton_adapted_in (class_type: CLASS_TYPE): TYPE_A
			-- Adapt current type in the context of `class_type' where all formals are adapted using
			-- the actual from `class_type' but only if actuals are basic types, for expanded types
			-- we leave the formal.
			--  This is a special version only used in `{GENERIC_DESC}.instantiation_in' for backward
			-- compatibility of storable files. If we did not care about backward compatibility, we would
			-- not need to use it.
		require
			class_type_not_void: class_type /= Void
			class_type_valid: class_type.associated_class.is_valid
			class_type_valid_for_current: is_valid_for_class (class_type.associated_class)
		do
			Result := Current
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): TYPE_A
			-- Evaluate `Current' written in `a_ancestor' in the context of `a_descendant' class.
			-- If `a_feature' is not Void, then it is the feature seen from `a_descendant' from where
			-- `Current' appears (i.e. not in an inheritance clause).
		require
			type_is_valid: is_valid
			a_ancestor_not_void: a_ancestor /= Void
			a_ancestor_valid: a_ancestor.is_valid
			a_ancestor_compiled: a_ancestor.has_feature_table
			a_descendant_not_void: a_descendant /= Void
			a_descendant_valid: a_descendant.is_valid
			a_descendant_compiled: a_descendant.has_feature_table
--| FIXME IEK Features from a non-conforming parent fail in this routine when assertions are evaluated.
--			real_descendant: (a_feature = Void or else not a_feature.has_replicated_ast) implies a_descendant.simple_conform_to (a_ancestor)
--			a_feature_valid: (a_feature /= Void and then not a_feature.has_replicated_ast) implies
--				(a_feature.access_class.simple_conform_to (a_ancestor) and
--				a_descendant.simple_conform_to (a_feature.access_class))
			is_feature_needed: has_like_argument implies a_feature /= Void
			is_valid_for_class: is_valid_for_class (a_ancestor)
		do
			Result := Current
		ensure
			same_object: (a_ancestor = a_descendant) implies Result = Current
		end

	good_generics: BOOLEAN
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		require
			is_class_valid: is_class_valid
		do
			Result := True
		end

	error_generics: VTUG
			-- Build the error if `good_generics' returns False
		require
			not_good_generics: not good_generics
		do
		end

	check_constraints (a_type_context: CLASS_C; a_context_feature: FEATURE_I; a_check_creation_readiness: BOOLEAN)
			-- Check the constained genericity validity rule and leave
			-- error info in `constraint_error_list'
		require
			good_argument: a_type_context /= Void
			good_generic_count: good_generics
		do
		end

	check_labels (a_context_class: CLASS_C; a_node: TYPE_AS)
			-- Check validity of `labels' of current in `a_context_class'.
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
		do
		end

	expanded_deferred: BOOLEAN
			-- Is the expanded type deferred or once?
		require
			has_expanded
		local
			act_type: TYPE_A
			b: like {TYPE_A}.base_class
		do
			act_type := actual_type
			if act_type.is_expanded then
				b := act_type.base_class
				Result := b.is_deferred or b.is_once
			end
		end

	valid_expanded_creation (c: CLASS_C): BOOLEAN
			-- Is the expanded type has an associated class with one
			-- creation routine which is a version of {ANY}.default_create
			-- exported to `class_c'.
		require
			has_expanded
		do
			Result :=
				not is_expanded or else
				attached base_class as b and then
				(b.is_external or else
				not attached b.creators as creators or else
				attached creators [b.default_create_feature.feature_name_id] as e and then e.valid_for (c))
		end

	is_ancestor_valid: BOOLEAN
			-- Is type ancestor valid?
			-- (This is currently checked only for expanded types that have
			-- an external ancestor, that is not supported by CIL code generation.)
		require
			il_generation: system.il_generation
		do
			Result := True
			if is_expanded and then not is_external and then base_class.has_external_ancestor_class then
				Result := False
			end
		end

	create_info: CREATE_INFO
			-- Byte code information for entity type creation
		require
			is_valid: is_valid
		deferred
		ensure
			create_info_not_void: Result /= Void
		end

	check_for_obsolete_class (current_class: CLASS_C; current_feature: FEATURE_I)
			-- Check for obsolete class from Current. If
			-- obsolete then display warning message.
		require
			good_arg: current_class /= Void
		local
			ass_class: CLASS_C
			warn: OBS_CLASS_WARN
		do
			if
				not current_class.is_obsolete and (current_feature = Void or else not current_feature.is_obsolete) and then
		   		actual_type.has_associated_class
		   	then
				ass_class := actual_type.base_class
				if ass_class.is_obsolete and then current_class.lace_class.options.is_warning_enabled (w_obsolete_class) then
					create warn.make_with_class (current_class)
					if current_feature /= Void then
						warn.set_feature (current_feature)
					end
					warn.set_obsolete_class (ass_class)
					error_handler.insert_warning (warn, current_class.is_warning_reported_as_error (w_obsolete_class))
				end
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE)
			-- Update dependency for Dead Code Removal
		do
		end

feature {TYPE_A} -- Helpers

	combined_hash_code (a_seed, a_hash_code: INTEGER): INTEGER
			-- Given an existing value `a_seed' and a hash_code `a_hash_code', compute a new hash_code.
		note
			copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
			copyright: "Copyright 2005-2014 Daniel James for code in `combined_hash_code'."
			license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
			license:   "Boost Software License, Version 1.0 (see http://www.boost.org/LICENSE_1_0.txt)"
		do
				-- The way to compute the combined hash_code is taken from the Boost C++ library.
				-- The constant 0x9e3779b9 is derived from (2^32 / Phi) where Phi is
				-- the golden ratio (1 + sqrt(5)) / 2. That constant is an arbitrary value.
				-- Its purpose is to avoid mapping all zeros to all zeros. It helps spread entropy
				-- and handles duplicates.
			Result := a_seed.bit_xor (a_hash_code + 0x9e3779b9 + (a_seed |<< 6) + (a_seed |>> 2))
			Result := Result.hash_code
		ensure
			good_hash_value: Result >= 0
		end

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Does Current conform to `other' in `a_context_class'?
			-- If `a_in_generic', it is the conformance when `Current' is an actual generic parameter
			-- of some other type.
		require
			is_valid: is_valid
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		deferred
		end

	valid_generic (a_context_class: CLASS_C; type: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- Do the generic parameter of `type' conform to those of
			-- Current ?
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			type_not_void: type /= Void
			type_has_class: type.has_associated_class
			has_associated_class: has_associated_class
			conforming_type: type.base_class.conform_to (base_class)
		do
		end

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is Current consistent and valid for `a_class'?
		do
			Result := True
		end

	internal_generic_derivation (a_level: INTEGER): TYPE_A
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := Current
		ensure
			internal_generic_derivation_not_void: Result /= Void
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER): BOOLEAN
			-- Helpers for `same_generic_derivation_as'.
		require
			other_not_void: other /= Void
			other_derived: other.internal_generic_derivation (a_level).same_as (other)
		do
			if attached {like Current} other as l_like_current then
				Result := is_equal (l_like_current)
			end
		ensure
				-- Only if `current_type' is Void, can we ensure that a True results means that they have
				-- the same generic derivation.
			definition: (Result and current_type = Void) implies
				internal_generic_derivation (a_level).same_as (other.internal_generic_derivation (a_level))
		end

feature {NONE} -- Implementation

	delayed_convert_constraint_check (
			context_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			a_set_to_check, a_constraint_types: TYPE_SET_A;
			i: INTEGER;
			in_constraint: BOOLEAN)

			-- Check that if we have class A [G -> ANY] and we found A [X] where
			-- X is expanded, then it exists a conversion routine from X to reference X
			-- and that `reference X' conforms to the constraint ANY.
			-- Delayed because could not be done during degree 4 since information
			-- about conversion routine is usually not yet computed.
		require
			context_class_not_void: context_class /= Void
			gen_type_not_void: gen_type /= Void
			a_set_to_check_not_void: a_set_to_check /= Void
			a_constraint_types_not_void: a_constraint_types /= Void
			a_set_to_check_is_expanded: a_set_to_check.has_expanded
			not_a_constraint_type_is_reference: not a_constraint_types.has_expanded
		local
			l_vtcg7: VTCG7
			l_to_check, l_constraint_type: TYPE_A
		do
			reset_constraint_error_list

				-- Only used in case of a single constraint!!
			l_constraint_type := a_constraint_types.first.type

			if context_class.is_valid and a_set_to_check.is_valid then
				l_to_check := a_set_to_check.first.type
				if a_set_to_check.count /= 1 or else a_constraint_types.count /= 1 then
					generate_constraint_error (gen_type, l_to_check.to_type_set, a_constraint_types, i, Void)
						-- The feature listed in the creation constraint has
						-- not been declared in the constraint class.
					create l_vtcg7
					l_vtcg7.set_in_constraint (in_constraint)
					l_vtcg7.set_class (context_class)
					l_vtcg7.set_error_list (constraint_error_list)
					l_vtcg7.set_parent_type (gen_type)
					Error_handler.insert_error (l_vtcg7)
				elseif
					not (l_to_check.convert_to (context_class, l_constraint_type) and
					l_to_check.is_conformant_to (context_class, l_constraint_type))
				then
					generate_constraint_error (gen_type, l_to_check.to_type_set, a_constraint_types, i, Void)
						-- The feature listed in the creation constraint has
						-- not been declared in the constraint class.
					create l_vtcg7
					l_vtcg7.set_in_constraint (in_constraint)
					l_vtcg7.set_class (context_class)
					l_vtcg7.set_error_list (constraint_error_list)
					l_vtcg7.set_parent_type (gen_type)
					Error_handler.insert_error (l_vtcg7)
				end
			end
		end

	generate_constraint_error (gen_type: GEN_TYPE_A; current_type, constraint_type: TYPE_SET_A; position: INTEGER; a_unmatched_creation_constraints: LIST[FEATURE_I])
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
			create constraint_info
			constraint_info.set_type (gen_type)
			constraint_info.set_actual_type_set (current_type)
			constraint_info.set_formal_number (position)
				-- This is necessary to instantiate the constraint in the context of `gen_type'
				-- as the constraint may involve some formal generic parameters that do not exist
				-- in the context of the class which triggerred the error.
				-- This fixes eweasel test#valid266.
			constraint_info.set_constraint_types (constraint_type.instantiated_in (gen_type))
			constraint_info.set_unmatched_creation_constraints (a_unmatched_creation_constraints)
			constraint_error_list.extend (constraint_info)
		end

feature {NONE} -- Attachment properties

	attachment_bits: NATURAL_8
			-- Associated attachment flags

	has_detachable_mark_mask: NATURAL_8 = 1
			-- Mask in `attachment_bits' that tells whether the type has an explicit detachable mark

	has_attached_mark_mask: NATURAL_8 = 2
			-- Mask in `attachment_bits' that tells whether the type has an explicit attached mark

	is_attached_mask: NATURAL_8 = 4
			-- Mask in `attachment_bits' that tells whether the type is attached

	is_implicitly_attached_mask: NATURAL_8 = 8
			-- Mask in `attachment_bits' that tells whether the type is implicitly attached

	variant_bits: NATURAL_8
			-- Associated variant flags

	has_frozen_mark_mask: NATURAL_8 = 1
			-- Mask in `variant_bits' that tells whether the type has an explicit frozen mark

	has_variant_mark_mask: NATURAL_8 = 2
			-- Mask in `variant_bits' that tells whether the type has an explicit variant mark

	is_implicitly_frozen_mask: NATURAL_8 = 4
			-- Mask in `variant_bits' that tells whether the type is implicitly frozen.

invariant
		-- A generic type should at least have one generic parameter.
		-- A tuple however is an eception and can have no generic parameter.
	generics_not_void_implies_generics_not_empty_or_tuple: (generics /= Void implies (not generics.is_empty or is_tuple))

	expanded_consistency: is_expanded implies not is_separate
	separate_mark_consistency: not is_expanded implies (has_separate_mark implies is_separate)

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
