indexing
	description: "Automatically generated class to access COM+ runtime and Reflection.Emit"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_IL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR_I
		redefine
			start_parents_list,
			start_arguments_list,
			end_arguments_list
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization of current object.
		do
		end

feature -- Generation Structure

	generate_key is
		do
		end

	start_assembly_generation (name, file_name, location: STRING) is
			-- Create Assembly with `name'.
		do
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		do
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
		do
		end

	define_entry_point (type_id: INTEGER; feature_id: INTEGER) is
			-- Define entry point for IL component from `feature_id' in
			-- class `type_id'.
		do
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		do
		end

	end_module_generation is
			-- Finish creation of current module.
		do
		end

feature -- Class info

	generate_class_mappings (class_name: STRING; id: INTEGER; filename: STRING) is
			-- Create a correspondance table between `id' and `class_name'.
		do
		end

	generate_array_class_mappings (class_name, element_type_name: STRING; id: INTEGER) is
			-- Create a correspondance table between `id' and `class_name'.
		do
		end

	start_class_description is
			-- Following calls to current will only describe parents and features of current class.
		do
		end

	generate_class_header (is_interface, is_deferred, is_expanded, is_external: BOOLEAN; type_id: INTEGER) is
			-- Generate class name and its specifier.
		do
		end

	end_class is
			-- Finish description of current class structure.
		do
		end

	start_parents_list is
			-- Starting inheritance part description
		do
		end

	add_to_parents_list (type_id: INTEGER) is
			-- Add class `name' into list of parents of current type.
		do
		end

	end_parents_list is
			-- Finishing inheritance part description
		do
		end
	
feature -- Features info

	start_features_list (type_id: INTEGER) is
			-- Starting enumeration of features written in current class.
		do
		end

	start_feature_description (count: INTEGER) is
			-- Start description of a feature of current class.
		do
		end

	create_feature_description is
			-- End description of a feature of current class.
		do
		end

	check_renaming is
			-- Check renaming for current feature and class.
		do
		end

	check_renaming_and_redefinition is
			-- Check covariance for current feature and class.
		do
		end

	end_features_list is
			-- Finishing enumeration of features written in current class.
		do
		end

	generate_feature_nature (is_redefined, is_deferred, is_frozen, is_attribute: BOOLEAN) is
			-- Generate nature of current feature.
		do
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER; routine_ids: ARRAY [INTEGER]; in_current_class: BOOLEAN; written_type_id: INTEGER) is
			-- Generate feature name.
		do
		end

	generate_external_identification (name, il_name: STRING; ext_kind, feature_id, rout_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [STRING]; return_type: STRING) is
			-- Generate feature identification.
		do
		end

	generate_deferred_external_identification (name: STRING; feature_id, rout_id, written_type_id: INTEGER) is
			-- Generate feature name.
		do
		end

	generate_feature_return_type (type_id: INTEGER) is
			-- Generate return type `type_id' of current feature.
		do
		end

	start_arguments_list (count: INTEGER) is
			-- Start declaration of arguments list of `count' size of current feature.
		do
		end

	generate_feature_argument (name: STRING; type_id: INTEGER) is
			-- Generate argument `name' of type `type_a'.
		do
		end

	end_arguments_list is
			-- End declaration of arguments list of current feature.
		do
		end

feature -- Custom attribute

	add_ca (target_type_id: INTEGER; attribute_type_id: INTEGER; arg_count: INTEGER) is
			-- No description available.
			-- `target_type_id' [in].  
			-- `attribute_type_id' [in].  
			-- `arg_count' [in].  
		do
		end

	generate_class_ca is
			-- No description available.
		do
		end

	generate_feature_ca (feature_id: INTEGER) is
			-- No description available.
			-- `feature_id' [in].  
		do
		end

	add_cainteger_arg (a_value: INTEGER) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_castring_arg (a_value: STRING) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_careal_arg (a_value: REAL) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_cadouble_arg (a_value: DOUBLE) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_cacharacter_arg (a_value: CHARACTER) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_caboolean_arg (a_value: BOOLEAN) is
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_caarray_integer_arg (a_value: ARRAY [INTEGER]) is
			-- Add custom attribute constructor integer array argument `a_value'.
		do
		end

	add_caarray_string_arg (a_value: ARRAY [STRING]) is
			-- Add custom attribute constructor string array argument `a_value'.
		do
		end

	add_caarray_real_arg (a_value: ARRAY [REAL]) is
			-- Add custom attribute constructor real array argument `a_value'.
		do
		end

	add_caarray_double_arg (a_value: ARRAY [DOUBLE]) is
			-- Add custom attribute constructor double array argument `a_value'.
		do
		end

	add_caarray_character_arg (a_value: ARRAY [CHARACTER]) is
			-- Add custom attribute constructor character array argument `a_value'.
		do
		end

	add_caarray_boolean_arg (a_value: ARRAY [BOOLEAN]) is
			-- Add custom attribute constructor boolean array argument `a_value'.
		do
		end

	add_catyped_arg (a_value: INTEGER; type_id: INTEGER) is
			-- No description available.
			-- `a_value' [in].  
			-- `type_id' [in].  
		do
		end
		
feature -- IL Generation

	start_il_generation (type_id: INTEGER) is
		do
		end

	generate_feature_il (feature_id: INTEGER) is
			-- Start il generation for feature `feature_id' of class `class_id'.
		do
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Start il generation for creation feature `feature_id' of class `class_id'.
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER; parameters_type: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN; type_id: INTEGER; feature_id: INTEGER) is
			-- Generate call to `name' with signature `parameters_type'.
		do
		end

feature -- Local variable info generation

	put_result_info (type_id: INTEGER) is
			-- Specifies `type_id' of type of result.
		do
		end

	put_local_info (type_id: INTEGER; name: STRING) is
			-- Specifies `type_id' of type local.
		do
		end

feature -- Object creation

	create_like_current_object is
			-- Create object of same type as current object.
		do
		end

	create_object (type_id: INTEGER) is
			-- Create object of `type_id'.
		do
		end

	create_attribute_object (type_id, feature_id: INTEGER) is
			-- Create object of `type_id'.
		do
		end

	mark_creation_routines (feature_ids: ARRAY [INTEGER]) is
			-- Mark routines of `feature_ids' in Current class as creation
			-- routine of Current class.
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

	generate_result is
			-- Generate access to `Result'.
		do
		end

	generate_attribute (type_id, feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_id'.
		do
		end

	generate_feature_access (type_id, feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_id'.
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

	generate_metamorphose (type_id: INTEGER) is
			-- Generate `metamorphose', ie boxing a basic type of `type_id' into its
			-- corresponding reference type.
		do
		end

	generate_unmetamorphose (type_id: INTEGER)  is
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

	generate_attribute_address (type_id, feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_id'.
		do
		end

	generate_routine_address (type_id, feature_id: INTEGER) is
			-- Generate address of routine of `feature_id' in class `type_id'.
		do
		end

	generate_load_from_address (type_id: INTEGER) is
			-- Load value of `type_i' type from address pushed on stack.
		do
		end

feature -- Assignments

	generate_is_instance_of (type_id: INTEGER) is
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_check_cast (source_type_id, target_type_id: INTEGER) is
			-- Generate `checkcast' byte code instruction.
		do
		end	
	
	generate_attribute_assignment (feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
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

feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		do
		end

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		do
		end

feature -- Once management

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		do
		end

	generate_once_result_info (name: STRING; type_id: INTEGER) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_id'.
		do
		end

	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		do
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		do
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of ARRAY.
		do
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of ARRAY.
		do
		end

	generate_array_creation (type_id: INTEGER) is
		do
		end

	generate_array_count is
		do
		end

	generate_array_upper is
		do
		end

	generate_array_lower is
		do
		end

feature --- Rescue

	generate_start_exception_block is
		do
		end

	generate_start_rescue is
		do
		end

	generate_end_exception_block is
		do
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: INTEGER) is
		do
		end

	generate_set_assertion_status is
		do
		end

	generate_restore_assertion_status is
		do
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
		do
		end

	generate_precondition_violation is
		do
		end

	generate_precondition_check (tag: STRING; labelID: INTEGER) is
		do
		end

	generate_invariant_checking (type_id: INTEGER) is
		do
		end

	mark_invariant (feature_id: INTEGER) is
		do
		end

feature -- Constants generation

	put_void is
			-- Put `Void' on IL stack.
		do
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		do
		end

	put_integer32_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		do
		end

	put_double_constant (d: DOUBLE) is
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

	branch_on_true (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
		end

	branch_on_false (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
		end

	branch_to (label: INTEGER) is
			-- Generate a branch instruction to `label'.
		do
		end

	mark_label (label: INTEGER) is
			-- Mark a portion of code with `label'.
		do
		end

	create_label: INTEGER is
			-- Create a new label.
		do
		end

feature -- Binary operator generation

	generate_lt is
			-- Generate `<' operator.
		do
		end

	generate_le is
			-- Generate `<=' operator.
		do
		end
		
	generate_gt is
			-- Generate `>' operator.
		do
		end
		
	generate_ge is
			-- Generate `>=' operator.
		do
		end

	generate_star is
			-- Generate `*' operator.
		do
		end

	generate_slash is
			-- Generate `/' operator.
		do
		end

	generate_power is
			-- Generate `^' operator.
		do
		end

	generate_plus is
			-- Generate `+' operator.
		do
		end

	generate_mod is
			-- Generate `\\' operator.
		do
		end

	generate_minus is
			-- Generate `-' operator.
		do
		end

	generate_div is
			-- Generate `//' operator.
		do
		end

	generate_xor is
			-- Generate `xor' operator.
		do
		end

	generate_or is
			-- Generate `or' and `or else' operator.
		do
		end

	generate_and is
			-- Generate `and' and `and then' operator.
		do
		end

	generate_implies is
			-- Generate `implies operator.
		do
		end

	generate_eq is
			-- Generate `=' operator.
		do
		end

	generate_ne is
			-- Generate `/=' operator.
		do
		end

	generate_shl is
			-- Generate `|<<' operator (shift left)
		do
		end

	generate_shr is
			-- Generate `|>>' operator (shift right)
		do
		end

feature -- Unary operator generation

	generate_uplus is
			-- Generate '+' operator.
		do
		end

	generate_uminus is
			-- Generate '-' operator.
		do
		end

	generate_not is
			-- Generate 'not' operator.
		do
		end

feature -- Line Info for debugging

	put_line_info (n: INTEGER) is
			-- Generate `file_name' and `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		do
		end

feature -- Compilation error handling

	last_error: STRING is
			-- Last exception which occurred during IL generation
		do
			Result := ""
		end

feature {NONE} -- Formatting

	to_upper (s: STRING): STRING is
			-- Uppercase version of `s'.
		do
		end

	to_lower (s: STRING): STRING is
			-- Lowercase version of `s'.
		do
		end

feature {NONE} -- Internal data

	classes_name: ARRAY [STRING]
			-- Manage correspondance between a class name and its ID.

	features_list: ARRAY [ARRAY [STRING]]
			-- Manage correspondance between a class and its feature list ordered
			-- following their `feature_id'.

	need_semicolon: BOOLEAN
			-- Manage the display of `;' between arguments of feature.

	current_type_id: INTEGER
			-- Type id of class being generated.

	counter: COUNTER is
			-- Counter for labels
		once
			create Result
		end

end -- class COM_IL_CODE_GENERATOR
