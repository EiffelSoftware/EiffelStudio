indexing
	description: "Generation of IL code using a bridge pattern."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_CODE_GENERATOR

inherit
	IL_CONST

	SHARED_IL_CONSTANTS

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		end
		
	SHARED_AST_CONTEXT
		rename
			context as ast_context
		export
			{NONE} all
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end
		
	SHARED_GENERATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		do
		end

feature -- Access

	is_frozen_class: BOOLEAN
			-- Is current class a SPECIAL one?

	current_class_type: CLASS_TYPE
			-- Currently class type being handled.

	internal_duplicate_rout_id, internal_finalize_rout_id: INTEGER
			-- Routine ID of `internal_duplicate' and `finalize' from ANY.
	
	last_parents: ARRAY [INTEGER]
			-- List of parents last described after call to `update_parents'.

	output_file_name: FILE_NAME
			-- File where assembly is stored.

feature -- Access

	current_type_id: INTEGER
			-- Type_id of class being analyzed.

	current_class: CLASS_C
			-- Current class being treated.

	runtime_type_id: INTEGER
			-- Identifier for class ISE.Runtime.TYPE.

	class_type_id: INTEGER
			-- Identifier for class ISE.Runtime.CLASS_TYPE.

	basic_type_id: INTEGER
			-- Identifier for class ISE.Runtime.BASIC_TYPE.

	generic_type_id: INTEGER
			-- Identifier for class ISE.Runtime.GENERIC_TYPE.
			
	formal_type_id: INTEGER
			-- Identifier for class ISE.Runtime.FORMAL_TYPE.
			
	none_type_id: INTEGER
			-- Identifier for class ISE.Runtime.NONE_TYPE.

	eiffel_type_info_type_id: INTEGER
			-- Identifier for class ISE.Runtime.EIFFEL_TYPE_INFO.

	generic_conformance_type_id: INTEGER
			-- Identifier for class ISE.Runtime.GENERIC_CONFORMANCE.

	once_generation: BOOLEAN
			-- Are we currently generating a once feature?

feature {IL_CODE_GENERATOR} -- Access

	is_console_application: BOOLEAN
			-- Is current a console application?
			
	is_dll: BOOLEAN
			-- Is current generated as a DLL?

	is_verifiable: BOOLEAN
			-- Does code generation has to be verifiable?

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information?
			
	is_cls_compliant: BOOLEAN
			-- Does code generation generate CLS compliant code?
			
	any_type_id, object_type_id: INTEGER
			-- Type id of ANY and SYSTEM_OBJECT class.

	local_count: INTEGER
			-- Number of meaningful local variables.

feature {NONE} -- Once per type definition

	current_class_token: INTEGER
			-- Token of current class being generated.

feature -- Settings

	set_current_class_type (cl_type: like current_class_type) is
			-- Set `current_class_type' to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
			current_class_type := cl_type
		ensure
			current_class_type_set: current_class_type = cl_type
		end

	set_current_class (cl: like current_class) is
			-- Set `current_class' to `cl'.
		require
			cl_not_void: cl /= Void
		do
			current_class := cl
		ensure
			current_class_set: current_class = cl
		end

	set_current_type_id (an_id: like current_type_id) is
			-- Set `current_type_id' to `an_id'.
		require
			valid_id: an_id > 0
		do
			current_type_id := an_id
		ensure
			current_type_id_set: current_type_id = an_id
		end

	set_runtime_type_id (an_id: like runtime_type_id) is
			-- Set `an_id' to `runtime_type_id'.
		require
			valid_id: an_id > 0
		do
			runtime_type_id := an_id
		ensure
			runtime_type_id_set: runtime_type_id = an_id
		end
		
	set_class_type_id (an_id: like class_type_id) is
			-- Set `an_id' to `class_type_id'.
		require
			valid_id: an_id > 0
		do
			class_type_id := an_id
		ensure
			class_type_id_set: class_type_id = an_id
		end
		
	set_generic_type_id (an_id: like generic_type_id) is
			-- Set `an_id' to `generic_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_type_id := an_id
		ensure
			generic_type_id_set: generic_type_id = an_id
		end
		
	set_formal_type_id (an_id: like formal_type_id) is
			-- Set `an_id' to `formal_type_id'.
		require
			valid_id: an_id > 0
		do
			formal_type_id := an_id
		ensure
			formal_type_id_set: formal_type_id = an_id
		end
		
	set_none_type_id (an_id: like none_type_id) is
			-- Set `an_id' to `none_type_id'.
		require
			valid_id: an_id > 0
		do
			none_type_id := an_id
		ensure
			none_type_id_set: none_type_id = an_id
		end

	set_eiffel_type_info_type_id (an_id: like eiffel_type_info_type_id) is
			-- Set `an_id' to `eiffel_type_info_type_id'.
		require
			valid_id: an_id > 0
		do
			eiffel_type_info_type_id := an_id
		ensure
			eiffel_type_info_type_id_set: eiffel_type_info_type_id = an_id
		end
		
	set_basic_type_id (an_id: like basic_type_id) is
			-- Set `an_id' to `basic_type_id'.
		require
			valid_id: an_id > 0
		do
			basic_type_id := an_id
		ensure
			basic_type_id_set: basic_type_id = an_id
		end

	set_generic_conformance_type_id (an_id: like generic_conformance_type_id) is
			-- Set `an_id' to `generic_conformance_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_conformance_type_id := an_id
		ensure
			generic_conformance_type_id_set: generic_conformance_type_id = an_id
		end

	set_once_generation (v: BOOLEAN) is
			-- Set `once_generation' to `v'.
		do
			once_generation := v
		ensure
			once_generation_set: once_generation = v
		end

	set_any_type_id (an_id: INTEGER) is
		require
			valid_id: an_id > 0
		do
			any_type_id := an_id
		ensure
			any_type_id_set: any_type_id = an_id
		end

	set_object_type_id (an_id: INTEGER) is
		require
			valid_id: an_id > 0
		do
			object_type_id := an_id
		ensure
			object_type_id_set: object_type_id = an_id
		end

feature -- Generation Structure

	start_assembly_generation (assembly_name, a_file_name, location: STRING) is
			-- Create Assembly with `name'.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		do
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
			-- In debug mode if `debug_mode' is true.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
		end

	define_entry_point (creation_type_id, a_type_id: INTEGER; a_feature_id: INTEGER) is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_type_id'.
		require
			positive_creation_type_id: creation_type_id > 0
			positive_type_id: a_type_id > 0
			positive_feature_id: a_feature_id > 0
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
		require
			valid_build: build >= 0
			valid_major: major >= 0
			valid_minor: minor >= 0
			valid_revision: revision >= 0
		do
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
		end

	set_cls_compliant (cls_compliant: BOOLEAN) is
			-- Mark current generation to generate cls_compliant code.
		do
		end

feature -- Class info

	start_class_mappings (class_count: INTEGER) is
			-- Following calls to current will only be `generate_class_mappings'.
		do
		end

	clean_implementation_class_data is
			-- Clean current class implementation data.
		require
			current_type_id_set: current_type_id > 0
		do
		end

	generate_type_class_mappings is
			-- Create correspondance between `runtime_type_id' and ISE.Runtime.TYPE.
		require
			runtime_type_id_set: runtime_type_id > 0
		do
		end

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Define all types, both external and eiffel one.
		require
			class_type_not_void: class_type /= Void
		do
		end

	define_default_constructor (class_type: CLASS_TYPE) is
			-- Define default constructor for implementation of `class_type'
		require
			class_type_not_void: class_type /= Void
		do
		end

	define_runtime_features (class_type: CLASS_TYPE) is
			-- Define all features needed by ISE .NET runtime. It generates
			-- `____class_name', `$$____type', `____set_type' and `____type'.
		require
			class_type_not_void: class_type /= Void
		do
		end

	update_parents (class_type: CLASS_TYPE; class_c: CLASS_C) is
			-- Generate ancestors map of `class_c'.
			-- (export status {NONE})
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
		end

feature -- Features info

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
		end

	generate_interface_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
		end

	generate_implementation_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
		end

	generate_feature (feat: FEATURE_I; in_interface, is_static, is_override: BOOLEAN) is
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		do
		end

	argument_actual_type (a_type: TYPE_I): TYPE_I is
			-- Compute real type of Current.
		require
			a_type_not_void: a_type /= Void
		do
		ensure
			valid_result: Result /= Void
		end

	generate_type_features (feats: HASH_TABLE [TYPE_FEATURE_I, INTEGER]; class_id: INTEGER) is
			-- Generate all TYPE_FEATURE_I that must be generated in
			-- interface corresponding to class ID `class_id'.
		require
			feats_not_void: feats /= Void
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

	generate_feature_ca (a_feature_id: INTEGER) is
			-- No description available.
			-- `a_feature_id' [in].  
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

	add_catyped_arg (a_value: INTEGER; a_type_id: INTEGER) is
			-- No description available.
			-- `a_value' [in].  
			-- `a_type_id' [in].  
		do
		end
		
feature -- IL Generation

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			eiffel_class: not class_c.is_external
		deferred
		end

	generate_feature_il (feat, orig: FEATURE_I; a_type_id, code_feature_id: INTEGER) is
			-- Specifies for which feature `feat' of `feat.feature_id' written in class of
			-- `a_type_id' IL code will be generated. If `a_type_id' is different from current
			-- type id, it means that `a_feature_id' is simply a delegation to a call on
			-- `code_feature_id' defined in `a_type_id': call to static version of feature if
			-- not `imp_inherited'.
		require
			feature_not_void: feat /= Void
			positive_type_id: a_type_id > 0
			positive_code_feature_id: code_feature_id > 0
		do
		end

	generate_feature_code (feat: FEATURE_I) is
			-- Generate IL code for feature `feat'.
		require
			feat_not_void: feat /= Void
		do
		end

	generate_feature_internal_duplicate (feat: FEATURE_I) is
			-- Generate IL code for feature `internal_duplicate' from ANY.
		require
			feat_not_void: feat /= Void
		do
		end

	generate_object_equality_test is
			-- Generate comparison of two objects.
		do
		end

	generate_finalize_feature (feat: FEATURE_I) is
			-- Generate `Finalize' that calls `finalize' definition from ANY.
		require
			feat_not_void: feat /= Void
		do
		end

	start_new_body (method_token: INTEGER) is
			-- Start a new body definition for method `method_token'.
		require
			valid_method_token: method_token /= 0
		do
		end

	last_override_token: INTEGER
			-- Token of last defined override feature.

	override_counter: COUNTER
			-- Number of generated override methods.

	generate_method_impl (cur_feat: FEATURE_I; parent_type: CLASS_TYPE; inh_feat: FEATURE_I) is
			-- Generate a MethodImpl from `parent_type' and `inh_feat'
			-- to `current_class_type' and `cur_feat'.
		require
			cur_feat_not_void: cur_feat /= Void
			parent_type_not_void: parent_type /= Void
			inh_feat_not_void: inh_feat /= Void
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		require
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			valid_external_type: valid_type (ext_kind)
		do
		end

	internal_generate_external_call (an_assembly_token, a_type_token: INTEGER; base_name: STRING;
			member_name: STRING; ext_kind: INTEGER;
			parameters_string: ARRAY [STRING]; return_type: STRING;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `member_name' with signature `parameters_type' + `return_type'.
		require
			valid_external_type: valid_type (ext_kind)
		do
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER) is
			-- Set `local_count' to `a_count'.
		require
			valid_count: a_count >= 0
		do
		ensure
			local_count_set: local_count = a_count
		end

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		require
			type_i_not_void: type_i /= Void
		do
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
		end

feature -- Object creation

	create_object (a_type_id: INTEGER) is
			-- Create object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
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

	generate_attribute_access (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate direct access to attribute of `a_feature_id' in implementation `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			
		end

	generate_attribute (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	generate_feature_access (type_i: TYPE_I; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	internal_generate_feature_access (a_type_id, a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `a_type_id'.
		require
			positive_type_id: a_type_id > 0
			positive_feature_id: a_feature_id > 0
		do
		end

	generate_precursor_feature_access (type_i: TYPE_I; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	put_type_token (a_type_id: INTEGER) is
			-- Put token associated to `a_type_id' on stack.
		do
		end

	put_method_token (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		require
			valid_n: n >= 0
		do
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		do
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		require
			type_i_not_void: type_i /= Void
		do
		end


	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			type_i_not_void: type_i /= Void
		do
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		require
			valid_n: n >= 0
		do
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		require
			valid_n: n >= 0
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

	generate_routine_address (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address of routine of `a_feature_id' in class `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	generate_load_from_address (a_type: TYPE_I) is
			-- Load value of `a_type' type from address pushed on stack.
		require
			type_not_void: a_type /= Void
		do
		end

feature -- Assignments

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		require
			type_i_not_void: type_i /= Void
		do
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		require
			target_type_not_void: target_type /= Void
		do
		end

	generate_cast_to_implementation (target_type: TYPE_I) is
			-- Generate `cast' to implementation of `target_type'.
		require
			target_type_not_void: target_type /= Void
		do
		end

	generate_attribute_assignment (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		do
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
		end

feature -- Conversion

	convert_to (type: TYPE_I) is
			-- Convert top of stack into `type'.
		require
			type_not_void: type /= Void
			type_is_basic: type.is_basic
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
		
	convert_to_double is
			-- Convert top of stack into appropriate type.
		do
		end
		
	convert_to_real is
			-- Convert top of stack into appropriate type.
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

	done_token, result_token: INTEGER
			-- Token for static fields holding value if once has been computed,
			-- and its value if computed.

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
		end

	generate_once_result_info (name: STRING; type_i: TYPE_I) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_i'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			type_i: type_i /= Void
		do
		end

	generate_once_computed is
			-- Mark current once as being computed.
		do
		end

	generate_once_result_address is
			-- Generate test on `done' of once feature `name'.
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
			-- Generate call to `item' of NATIVE_ARRAY.
		do
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of NATIVE_ARRAY.
		do
		end

	generate_array_creation (a_type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
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

	rescue_label: INTEGER
			-- Label used for rescue clauses to mark end of `try-catch'.
			
	generate_start_exception_block is
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause.
		do
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: IL_LABEL) is
			-- Check if assertions are already being checked,
			-- in that case we need to skip the assertion block.
		require
			end_of_assert_label_not_void: end_of_assert /= Void
		do
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag to True.
		do
		end

	generate_restore_assertion_status is
			-- Set `in_assertion' flag to False.
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

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call
		require
			type_i_not_void: type_i /= Void
		do
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		require
			type_not_void: type /= Void
		do
		end

	put_void is
			-- Add a Void element on stack.
		do
		end
		
	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		do
		end

	put_system_string (s: STRING) is
			-- Put `System.String' object corresponding to `s' on IL stack.
		require
			valid_s: s /= Void
		do
		end

	put_integer_constant (type: TYPE_I; i: INTEGER) is
			-- Put `i' as integer constant of type `type'.
		require
			type_not_void: type /= Void 
			type_is_long: type.is_long
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

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			label_not_void: label /= Void
		do
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			label_not_void: label /= Void
		do
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		require
			label_not_void: label /= Void
		do
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		require
			label_not_void: label /= Void
		do
		end

	create_label: IL_LABEL is
			-- Create a new label
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
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
		end

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
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
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
		end
		
feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		require
			valid_n: n > 0
		do
		end

	put_debug_info (location: TOKEN_LOCATION) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		require
			location_not_void: location /= Void
		do
		end

feature -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation

feature -- Convenience

	implemented_type (implemented_in: INTEGER; current_type: CL_TYPE_I): CL_TYPE_I is
			-- Return static_type_id of class that defined `feat'.
		require
			valid_implemented_in: implemented_in > 0
			current_type_not_void: current_type /= Void
		do
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n >= 0
		do
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			gen_type_not_void: gen_type /= Void
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
		
feature {NONE} -- Implementation: generation

	generate_type_feature (a_type_feature: TYPE_FEATURE_I) is
			-- Generate type description for `a_type_feature'.
		require
			a_type_feature_not_void: a_type_feature /= Void
		do
		end
	
feature {IL_CODE_GENERATOR} -- Implementation: convenience

	System_string_type: TYPE_I is
			-- Type of string object
		once
			Result := System.system_string_class.compiled_class.types.first.type
		end

	String_type: TYPE_I is
			-- Type of string object
		once
			Result := System.string_class.compiled_class.types.first.type
		end
		
	String_implementation_id: INTEGER is
			-- Type ID of string implementation.
		once
			Result := String_type.implementation_id
		end

	String_type_id: INTEGER is
			-- Type of string interface.
		once
			Result := String_type.static_type_id
		end
		
	String_make_feat_id: INTEGER is
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_class.compiled_class.
				feature_table.item_id (feature {PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		end

feature {NONE} -- Constants

	runtime_namespace: STRING is "ISE.Runtime"
	type_class_name: STRING is "ISE.Runtime.TYPE"
	type_array_class_name: STRING is "ISE.Runtime.TYPE[]"
	generic_type_class_name: STRING is "ISE.Runtime.GENERIC_TYPE"
	basic_type_class_name: STRING is "ISE.Runtime.BASIC_TYPE"
	class_type_class_name: STRING is "ISE.Runtime.CLASS_TYPE"
	formal_type_class_name: STRING is "ISE.Runtime.FORMAL_TYPE"
	none_type_class_name: STRING is "ISE.Runtime.NONE_TYPE"
	generic_conformance_class_name: STRING is "ISE.Runtime.GENERIC_CONFORMANCE"
	type_info_class_name: STRING is "ISE.Runtime.EIFFEL_TYPE_INFO"
	integer_32_class_name: STRING is "System.Int32"
	type_handle_class_name: STRING is "System.RuntimeTypeHandle"

	override_prefix: STRING is "__"
	setter_prefix: STRING is "_set_"
			-- Prefix for automatically generated features.

feature {NONE} -- Mapping between Eiffel compiler and generated tokens

	class_mapping: ARRAY [INTEGER]
			-- Array of type token indexed by their `type_id'.

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
			check
				not_callable: False
			end
		end
	
end -- class IL_CODE_GENERATOR
