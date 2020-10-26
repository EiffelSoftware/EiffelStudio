note
	description: "Generation of IL code for stack based virtual machine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_CODE_GENERATOR

inherit
	IL_CONST

	SHARED_IL_CONSTANTS

feature -- Access

	current_class_type: CLASS_TYPE
			-- Currently class type being handled.

	current_class: CLASS_C
			-- Current class being treated.

	current_type_id: INTEGER
			-- Type_id of class being analyzed.

	local_count: INTEGER
			-- Number of locals for feature being generated

feature -- Settings

	set_current_class_type (cl_type: like current_class_type)
			-- Set `current_class_type' to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
			current_class_type := cl_type
			current_class := cl_type.associated_class
		ensure
			current_class_type_set: current_class_type = cl_type
			current_class_set: current_class = cl_type.associated_class
		end

	set_current_type_id (an_id: like current_type_id)
			-- Set `current_type_id' to `an_id'.
		require
			valid_id: an_id > 0
		do
			current_type_id := an_id
		ensure
			current_type_id_set: current_type_id = an_id
		end

feature -- Generation type

	set_console_application
			-- Current generated application is a CONSOLE application.
		deferred
		end

	set_window_application
			-- Current generated application is a WINDOW application.
		deferred
		end

	set_dll
			-- Current generated application is a DLL.
		deferred
		end

	set_32bits
			-- Current generated application is a 32bit application
		deferred
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER)
			-- Assign current generated assembly with given version details.
		require
			valid_build: build >= 0
			valid_major: major >= 0
			valid_minor: minor >= 0
			valid_revision: revision >= 0
		deferred
		end

	set_verifiability (verifiable: BOOLEAN)
			-- Mark current generation to generate verifiable code.
		deferred
		end

feature -- IL Generation

	generate_call_to_standard_copy
			-- Generate a call to run-time feature `standard_copy'
			-- assuming that Current and argument are on the evaluation stack.
		deferred
		end

	generate_object_equality_test
			-- Generate comparison of two objects.
		deferred
		end

	generate_same_type_test
			-- Compare the type of two objects.
		deferred
		end

	generate_runtime_builtin_call (a_feature: FEATURE_I)
			-- Generate the call to the corresponding builtin routine in ISE_RUNTIME
		require
			a_feature_not_void: a_feature /= Void
			a_feature_has_builtin: attached a_feature.extension as l_extension and then l_extension.is_built_in
		deferred
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)

			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		require
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			valid_external_type: valid_type (ext_kind)
		deferred
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_A; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER)

			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		require
			a_actual_type_not_void: a_actual_type /= Void
			valid_external_type: valid_type (ext_kind)
		deferred
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER

			-- Get token for feature specified by `base_name' and `member_name'
		require
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			member_name_not_void: member_name /= Void
			member_name_not_empty: not member_name.is_empty
			valid_external_type: valid_type (ext_kind)
		deferred
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER)
			-- Set `local_count' to `a_count'.
		require
			valid_count: a_count >= 0
		deferred
		ensure
			local_count_set: local_count = a_count
		end

	put_result_info (type_i: TYPE_A)
			-- Specifies `type_i' of type of result.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	put_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	put_nameless_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	put_dummy_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

feature -- Object creation

	create_object (a_type_id: INTEGER)
			-- Create non-generic object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
			type_not_generic: -- not class_types.item (a_type_id).is_generic
		deferred
		end

	create_like_object
			-- Create object of same type as object on top of stack.
		deferred
		end

	load_type
			-- Load on stack type of object on top of stack.
		deferred
		end

	create_type
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		deferred
		end

	create_expanded_object (t: CL_TYPE_A)
			-- Create an object of expanded type `t'.
		require
			t_attached: t /= Void
			t_is_expanded: t.is_expanded
			t_is_internal: not t.is_external
		deferred
		end

feature -- IL stack managment

	duplicate_top
			-- Duplicate top element of IL stack.
		deferred
		end

	pop
			-- Remove top element of IL stack.
		deferred
		end

feature -- Variables access

	generate_current
			-- Generate access to `Current'.
		deferred
		end

	generate_current_as_reference
			-- Generate access to `Current' in its reference form.
			-- (I.e. box value type object if required.)
		deferred
		end

	generate_current_as_basic
			-- Load `Current' as a basic value.
		deferred
		end

	generate_result
			-- Generate access to `Result'.
		deferred
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_feature_access (type_i: TYPE_A; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_precursor_feature_access (type_i: TYPE_A; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_type_feature_call_on_type (f: TYPE_FEATURE_I; t: CL_TYPE_A)
			-- Generate a call to a type feature `f' on the type `t'
			-- assuming the target object is on the stack.
		require
			f_attached: attached f
			t_attached: attached t
		deferred
		end

	generate_type_feature_call (f: TYPE_FEATURE_I)
			-- Generate a call to a type feature `f' on current.
		require
			f_not_void: f /= Void
		deferred
		end

	generate_type_feature_call_for_formal (a_position: INTEGER)
			-- Generate a call to a type feature for formal at position `a_position'.
		require
			a_position_positive: a_position > 0
		deferred
		end

	put_type_instance (a_type: TYPE_A)
			-- Put instance of the native TYPE object corresponding to `a_type' on stack
			-- in the context of `a_context_type'
		require
			a_type_not_void: a_type /= Void
		deferred
		end

	put_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	put_impl_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in implementation of `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_argument (n: INTEGER)
			-- Generate access to `n'-th variable arguments of current feature.
		require
			valid_n: n >= 0
		deferred
		end

	generate_local (n: INTEGER)
			-- Generate access to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		deferred
		end

	generate_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing an expanded type `type_i'.
		require
			type_i_not_void: type_i /= Void
			type_is_expanded: type_i.is_expanded
		deferred
		end

	generate_external_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing an expanded type `type_i'
			-- using an associated external type (if any).
		require
			type_i_not_void: type_i /= Void
			type_is_expanded: type_i.is_expanded
		deferred
		end

	generate_eiffel_metamorphose (a_type: BASIC_A)
			-- Generate a metamorphose of `a_type' into a _REF type.
		require
			a_type_not_void: a_type /= Void
		deferred
		end

	generate_unmetamorphose (type_i: TYPE_A)
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			type_i_not_void: type_i /= Void
			type_is_expanded: type_i.is_expanded
		deferred
		end

	generate_external_unmetamorphose (type_i: TYPE_A)
			-- Generate `unmetamorphose', ie unboxing an external reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			type_i_attached: type_i /= Void
			type_is_expanded: type_i.is_expanded
		deferred
		end

	generate_creation (a_type: TYPE_A)
			-- Generate IL code for a hardcoded creation type `a_type'.
		require
			a_type_i_attached: a_type /= Void
		deferred
		end

feature -- Addresses

	generate_local_address (n: INTEGER)
			-- Generate address of `n'-th local variable.
		require
			valid_n: n >= 0
		deferred
		end

	generate_argument_address (n: INTEGER)
			-- Generate address of `n'-th argument variable.
		require
			valid_n: n >= 0
		deferred
		end

	generate_current_address
			-- Generate address of `Current'.
		deferred
		end

	generate_result_address
			-- Generate address of `Result'.
		deferred
		end

	generate_attribute_address (type_i: TYPE_A; attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			attr_type_not_void: attr_type /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_routine_address (type_i: TYPE_A; a_feature_id: INTEGER; is_last_argument_current: BOOLEAN)
			-- Generate address of routine of `a_feature_id' in class `type_i'
			-- assuming that previous argument is Current if `is_last_argument_current' is true.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_load_address (type_i: TYPE_A)
			-- Generate code that takes address of a boxed value object of type `type_i'.
		require
			type_i_not_void: type_i /= Void
			type_i_is_expanded: type_i.is_expanded
		deferred
		end

	generate_load_from_address (a_type: TYPE_A)
			-- Load value of `a_type' type from address pushed on stack in the
			-- context of `a_context_type'
		require
			type_not_void: a_type /= Void
			type_is_expanded: a_type.is_expanded
		deferred
		end

	generate_load_from_address_as_object (a_type: TYPE_A)
			-- Load value of non-built-in `a_type' type from address pushed on stack.
		require
			type_not_void: a_type /= Void
			type_is_expanded: a_type.is_expanded
		deferred
		end

	generate_load_from_address_as_basic (a_type: TYPE_A)
			-- Load value of a basic type `a_type' from address of an Eiffel object pushed on stack.
		require
			type_not_void: a_type /= Void
			type_is_basic: a_type.is_basic
		deferred
		end

feature -- Assignments

	generate_is_true_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	generate_is_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	generate_is_instance_of_external (type_i: CL_TYPE_A)
			-- Generate `Isinst' byte code instruction for external variant of the type `type_i'.
		require
			type_i_not_void: type_i /= Void
		deferred
		end

	generate_check_cast (source_type, target_type: TYPE_A)
			-- Generate `checkcast' byte code instruction.
		require
			target_type_not_void: target_type /= Void
		deferred
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_expanded_attribute_assignment (type_i, attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		require
			type_i_not_void: type_i /= Void
			attr_type_not_void: attr_type /= Void
			positive_feature_id: a_feature_id > 0
		deferred
		end

	generate_argument_assignment (n: INTEGER)
			-- Generate assignment to `n'-th argument of current feature.
		require
			valid_n: n >= 0
		deferred
		end

	generate_local_assignment (n: INTEGER)
			-- Generate assignment to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		deferred
		end

	generate_result_assignment
			-- Generate assignment to Result variable of current feature.
		deferred
		end

feature -- Conversion

	convert_to (type: TYPE_A)
			-- Convert top of stack into `type'.
		require
			type_not_void: type /= Void
			type_is_basic: type.is_basic
		deferred
		end

	convert_to_native_int
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_integer_8, convert_to_boolean
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_integer_16, convert_to_character_8
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_integer_32
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_integer_64
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_natural_8
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_natural_16
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_natural_32, convert_to_character_32
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_natural_64
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_real_64
			-- Convert top of stack into appropriate type.
		deferred
		end

	convert_to_real_32
			-- Convert top of stack into appropriate type.
		deferred
		end

feature -- Return statements

	generate_return (has_return_value: BOOLEAN)
			-- Generate simple end of routine
		deferred
		end

feature -- Once management

	generate_once_prologue (is_once_creation: BOOLEAN)
			-- Generate prologue for once feature that is a creation procedure of a once class iff `is_once_creation`.
			-- The feature is used with `generate_once_epilogue' as follows:
			--    generate_once_prologue
			--    ... -- code of once feature body
			--    generate_once_epilogue
		deferred
		end

	generate_once_epilogue
			-- Generate epilogue for once feature.
		deferred
		end

	generate_once_store_result
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		deferred
		end

feature -- Once manifest string manipulation

	generate_once_string_allocation (count: INTEGER)
			-- Generate code that allocates memory required for `count'
			-- once manifest strings of the current routine.
		require
			valid_count: count >= 0
		deferred
		end

	generate_once_string (number: INTEGER; value: READABLE_STRING_32; type: INTEGER)
			-- Generate code for once string in a current routine with the given
			-- `number' and `value' using CIL string type if `type' is `string_type_cil',
			-- STRING_8 if `type' is `string_type_string' or STRING_32 if `type' is
			-- string_type_string_32.
		require
			valid_number: number >= 0
			non_void_value: value /= Void
		deferred
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER; a_type_id: INTEGER)
			-- Generate call to `item' of NATIVE_ARRAY.
		require
			kind_positive: kind /= 0
			type_id_valid: kind = il_expanded implies a_type_id > 0
		deferred
		end

	generate_array_write_preparation (a_type_id: INTEGER)
			-- Prepare call to `put' from NATIVE_ARRAY in case of expanded elements.
		require
			type_id_valid: a_type_id > 0
		deferred
		end

	generate_array_write (kind: INTEGER; a_type_id: INTEGER)
			-- Generate call to `put' of NATIVE_ARRAY.
		require
			kind_positive: kind /= 0
			type_id_valid: kind = il_expanded implies a_type_id > 0
		deferred
		end

	generate_array_initialization (array_type: CL_TYPE_A; actual_generic: CLASS_TYPE)
			-- Initialize native array with actual parameter type
			-- `actual_generic' on the top of the stack.
		require
			actual_generic_not_void: actual_generic /= Void
		deferred
		end

	generate_array_creation (a_type_id: INTEGER)
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		require
			a_type_id_positive: a_type_id > 0
		deferred
		end

	generate_generic_array_creation (a_formal: FORMAL_A)
			-- Create a new NATIVE_ARRAY [X] where X is a formal type `a_formal'.
		require
			a_formal_not_void: a_formal /= Void
		deferred
		end

	generate_array_count
			-- Get length of current NATIVE_ARRAY on stack.
		deferred
		end

	generate_array_upper
			-- Generate call to `count - 1'.
		deferred
		end

	generate_array_lower
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		deferred
		end

feature -- Exception handling

	generate_start_exception_block
			-- Mark starting point for a routine that has
			-- a rescue clause.
		deferred
		end

	generate_start_rescue
			-- Mark beginning of rescue clause.
		deferred
		end

	generate_leave_to (a_label: IL_LABEL)
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		deferred
		end

	generate_end_exception_block
			-- Mark end of rescue clause.
		deferred
		end

	generate_last_exception
			-- Generate value of `last_exception' on stack.
		deferred
		end

	generate_restore_last_exception
			-- Restores `get_last_exception' using the local.
		deferred
		end

	generate_start_old_try_block (a_ex_local: INTEGER)
			-- Generate start of try block at entry to evaluate old expression.
			-- `a_ex_local' is the local declaration position for the exception.
		deferred
		end

	generate_catch_old_exception_block (a_ex_local: INTEGER)
			-- Generate catch block for old expression evaluatation
		deferred
		end

	prepare_old_expresssion_blocks (a_count: INTEGER)
			-- Prepare to generate `a_count' blocks for old expression evaluation
		deferred
		end

	generate_raising_old_exception (a_ex_local: INTEGER)
			-- Generate raising old violation exception when there was exception saved
		deferred
		end

	generate_get_rescue_level
			-- Generate `get_rescue_level' on stack.
		deferred
		end

	generate_set_rescue_level
			-- Generate `set_rescue_level' using the local.
		deferred
		end

feature -- Assertions

	generate_in_assertion_status
			-- Generate value of `in_assertion' on stack.
		deferred
		end

	generate_save_supplier_precondition
			-- Generate code to save the current supplier precondition in a local.
		deferred
		end

	generate_restore_supplier_precondition
			-- Restores the supplier precondition flag using the local.
		deferred
		end

	generate_is_assertion_checked (level: INTEGER)
			-- Check wether or not we need to check assertion for current type.
		require
			valid_level:
				level = {ASSERTION_I}.ck_require or
				level = {ASSERTION_I}.ck_ensure or
				level = {ASSERTION_I}.ck_check or
				level = {ASSERTION_I}.ck_loop or
				level = {ASSERTION_I}.ck_invariant
		deferred
		end

	generate_set_assertion_status
			-- Set `in_assertion' flag with top of stack.
		deferred
		end

	generate_in_precondition_status
			-- Generate value of `in_precondition' on stack.
		deferred
		end

	generate_set_precondition_status
			-- Set `in_precondition' flag with top of stack.
		deferred
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING)
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		deferred
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL)
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		require
			failure_block_not_void: failure_block /= Void
		deferred
		end

	generate_precondition_violation
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		deferred
		end

	generate_raise_exception (a_code: INTEGER; a_tag: STRING)
			-- Generate an exception of type EIFFEL_EXCEPTION with code
			-- `a_code' and with tag `a_tag'.
		deferred
		end

	generate_invariant_body (byte_list: BYTE_LIST [BYTE_NODE])
			-- Generate body of the routine that checks class invariant of the current class
			-- represented by `byte_list' (if any) as well as class invariant of ancestors.
		deferred
		end

	generate_invariant_checking (type_i: TYPE_A; entry: BOOLEAN)
			-- Generate an invariant check after routine call
			-- Is the invariant checking `entry'?
		require
			type_i_not_void: type_i /= Void
		deferred
		end

feature -- Constants generation

	put_default_value (type: TYPE_A)
			-- Put default value of `type' on IL stack.
		require
			type_not_void: type /= Void
		deferred
		end

	put_void
			-- Add a Void element on stack.
		deferred
		end

	put_manifest_string_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		require
			valid_n: n >= 0
		deferred
		end

	put_manifest_string (s: READABLE_STRING_GENERAL)
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		deferred
		end

	put_immutable_manifest_string_8 (s: READABLE_STRING_GENERAL)
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		deferred
		end

	put_manifest_string_32_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		require
			valid_n: n >= 0
		deferred
		end

	put_manifest_string_32 (s: READABLE_STRING_32)
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		deferred
		end

	put_immutable_manifest_string_32 (s: READABLE_STRING_32)
			-- Put instance of platform IMMUTABLE_STRING_32 object corresponding to `s' on IL stack.
		require
			valid_s: s /= Void
		deferred
		end

	put_system_string (s: READABLE_STRING_GENERAL)
			-- Put instance of platform String object corresponding to `s' on IL stack.
		require
			valid_s: s /= Void
		deferred
		end

	put_system_string_32 (s: READABLE_STRING_32)
			-- Put `System.String' object corresponding to `s' on IL stack.
			-- `s' is in UTF-8 encoding.
		require
			valid_s: s /= Void
		deferred
		end

	put_numeric_integer_constant (type: TYPE_A; i: INTEGER)
			-- Put `i' as a constant of type `type'.
		require
			type_not_void: type /= Void
			type_is_valid: type.is_integer or type.is_natural or type.is_real_32 or type.is_real_64
		deferred
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER)
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		deferred
		end

	put_integer_64_constant (i: INTEGER_64)
			-- Put `i' as INTEGER_64 on IL stack
		deferred
		end

	put_natural_8_constant,
	put_natural_16_constant,
	put_natural_32_constant (n: NATURAL_32)
			-- Put `n' as NATURAL_8, NATURAL_16, NATURAL on IL stack.
		deferred
		end

	put_natural_64_constant (n: NATURAL_64)
			-- Put `n' as NATURAL_64 on IL stack.
		deferred
		end

	put_real_32_constant (r: REAL)
			-- Put `d' on IL stack.
		deferred
		end

	put_real_64_constant (d: DOUBLE)
			-- Put `d' on IL stack.
		deferred
		end

	put_character_constant (c: CHARACTER)
			-- Put `c' on IL stack.
		deferred
		end

	put_boolean_constant (b: BOOLEAN)
			-- Put `b' on IL stack.
		deferred
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			label_not_void: label /= Void
		deferred
		end

	branch_on_false (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			label_not_void: label /= Void
		deferred
		end

	branch_to (label: IL_LABEL)
			-- Generate a branch instruction to `label'.
		require
			label_not_void: label /= Void
		deferred
		end

	branch_on_condition (comparison: INTEGER_16; label: IL_LABEL)
			-- Generate a branch instruction to `label' if two top-level operands on
			-- IL stack when compared using conditional instruction `comparison' yield True.
		require
			valid_comparison:
				comparison = {MD_OPCODES}.beq or else
				comparison = {MD_OPCODES}.bge or else
				comparison = {MD_OPCODES}.bge_un or else
				comparison = {MD_OPCODES}.bgt or else
				comparison = {MD_OPCODES}.bgt_un or else
				comparison = {MD_OPCODES}.ble or else
				comparison = {MD_OPCODES}.ble_un or else
				comparison = {MD_OPCODES}.blt or else
				comparison = {MD_OPCODES}.blt_un or else
				comparison = {MD_OPCODES}.bne_un
			label_not_void: label /= Void
		deferred
		end

	mark_label (label: IL_LABEL)
			-- Mark a portion of code with `label'.
		require
			label_not_void: label /= Void
		deferred
		end

	create_label: IL_LABEL
			-- Create a new label
		deferred
		end

feature -- Switch instruction

	switch_count: INTEGER
			-- Number of switch labels to be generated

	put_switch_start (count: INTEGER)
			-- Generate start of a switch instruction with `count' items.
		require
			valid_count: count > 0
		deferred
		ensure
			switch_count_set: switch_count = count
		end

	put_switch_label (label: IL_LABEL)
			-- Generate a branch to `label' in switch instruction.
		require
			label_not_void: label /= Void
			positive_switch_count: switch_count > 0
		deferred
		ensure
			switch_count_decremented: switch_count = old switch_count - 1
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER; is_unsigned: BOOLEAN)
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		deferred
		end

	generate_real_comparison_routine (a_code: INTEGER; is_real_32: BOOLEAN; a_return_type: TYPE_A)
			-- Generate a binary operator comparison for REAL_XX types when
			-- user chose to have a total order on REALs.
		require
			a_code_valid:
				a_code = {IL_CONST}.il_ne or
				a_code = {IL_CONST}.il_eq or
				a_code = {IL_CONST}.il_le or
				a_code = {IL_CONST}.il_lt or
				a_code = {IL_CONST}.il_ge or
				a_code = {IL_CONST}.il_gt or
				a_code = {IL_CONST}.il_max or
				a_code = {IL_CONST}.il_min or
				a_code = {IL_CONST}.il_three_way_comparison
			a_return_type_not_void: a_return_type /= Void
			a_return_type_valid: a_return_type.is_boolean or a_return_type.is_integer or
				a_return_type.is_real_32 or a_return_type.is_real_64
		deferred
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER)
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		deferred
		end

feature -- Basic feature

	generate_is_query_on_character (query_name: STRING)
			-- Generate is_`query_name' on CHARACTER returning a boolean.
		require
			query_name_not_void: query_name /= Void
		deferred
		end

	generate_is_query_on_real (is_real_32: BOOLEAN; query_name: STRING)
			-- Generate static call `query_name' on REAL_32 taking a REAL_32 as argument
			-- if `is_real_32', otherwise using REAL_64, and returning a boolean.
		require
			query_name_not_void: query_name /= Void
			query_name_not_empty: not query_name.is_empty
		deferred
		end

	generate_upper_lower (is_upper: BOOLEAN)
		deferred
		end

	generate_math_one_argument (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type): type"
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			type_not_void: type /= Void
			basic_type: type.is_basic
		deferred
		end

	generate_math_two_arguments (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type, type): type"
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			type_not_void: type /= Void
			basic_type: type.is_basic
		deferred
		end

	generate_to_string
			-- Generate call on `ToString'.
		deferred
		end

	generate_hash_code
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		deferred
		end

	generate_out (type: TYPE_A)
			-- Generate `out' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		deferred
		end

feature -- Line info

	put_line_info (n: INTEGER)
			-- Generate debug information at line `n'.
		require
			valid_n: n > 0
		deferred
		end

	put_silent_line_info (n: INTEGER)
			-- Generate debug information at line `n'.			
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		require
			valid_n: n > 0
		deferred
		end

	put_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		require
			location_not_void: location /= Void
		deferred
		end

	put_ghost_debug_infos (a_line_n:INTEGER; a_nb: INTEGER)
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal, for instance, with the not generated debug clauses
			-- but displayed in eStudio during debugging
		require
			a_nb_positive_or_zero: a_nb >= 0
		deferred
		end

	put_silent_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
			-- but ignored from the EiffelStudio Debugger (.NET)
		require
			location_not_void: location /= Void
		deferred
		end

	flush_sequence_points (a_class_type: CLASS_TYPE)
			-- Flush all sequence points.
		require
			a_class_type_not_void: a_class_type /= Void
		deferred
		end

	set_pragma_offset (a_offset: INTEGER)
			-- Set line pragma offset for debug info.
		deferred
		end

	set_default_document
			-- Restore debug document to default.
		deferred
		end

	set_stop_breakpoints_generation (a_bool: BOOLEAN)
			-- Should breakpoints not be generated?
		deferred
		end

	set_document (a_doc: STRING)
			-- Set debug document to `a_doc'.
		require
			attached_document: a_doc /= Void
		deferred
		end

feature -- Convenience

	generate_call_on_void_target_exception
			-- Generate call on void target exception.
		deferred
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		deferred
		end

	generate_generic_type_instance (n: INTEGER)
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n >= 0
		deferred
		end

	generate_tuple_type_instance (n: INTEGER)
			-- Generate a RT_TUPLE_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n >= 0
		deferred
		end

	generate_generic_type_settings (gen_type: TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			gen_type_not_void: gen_type /= Void
		deferred
		end

	generate_none_type_instance
			-- Generate a NONE_TYPE instance.
		deferred
		end

	generate_generating_type_instance (a_gen_type: TYPE_A)
			-- Generate an instance of the generic type `a_gen_type' where the type
			-- of the actual generic parameter is the type of the object on top
			-- of the stack.
			-- Useful to generate {ANY}.generating_type.
		require
			a_type_not_void: a_gen_type /= Void
			has_one_generic: attached a_gen_type.generics as l_generics and then l_generics.count = 1
		deferred
		end

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
