indexing
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

	make is
			-- Initialize generator.
		do
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		do
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		do
		end

	set_dll is
			-- Current generated application is a DLL.
		do
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER) is
			-- Assign current generated assembly with given version details.
		do
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
		end

feature -- IL Generation

	generate_object_equality_test is
			-- Generate comparison of two objects.
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		do
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER
		is
			-- Get token for feature specified by `base_name' and `member_name'
		do
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER) is
			-- Set `local_count' to `a_count'.
		do
		end

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		do
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
		end

feature -- Object creation

	create_object (a_type_id: INTEGER) is
			-- Create object of `a_type_id'.
		do
		end

	create_like_object is
			-- Create object of same type as object on top of stack.
		do
		end

	load_type is
			-- Load on stack type of object on top of stack.
		do
		end
		
	create_type is
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
		end

	initialize_expanded_variable (variable_class_type: CLASS_TYPE) is
			-- Initialize an expanded variable of type `variable_class_type' assuming
			-- that its address is currently on the evaluation stack.
		do
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		do
		end

	pop is
			-- Remove top element of IL stack.
		do
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		do
		end

	generate_current_as_reference is
			-- Generate access to `Current' in its reference form.
			-- (I.e. box value type object if required.)
		do
		end

	generate_result is
			-- Generate access to `Result'.
		do
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		do
		end

	generate_feature_access (type_i: TYPE_I; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
		end

	generate_precursor_feature_access (type_i: TYPE_I; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		do
		end

	generate_type_feature_call (f: TYPE_FEATURE_I) is
			-- Generate a call to a type feature `f' on current.
		do
		end

	put_type_instance (a_type: TYPE_I) is
			-- Put instance of the native TYPE object corresponding to `a_type' on stack.
		do
		end

	put_method_token (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		do
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		do
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		do
		end

	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		do
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		do
		end

	generate_current_address is
			-- Generate address of `Current'.
		do
		end

	generate_result_address is
			-- Generate address of `Result'.
		do
		end

	generate_attribute_address (type_i: TYPE_I; attr_type: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		do
		end

	generate_load_address (type_i: TYPE_I) is
			-- Generate code that takes address of a boxed value object of type `type_i'.
		do
		end

	generate_routine_address (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address of routine of `a_feature_id' in class `type_i'.
		do
		end

	generate_load_from_address (a_type: TYPE_I) is
			-- Load value of `a_type' type from address pushed on stack.
		do
		end

feature -- Assignments

	generate_is_true_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		do
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class.
		do
		end

	generate_expanded_attribute_assignment (type_i, attr_type: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		do
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		do
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
		end

feature -- Conversion

	convert_to (type: TYPE_I) is
			-- Convert top of stack into `type'.
		do
		end

	convert_to_native_int is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_integer_8, convert_to_boolean is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_integer_16, convert_to_character is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_integer_32 is
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_integer_64 is
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_8 is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_natural_16 is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_natural_32 is
			-- Convert top of stack into appropriate type.
		do
		end

	convert_to_natural_64 is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_real_64 is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_real_32 is
			-- Convert top of stack into appropriate type.
		do
		end

feature -- Return statements

	generate_return (has_return_value: BOOLEAN) is
			-- Generate simple end of routine
		do
		end

feature -- Once management

	generate_once_prologue is
			-- Generate prologue for once feature.
			-- The feature is used with `generate_once_epilogue' as follows:
			--    generate_once_prologue
			--    ... -- code of once feature body
			--    generate_once_epilogue
		do
		end

	generate_once_epilogue is
			-- Generate epilogue for once feature.
		do
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
		end

feature -- Once manifest string manipulation

	generate_once_string_allocation (count: INTEGER) is
			-- Generate code that allocates memory required for `count'
			-- once manifest strings of the current routine.
		do
		end

	generate_once_string (number: INTEGER; value: STRING; is_cil_string: BOOLEAN) is
			-- Generate code for once string in a current routine with the given
			-- `number' and `value' using CIL string type if `is_cil_string' is `true' 
			-- or Eiffel string type otherwise.
		do
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER; a_type_id: INTEGER) is
			-- Generate call to `item' of NATIVE_ARRAY.
		do
		end

	generate_array_write_preparation (a_type_id: INTEGER) is
			-- Prepare call to `put' from NATIVE_ARRAY in case of expanded elements.
		do
		end

	generate_array_write (kind: INTEGER; a_type_id: INTEGER) is
			-- Generate call to `put' of NATIVE_ARRAY.
		do
		end

	generate_array_initialization (actual_generic: CLASS_TYPE) is
			-- Initialize native array with actual parameter type
			-- `actual_generic' on the top of the stack.
		do
		end

	generate_array_creation (a_type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
		end

	generate_generic_array_creation (a_formal: FORMAL_I) is
			-- Create a new NATIVE_ARRAY [X] where X is a formal type `a_formal'.
		do
		end

	generate_array_count is
			-- Get length of current NATIVE_ARRAY on stack.
		do
		end

	generate_array_upper is
			-- Generate call to `count - 1'.
		do
		end

	generate_array_lower is
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		do
		end

feature -- Exception handling

	generate_start_exception_block is
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause.
		do
		end

	generate_leave_to (a_label: IL_LABEL) is
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		do
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
		end

feature -- Assertions

	generate_in_assertion_status is
			-- Generate value of `in_assertion' on stack.
		do
		end

	generate_is_assertion_checked (level: INTEGER) is
			-- Check wether or not we need to check assertion for current type.
		do
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag with top of stack.
		do
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		do
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL) is
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		do
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
		end

	generate_raise_exception (a_code: INTEGER; a_tag: STRING) is
			-- Generate an exception of type EIFFEL_EXCEPTION with code
			-- `a_code' and with tag `a_tag'.
		do
		end

	generate_invariant_feature (feat: INVARIANT_FEAT_I) is
			-- Generate `_invariant' that checks `current_class_type' invariants.
		do
		end

	generate_inherited_invariants is
			-- Generate call to all directly inherited invariant features.
		do
		end

	generate_invariant_checked_for (a_label: IL_LABEL) is
			-- Generate check to find out if we should check invariant or not.
		do
		end

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call
		do
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		do
		end

	put_void is
			-- Add a Void element on stack.
		do
		end

	put_manifest_string_from_system_string_local (n: INTEGER) is
			-- Create a manifest string by using local at position `n' which 
			-- should be of type SYSTEM_STRING.
		do
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		do
		end

	put_system_string (s: STRING) is
			-- Put instance of platform String object corresponding to `s' on IL stack.
		do
		end

	put_numeric_integer_constant (type: TYPE_I; i: INTEGER) is
			-- Put `i' as a constant of type `type'.
		do
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER) is
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
		end
		
	put_integer_64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		do
		end

	put_natural_8_constant,
	put_natural_16_constant,
	put_natural_32_constant (n: NATURAL_32) is
			-- Put `n' as NATURAL_8, NATURAL_16, NATURAL_32 on IL stack.
		do
		end

	put_natural_64_constant (n: NATURAL_64) is
			-- Put `n' as NATURAL_64 on IL stack.
		do
		end

	put_real_32_constant (r: REAL) is
			-- Put `d' on IL stack.
		do
		end

	put_real_64_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		do
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		do
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		do
		end

	branch_on_condition (comparison: INTEGER_16; label: IL_LABEL) is
			-- Generate a branch instruction to `label' if two top-level operands on
			-- IL stack when compared using conditional instruction `comparison' yield True.
		do
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		do
		end

	create_label: IL_LABEL is
			-- Create a new label
		do
		end

feature -- Switch instruction

	put_switch_start (count: INTEGER) is
			-- Generate start of a switch instruction with `count' items.
		do
		end

	put_switch_label (label: IL_LABEL) is
			-- Generate a branch to `label' in switch instruction.
		do
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
		end

feature -- Basic feature

	generate_min (type: TYPE_I) is
			-- Generate `min' on basic types.
		do
		end

	generate_is_query_on_character (query_name: STRING) is
			-- Generate is_`query_name' on CHARACTER returning a boolean.
		do
		end

	generate_upper_lower (is_upper: BOOLEAN) is
		do
		end

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		do
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		do
		end

	generate_to_string is
			-- Generate call on `ToString'.
		do
		end
	
	generate_hash_code is
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
		end
		
	generate_out (type: TYPE_I) is
			-- Generate `out' on basic types.
		do
		end
		
feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		do
		end

	put_silent_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.			
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
		end

	put_debug_info (location: LOCATION_AS) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		do
		end

	put_ghost_debug_infos (a_line_n:INTEGER; a_nb: INTEGER) is
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal with the not generated debug clauses
			-- but displayed in eStudio during debugging
		do
		end

	put_silent_debug_info (location: LOCATION_AS) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
			-- but ignored from the EiffelStudio Debugger (.NET)
		do
		end

	flush_sequence_points (a_class_type: CLASS_TYPE) is
			-- Flush all sequence points.
		do
		end

feature -- Convenience

	implemented_type (implemented_in: INTEGER; current_type: CL_TYPE_I): CL_TYPE_I is
			-- Return static_type_id of class that defined `feat'.
		do
		end

	generate_call_on_void_target_exception is
			-- Generate call on void target exception.
		do
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		do
		end

	generate_tuple_type_instance (n: INTEGER) is
			-- Generate a RT_TUPLE_TYPE instance corresponding that will hold `n' items.
		do
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
		end

	generate_none_type_instance is
			-- Generate a NONE_TYPE instance.
		do
		end

	assign_computed_type is
			-- Given elements on stack, compute associated type and set it to
			-- newly created object.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CIL_CODE_GENERATOR
