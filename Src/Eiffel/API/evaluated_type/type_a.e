indexing
	description: "Actual type description."
	code_review: "http://docs.google.com/Doc?id=dd7kn5vj_93ng9v6cg"
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

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		require
			v_not_void: v /= Void
			v_is_valid: v.is_valid
		deferred
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16 is
			-- Flags for annotations of Current.
			-- Currently only `!' and `frozen' are supported
		do
 				-- Only if a type is not expanded do we need to generate the
				-- attached annotation since by default expanded implies attached.
			if is_attached and not is_expanded then
				Result := {SHARED_GEN_CONF_LEVEL}.attached_type
			end
-- To uncomment when variant/frozen proposal for generics is supported.
--			if is_frozen then
--				Result := Result | {SHARED_GEN_CONF_LEVEL}.frozen_type
--			end
		end

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16 is
			-- Mode dependent type id - just for convenience
		require
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := {SHARED_GEN_CONF_LEVEL}.terminator_type       -- Invalid type id.
			check
				not_called: False
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A) is
			-- Generate mode dependent sequence of type id's
			-- separated by commas. `use_info' is true iff
			-- we generate code for a creation instruction.
		require
			valid_file : buffer /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			generate_cid_prefix (buffer, Void)
			buffer.put_integer (generated_id (final_mode, a_context_type))
			buffer.put_character (',')
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A) is
			-- Generate mode dependent sequence of type id's
			-- separated by commas. `use_info' is true iff
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
			generate_cid_prefix (buffer, idx_cnt)
			buffer.put_integer (generated_id (final_mode, a_context_type))
			buffer.put_character (',')

				-- Increment counter
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL) is
			-- Generate mode dependent initialization of
			-- cid array. `use_info' is true iff
			-- we generate code for a creation instruction.
			-- 'idx_cnt' holds the index in the array for
			-- this entry.
		require
			valid_file : buffer /= Void
			valid_counter : idx_cnt /= Void
		local
			dummy : INTEGER
		do
			generate_cid_prefix (Void, idx_cnt)
				-- Increment counter
			dummy := idx_cnt.next
		end

	frozen make_full_type_byte_code (ba: BYTE_ARRAY; a_context_type: TYPE_A) is
			-- Append full type info for the current type to `ba'
			-- following the format for locals, creation expressions, etc.
		require
			ba_attached: ba /= Void
			a_context_type_not_void: a_context_type /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			if has_associated_class_type (a_context_type) then
				ba.append_short_integer (type_id (a_context_type) - 1)
			else
				ba.append_short_integer (0)
			end
				-- We can provide `Void' for `generated_id' since it is the one
				-- from `a_context_type' that we are retrieving.
			ba.append_natural_16 (a_context_type.generated_id (False, Void))
			make_type_byte_code (ba, True, a_context_type)
			ba.append_short_integer (-1)
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A) is
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		require
			ba_attached: ba /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			make_type_prefix_byte_code (ba)
			ba.append_natural_16 (generated_id (False, a_context_type))
		end

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		require
			il_generator_not_void: il_generator /= Void
		do
		end

feature {NONE} -- Generic conformance

	generate_cid_prefix (buffer: GENERATION_BUFFER; idx_cnt: COUNTER) is
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

	make_type_prefix_byte_code (ba: BYTE_ARRAY) is
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

	generate_cecil_value (buffer: GENERATION_BUFFER; a_context_type: TYPE_A) is
			-- Generate type value for cecil.
		require
			buffer_not_void: buffer /= Void
			context_type_valid: is_valid_context_type (a_context_type)
		do
			c_type.generate_sk_value (buffer)
		end

feature -- IL code generation

	element_type: INTEGER_8 is
			-- Type of current element. See MD_SIGNATURE_CONSTANTS for
			-- all possible values.
		do
			Result := c_type.element_type
		end

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING is
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

	minimum_interval_value: INTERVAL_VAL_B is
			-- Minimum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_character
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
		end

	maximum_interval_value: INTERVAL_VAL_B is
			-- Maximum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_character
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
		end

	is_optimized_as_frozen: BOOLEAN is
			-- Is current type optimizable as a frozen one in .NET code generation?
		do
		end

	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		require
			il_generation: System.il_generation
			valid_type: is_valid
		do
		end

	heaviest (other: TYPE_A): TYPE_A is
			-- Heaviest of two numeric types.
		do
			Result := Current
		end

	dispatch_anchors (a_context_class: CLASS_C) is
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

	has_renaming: BOOLEAN is
			-- Does current type have renamed features?
			-- This can occur in code like: "G -> A rename a as b end"
		do
			Result := false
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := not (is_void or else is_formal or else is_none or else is_type_set)
		ensure
			Yes_if_is: Result implies not (is_void or else
								is_formal or else is_none or else is_type_set)
		end

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN is
			-- Does Current have an associated class in `a_context_type'?
		require
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := has_associated_class
		end

	generics: ARRAY [TYPE_A] is
			-- Actual generic types
		do
			-- Void
		end

	is_type_set: BOOLEAN is
			-- Is current type a type_set?
			-- | example: {A, B}
		do
			-- False
		end

	is_valid_generic_derivation: BOOLEAN is
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

	is_class_valid: BOOLEAN is
			-- Are all types referenced by current type part of the system?
		do
			Result := True
		end

	frozen is_valid: BOOLEAN is
			-- Is current a valid declaration by itself?
		do
			Result := internal_is_valid_for_class (Void)
		ensure
			true_implication: is_valid implies is_class_valid
			false_implication: not is_class_valid implies not is_valid
		end

	frozen is_valid_for_class (a_class: CLASS_C): BOOLEAN is
			-- Is current valid for a declaration in `a_class'?
		require
			a_class_not_void: a_class /= Void
			a_class_valid: a_class.is_valid
		do
			Result := internal_is_valid_for_class (a_class)
		end

	frozen is_valid_context_type (a_type: TYPE_A): BOOLEAN is
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
						-- First type should be the one from a generic derivation.
					a_type.generic_derivation.same_as (a_type) and then
						-- Second it should be valid for Current type.
					(a_type.has_associated_class and then is_valid_for_class (a_type.associated_class))
			else
				Result := True
			end
		end

	is_integer: BOOLEAN is
			--  Is the current actual type an integer type?
		do
			-- Do nothing
		end

	is_natural: BOOLEAN is
			-- Is current actual type a natural type?
		do
			-- Do nothing
		end

	is_real_32: BOOLEAN is
			-- Is the current actual type a real 32 bits type ?
		do
			-- Do nothing
		end

	is_real_64: BOOLEAN is
			-- Is the current actual type a real 64 bits type ?
		do
			-- Do nothing
		end

	is_character: BOOLEAN is
			-- Is the current actual type a character type ?
		do
			-- Do nothing
		end

	is_character_32: BOOLEAN is
			-- Is the current actual type a character 32 bits type ?
		do
			-- Do nothing
		end

	is_boolean: BOOLEAN is
			-- Is the current actual type a boolean type ?
		do
			-- Do nothing
		end

	is_bit: BOOLEAN is
			-- Is the current actual type a bits type ?
		do
			-- Do nothing
		end

	is_formal: BOOLEAN is
			-- Is the current actual type a formal generic ?
		do
			-- Do nothing
		end

	is_expanded: BOOLEAN is
			-- Is the current actual type an expanded one ?
		do
			-- Do nothing
		end

	is_enum: BOOLEAN is
			-- Is the current actual type an external enum one?
		do
			-- Do nothing
		end

	is_renamed_type: BOOLEAN is
			-- Is current type an instance of `RENAMED_TYPE_A [TYPE_A]'?
			-- If so there is the possibility that some features of this type are renamed.
		do
		end

	is_reference: BOOLEAN is
			-- Is current actual type a reference one?
		do
			Result := not is_expanded
		end

	is_true_expanded: BOOLEAN is
			-- Is current actual type an expanded one which is not basic?
		do
			Result := is_expanded and not is_basic
		end

	is_basic: BOOLEAN is
			-- Is the current actual type a basic type ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is current type based on an external one?
		do
		end

	is_true_external: BOOLEAN is
			-- Is Current type based solely on an external one?
		local
			l_class: CLASS_C
		do
			l_class := associated_class
			if l_class /= Void then
				Result := l_class.is_external_class_c
			end
		end

	is_separate: BOOLEAN is
			-- Is the current actual type a separate one ?
		do
			-- Do nothing
		end

	is_none: BOOLEAN is
			-- Is the current actual type a none type ?
		do
			-- Do nothing
		end

	is_like: BOOLEAN is
			-- Is the current type an anchored one ?
		do
			-- Do nothing
		end

	is_like_argument: BOOLEAN is
			-- Is the current type a like argument?
		do
			-- Do nothing
		end

	is_multi_constrained: BOOLEAN is
			-- Is the current actual type a formal generic type representing a multiconstraint?
		do
		end

	is_named_tuple: BOOLEAN is
			-- Is the current type a tuple with labels?
		do
			-- Do nothing
		end

	is_pointer: BOOLEAN is
			-- Is the current type a pointer type ?
		do
			-- Do nothing
		end

	is_typed_pointer: BOOLEAN is
			-- Is current type a typed pointer type ?
		do
			-- Do nothing
		end

	is_tuple: BOOLEAN is
			-- Is it a TUPLE type
		do
			-- Do nothing
		end

	is_named_type: BOOLEAN is
			-- Is it a named type?
		do
		end

	is_full_named_type: BOOLEAN is
			-- Is it a full named type?
		do
		ensure
			is_full_named_type_consistent: Result implies is_named_type
		end

	is_solved: BOOLEAN is
		do
			Result := True
		end

	has_like: BOOLEAN is
			-- Has the type anchored type in its definition ?
		do
			-- Do nothing
		end

	has_like_current: BOOLEAN is
			-- Has the type `like Current' in its definition?
		require
			is_valid: is_valid
		do
		end

	has_like_argument: BOOLEAN is
			-- Has the type like argument in its definition?
		do
			-- Do nothing	
		end

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			-- False for non-generic type.
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		ensure
			definition: Result = (has_like or has_formal_generic)
		end

	is_explicit: BOOLEAN is
			-- Is type fixed at compile time without anchors or formals?	
		do
			Result := True
		end

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
		end

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end

	is_attached: BOOLEAN is
			-- Is type attached?
		do
				-- False by default
		end

	is_implicitly_attached: BOOLEAN
			-- Is type (implicitly) attached?
			-- True means it's safe to attach value of this type
			-- to an attached entity without compromizing its
			-- attachment status.
		do
				-- False by default
		end

	is_initialization_required: BOOLEAN
			-- Is initialization required for this type in void-safe mode?
		do
			if not is_expanded and then is_attached then
				Result := True
			end
		end

	is_standalone: BOOLEAN is
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?
		do
			Result := not is_loose
		end

feature -- Comparison

	frozen is_safe_equivalent (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		require
			is_valid: is_valid
		do
			if other /= Void and then other.same_type (Current) then
				Result := {l_other: like Current} other and then
					l_other.is_valid and then is_equivalent (l_other)
			end
		end;

	frozen equivalent (o1, o2: TYPE_A): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		require
			o1_is_valid: o1 /= Void implies o1.is_valid
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o1.is_safe_equivalent (o2)
			end
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			is_valid: is_valid
			arg_non_void: other /= Void
			same_type: same_type (other)
			other_is_valid: other.is_valid
		deferred
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		require
			other_attached: other /= Void
		do
			-- Do nothing
		end

	same_generic_derivation_as (current_type, other: TYPE_A): BOOLEAN is
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

feature -- Access

	associated_class: CLASS_C is
			-- Class associated to the current type.
		deferred
		ensure
			definition: (Result /= Void) = has_associated_class
		end

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE is
			-- Class associated to the current type.
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
		end

	actual_type: TYPE_A is
			-- Actual type of the interpreted type
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	conformance_type: TYPE_A is
			-- Type which is used to check conformance
		do
			Result := actual_type
		ensure
			Result_not_void: Result /= Void
		end

	deep_actual_type: TYPE_A is
			-- Actual type; recursive on generic types
			-- NOTE by M.S: Needed for ROUTINEs - perhaps
			--              this is the intended meaning
			--              of 'actual_type' - but 'actual_type'
			--              does not recurs on generics(?)!
		do
			Result := Current
		end

	context_free_type: TYPE_A is
			-- Type where all anchors to features are removed.
		do
			Result := Current
		end

	has_generics: BOOLEAN is
			-- Has the current type generics types ?
		do
			Result := generics /= Void
		end

	intrinsic_type: TYPE_A is
			-- Default type of a manifest constant.
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	renaming: RENAMING_A is
			-- Renaming of current type.
		do
			-- Result := Void
		end

feature -- Attachment properties

	as_attached_type: like Current
			-- Attached variant of the current type
		require
			not_is_attached: not is_attached
		do
			Result := Current
		ensure
			result_attached: Result /= Void
		end

	as_implicitly_attached: like Current
			-- Implicitly attached type
		require
			not_is_attached: not is_attached
			not_is_implicitly_attached: not is_implicitly_attached
		do
			Result := Current
		ensure
			result_attached: Result /= Void
			result_not_attached: not Result.is_attached
		end

	as_implicitly_detachable: like Current
			-- Implicitly detachable type
		do
			Result := Current
		ensure
			result_attached: Result /= Void
		end

	as_attachment_mark_free: like Current
			-- Same as Current but without any attachment mark
		do
			Result := Current
		ensure
			as_attachment_mark_free_not_void: Result /= Void
		end

	to_other_attachment (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
		require
			other_attached: other /= Void
		do
			Result := Current
		ensure
			result_attached: Result /= Void
		end

feature -- Output

	frozen append_to (a_text_formatter: TEXT_FORMATTER) is
			-- Append `Current' to `text'.
		do
			ext_append_to (a_text_formatter, Void)
		end

	frozen name: STRING is
		do
			Result := dump
		end

	dump: STRING is
			-- Dumped trace
		deferred
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C) is
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.
			-- This replaces the old "G#2" or "arg#1" texts in feature signature views.
			-- Actually used in FORMAL_A and LIKE_ARGUMENT.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		deferred
		end

feature -- Conversion

	to_type_set: TYPE_SET_A is
			-- Create a type set containing one element which is `Current'.
		do
			create Result.make (1)
			Result.extend (create {RENAMED_TYPE_A [TYPE_A]}.make (Current, Void))
		ensure
			to_type_set_not_void: Result /= Void
		end

feature -- Access

	sk_value (a_context_type: TYPE_A): INTEGER is
			-- SK value associated to the current type.
		require
			context_type_valid: is_valid_context_type (a_context_type)
		do
			Result := c_type.sk_value
		end

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in itself ?
		do
			-- Do nothing
		end

	type_id (a_context_type: TYPE_A): INTEGER is
			-- Type ID of the corresponding class type
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).type_id
		end

	static_type_id (a_context_type: TYPE_A): INTEGER is
			-- Static type ID of the corresponding class type.
			--| See comments on `has_associated_class_type' for details on `a_context_type'.
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).static_type_id
		end

	external_id (a_context_type: TYPE_A): INTEGER is
			-- External type id of `Current' (or `static_type_id' for pure Eiffel type).
		require
			context_type_valid: is_valid_context_type (a_context_type)
			has_associated_class_type: has_associated_class_type (a_context_type)
		do
			Result := associated_class_type (a_context_type).external_id
		end

	implementation_id (a_context_type: TYPE_A): INTEGER is
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

	description: ATTR_DESC is
			-- Descritpion of type for skeletons
		local
			l_ref: REFERENCE_DESC
		do
			create l_ref
			l_ref.set_type_i (Current)
			Result := l_ref
		end

	instantiated_description: ATTR_DESC is
			-- Description of type when SKELETON is instantiated in the context of
			-- a CLASS_TYPE.
		do
			Result := description
		end

	c_type: TYPE_C is
			-- Corresponding C type
		do
			Result := reference_c_type
		ensure
			result_not_void: Result /= Void
		end

	meta_type: TYPE_A is
			-- Meta type
		do
			Result := Current
		end

	generic_derivation: TYPE_A is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := internal_generic_derivation (0)
		ensure
			generic_derivation_not_void: Result /= Void
		end

	is_numeric: BOOLEAN is
			-- Is the current actual type a numeric type ?
		do
			-- Do nothing
		end

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER) is
			-- Is `Current' a valid generic parameter at position `i' of `gen_type'?
		require
			a_gen_type_not_void: a_gen_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_class_not_void: a_class /= Void
			i_non_negative: i > 0
		local
			l_vtcg7: VTCG7
			l_formal_a: FORMAL_A
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
				l_formal_a ?= a_target_type
				check indeed_a_formal_a: l_formal_a /= Void end
				l_target_type := a_gen_type.generics.item (l_formal_a.position)
			else
				l_target_type := a_target_type
			end

			if not conform_to (l_target_type) then
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

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?
		require
			is_valid: is_valid
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		deferred
		end

	frozen conforms_to_array: BOOLEAN is
			-- Does current conform to ARRAY regardless of the context.
		do
			Result := has_associated_class and then associated_class.conform_to (system.array_class.compiled_class)
		end

	is_conformant_to (other: TYPE_A): BOOLEAN is
			-- Does Current inherit from other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		require
			is_valid: is_valid
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		do
			Result := conform_to (other)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
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

	valid_generic (type: TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those of
			-- Current ?
		require
			type_not_void: type /= Void
			type_has_class: type.has_associated_class
			has_associated_class: has_associated_class
			conforming_type: type.associated_class.conform_to (associated_class)
		do
		end

	actual_argument_type (a_arg_types: ARRAY [TYPE_A]): TYPE_A is
			-- Type including like argument process based on `a_arg_types'.
		require
			a_arg_types_not_void: a_arg_types /= Void
		do
			Result := Current
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `type'
			-- assuming that Current is written in the class of id `written_id'.
		require
			good_argument: type /= Void
			positive_id: written_id > 0
		do
			Result := Current
		end

	instantiated_in (class_type: TYPE_A): TYPE_A is
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

	adapted_in (class_type: CLASS_TYPE): TYPE_A is
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

	skeleton_adapted_in (class_type: CLASS_TYPE): TYPE_A is
			-- Adapt current type in the context of `class_type' where all formals are adapted using
			-- the actual from `class_type' but only if actuals are basic types, for expanded types
			-- we leave the formal.
			--  This is a special version only used in `{GENERIC_DESC}.instantiation_in' for backward
			-- compatibility of storable files. If we did not care about backward compatibility, we would
			-- not need to use it.
		require
			class_type_not_void: class_type /= Void
			class_type_valid: class_type.associated_class.is_valid
			class_typer_valid_for_current: is_valid_for_class (class_type.associated_class)
		do
			Result := Current
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): TYPE_A is
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

	duplicate: like Current is
			-- Duplication
		do
			Result := twin
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		require
			is_class_valid: is_class_valid
		do
			Result := True
		end

	error_generics: VTUG is
			-- Build the error if `good_generics' returns False
		require
			not_good_generics: not good_generics
		do
		end

	check_constraints (a_type_context: CLASS_C; a_context_feature: FEATURE_I; a_check_creation_readiness: BOOLEAN) is
			-- Check the constained genericity validity rule and leave
			-- error info in `constraint_error_list'
		require
			good_argument: a_type_context /= Void
			good_generic_count: good_generics
		do
		end

	check_labels (a_context_class: CLASS_C; a_node: TYPE_AS) is
			-- Check validity of `labels' of current in `a_context_class'.
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
		do
		end

	expanded_deferred: BOOLEAN is
			-- Is the expanded type deferred ?
		require
			has_expanded
		local
			act_type: TYPE_A
		do
			act_type := actual_type
			Result := act_type.is_expanded and then act_type.associated_class.is_deferred
		end

	valid_expanded_creation (c: CLASS_C): BOOLEAN
			-- Is the expanded type has an associated class with one
			-- creation routine which is a version of {ANY}.default_create
			-- exported to `class_c'.
		require
			has_expanded
		local
			a: CLASS_C
			creators: HASH_TABLE [EXPORT_I, STRING]
		do
			if is_expanded then
				a := associated_class
				if a.is_external then
					Result := True
				else
					creators := a.creators
					if creators = Void then
						Result := True
					else
						creators.search (a.default_create_feature.feature_name)
						if creators.found then
							Result := creators.found_item.valid_for (c)
						end
					end
				end
			else
				Result := True
			end
		end

	is_ancestor_valid: BOOLEAN is
			-- Is type ancestor valid?
			-- (This is currently checked only for expanded types that have
			-- an external ancestor, that is not supported by CIL code generation.)
		require
			il_generation: system.il_generation
		do
			Result := True
			if is_expanded and then not is_external and then associated_class.has_external_ancestor_class then
				Result := False
			end
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		require
			is_valid: is_valid
		deferred
		ensure
			create_info_not_void: Result /= Void
		end

	check_for_obsolete_class (current_class: CLASS_C; current_feature: FEATURE_I) is
			-- Check for obsolete class from Current. If
			-- obsolete then display warning message.
		require
			good_arg: current_class /= Void
		local
			ass_class: CLASS_C
			warn: OBS_CLASS_WARN
		do
			if not current_class.is_obsolete and (current_feature = Void or else not current_feature.is_obsolete) then
		   		if actual_type.has_associated_class then
					ass_class := actual_type.associated_class
					if ass_class.is_obsolete and then ass_class.lace_class.options.is_warning_enabled (w_obsolete_class) then
						create warn.make_with_class (current_class)
						if current_feature /= Void then
							warn.set_feature (current_feature)
						end
						warn.set_obsolete_class (ass_class)
						Error_handler.insert_warning (warn)
					end
				end
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		do
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN is
			-- Is Current consistent and valid for `a_class'?
		do
			Result := True
		end

	internal_generic_derivation (a_level: INTEGER): TYPE_A is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_A
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := Current
		ensure
			internal_generic_derivation_not_void: Result /= Void
		end

	internal_same_generic_derivation_as (current_type, other: TYPE_A; a_level: INTEGER): BOOLEAN is
			-- Helpers for `same_generic_derivation_as'.
		require
			other_not_void: other /= Void
			other_derived: other.internal_generic_derivation (a_level).same_as (other)
		do
			if {l_like_current: like Current} other then
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
			gen_type: GEN_TYPE_A
			a_set_to_check, 	a_constraint_types: TYPE_SET_A;
			i: INTEGER;
			in_constraint: BOOLEAN)
		is
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
					generate_constraint_error (gen_type, l_to_check, a_constraint_types, i, Void)
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
					l_to_check.is_conformant_to (l_constraint_type))
				then
					generate_constraint_error (gen_type, l_to_check, a_constraint_types, i, Void)
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

	generate_constraint_error (gen_type: GEN_TYPE_A; current_type: TYPE_A; constraint_type: TYPE_A; position: INTEGER; a_unmatched_creation_constraints: LIST[FEATURE_I]) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
			l_current_type_set, l_constraint_type_set: TYPE_SET_A
		do
			l_current_type_set := current_type.to_type_set
			l_constraint_type_set := constraint_type.to_type_set
			create constraint_info
			constraint_info.set_type (gen_type)
			constraint_info.set_actual_type_set (l_current_type_set)
			constraint_info.set_formal_number (position)
			constraint_info.set_constraint_types (l_constraint_type_set)
			constraint_info.set_unmatched_creation_constraints (a_unmatched_creation_constraints)
			constraint_error_list.extend (constraint_info)
		end

invariant
		-- A generic type should at least have one generic parameter.
		-- A tuple however is an eception and can have no generic parameter.
	generics_not_void_implies_generics_not_empty_or_tuple: (generics /= Void implies (not generics.is_empty or is_tuple))

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

end -- class TYPE_A
