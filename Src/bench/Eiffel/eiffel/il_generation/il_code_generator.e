indexing
	description: "Generation of IL code using a bridge pattern."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_CODE_GENERATOR

inherit
	IL_CONST

	SHARED_IL_CONSTANTS

	SHARED_WORKBENCH

	COMPILER_EXPORTER

	SHARED_INST_CONTEXT

	ASSERT_TYPE

create
	default_create

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
		local
			imp: JVM_IL_CODE_GENERATOR
		do
			imp ?= implementation
			if imp = Void then
				create {JVM_IL_CODE_GENERATOR} implementation.make
			end
		end

	set_msil_generation is
			-- Create an implementation object that will generate MSIL byte code
		local
			imp: COM_IL_CODE_GENERATOR
		do
			create imp.make
			imp.generate_key
			implementation := imp
		end

feature -- Generation Structure

	start_assembly_generation (assembly_name, file_name: STRING) is
			-- Create Assembly with `name'.
		require
			not_started: not assembly_generation_started
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		do
			implementation.start_assembly_generation (assembly_name, file_name, (create {PROJECT_CONTEXT}).Final_generation_path)
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

	define_entry_point (type_id: INTEGER; feature_id: INTEGER) is
			-- Define entry point for IL component from `feature_id' in
			-- class `type_id'.
		require
			positive_type_id: type_id > 0
			positive_feature_id: feature_id > 0
		do
			implementation.define_entry_point (type_id, feature_id)
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

	generate_class_mappings (class_name: STRING; id: INTEGER; filename: STRING) is
			-- Create a correspondance table between `id' and `class_name'.
			-- `filename' is the path to the source file of `class_name'
		require
			class_mappings_started: class_mappings_started
			name_not_void: class_name /= Void
			name_not_empty: not class_name.is_empty
			id_positive: id > 0
			non_void_filename: filename /= Void
			non_empty_filename: not filename.is_empty
		do
			implementation.generate_class_mappings (class_name, id, filename)
		end

	generate_array_class_mappings (class_name, element_type_name: STRING; id: INTEGER) is
			-- Create a correspondance table between `id' and `class_name'.
		require
			class_mappings_started: class_mappings_started
			name_not_void: class_name /= Void
			name_not_empty: not class_name.is_empty
			element_type_name_not_void: element_type_name /= Void
			element_type_name_not_empty: not element_type_name.is_empty
			id_positive: id > 0
		do
			implementation.generate_array_class_mappings (class_name, element_type_name, id)
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

	generate_class_header (is_interface, is_deferred, is_expanded, is_external: BOOLEAN; type_id: INTEGER) is
			-- Generate class name and its specifier.
 		require
 			class_descriptions_generation_started: class_descriptions_generation_started
			positive_type_id: type_id > 0
		do
			implementation.generate_class_header (is_interface, is_deferred, is_expanded, is_external, type_id)		
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

	add_to_parents_list (type_id: INTEGER) is
			-- Add class of `type_id' into list of parents of current type.
			-- `start_parents_list' should have been called before.
		require
			parents_list_generation_started: parents_list_generation_started
			positive_type_id: type_id > 0
		do
			implementation.add_to_parents_list (type_id)
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

	start_features_list (type_id: INTEGER) is
			-- Starting enumeration of features written in current class.
		require
			class_descriptions_generation_started: class_descriptions_generation_started
			positive_type_id: type_id > 0
		do
			implementation.start_features_list (type_id)
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

	generate_feature_nature (is_redefined, is_deferred, is_frozen, is_attribute: BOOLEAN) is
			-- Generate info about current feature.
		require
			feature_description_generation_started: feature_description_generation_started
			non_deferred_frozen: is_frozen implies not is_deferred
			non_deferred_attribute: is_attribute implies not is_deferred
		do
			implementation.generate_feature_nature (is_redefined, is_deferred, is_frozen, is_attribute)
		end

	generate_feature_identification (name: STRING; feat_id: INTEGER; routine_ids: ARRAY [INTEGER]; in_current_class: BOOLEAN; written_type_id: INTEGER) is
			-- Generate feature identification.
		require
			feature_description_generation_started: feature_description_generation_started
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			positive_feat_id: feat_id > 0
			routine_ids: routine_ids /= Void
			positive_written_type_id: written_type_id > 0
		do
			implementation.generate_feature_identification (name, feat_id, routine_ids, in_current_class, written_type_id)
		end

	generate_external_identification (name, il_name: STRING; ext_kind, feature_id, routine_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [STRING]; return_type: STRING) is
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
			implementation.generate_external_identification (name, il_name, ext_kind, feature_id, routine_id, in_current_class, written_type_id, signature, return_type)
		end

	generate_deferred_external_identification (name: STRING; feature_id, routine_id, written_type_id: INTEGER) is
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

	generate_feature_il (feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in class of `type_id'
			-- IL code will be generated.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
		do
			implementation.generate_feature_il (feature_id)
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Specifies for which creation feature of `feature_id' written in
			-- class of `type_id' IL code will be generated.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
		do
			implementation.generate_creation_feature_il (feature_id)
		end

	generate_il (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
		local
			feat_tbl: FEATURE_TABLE
			feat: FEATURE_I
		do
			from
				feat_tbl := class_c.feature_table
				feat_tbl.start
				implementation.start_il_generation (class_type.static_type_id)
				Inst_context.set_cluster (class_c.cluster)
			until
				feat_tbl.after
			loop
				feat := feat_tbl.item_for_iteration
				if feat.to_generate_in (class_c) then
					generate_feature_il (feat.feature_id)
					class_type.generate_il_feature (feat)
				end
				feat_tbl.forth
			end
			if class_c.has_invariant then
				feat := class_c.invariant_feature
				if feat.to_generate_in (class_c) then
					generate_feature_il (feat.feature_id)
					class_type.generate_il_feature (feat)
				end
			end
--			generate_creation_routines (class_c, class_type)
		end

	generate_creation_routines (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate description for creation routines of `class_c' if any.
		require
			class_c_not_void: class_c /= Void
		local
			creators: EXTEND_TABLE [EXPORT_I, STRING]
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
				parameters_type: ARRAY [STRING]; return_type:STRING;
				is_virtual: BOOLEAN; type_i: TYPE_I; feature_id: INTEGER) is
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
					parameters_type, return_type, is_virtual, static_id_of (type_i), feature_id)
		end

feature -- Local variable info generation

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.put_result_info (static_id_of (type_i))
		end

	put_local_info (type_i: TYPE_I; name:STRING) is
			-- Specifies `type_i' of type of local.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.put_local_info (static_id_of (type_i), name)
		end

feature -- Object creation

	create_like_current_object is
			-- Create object of same type as current object.
		require
			il_generation_started: il_generation_started
		do
			implementation.create_like_current_object
		end

	create_object (type_i: TYPE_I) is
			-- Create object of `type_id'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
		do
			implementation.create_object (static_id_of (type_i))
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
			implementation.generate_result
		end

	generate_attribute (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_id'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_attribute (static_id_of (type_i), feature_id)
		end

	generate_feature_access (type_i: TYPE_I; feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_i'.
		require
			il_generation_started: il_generation_started
			type_i_not_void: type_i /= Void
			positive_feature_id: feature_id > 0
		do
			implementation.generate_feature_access (static_id_of (type_i), feature_id, is_virtual)
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
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_id'.
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
			implementation.generate_result_address
		end

	generate_attribute_address (type_i: TYPE_I; feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_id'.
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

	generate_attribute_assignment (feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
		require
			il_generation_started: il_generation_started
			positive_feature_id: feature_id > 0
		do
			implementation.generate_attribute_assignment (feature_id)
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
			implementation.generate_result_assignment
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
			implementation.generate_return_value
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

	generate_array_creation (type_id: INTEGER) is
		require
			il_generation_started: il_generation_started
			positive_type_id: type_id > 0
		do
			implementation.generate_array_creation (type_id)
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
		do
			if type.is_boolean then
				implementation.put_boolean_constant (False)
			elseif type.is_double then
				implementation.put_double_constant (0.0)
			elseif type.is_numeric then
				implementation.put_integer32_constant (0)
			elseif type.is_char then
				implementation.put_character_constant ('%U')
			else
				implementation.put_void		
			end
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			il_generation_started: il_generation_started
			valid_s: s /= Void
		do
			implementation.put_manifest_string (s)
		end

	put_integer_32_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_integer32_constant (i)
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
			when il_slash then implementation.generate_slash
			when il_power then implementation.generate_power
			when il_plus then implementation.generate_plus
			when il_mod then implementation.generate_mod
			when il_minus then implementation.generate_minus
			when il_div then implementation.generate_div
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
			when il_uplus then implementation.generate_uplus
			when il_uminus then implementation.generate_uminus
			when il_not then implementation.generate_not
			end
		end

feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		require
			il_generation_started: il_generation_started
		do
			implementation.put_line_info (n)
		end

feature -- Compilation error handling

	last_error: STRING is
			-- Last exception which occured during IL generation
		do
			Result := implementation.last_error
		end

feature {IL_META_DATA_GENERATOR} -- Implementation

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
				Result := any_static_type_id
			end
		end

	any_static_type_id: INTEGER is
			-- Static type id of ANY.
		do
			Result := System.any_class.compiled_class.types.first.static_type_id
		end

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
		end

invariant -- State invariants

	module_in_assembly: module_generation_started implies assembly_generation_started
	class_in_module: class_descriptions_generation_started implies module_generation_started
	method_in_class: feature_description_generation_started implies	class_descriptions_generation_started

end -- class IL_CODE_GENERATOR
