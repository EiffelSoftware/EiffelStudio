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

feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		do
			internal_duplicate_rout_id := System.any_class.compiled_class.feature_table.item_id (
				feature {PREDEFINED_NAMES}.Internal_duplicate_name_id).rout_id_set.first
			internal_finalize_rout_id := System.any_class.compiled_class.feature_table.item_id (
				feature {PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
		end

feature {NONE} -- Access

	meta_data_generator: IL_META_DATA_GENERATOR
			-- Access to generate metadata.

	is_frozen_class: BOOLEAN
			-- Is current class a SPECIAL one?

	current_class_type: CLASS_TYPE
			-- Currently class type being handled.

	internal_duplicate_rout_id, internal_finalize_rout_id: INTEGER
			-- Routine ID of `internal_duplicate' and `finalize' from ANY.
			
feature -- Access

	is_for_interfaces: BOOLEAN
			-- Is current mode set for generating interfaces?

	type_id: INTEGER
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

	once_generation: BOOLEAN
			-- Are we currently generating a once feature?

feature -- Settings

	set_type_id (an_id: like type_id) is
			-- Set `an_id' to `type_id'.
		require
			valid_id: an_id > 0
		do
			type_id := an_id
		ensure
			type_id_set: type_id = an_id
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

	set_meta_data_generator (il_md_gen: IL_META_DATA_GENERATOR) is
			-- Set `meta_data_generator' to `il_md_gen'.
		do
			meta_data_generator := il_md_gen
		ensure
			meta_data_generator_set: meta_data_generator = il_md_gen
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
			implementation.set_any_type_id (an_id)
		end

feature -- Target of generation

	set_for_interfaces is
			-- Set generation mode for `interfaces'.
		do
			is_for_interfaces := True
			implementation.set_for_interfaces
		end

	set_for_implementations is
			-- Set generation mode for `implementations'.
		do
			is_for_interfaces := False
			implementation.set_for_implementations
		end

feature -- States

	assembly_generation_started: BOOLEAN
			-- Was assembly generation started?

	module_generation_started: BOOLEAN
			-- Was module generation started?

	class_mappings_started: BOOLEAN
			-- Was class mappings generation started?

	class_descriptions_generation_started: BOOLEAN
			-- Was classes generation started?

	parents_list_generation_started: BOOLEAN
			-- Was generation of parents list started?

	features_list_generation_started: BOOLEAN
			-- Was generation of features list started?

	feature_description_generation_started: BOOLEAN
			-- Was feature generation started?

	arguments_list_generation_started: BOOLEAN
			-- Was arguments list generation started?

	il_generation_started: BOOLEAN
			-- Was IL generation started?

feature -- Generation settings

	set_java_generation is
			-- Create an implementation object that will generate java byte code
		do
			check
				False
			end
		end

	set_msil_generation is
			-- Create an implementation object that will generate MSIL byte code
		local
			imp: COM_IL_CODE_GENERATOR
		do
			create imp.make
			imp.generate_key (System.in_final_mode)
			implementation := imp
		end

feature -- Generation Structure

	start_assembly_generation (assembly_name, file_name, location: STRING) is
			-- Create Assembly with `name'.
		require
			not_started: not assembly_generation_started
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		do
			implementation.start_assembly_generation (assembly_name, file_name, location)
			assembly_generation_started := True
		ensure
			assembly_generation_started: assembly_generation_started
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		require
			assembly_generation_started: assembly_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			implementation.add_assembly_reference (name)
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
			-- In debug mode if `debug_mode' is true.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			assembly_generation_started: assembly_generation_started
			module_generation_not_started: not module_generation_started
		do
			implementation.start_module_generation (name, debug_mode)
			module_generation_started:= True
		ensure
			module_generation_started: module_generation_started
		end

	define_entry_point (creation_type_id, a_type_id: INTEGER; feature_id: INTEGER) is
			-- Define entry point for IL component from `feature_id' in
			-- class `a_type_id'.
		require
			positive_creation_type_id: creation_type_id > 0
			positive_type_id: a_type_id > 0
			positive_feature_id: feature_id > 0
		do
			implementation.define_entry_point (creation_type_id, a_type_id, feature_id)
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		require
			started: assembly_generation_started
		do
			implementation.end_assembly_generation
			assembly_generation_started := False
		ensure
			finished: not assembly_generation_started
		end

	end_module_generation is
			-- Finish creation of current module.
		require
			assembly_generation_started: assembly_generation_started
		do
			implementation.end_module_generation
			module_generation_started := False
		ensure
			module_generation_finished: not module_generation_started
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		do
			implementation.set_console_application
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		do
			implementation.set_window_application
		end

	set_dll is
			-- Current generated application is a DLL.
		do
			implementation.set_dll
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
			implementation.set_version (build, major, minor, revision)
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
			implementation.set_verifiability (verifiable)
		end

	set_cls_compliant (cls_compliant: BOOLEAN) is
			-- Mark current generation to generate cls_compliant code.
		do
			implementation.set_cls_compliant (cls_compliant)
		end

feature -- Class info

	start_class_mappings (class_count: INTEGER) is
			-- Following calls to current will only be `generate_class_mappings'.
		require
			module_generation_started: module_generation_started
		do
			implementation.start_class_mappings (class_count)
			class_mappings_started := True
		ensure
			class_mappings_started: class_mappings_started
		end

	generate_class_mappings (il_name, class_name: STRING;
			id, interface_id: INTEGER; filename, element_type: STRING)
		is
			-- Create a correspondance table between `id' and `class_name'.
			-- `filename' is the path to the source file of `class_name'
		require
			class_mappings_started: class_mappings_started
			il_name_not_void: il_name /= Void
			il_name_not_empty: not il_name.is_empty
			class_name_not_void: class_name /= Void
			class_name_not_empty: not class_name.is_empty
			id_positive: id > 0
			interface_id_positive: interface_id > 0
			non_void_filename: filename /= Void
			element_type_not_void: element_type /= Void
		do
			implementation.generate_class_mappings (il_name, class_name, id,
				interface_id, filename, element_type)
		end

	generate_type_class_mappings is
			-- Create correspondance between `type_id' and ISE.Runtime.TYPE.
		require
			type_id_set: type_id > 0
		do
			implementation.generate_type_class_mapping (type_id)
			implementation.generate_class_type_class_mapping (class_type_id)
			implementation.generate_basic_type_class_mapping (basic_type_id)
			implementation.generate_generic_type_class_mapping (generic_type_id)
			implementation.generate_formal_type_class_mapping (formal_type_id)
			implementation.generate_none_type_class_mapping (none_type_id)
			implementation.generate_eiffel_type_info_type_class_mapping (eiffel_type_info_type_id)
		end
		
	start_classes_descriptions is
			-- Following calls to current will only describe parents and features of current class.
		require
			module_generation_started: module_generation_started
		do
			implementation.start_classes_descriptions
			class_descriptions_generation_started := True
			class_mappings_started := False
		ensure
			class_descriptions_generation_started: class_descriptions_generation_started
			class_mappings_finished: not class_mappings_started
		end

	end_classes_descriptions is
			-- Following calls to current will only describe parents and features of current class.
		require
			class_descriptions_generation_started: class_descriptions_generation_started
		do
			implementation.end_classes_descriptions
			class_descriptions_generation_started:= False
		ensure
			class_descriptions_generation_finished: not class_descriptions_generation_started
		end

	generate_class_header
			(is_interface, is_deferred, is_frozen, is_expanded,
			is_external: BOOLEAN; a_type_id: INTEGER)
		is
			-- Generate class name and its specifier.
 		require
 			class_descriptions_generation_started: class_descriptions_generation_started
			positive_type_id: a_type_id > 0
		do
			implementation.generate_class_header (is_interface, is_deferred, is_frozen,
				is_expanded, is_external, a_type_id)		
		end

	end_class is
			-- Finish description of current class structure.
		require
			il_generation_started: il_generation_started
		do
			implementation.end_class
		end

	start_parents_list is
			-- Starting inheritance part description
		require
			class_descriptions_generation_started: class_descriptions_generation_started
		do
			implementation.start_parents_list
			parents_list_generation_started:= True
		ensure
			parents_list_generation_started: parents_list_generation_started
		end

	add_to_parents_list (a_type_id: INTEGER) is
			-- Add class of `a_type_id' into list of parents of current type.
			-- `start_parents_list' should have been called before.
		require
			parents_list_generation_started: parents_list_generation_started
			positive_type_id: a_type_id > 0
		do
			implementation.add_to_parents_list (a_type_id)
		end

	add_interface (a_type_id: INTEGER) is
			-- Add interface of `a_type_id' into list of parents of current type.
		require
			positive_type_id: a_type_id > 0
		do
			implementation.add_interface (a_type_id)
		end

	set_implementation_class is
			-- Make current generated class an implementation one.
		do
			implementation.set_implementation_class
		end

	end_parents_list is
			-- Finishing inheritance part description
			-- `start_parents_list' should have been called before.
		require
			parents_list_generation_started: parents_list_generation_started
		do
			implementation.end_parents_list
			parents_list_generation_started := False
		ensure
			parents_list_generation_finished: not parents_list_generation_started
		end
	
feature -- Features info

	start_features_list (a_type_id: INTEGER) is
			-- Starting enumeration of features written in current class.
		require
			class_descriptions_generation_started: class_descriptions_generation_started
			positive_type_id: a_type_id > 0
		do
			implementation.start_features_list (a_type_id)
			features_list_generation_started := True
		ensure
			features_list_generation_started: features_list_generation_started
		end

	start_feature_description (arg_count: INTEGER) is
			-- Start description of a feature of current class.
		require
			features_list_generation_started: features_list_generation_started
			arg_count_nonnegative: arg_count >= 0
		do
			implementation.start_feature_description (arg_count)
			feature_description_generation_started := True
		ensure
			feature_description_generation_started: feature_description_generation_started
		end

	create_feature_description is
			-- End description of a feature of current class.
		require
			feature_description_generation_started: feature_description_generation_started
		do
			implementation.create_feature_description
			feature_description_generation_started:= False
		ensure
			feature_description_generation_finished: not feature_description_generation_started
		end

	check_renaming is
			-- Check renaming for current feature and class.
		require
			feature_description_generation_started: feature_description_generation_started
		do
			implementation.check_renaming
		end

	check_renaming_and_redefinition is
			-- Check covariance for current feature and class.
		do
			implementation.check_renaming_and_redefinition
		end

	end_features_list is
			-- Finishing enumeration of features written in current class.
		require
			features_list_generation_started: features_list_generation_started
		do
			implementation.end_features_list
			features_list_generation_started := False
		ensure
			features_list_generation_finished: not features_list_generation_started
		end

	generate_interface_feature_identification (name: STRING; feature_id: INTEGER;
			is_attribute: BOOLEAN)
		is
			-- Generate feature identification for feature located in interface.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
		do
			implementation.generate_interface_feature_identification (name, feature_id, is_attribute)
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER;
			is_redefined, is_deferred, is_frozen, is_attribute, is_c_external, is_static: BOOLEAN)
		is
			-- Generate info about current feature.
		require
			feature_description_generation_started: feature_description_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
			non_deferred_frozen: is_frozen implies not is_deferred
			non_deferred_attribute: is_attribute implies not is_deferred
		do
			implementation.generate_feature_identification (name, feature_id,
				is_redefined, is_deferred, is_frozen, is_attribute, is_c_external, is_static)
		end

	generate_external_identification
			(name: STRING; il_name_id: INTEGER; ext_kind, feature_id, routine_id: INTEGER;
			in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [INTEGER];
			return_type: INTEGER)
		is
			-- Generate feature identification.
		require
			feature_description_generation_started: feature_description_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
			positive_written_type_id: written_type_id > 0
			positive_routine_id: routine_id > 0
			valid_external_type: valid_type (ext_kind)
		do
			implementation.generate_external_identification (
					name, Names_heap.item (il_name_id), ext_kind, feature_id, routine_id,
					in_current_class, written_type_id,
					Names_heap.convert_to_string_array (signature),
					Names_heap.item (return_type))
		end

	generate_deferred_external_identification
			(name: STRING; feature_id, routine_id, written_type_id: INTEGER)
		is
			-- Generate feature identification.
		require
			feature_description_generation_started: feature_description_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feature_id: feature_id > 0
		do
			implementation.generate_deferred_external_identification (name,
					feature_id, routine_id, written_type_id)
		end

	generate_feature_return_type (type_i: TYPE_I) is
			-- Generate return type `type_i' of current feature.
		require
			feature_description_generation_started: feature_description_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_feature_return_type (static_id_of (type_i))
		end
		
	generate_type_info_return_type is
			-- Generate return type of known type `type_id' for Current feature.
		require
			feature_description_generation_started: feature_description_generation_started
		do
			implementation.generate_feature_return_type (type_id)
		end

	start_arguments_list (count: INTEGER) is
			-- Start declaration of arguments list of `count' size of current feature.
		require
			feature_description_generation_started: feature_description_generation_started
		do
			implementation.start_arguments_list (count)
			arguments_list_generation_started:= True
		ensure
			arguments_list_generation_started: arguments_list_generation_started
		end

	generate_feature_argument (name: STRING; type_i: TYPE_I) is
			-- Generate argument `name' of type `type_i'.
		require
			arguments_list_generation_started: arguments_list_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			type_i_not_void: type_i /= Void
		do
			implementation.generate_feature_argument (name, static_id_of (type_i))
		end

	end_arguments_list is
			-- End declaration of arguments list of current feature.
		require
			arguments_list_generation_started: arguments_list_generation_started
		do
			implementation.end_arguments_list
			arguments_list_generation_started := False
		ensure
			arguments_list_generation_finshed: not arguments_list_generation_started
		end

feature -- IL Generation

	start_il_generations is
			-- Start IL code generation.
		require
			classes_descriptions_generation_finished: not class_descriptions_generation_started
		do
			implementation.start_il_generations
			il_generation_started := True
		ensure
			il_generation_started: il_generation_started
		end

	start_il_generation (a_type_id: INTEGER) is
			-- Start code generation on class of type `a_type_id.
		do
			implementation.start_il_generation (a_type_id)
		end

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
			eiffel_class: not class_c.is_external
		deferred
		end

	generate_feature_il (feature_id, a_type_id, code_feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in class of `a_type_id'
			-- IL code will be generated. If `a_type_id' is different from current type id,
			-- it means that `feature_id' is simply a delegation to a call on `code_feature_id'
			-- defined in `a_type_id': call to static version of feature if not `imp_inherited'.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
			positive_type_id: a_type_id > 0
			positive_code_feature_id: code_feature_id > 0
		do
			implementation.generate_feature_il (feature_id, a_type_id, code_feature_id)
		end

	generate_implementation_feature_il (feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in class of `a_type_id'
			-- IL code will be generated.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
		do
			implementation.generate_implementation_feature_il (feature_id)
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Specifies for which creation feature of `feature_id' written in
			-- class of `a_type_id' IL code will be generated.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
		do
			implementation.generate_creation_feature_il (feature_id)
		end

	generate_method_impl (feature_id, parent_type_id, parent_feature_id: INTEGER) is
			-- Generate a MethodImpl from `parent_type_id' and `parent_feature_id'
			-- to `current_class_type' and `feature_id'.
		require
			positive_feature_id: feature_id > 0
			positive_parent_type_id: parent_type_id > 0
			positive_parent_feature_id: parent_feature_id > 0
		do
			implementation.generate_method_impl (feature_id, parent_type_id,
				parent_feature_id)
		end

	generate_creation_routines (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate description for creation routines of `class_c' if any.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			creators: HASH_TABLE [EXPORT_I, STRING]
			feat_tbl: FEATURE_TABLE
			feat: FEATURE_I
			i: INTEGER
		do
			if not class_c.is_external then
				creators := class_c.creators	
				if creators /= Void and then not creators.is_empty then
					from
						creators.start
						feat_tbl := class_c.feature_table
					until
						creators.after
					loop
						feat := feat_tbl.item (creators.key_for_iteration)
						generate_creation_feature_il (feat.feature_id)
						class_type.generate_il_feature (feat)
						creators.forth
						i := i + 1
					end
				end
			end
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
				parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
				is_virtual: BOOLEAN) is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		require
			il_generation_started: il_generation_started
			base_name_not_void: base_name /= Void
			base_name_empty: not base_name.is_empty
			valid_external_type: valid_type (ext_kind)
				-- in case of a creator_type the name seems 
				-- to be Void sometimes !!!
				--			name_not_void: name /= Void
				--			name_empty: not name.is_empty
				--			return_type_not_void: return_type /= Void
				-- same here
			return_type_not_void: True
		do
			implementation.generate_external_call (base_name, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), is_virtual)
		end

feature -- Local variable info generation

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			if not once_generation then
				implementation.put_result_info (static_id_of (type_i))
			end
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.put_local_info (static_id_of (type_i), Names_heap.item (name_id))
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.put_local_info (static_id_of (type_i), "_" + name_id.out)
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.put_local_info (static_id_of (type_i), "_dummy_" + name_id.out)
		end

feature -- Object creation

	create_object (type_i: TYPE_I) is
			-- Create object of `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.create_object (static_id_of (type_i))
		end

	create_like_object is
			-- Create object of same type as object on top of stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_external_call (generic_conformance_class_name,
				"create_like_object", Static_type, <<type_info_class_name>>,
				type_info_class_name,
				False)			
		end

	load_type is
			-- Load on stack type of object on top of stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_external_call (generic_conformance_class_name,
				"load_type_of_object", Static_type, <<type_info_class_name>>,
				type_class_name,
				False)			
		end
		
	create_type is
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_external_call (generic_conformance_class_name,
				"create_type", Static_type, <<type_class_name,
				type_info_class_name>>, type_info_class_name,
				False)			
		end

	create_attribute_object (type_i: TYPE_I; feature_id: INTEGER) is
			-- Create object corresponding to type of `feature_id' in `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.create_attribute_object (static_id_of (type_i), feature_id)
		end

	mark_creation_routines (feature_ids: ARRAY [INTEGER]) is
			-- Mark routines of `feature_ids' in Current class as creation
			-- routine of Current class.
		require
			feature_ids_not_void: feature_ids /= Void
		do
			implementation.mark_creation_routines (feature_ids)
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.duplicate_top
		end

	pop is
			-- Remove top element of IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.pop
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_current
		end

	generate_result is
			-- Generate access to `Result'.
		require
			il_generation_started: il_generation_started
		do
			if once_generation then
				implementation.generate_once_result
			else
				implementation.generate_result
			end
		end

	generate_attribute (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
				-- Attribute are accessed through their encapsulation.
			implementation.generate_attribute (static_id_of (type_i), feature_id)
		end

	generate_feature_access (type_i: TYPE_I; feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_feature_access (static_id_of (type_i), feature_id, True)
		end

	generate_precursor_feature_access (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate access to feature of `feature_id' in `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_precursor_feature_access (implementation_id_of (type_i), feature_id)
		end

	put_method_token (type_i: TYPE_I; feature_id: INTEGER) is
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.put_method_token (static_id_of (type_i), feature_id)
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			implementation.generate_argument (n)
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			implementation.generate_local (n)
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_metamorphose (static_id_of (type_i))
		end


	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_unmetamorphose (static_id_of (type_i))
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			implementation.generate_local_address (n)
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			implementation.generate_argument_address (n)
		end

	generate_current_address is
			-- Generate address of `Current'.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_current_address
		end

	generate_result_address is
			-- Generate address of `Result'.
		require
			il_generation_started: il_generation_started
		do
			if once_generation then
				implementation.generate_once_result_address
			else
				implementation.generate_result_address
			end
		end

	generate_attribute_address (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_attribute_address (static_id_of (type_i), feature_id)
		end

	generate_routine_address (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate address of routine of `feature_id' in class `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_routine_address (static_id_of (type_i), feature_id)
		end

	generate_load_from_address (type_i: TYPE_I) is
			-- Load value of `type_i' type from address pushed on stack.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_load_from_address (static_id_of (type_i))
		end

feature -- Assignments

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_is_instance_of (static_id_of (type_i))
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		require
			il_generation_started: il_generation_started
			source_type_not_void: source_type /= Void
			target_type_not_void: target_type /= Void
			not_expanded_source: not source_type.is_expanded
			not_expanded_target: not target_type.is_expanded
		do
			implementation.generate_check_cast (
				static_id_of (source_type), static_id_of (target_type))
		end

	generate_attribute_assignment (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_attribute_assignment (static_id_of (type_i), feature_id)
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			implementation.generate_local_assignment (n)
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		require
			il_generation_started: il_generation_started
		do
			if once_generation then
				implementation.generate_once_store_result
			else
				implementation.generate_result_assignment
			end
		end

feature -- Conversion

	convert_to (type: TYPE_I) is
			-- Convert top of stack into `type'.
		require
			il_generation_started: il_generation_started
			type_not_void: type /= Void
			type_is_basic: type.is_basic
		local
			int: LONG_I
		do
			if type.is_boolean then
				implementation.convert_to_boolean
			elseif type.is_double then
				implementation.convert_to_double
			elseif type.is_float then
				implementation.convert_to_real
			elseif type.is_long then
				int ?= type
				check
					int_not_void: int /= Void
				end
				inspect int.size
				when 8 then implementation.convert_to_integer8
				when 16 then implementation.convert_to_integer16
				when 32 then implementation.convert_to_integer32
				when 64 then implementation.convert_to_integer64
				end
			elseif type.is_char then
				implementation.convert_to_character
			elseif type.is_feature_pointer then
				implementation.convert_to_native_int
			else
				check
					False
				end
			end
		end

	convert_to_integer_8 is
			-- Convert top of stack into INTEGER_8.
		do
			implementation.convert_to_integer8
		end

	convert_to_integer_16 is
			-- Convert top of stack into INTEGER_16.
		do
			implementation.convert_to_integer16
		end

	convert_to_integer_32 is
			-- Convert top of stack into INTEGER_32.
		do
			implementation.convert_to_integer32
		end

	convert_to_integer_64 is
			-- Convert top of stack into INTEGER_64.
		do
			implementation.convert_to_integer64
		end

	convert_to_real is
			-- Convert top of stack into REAL.
		do
			implementation.convert_to_real
		end

	convert_to_double is
			-- Convert top of stack into DOUBLE.
		do
			implementation.convert_to_double
		end
		
	convert_to_character is
			-- Convert top of stack into CHARACTER.
		do
			implementation.convert_to_character
		end

feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_return
		end

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		require
			il_generation_started: il_generation_started
		do
				-- We do not use implementation directly here, as `generate_result'
				-- has a different behavior depending whether or not we are currently
				-- generating a once function.
			generate_result
			implementation.generate_return
		end

feature -- Once management

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		require
			il_generation_started: il_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			implementation.generate_once_done_info (name)
		end

	generate_once_result_info (name: STRING; type_i: TYPE_I) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_i'.
		require
			il_generation_started: il_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			type_i: type_i /= Void
		do
			implementation.generate_once_result_info (name, static_id_of (type_i))
		end

	generate_once_computed is
			-- Mark current once as being computed.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_once_computed
		end

	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_once_test
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_once_result
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_once_store_result
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of ARRAY.
		require
			il_generation_started: il_generation_started
			valid_kind: valid_type_kind (kind)
		do
			implementation.generate_array_access (kind)
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of ARRAY.
		require
			il_generation_started: il_generation_started
			valid_kind: valid_type_kind (kind)
		do
			implementation.generate_array_write (kind)
		end

	generate_array_creation (a_type_id: INTEGER) is
		require
			il_generation_started: il_generation_started
			positive_type_id: a_type_id > 0
		do
			implementation.generate_array_creation (a_type_id)
		end

	generate_array_count is
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_array_count
		end

	generate_array_upper is
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_array_upper
		end

	generate_array_lower is
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_array_lower
		end

feature -- Exception handling

	generate_start_exception_block is
			-- Mark a certain routine has having a rescue clause.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_start_exception_block
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause in routine.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_start_rescue
		end

	generate_end_exception_block is
			-- Mark end of rescue clause and end of routine.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_end_exception_block
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: IL_LABEL) is
			-- Check if assertions are already being checked,
			-- in that case we need to skip the assertion block.
		require
			il_generation_started: il_generation_started
			end_of_assert_label_not_void: end_of_assert /= Void
		do
			implementation.generate_in_assertion_test (end_of_assert.id)
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag to True.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_set_assertion_status
		end

	generate_restore_assertion_status is
			-- Set `in_assertion' flag to False.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_restore_assertion_status
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		require
			il_generation_started: il_generation_started
		local
			type_assert: STRING
		do
			inspect
				assert_type
			when In_postcondition then
				type_assert := "Postcondition violation: "
			when In_check then
				type_assert := "Check violation: "
			when In_loop_invariant then
				type_assert := "Loop invariant violation: "
			when In_loop_variant then
				type_assert := "Loop variant violation: "
			when In_invariant then
				type_assert := "Invariant violation: "
			end
			implementation.generate_assertion_check (assert_type, type_assert + tag)
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL) is
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_precondition_check ("Precondition violation: " + tag,
					failure_block.id)
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		require
			il_generation_started: il_generation_started
		do
			implementation.generate_precondition_violation
		end

	mark_invariant (feature_id: INTEGER) is
			-- Mark routine `feature_id' in Current class as invariant of Current class.
		require
			positive_feature_id: feature_id > 0
		do
			implementation.mark_invariant (feature_id)
		end

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.generate_invariant_checking (static_id_of (type_i))
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		require
			il_generation_started: il_generation_started
			type_not_void: type /= Void
		local
			int: LONG_I
		do
			if type.is_boolean then
				implementation.put_boolean_constant (False)
			elseif type.is_double then
				implementation.put_double_constant (0.0)
			elseif type.is_float then
				implementation.put_real_constant (0.0)
			elseif type.is_long then
				int ?= type
				check
					int_not_void: int /= Void
				end
				inspect int.size
				when 8 then implementation.put_integer8_constant (0)
				when 16 then implementation.put_integer16_constant (0)
				when 32 then implementation.put_integer32_constant (0)
				when 64 then implementation.put_integer64_constant (0)
				end
			elseif type.is_char then
				implementation.put_character_constant ('%U')
			elseif type.is_feature_pointer then
				implementation.put_integer32_constant (0)
				implementation.convert_to_native_int
			else
				implementation.put_void
			end
		end

	put_void is
			-- Add a Void element on stack.
		do
			implementation.put_void
		end
		
	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			il_generation_started: il_generation_started
			valid_s: s /= Void
		do
			implementation.create_object (String_type_id)
			implementation.duplicate_top
			implementation.put_manifest_string (s)
			implementation.generate_feature_access (String_type_id, String_make_feat_id, True)
		end

	put_integer_constant (type: CL_TYPE_I; i: INTEGER) is
			-- Put `i' as integer constant of type `type'.
		require
			type_not_void: type /= Void 
			type_is_long: type.is_long
		local
			long: LONG_I
		do
			long ?= type
			inspect
				long.size
			when 8 then implementation.put_integer8_constant (i)
			when 16 then implementation.put_integer16_constant (i)
			when 32 then implementation.put_integer32_constant (i)
			when 64 then implementation.put_integer64_constant (i)
			end
		end

	put_integer_8_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_integer8_constant (i)
		end

	put_integer_16_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_integer16_constant (i)
		end

	put_integer_32_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_integer32_constant (i)
		end
		
	put_integer_64_constant (i: INTEGER_64) is
			-- Put `i' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_integer64_constant (i)
		end

	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_double_constant (d)
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_character_constant (c)
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_boolean_constant (b)
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			il_generation_started: il_generation_started
			label_not_void: label /= Void
		do
			implementation.branch_on_true (label.id)
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			il_generation_started: il_generation_started
			label_not_void: label /= Void
		do
			implementation.branch_on_false (label.id)
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		require
			il_generation_started: il_generation_started
			label_not_void: label /= Void
		do
			implementation.branch_to (label.id)
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		require
			il_generation_started: il_generation_started
			label_not_void: label /= Void
		do
			implementation.mark_label (label.id)
		end

	create_label: IL_LABEL is
			-- Create a new label
		require
			il_generation_started: il_generation_started
		do
			create Result.make (implementation.create_label)
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		require
			il_generation_started: il_generation_started
			valid_code: code >= 0 and then code <= 15
		do
			inspect
				code
			when il_le then implementation.generate_le
			when il_lt then implementation.generate_lt
			when il_ge then implementation.generate_ge
			when il_gt then implementation.generate_gt
			when il_star then implementation.generate_star
			when il_power then implementation.generate_power
			when il_plus then implementation.generate_plus
			when il_mod then implementation.generate_mod
			when il_minus then implementation.generate_minus
			when il_div, il_slash then implementation.generate_div
			when il_xor then implementation.generate_xor
			when il_or then implementation.generate_or
			when il_and then implementation.generate_and
			when il_ne then implementation.generate_ne
			when il_eq then implementation.generate_eq
			when il_shl then implementation.generate_shl
			when il_shr then implementation.generate_shr
			end
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		require
			il_generation_started: il_generation_started
			valid_code: code >= 16 and then code <= 18
		do
			inspect
				code
			when il_uplus then -- Nothing to be done here.
			when il_uminus then implementation.generate_uminus
			when il_not then implementation.generate_not
			when il_bitwise_not then implementation.generate_bitwise_not
				
			end
		end

feature -- Basic feature

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
			implementation.generate_max (static_id_of (type))
		end

	generate_min (type: TYPE_I) is
			-- Generate `min' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
			implementation.generate_min (static_id_of (type))
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		do
			implementation.generate_abs (static_id_of (type))
		end

	generate_hash_code is
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
			implementation.convert_to_integer32
			implementation.put_integer32_constant (0x7FFFFFFF)
			implementation.generate_and
		end
		
	generate_out (type: TYPE_I) is
			-- Generate `out' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			local_number: INTEGER
		do
				-- Generate `out' representation in IL format
			generate_metamorphose (type)
			implementation.generate_to_string
			
				-- Store value
			byte_context.add_local (System_string_type)
			local_number := byte_context.local_list.count
			put_dummy_local_info (System_string_type, local_number)
			implementation.generate_local_assignment (local_number)
			
			implementation.create_object (string_type_id)
			implementation.duplicate_top
			implementation.generate_local (local_number)
			implementation.generate_feature_access (string_type_id, string_make_feat_id, True)
		end
		
feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		require
			il_generation_started: il_generation_started
			valid_n: n > 0
		do
			if System.line_generation then
				implementation.put_line_info (n, 0, 1000)
			end
		end

	put_debug_info (location: TOKEN_LOCATION) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		require
			il_generation_started: il_generation_started
			location_not_void: location /= Void
		do
			if System.line_generation then
				implementation.put_line_info (location.line_number,
					location.start_column_position, location.end_column_position)		
			end
		end

feature -- Compilation error handling

	last_error: STRING is
			-- Last exception which occurred during IL generation
		do
			Result := implementation.last_error
		ensure
			result_not_void: Result /= Void
		end

feature -- Convenience

	implemented_type (implemented_in: INTEGER; current_type: CL_TYPE_I): CL_TYPE_I is
			-- Return static_type_id of class that defined `feat'.
		require
			valid_implemented_in: implemented_in > 0
			current_type_not_void: current_type /= Void
		local
			cl_type_a: CL_TYPE_A
			written_class: CLASS_C
			class_id: INTEGER
		do
			class_id := current_type.class_id

				-- If `feat' is defined in current class, that's easy and we
				-- return `current_type_id'. Otherwise we have to find the
				-- correct CLASS_TYPE object where `feat' is written.
			if class_id = implemented_in then
				Result := current_type
			else
				written_class := System.class_of_id (implemented_in) 
					-- We go through the hierarchy only when `written_class'
					-- is generic, otherwise for the most general case where
					-- `written_class' is not generic it will take a long
					-- time to go through the inheritance hierarchy.
				if written_class.types.count > 1 then
					cl_type_a := current_type.type_a
					Result := cl_type_a.find_class_type (written_class).type_i
				else
					Result := written_class.types.first.type
				end
			end
		end

feature -- Generic conformance

	generate_formal_type_instance (formal_type: FORMAL_I) is
			-- Generate a FORMAL_TYPE instance corresponding to `formal_type'.
		require
			formal_type_not_void: formal_type /= Void
		do
			implementation.create_object (formal_type_id)
			implementation.duplicate_top
			implementation.put_integer32_constant (formal_type.position)
			implementation.generate_external_call (formal_type_class_name, "set_position",
				Normal_type, <<integer_32_class_name>>, Void, True)
		end
	
	generate_class_type_instance (cl_type: CL_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		local
			l_type_id: INTEGER
		do
			if cl_type.is_basic then
				l_type_id := basic_type_id
			else
				l_type_id := class_type_id
			end
			implementation.create_object (l_type_id)
			implementation.duplicate_top
			implementation.put_type_token (implementation_id_of (cl_type))
			implementation.generate_external_call (class_type_class_name, "set_type",
				Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n > 0
		do
			implementation.create_object (generic_type_id)
			implementation.duplicate_top
			implementation.put_integer32_constant (n)
			implementation.generate_array_creation (type_id)
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			gen_type_not_void: gen_type /= Void
		do
			implementation.generate_external_call (generic_type_class_name, "set_type_array",
				Normal_type, <<type_array_class_name>>, Void, True);

			implementation.duplicate_top
			implementation.put_type_token (implementation_id_of (gen_type))
			implementation.generate_external_call (generic_type_class_name, "set_type",
				Normal_type, <<type_handle_class_name>>, Void, True)

			implementation.duplicate_top
			implementation.put_integer32_constant (gen_type.meta_generic.count)
			implementation.generate_external_call (generic_type_class_name, "set_nb_generics",
				Normal_type, <<integer_32_class_name>>, Void, True)
		end

	generate_none_type_instance is
			-- Generate a NONE_TYPE instance.
		do
			implementation.create_object (none_type_id)
		end

	assign_computed_type is
			-- Given elements on stack, compute associated type and set it to
			-- newly created object.
		do
				-- First object on stack is newly created object on which we 
				-- want to assign the computed type.
				-- Second object is the array containing the type array.
				-- Last, we push current object to the stack.
			implementation.generate_current
			implementation.generate_external_call (generic_conformance_class_name, "compute_type",
				Static_type, <<type_info_class_name, type_class_name,
				type_info_class_name>>, Void, False)
		end
		
feature {NONE} -- Implementation: generation

	generate_type_feature (a_type_feature: TYPE_FEATURE_I) is
			-- Generate type description for `a_type_feature'.
		require
			a_type_feature_not_void: a_type_feature /= Void
		local
			l_cl_type: CL_TYPE_I
			l_gen_type: GEN_TYPE_I
			l_formal_type: FORMAL_I
			l_type_i: TYPE_I
			l_type_id, i, up: INTEGER
		do
			l_type_i := a_type_feature.type.actual_type.type_i

				-- We are now evaluation `l_type_i' in the context of current CLASS_TYPE
				-- generation. So if it is a formal, we have to make sure that call to
				-- `byte_context.real_type (l_type_i)' keeps its formal status, by default
				-- it translates a FORMAL_I into a REFERENCE_I.
			if l_type_i.has_formal then
				if l_type_i.is_formal then
					l_formal_type ?= l_type_i
					l_type_i := byte_context.real_type (l_type_i)
					if not l_type_i.is_expanded then
						l_type_i := l_formal_type
					end
				else
					l_type_i := byte_context.real_type (l_type_i)
				end
			end

			if l_type_i.is_formal then
				l_type_id := formal_type_id
			else
				l_cl_type ?= l_type_i
				if l_cl_type.is_basic then
					l_type_id := basic_type_id
				else
					l_gen_type ?= l_cl_type
					if l_gen_type /= Void then
						l_type_id := generic_type_id
					else
						l_type_id := class_type_id
					end
				end
			end
			implementation.put_result_info (l_type_id)
			implementation.create_object (l_type_id)
			implementation.generate_result_assignment

			implementation.generate_result
			
			if l_type_id = formal_type_id then
				implementation.put_integer32_constant (l_formal_type.position)
				implementation.generate_external_call (formal_type_class_name, "set_position",
					Normal_type, <<integer_32_class_name>>, Void, True)
			elseif l_type_id = class_type_id then
					-- Non-generic class.
				implementation.put_type_token (implementation_id_of (l_cl_type))
				implementation.generate_external_call (class_type_class_name, "set_type",
					Normal_type, <<type_handle_class_name>>, Void, True)
			elseif l_type_id = basic_type_id then
				implementation.put_type_token (implementation_id_of (l_cl_type))
				implementation.generate_external_call (basic_type_class_name, "set_type",
					Normal_type, <<type_handle_class_name>>, Void, True)
			else
				implementation.duplicate_top

				put_integer_32_constant (l_gen_type.meta_generic.count)
				implementation.generate_array_creation (type_id)

				from
					i := l_gen_type.true_generics.lower
					check
						i_start_at_one: i = 1
					end
					up := l_gen_type.true_generics.upper
				until
					i > up
				loop
					implementation.duplicate_top
					put_integer_32_constant (i - 1)
					l_gen_type.true_generics.item (i).generate_gen_type_il (Current, True)
					implementation.generate_array_write (feature {IL_CONST}.il_ref)
					i := i + 1
				end

				implementation.generate_external_call (generic_type_class_name, "set_type_array",
					normal_type, <<type_array_class_name>>, void, True)
				implementation.duplicate_top
				implementation.put_type_token (implementation_id_of (l_gen_type))
				implementation.generate_external_call (generic_type_class_name, "set_type",
					normal_type, <<type_handle_class_name>>, void, True)
				implementation.duplicate_top
				implementation.put_integer32_constant (l_gen_type.meta_generic.count)
				implementation.generate_external_call (generic_type_class_name, "set_nb_generics",
					normal_type, <<integer_32_class_name>>, void, True)
					
				implementation.pop
			end
			generate_return_value
		end
	
feature {IL_META_DATA_GENERATOR} -- Implementation: convenience

	implementation: IL_CODE_GENERATOR_I
			-- COM object that knows how to generate IL code.

	static_id_of (type_i: TYPE_I): INTEGER is
			-- Return static type id of `type'.
		require
			type_i_not_void: type_i /= Void
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= type_i
			if cl_type /= Void then
				Result := cl_type.associated_class_type.static_type_id
			else
				check
					is_reference_at_least: type_i.is_reference
				end
				Result := System.any_class.compiled_class.types.first.static_type_id
			end
		end

	implementation_id_of (type_i: TYPE_I): INTEGER is
			-- Return static type id of `type'.
		require
			type_i_not_void: type_i /= Void
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= type_i
			if cl_type /= Void then
				Result := cl_type.associated_class_type.implementation_id
			else
				check
					is_reference_at_least: type_i.is_reference
				end
				Result := System.any_class.compiled_class.types.first.implementation_id
			end
		end

	System_object_type: TYPE_I is
			-- Type of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.types.first.type
		end
	
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
		
	String_type_id: INTEGER is
			-- Type of string object
		once
			Result := static_id_of (String_type)
		end
		
	String_make_feat_id: INTEGER is
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_class.compiled_class.
				feature_table.item_id (feature {PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		end

feature {NONE} -- Constants

	type_class_name: STRING is "ISE.Runtime.TYPE"
	type_array_class_name: STRING is "ISE.Runtime.TYPE[]"
	generic_type_class_name: STRING is "ISE.Runtime.GENERIC_TYPE"
	basic_type_class_name: STRING is "ISE.Runtime.BASIC_TYPE"
	class_type_class_name: STRING is "ISE.Runtime.CLASS_TYPE"
	formal_type_class_name: STRING is "ISE.Runtime.FORMAL_TYPE"
	generic_conformance_class_name: STRING is "ISE.Runtime.GENERIC_CONFORMANCE"
	type_info_class_name: STRING is "ISE.Runtime.EIFFEL_TYPE_INFO"
	integer_32_class_name: STRING is "System.Int32"
	system_type_class_name: STRING is "System.Type"
	type_handle_class_name: STRING is "System.RuntimeTypeHandle"

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
			check
				not_callable: False
			end
		end

invariant -- State invariants

	module_in_assembly: module_generation_started implies assembly_generation_started
	class_in_module: class_descriptions_generation_started implies module_generation_started
	method_in_class: feature_description_generation_started implies	class_descriptions_generation_started

end -- class IL_CODE_GENERATOR
