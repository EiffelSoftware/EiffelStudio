indexing
	description: "Interface used for IL code generationn."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_CODE_GENERATOR_I

inherit
	SHARED_IL_CONSTANTS

	IL_CONST

feature -- Target of generation

	set_for_interfaces is
			-- Set generation mode for `interfaces'.
		deferred
		end

	set_for_implementations is
			-- Set generation mode for `implementations'.
		deferred
		end

feature -- Generation Structure

	start_assembly_generation (assembly_name, file_name, location: STRING) is
			-- Create Assembly with `name'.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		deferred
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		deferred
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Start generation of module with name `name' within current assembly.
			-- In debug mode if `debug_mode' is true.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		deferred
		end

	define_entry_point (type_id: INTEGER; feature_id: INTEGER) is
			-- Define entry point for IL component from `feature_id' in
			-- class `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		deferred
		end

	end_module_generation is
			-- Finish creation of current module.
		deferred
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		deferred
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		deferred
		end

	set_dll is
			-- Current generated application is a DLL.
		deferred
		end

feature -- Class info

	start_class_mappings (class_count: INTEGER) is
			-- Start generation of class mappings
		do
		 print ("")
		end

	generate_class_mappings (class_name: STRING;
			id, interface_id: INTEGER; filename, element_type: STRING)
		is
			-- Create a mapping table between `id' and `class_name'.
			-- `filename' is the path to the source file of `class_name'
		require
			name_not_void: class_name /= Void
			name_not_empty: not class_name.is_empty
			id_positive: id > 0
			interface_id_positive: interface_id > 0
			non_void_filename: filename /= Void
			element_type_not_void: element_type /= Void
		deferred
		end

	start_classes_descriptions is
			-- Start description of classes
		do
		end

	end_classes_descriptions is
			-- End declaration of classes
		do
		end

	generate_class_header (is_interface, is_deferred, is_frozen, is_expanded, is_external: BOOLEAN; type_id: INTEGER) is
			-- Generate `class_name' and its specifier.
		require
			positive_type_id: type_id > 0
		deferred
		end

	end_class is
			-- Finish description of current class structure.
		deferred
		end

	start_parents_list is
			-- Starting inheritance part description
		do
		end

	add_to_parents_list (type_id: INTEGER) is
			-- Add class of `type_id' into list of parents of current type.
			-- `start_parents_list' should have been called before.
		require
			positive_type_id: type_id > 0
		deferred
		end

	add_interface (type_id: INTEGER) is
			-- Add interface of `type_id' into list of parents of current type.
		require
			positive_type_id: type_id > 0
		deferred
		end

	end_parents_list is
			-- Finishing inheritance part description
			-- `start_parents_list' should have been called before.
		deferred
		end
	
feature -- Features info

	start_features_list (type_id: INTEGER) is
			-- Starting enumeration of features written in current class.
		require
			positive_type_id: type_id > 0
		deferred
		end

	start_feature_description (arg_count: INTEGER) is
			-- Start description of a feature of current class.
		require
			arg_count_nonnegative: arg_count >= 0
		deferred
		end

	create_feature_description is
			-- End description of a feature of current class.
		deferred
		end

	check_renaming is
			-- Check renaming for current feature and class.
		deferred
		end

	check_renaming_and_redefinition is
			-- Check covariance for current feature and class.
		deferred
		end

	end_features_list is
			-- Finishing enumeration of features written in current class.
		deferred
		end

	generate_interface_feature_identification (name: STRING; feature_id: INTEGER;
			is_attribute: BOOLEAN)
		is
			-- Generate feature identification for feature located in interface.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER;
			is_redefined, is_deferred, is_frozen, is_attribute, is_c_external, is_static: BOOLEAN)
		is
			-- Generate feature identification.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
			non_deferred_frozen: is_frozen implies not is_deferred
			non_deferred_attribute: is_attribute implies not is_deferred
		deferred
		end

	generate_external_identification (name, il_name: STRING; ext_kind, feature_id, routine_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [STRING]; return_type: STRING) is
			-- Generate feature identification.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
			positive_written_type_id: written_type_id > 0
			positive_routine_id: routine_id > 0
			valid_external_type: valid_type (ext_kind)
		deferred
		end

	generate_deferred_external_identification (name: STRING; feature_id, routine_id, written_type_id: INTEGER) is
			-- Generate feature identification.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
			positive_routine_id: routine_id > 0
		deferred
		end

	generate_feature_return_type (type_id: INTEGER) is
			-- Generate return type `type_id' of current feature.
		require
			positive_type_id: type_id > 0
		deferred
		end

	start_arguments_list (count: INTEGER) is
			-- Start declaration of arguments list of `count' size of current feature.
		do
		end

	generate_feature_argument (name: STRING; type_id: INTEGER) is
			-- Generate argument `name' of type `type_a'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_type_id: type_id > 0
		deferred
		end

	end_arguments_list is
			-- End declaration of arguments list of current feature.
		do
		end

feature -- IL Generation

	start_il_generations is
			-- Start IL code generation.
		do
		end

	start_il_generation (type_id: INTEGER) is
			-- Start IL code generation of current class.
		require
			positive_type_id: type_id > 0
		deferred
		end

	generate_feature_il (feature_id, type_id, code_feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in class of `type_id'
			-- IL code will be generated. If `type_id' is different from current type id,
			-- it means that `feature_id' is simply a delegation to a call on `code_feature_id'
			-- defined in `type_id'.
		require
			positive_feature_id: feature_id > 0
			positive_type_id: type_id > 0
			positive_code_feature_id: code_feature_id > 0
		deferred
		end

	generate_implementation_feature_il (feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in class of `type_id'
			-- IL code will be generated.
		require
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_method_impl (feature_id, parent_type_id, parent_feature_id: INTEGER) is
			-- Generate a MethodImpl from `parent_type_id' and `parent_feature_id'
			-- to `current_class_type' and `feature_id'.
		require
			positive_feature_id: feature_id > 0
			positive_parent_type_id: parent_type_id > 0
			positive_parent_feature_id: parent_feature_id > 0
		deferred
		end

	generate_feature_internal_clone (feature_id: INTEGER) is
		require
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Specifies for which creation feature of `feature_id' written in
			-- class of `type_id' IL code will be generated.
		require
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER; parameters_type: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN; type_id: INTEGER; feature_id: INTEGER) is
			-- Generate call to `name' with signature `parameters_type'.
		require
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			valid_external_type: valid_type (ext_kind)
			-- name seems to be emty if ext_kind = 
			-- creatore_type sometimes
			--			name_not_void: name /= Void
			--			name_empty: not name.is_empty
		deferred
		end

feature -- Local variable info generation

	put_result_info (type_id: INTEGER) is
			-- Specifies `type_id' of type of result.
		require
			positive_type_id: type_id > 0
		deferred
		end

	put_local_info (type_id: INTEGER; name: STRING) is
			-- Specifies `type_id' of type of local at position `pos'.
		require
			positive_type_id: type_id > 0
		deferred
		end

feature -- Object creation

	create_like_current_object is
			-- Create object of same type as current object.
		deferred
		end

	create_object (type_id: INTEGER) is
			-- Create object of `type_id'.
		require
			positive_type_id: type_id > 0
		deferred
		end

	create_attribute_object (type_id, feature_id: INTEGER) is
			-- Create object of `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	mark_creation_routines (feature_ids: ARRAY [INTEGER]) is
			-- Mark routines of `feature_ids' in Current class as creation
			-- routine of Current class.
		require
			feature_ids_not_void: feature_ids /= Void
		deferred
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		deferred
		end

	pop is
			-- Remove top element of IL stack.
		deferred
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		deferred
		end

	generate_result is
			-- Generate access to `Result'.
		deferred
		end

	generate_attribute (type_id, feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_feature_access (type_id, feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_precursor_feature_access (type_id, feature_id: INTEGER) is
			-- Generate access to feature of `feature_id' in `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th argument of current feature.
			-- Cannot be `0', reserved for `Current'.
		require
			valid_n: n > 0
		deferred
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		require
			valid_n: n > 0
		deferred
		end

	generate_metamorphose (type_id: INTEGER) is
			-- Generate `metamorphose', ie boxing a basic type of `type_id' into its
			-- corresponding reference type.
		require
			positive_type_id: type_id > 0
		deferred
		end

	generate_unmetamorphose (type_id: INTEGER) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_id'.
			-- Load content of address resulting from unbox operation.
		require
			positive_type_id: type_id > 0
		deferred
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		require
			valid_n: n > 0
		deferred
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		require
			valid_n: n > 0
		deferred
		end

	generate_current_address is
			-- Generate address of `Current'.
		deferred
		end

	generate_result_address is
			-- Generate address of `Result'.
		deferred
		end

	generate_attribute_address (type_id, feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_routine_address (type_id, feature_id: INTEGER) is
			-- Generate address of routine of `feature_id' in class `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		deferred
		end

	generate_load_from_address (type_id: INTEGER) is
			-- Load value of `type_i' type from address pushed on stack.
		require
			positive_type_id: type_id > 0
		deferred
		end

feature -- Assignments

	generate_is_instance_of (type_id: INTEGER) is
			-- Generate `Isinst' byte code instruction.
		require
			positive_type_id: type_id > 0
		deferred
		end
		
	generate_check_cast (source_type_id, target_type_id: INTEGER) is
			-- Generate `checkcast' byte code instruction.
		require
			positive_source_type_id: source_type_id > 0
			positive_target_type_id: target_type_id > 0
		deferred
		end

	generate_attribute_assignment (type_id, feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
		require
			positive_feature_id: feature_id > 0
			positive_type_id: type_id > 0
		deferred
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		require
			valid_n: n > 0
		deferred
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		deferred
		end

feature -- Conversion

	convert_to_native_int,
	convert_to_integer8,
	convert_to_integer16,
	convert_to_integer32,
	convert_to_integer64,
	convert_to_double,
	convert_to_real,
	convert_to_boolean,
	convert_to_character
		is
			-- Convert top of stack into an appropriate type.
		deferred
		end

feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		deferred
		end

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		deferred
		end

feature -- Once management

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		deferred
		end

	generate_once_result_info (name: STRING; type_id: INTEGER) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_id'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_type_id: type_id > 0
		deferred
		end

	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		deferred
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		deferred
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		deferred
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of ARRAY.
		require
			valid_kind: valid_type_kind (kind)
		deferred
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of ARRAY.
		require
			valid_kind: valid_type_kind (kind)
		deferred
		end

	generate_array_creation (type_id: INTEGER) is
		require
			positive_type_id: type_id > 0
		deferred
		end

	generate_array_count is
		deferred
		end

	generate_array_upper is
		deferred
		end

	generate_array_lower is
		deferred
		end

feature -- Exception handling

	generate_start_exception_block is
			-- Mark a certain routine has having a rescue clause.
		deferred
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause in routine.
		deferred
		end

	generate_end_exception_block is
			-- Mark end of rescue clause and end of routine.
		deferred
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: INTEGER) is
			-- Check if assertions are already being checked,
			-- in that case we need to skip the assertion block.
		require
			end_of_assert_label_not_void: end_of_assert /= Void
		deferred
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag to True.
		deferred
		end

	generate_restore_assertion_status is
			-- Set `in_assertion' flag to False.
		deferred
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		deferred
		end

	generate_precondition_check (tag: STRING; failure_block: INTEGER) is
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		deferred
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		deferred
		end

	generate_invariant_checking (type_id: INTEGER) is
			-- Generate an invariant check after routine call
		require
			positive_type_id: type_id > 0
		deferred
		end

	mark_invariant (feature_id: INTEGER) is
			-- Mark routine `feature_id' in Current class as invariant of Current class.
		require
			positive_feature_id: feature_id > 0
		deferred
		end

feature -- Constants generation

	put_void is
			-- Put `Void' on IL stack.
		deferred
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			s_not_void: s /= Void
		deferred
		end

	put_integer8_constant,
	put_integer16_constant,
	put_integer32_constant (i: INTEGER) is
			-- Put `i' as INTEGER_8, INTEGER_16 or INTEGER on IL stack
		deferred
		end
		
	put_integer64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		deferred
		end
		
	put_real_constant (r: REAL) is
			-- put `r' on IL stack.
		deferred
		end
		
	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		deferred
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		deferred
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		deferred
		end

feature -- Labels and branching

	branch_on_true (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			label_not_void: label /= Void
		deferred
		end

	branch_on_false (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			label_not_void: label /= Void
		deferred
		end

	branch_to (label: INTEGER) is
			-- Generate a branch instruction to `label'.
		require
			label_not_void: label /= Void
		deferred
		end

	mark_label (label: INTEGER) is
			-- Mark a portion of code with `label'.
		require
			label_not_void: label /= Void
		deferred
		end

	create_label: INTEGER is
			-- Create a new label.
		deferred
		end

feature -- Binary_operator generation

	generate_lt is
			-- Generate `<' operator.
		deferred
		end

	generate_le is
			-- Generate `<=' operator.
		deferred
		end
		
	generate_gt is
			-- Generate `>' operator.
		deferred
		end
		
	generate_ge is
			-- Generate `>=' operator.
		deferred
		end

	generate_star is
			-- Generate `*' operator.
		deferred
		end

	generate_power is
			-- Generate `^' operator.
		deferred
		end

	generate_plus is
			-- Generate `+' operator.
		deferred
		end

	generate_mod is
			-- Generate `\\' operator.
		deferred
		end

	generate_minus is
			-- Generate `-' operator.
		deferred
		end

	generate_div is
			-- Generate `//' operator.
		deferred
		end

	generate_xor is
			-- Generate `xor' operator.
		deferred
		end

	generate_or is
			-- Generate `or' operator.
		deferred
		end

	generate_and is
			-- Generate `and' operator.
		deferred
		end

	generate_implies is
			-- Generate `implies operator.
		deferred
		end

	generate_eq is
			-- Generate `=' operator.
		deferred
		end

	generate_ne is
			-- Generate `/=' operator.
		deferred
		end

	generate_shl is
			-- Generate `|<<' operator (shift left)
		deferred
		end

	generate_shr is
			-- Generate `|>>' operator (shift right)
		deferred
		end

feature -- Unary operator generation

	generate_uplus is
			-- Generate '+' operator.
		deferred
		end

	generate_uminus is
			-- Generate '-' operator.
		deferred
		end

	generate_not is
			-- Generate 'not' operator.
		deferred
		end

	generate_bitwise_not is
			-- Generate `bitwise not' operator
		deferred
		end
		
feature -- Basic feature

	generate_max (type_id: INTEGER) is
			-- Generate `max' on basic types.
		require
			valid_type_id: type_id > 0
		deferred
		end

	generate_min (type_id: INTEGER) is
			-- Generate `min' on basic types.
		require
			valid_type_id: type_id > 0
		deferred
		end

	generate_abs (type_id: INTEGER) is
			-- Generate `abs' on basic types.
		require
			valid_type_id: type_id > 0
		deferred
		end

	generate_to_string is
			-- Generate call on `ToString'.
		deferred
		end
		
feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate `file_name' and `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		deferred
		end

feature -- Compilation error handling

	last_error: STRING is
			-- Last exception which occurred during IL generation
		deferred
		end

end -- class IL_CODE_GENERATOR_I
