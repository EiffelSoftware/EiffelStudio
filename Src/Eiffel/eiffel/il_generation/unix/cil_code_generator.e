note
	description: "Generation of IL code. Null operation for Unix."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize generator.
		do
		end

feature -- Generation type

	set_console_application
			-- Current generated application is a CONSOLE application.
		do
		end

	set_window_application
			-- Current generated application is a WINDOW application.
		do
		end

	set_dll
			-- Current generated application is a DLL.
		do
		end

	set_32bits
			-- Current generated application is a 32bit application
		do
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER)
			-- Assign current generated assembly with given version details.
		do
		end

	set_verifiability (verifiable: BOOLEAN)
			-- Mark current generation to generate verifiable code.
		do
		end

feature -- IL Generation

	generate_call_to_standard_copy
			-- Generate a call to run-time feature `standard_copy'
			-- assuming that Current and argument are on the evaluation stack.
		do
		end

	generate_object_equality_test
			-- Generate comparison of two objects.
		do
		end

	generate_same_type_test
			-- <Precursor>
		do
		end

	generate_runtime_builtin_call (a_feature: FEATURE_I)
			-- Generate the call to the corresponding builtin routine in ISE_RUNTIME
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)

			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		do
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_A; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER)

		do
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER

			-- Get token for feature specified by `base_name' and `member_name'
		do
		end

	constructor_token (a_type_id: INTEGER): INTEGER
			-- Token identifier for default constructor of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
		ensure
			constructor_token_valid: Result /= 0
		end

	inherited_constructor_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- constructor token.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
		ensure
			feature_token_valid: Result /= 0
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER)
			-- Set `local_count' to `a_count'.
		do
		end

	put_result_info (type_i: TYPE_A)
			-- Specifies `type_i' of type of result.
		do
		end

	put_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
		end

	put_nameless_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
		end

	put_dummy_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
		end

feature -- Object creation

	create_object (a_type_id: INTEGER)
			-- Create object of `a_type_id'.
		do
		end

	create_like_object
			-- Create object of same type as object on top of stack.
		do
		end

	load_type
			-- Load on stack type of object on top of stack.
		do
		end

	create_type
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
		end

	create_expanded_object (t: CL_TYPE_A)
			-- Create an object of expanded type `t'.
		do
		end

feature -- IL stack managment

	duplicate_top
			-- Duplicate top element of IL stack.
		do
		end

	pop
			-- Remove top element of IL stack.
		do
		end

feature -- Variables access

	generate_current
			-- Generate access to `Current'.
		do
		end

	generate_current_as_reference
			-- Generate access to `Current' in its reference form.
			-- (I.e. box value type object if required.)
		do
		end

	generate_current_as_basic
			-- Load `Current' as a basic value.
		do
		end

	generate_result
			-- Generate access to `Result'.
		do
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		do
		end

	generate_feature_access (type_i: TYPE_A; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
		end

	generate_precursor_feature_access (type_i: TYPE_A; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		do
		end

	generate_type_feature_call_on_type (f: TYPE_FEATURE_I; t: CL_TYPE_A)
			-- <Precursor>
		do
		end

	generate_type_feature_call (f: TYPE_FEATURE_I)
			-- Generate a call to a type feature `f' on current.
		do
		end

	generate_type_feature_call_for_formal (a_position: INTEGER)
			-- Generate a call to a type feature for formal at position `a_position'.
		do
		end

	put_type_instance (a_type: TYPE_A)
			-- Put instance of the native TYPE object corresponding to `a_type' on stack.
		do
		end

	put_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
		end

	put_impl_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
		end

	generate_argument (n: INTEGER)
			-- Generate access to `n'-th variable arguments of current feature.
		do
		end

	generate_local (n: INTEGER)
			-- Generate access to `n'-th local variable of current feature.
		do
		end

	generate_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		do
		end

	generate_external_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing an expanded type `type_i'
			-- using an associated external type (if any).
		do
		end

	generate_eiffel_metamorphose (a_type: BASIC_A)
			-- Generate a metamorphose of `a_type' into a _REF type.
		do
		end

	generate_unmetamorphose (type_i: TYPE_A)
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
		end

	generate_external_unmetamorphose (type_i: CL_TYPE_A)
			-- Generate `unmetamorphose', ie unboxing an external reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
		end

	generate_creation (cl_type_i: CL_TYPE_A)
			-- Generate IL code for a hardcoded creation type `cl_type_i'.
		do
		end

feature -- Addresses

	generate_local_address (n: INTEGER)
			-- Generate address of `n'-th local variable.
		do
		end

	generate_argument_address (n: INTEGER)
			-- Generate address of `n'-th argument variable.
		do
		end

	generate_current_address
			-- Generate address of `Current'.
		do
		end

	generate_result_address
			-- Generate address of `Result'.
		do
		end

	generate_attribute_address (type_i: TYPE_A; attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		do
		end

	generate_load_address (type_i: TYPE_A)
			-- Generate code that takes address of a boxed value object of type `type_i'.
		do
		end

	generate_routine_address (type_i: TYPE_A; a_feature_id: INTEGER; is_last_argument_current: BOOLEAN)
			-- Generate address of routine of `a_feature_id' in class `type_i'
			-- assuming that previous argument is Current if `is_last_argument_current' is true.
		do
		end

	generate_load_from_address (a_type: TYPE_A)
			-- Load value of `a_type' type from address pushed on stack.
		do
		end

	generate_load_from_address_as_object (a_type: TYPE_A)
			-- Load value of non-built-in `a_type' type from address pushed on stack.
		do
		end

	generate_load_from_address_as_basic (a_type: TYPE_A)
			-- Load value of a basic type `a_type' from address of an Eiffel object pushed on stack.
		do
		end

feature -- Assignments

	generate_is_true_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_is_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_is_instance_of_external (type_i: CL_TYPE_A)
			-- Generate `Isinst' byte code instruction for external variant of the type `type_i'.
		do
		end

	generate_check_cast (source_type, target_type: TYPE_A)
			-- Generate `checkcast' byte code instruction.
		do
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class.
		do
		end

	generate_expanded_attribute_assignment (type_i, attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		do
		end

	generate_argument_assignment (n: INTEGER)
			-- Generate assignment to `n'-th argument of current feature.
		do
		end

	generate_local_assignment (n: INTEGER)
			-- Generate assignment to `n'-th local variable of current feature.
		do
		end

	generate_result_assignment
			-- Generate assignment to Result variable of current feature.
		do
		end

feature -- Conversion

	convert_to (type: TYPE_A)
			-- Convert top of stack into `type'.
		do
		end

	convert_to_native_int
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_integer_8, convert_to_boolean
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_integer_16, convert_to_character_8
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_integer_32
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_integer_64
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_8
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_16
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_32, convert_to_character_32
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_64
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_real_64
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_real_32
			-- Convert top of stack into appropriate type.
		do
		end

feature -- Return statements

	generate_return (has_return_value: BOOLEAN)
			-- Generate simple end of routine
		do
		end

feature -- Once management

	generate_once_prologue (is_once_creation: BOOLEAN)
			-- Generate prologue for once feature.
			-- The feature is used with `generate_once_epilogue' as follows:
			--    generate_once_prologue
			--    ... -- code of once feature body
			--    generate_once_epilogue
		do
		end

	generate_once_epilogue
			-- Generate epilogue for once feature.
		do
		end

	generate_once_store_result
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
		end

feature -- Once manifest string manipulation

	generate_once_string_allocation (count: INTEGER)
			-- Generate code that allocates memory required for `count'
			-- once manifest strings of the current routine.
		do
		end

	generate_once_string (number: INTEGER; value: READABLE_STRING_32; type: INTEGER)
			-- Generate code for once string in a current routine with the given
			-- `number' and `value' using CIL string type if `is_cil_string' is `true'
			-- or Eiffel string type otherwise.
		do
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER; a_type_id: INTEGER)
			-- Generate call to `item' of NATIVE_ARRAY.
		do
		end

	generate_array_write_preparation (a_type_id: INTEGER)
			-- Prepare call to `put' from NATIVE_ARRAY in case of expanded elements.
		do
		end

	generate_array_write (kind: INTEGER; a_type_id: INTEGER)
			-- Generate call to `put' of NATIVE_ARRAY.
		do
		end

	generate_array_initialization (array_type: CL_TYPE_A; actual_generic: CLASS_TYPE)
			-- Initialize native array with actual parameter type
			-- `actual_generic' on the top of the stack.
		do
		end

	generate_array_creation (a_type_id: INTEGER)
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
		end

	generate_generic_array_creation (a_formal: FORMAL_A)
			-- Create a new NATIVE_ARRAY [X] where X is a formal type `a_formal'.
		do
		end

	generate_array_count
			-- Get length of current NATIVE_ARRAY on stack.
		do
		end

	generate_array_upper
			-- Generate call to `count - 1'.
		do
		end

	generate_array_lower
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		do
		end

feature -- Exception handling

	generate_start_exception_block
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
		end

	generate_start_rescue
			-- Mark beginning of rescue clause.
		do
		end

	generate_leave_to (a_label: IL_LABEL)
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		do
		end

	generate_end_exception_block
			-- Mark end of rescue clause.
		do
		end

	generate_last_exception
			-- Generate value of `last_exception' on stack.
		do
		end

	generate_restore_last_exception
			-- Restores `get_last_exception' using the local.
		do
		end

	generate_start_old_try_block (a_ex_local: INTEGER)
			-- Generate start of try block at entry to evaluate old expression.
			-- `a_ex_local' is the local declaration position for the exception.
		do
		end

	generate_catch_old_exception_block (a_ex_local: INTEGER)
			-- Generate catch block for old expression evaluatation
		do
		end

	prepare_old_expresssion_blocks (a_count: INTEGER)
			-- Prepare to generate `a_count' blocks for old expression evaluation
		do
		end

	generate_raising_old_exception (a_ex_local: INTEGER)
			-- Generate raising old violation exception when there was exception saved
		do
		end

	generate_get_rescue_level
			-- Generate `get_rescue_level' on stack.
		do
		end

	generate_set_rescue_level
			-- Generate `set_rescue_level' using the local.
		do
		end

feature -- Assertions

	generate_in_assertion_status
			-- Generate value of `in_assertion' on stack.
		do
		end

	generate_save_supplier_precondition
			-- Generate code to save the current supplier precondition in a local.
		do
		end

	generate_restore_supplier_precondition
			-- Restores the supplier precondition flag using the local.
		do
		end

	generate_in_precondition_status
			-- Generate value of `in_precondition' on stack.
		do
		end

	generate_set_precondition_status
			-- Set `in_precondition' flag with top of stack.
		do
		end

	generate_is_assertion_checked (level: INTEGER)
			-- Check wether or not we need to check assertion for current type.
		do
		end

	generate_set_assertion_status
			-- Set `in_assertion' flag with top of stack.
		do
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING)
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		do
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL)
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		do
		end

	generate_precondition_violation
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
		end

	generate_raise_exception (a_code: INTEGER; a_tag: STRING)
			-- Generate an exception of type EIFFEL_EXCEPTION with code
			-- `a_code' and with tag `a_tag'.
		do
		end

	generate_invariant_body (byte_list: BYTE_LIST [BYTE_NODE])
			-- Generate body of the routine that checks class invariant of the current class
			-- represented by `byte_list' (if any) as well as class invariant of ancestors.
		do
		end

	generate_invariant_checking (type_i: TYPE_A; entry: BOOLEAN)
			-- Generate an invariant check after routine call
		do
		end

feature -- Constants generation

	put_default_value (type: TYPE_A)
			-- Put default value of `type' on IL stack.
		do
		end

	put_void
			-- Add a Void element on stack.
		do
		end

	put_manifest_string_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		do
		end

	put_manifest_string (s: READABLE_STRING_GENERAL)
			-- Put `s' on IL stack.
		do
		end

	put_immutable_manifest_string_8 (s: READABLE_STRING_GENERAL)
			-- <Precursor/>
		do
		end

	put_manifest_string_32_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		do
		end

	put_manifest_string_32 (s: READABLE_STRING_32)
			-- Put `s' on IL stack.
			-- `s' is in UTF-8
		do
		end

	put_immutable_manifest_string_32 (s: READABLE_STRING_32)
			-- <Precursor/>
		do
		end

	put_system_string (s: READABLE_STRING_GENERAL)
			-- Put instance of platform String object corresponding to `s' on IL stack.
		do
		end

	put_system_string_32 (s: READABLE_STRING_32)
			-- Put `System.String' object corresponding to `s' on IL stack.
			-- `s' is in UTF-8 encoding.
		do
		end

	put_numeric_integer_constant (type: TYPE_A; i: INTEGER)
			-- Put `i' as a constant of type `type'.
		do
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER)
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
		end

	put_integer_64_constant (i: INTEGER_64)
			-- Put `i' as INTEGER_64 on IL stack
		do
		end

	put_natural_8_constant,
	put_natural_16_constant,
	put_natural_32_constant (n: NATURAL_32)
			-- Put `n' as NATURAL_8, NATURAL_16, NATURAL_32 on IL stack.
		do
		end

	put_natural_64_constant (n: NATURAL_64)
			-- Put `n' as NATURAL_64 on IL stack.
		do
		end

	put_real_32_constant (r: REAL)
			-- Put `d' on IL stack.
		do
		end

	put_real_64_constant (d: DOUBLE)
			-- Put `d' on IL stack.
		do
		end

	put_character_constant (c: CHARACTER)
			-- Put `c' on IL stack.
		do
		end

	put_boolean_constant (b: BOOLEAN)
			-- Put `b' on IL stack.
		do
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
		end

	branch_on_false (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
		end

	branch_to (label: IL_LABEL)
			-- Generate a branch instruction to `label'.
		do
		end

	branch_on_condition (comparison: INTEGER_16; label: IL_LABEL)
			-- Generate a branch instruction to `label' if two top-level operands on
			-- IL stack when compared using conditional instruction `comparison' yield True.
		do
		end

	mark_label (label: IL_LABEL)
			-- Mark a portion of code with `label'.
		do
		end

	create_label: IL_LABEL
			-- Create a new label
		do
		end

feature -- Switch instruction

	put_switch_start (count: INTEGER)
			-- Generate start of a switch instruction with `count' items.
		do
		end

	put_switch_label (label: IL_LABEL)
			-- Generate a branch to `label' in switch instruction.
		do
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER; is_unsigned: BOOLEAN)
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
		end

	generate_real_comparison_routine (a_code: INTEGER; is_real_32: BOOLEAN; a_return_type: TYPE_A)
			-- Generate a binary operator comparison for REAL_XX types when
			-- user chose to have a total order on REALs.
		do
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER)
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
		end

feature -- Basic feature

	generate_is_query_on_character (query_name: STRING)
			-- Generate is_`query_name' on CHARACTER returning a boolean.
		do
		end

	generate_is_query_on_real (is_real_32: BOOLEAN; query_name: STRING)
			-- Generate static call `query_name' on REAL_32 taking a REAL_32 as argument
			-- if `is_real_32', otherwise using REAL_64, and returning a boolean.
		do
		end

	generate_upper_lower (is_upper: BOOLEAN)
		do
		end

	generate_math_one_argument (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type): type"
		do
		end

	generate_math_two_arguments (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type, type): type"
		do
		end

	generate_to_string
			-- Generate call on `ToString'.
		do
		end

	generate_hash_code
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
		end

	generate_out (type: TYPE_A)
			-- Generate `out' on basic types.
		do
		end

feature -- Line info

	put_line_info (n: INTEGER)
			-- Generate debug information at line `n'.
		do
		end

	put_silent_line_info (n: INTEGER)
			-- Generate debug information at line `n'.			
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
		end

	put_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		do
		end

	put_ghost_debug_infos (a_line_n:INTEGER; a_nb: INTEGER)
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal with the not generated debug clauses
			-- but displayed in eStudio during debugging
		do
		end

	put_silent_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
			-- but ignored from the EiffelStudio Debugger (.NET)
		do
		end

	flush_sequence_points (a_class_type: CLASS_TYPE)
			-- Flush all sequence points.
		do
		end

	set_pragma_offset (a_offset: INTEGER)
			-- Set line pragma offset for debug info.
		do
		end

	set_default_document
			-- Restore debug document to default.
		do
		end

	set_stop_breakpoints_generation (a_bool: BOOLEAN)
			-- Should breakpoints not be generated?
		do
		end

	set_document (a_doc: STRING)
			-- Set debug document to `a_doc'.
		do
		end

feature -- Convenience

	generate_call_on_void_target_exception
			-- Generate call on void target exception.
		do
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
		end

	generate_generic_type_instance (n: INTEGER)
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		do
		end

	generate_tuple_type_instance (n: INTEGER)
			-- Generate a RT_TUPLE_TYPE instance corresponding that will hold `n' items.
		do
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
		end

	generate_none_type_instance
			-- Generate a NONE_TYPE instance.
		do
		end

	generate_generating_type_instance (a_gen_type: TYPE_A)
			-- <Precursor>
		do
		end

feature {CIL_CODE_GENERATOR, CUSTOM_ATTRIBUTE_GENERATOR} -- Custom attribute definition

	define_custom_attribute (token: INTEGER; ctor_token: INTEGER; data: MD_CUSTOM_ATTRIBUTE)
			-- Define a custom attribute on `token' using constructor `ctor_token' with
			-- arguments `data'.
			-- Same as `md_emit.define_custom_attribute' but we do not care about return type.
		do
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
