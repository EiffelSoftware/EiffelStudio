indexing
	description: "Generate IL code using `cli_writer' library."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_CODE_GENERATOR_IMP

inherit
	IL_CODE_GENERATOR_I

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization of current object.
		do
				-- Initialize COM.
			(create {CLI_COM}).initialize_com
		
				-- Initialize metadata emitter.
			create md_dispenser.make
			md_emit := md_dispenser.emitter
	
				-- Create signature for `done' in once computation.		
			create done_sig.make
			done_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
		end

feature {NONE} -- Access

	md_dispenser: MD_DISPENSER
	md_emit: MD_EMIT
			-- Object used to generate Metadata.

	method_writer: MD_METHOD_WRITER
			-- To store method bodys.

	method_body: MD_METHOD_BODY
			-- Body for currently generated routine.

feature {NONE} -- Access

	done_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `done_token' so that we do not have
			-- to compute it too often.

feature -- Target of generation

	set_for_interfaces is
			-- Set generation mode for `interfaces'.
		do
		end

	set_for_implementations is
			-- Set generation mode for `implementations'.
		do
		end

feature -- Generation Structure

	generate_key (final_mode: BOOLEAN) is
		do
			check
				not_yet_implemented: False
			end
		end

	start_assembly_generation (name, file_name, location: STRING) is
			-- Create Assembly with `name'.
		do
			remap_external_token
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		do
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
		do
		end

	define_entry_point (creation_type_id, type_id: INTEGER; feature_id: INTEGER) is
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
			-- Assign current generated assembly with given version.
		do
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
		end

	set_cls_compliant (cls_compliant: BOOLEAN) is
			-- Mark current generation to generate cls compliant code.
		do
		end

	set_any_type_id (id: INTEGER) is
		do
		end

feature -- Class info

	generate_class_mappings (dotnet_name, eiffel_name: STRING; id, interface_id: INTEGER; filename, element_type_name: STRING) is
			-- Create a correspondance table between `id' and `class_name'.
		do
		end

	generate_type_class_mapping,
	generate_class_type_class_mapping,
	generate_generic_type_class_mapping,
	generate_basic_type_class_mapping,
	generate_formal_type_class_mapping,
	generate_none_type_class_mapping,
	generate_eiffel_type_info_type_class_mapping (type_id: INTEGER) is
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

	generate_class_header (is_interface, is_deferred, is_frozen, is_expanded, is_external: BOOLEAN; type_id: INTEGER) is
			-- Generate class name and its specifier.
		do
		end

	end_class is
			-- Finish description of current class structure.
		do
		end

	add_to_parents_list (type_id: INTEGER) is
			-- Add class `name' into list of parents of current type.
		do
		end

	add_interface (type_id: INTEGER) is
			-- Add interface of `type_id' into list of parents of current type.
		do
		end

	set_implementation_class is
			-- Add interface of `type_id' into list of parents of current type.
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

	generate_interface_feature_identification (name: STRING; feature_id: INTEGER; is_attribute: BOOLEAN) is
			-- Generate feature name.
		do
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER;
			is_redefined, is_deferred, is_frozen, is_attribute, is_c_external, is_static: BOOLEAN)
		is
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

	generate_feature_argument (name: STRING; type_id: INTEGER) is
			-- Generate argument `name' of type `type_a'.
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

	generate_feature_il (feature_id, type_id, code_feature_id: INTEGER) is
			-- Start il generation for feature `feature_id' of class `class_id'.
		do
		end

	generate_implementation_feature_il (feature_id: INTEGER) is
		do
		end

	generate_finalize_feature (feature_id: INTEGER) is
		do
		end

	generate_method_impl (feature_id, parent_type_id, parent_feature_id: INTEGER) is
			-- Generate a MethodImpl from `parent_type_id' and `parent_feature_id'
		do
		end

	generate_feature_internal_duplicate (feature_id: INTEGER) is
		do
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Start il generation for creation feature `feature_id' of class `class_id'.
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER; parameters_type: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN) is
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

	set_eiffel_type (type_id: INTEGER) is
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
			method_body.put_opcode (feature {MD_OPCODES}.Dup)
		end

	pop is
			-- Remove top element of IL stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Pop)
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldarg_0)
		end

	generate_result is
			-- Generate access to `Result'.
		do
			generate_local (result_position)
		end

	generate_attribute (type_id, feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_id'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld,
				feature_token (type_id, feature_id))
		end

	generate_feature_access (type_id, feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_id'.
		local
			l_opcode: INTEGER_16
		do
			if is_virtual then
				l_opcode := feature {MD_OPCODES}.Callvirt
			else
				l_opcode := feature {MD_OPCODES}.Call
			end

				-- FIXME: Manu 3/29/2002: we do not know here number of arguments
				-- nor if it is a function or not.
			method_body.put_call (l_opcode, feature_token (type_id, feature_id), 10, False)
		end

	generate_precursor_feature_access (type_id, feature_id: INTEGER) is
			-- Generate access to feature of `feature_id' in `type_id'.
		do
				-- FIXME: Manu 3/29/2002: we do not know here number of arguments
				-- nor if it is a function or not.
			method_body.put_call (feature {MD_OPCODES}.Call, feature_token (type_id, feature_id),
				10, False)
		end

	generate_type_feature (feature_id: INTEGER) is
			-- Specifies for which feature of `feature_id' written in current class
			-- IL code will be generated.
		do
			check
				not_yet_implemented: False
			end
		end

	put_type_token (type_id: INTEGER) is
			-- Put token associated to `type_id' on stack.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken,
				class_mapping.item (type_id))
		end

	put_method_token (type_id, feature_id: INTEGER) is
			-- Generate access to feature of `feature_id' in `type_id'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken, feature_token (type_id, feature_id))
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		do
			inspect
				n
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_0)				
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldarg_3)
			else
				if n <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarg_s, n.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldarg, n.to_integer_16)
				end
			end
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		do
			inspect
				n
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_0)				
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_3)
			else
				if n <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloc_s, n.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloc, n.to_integer_16)
				end
			end
		end

	generate_metamorphose (type_id: INTEGER) is
			-- Generate `metamorphose', ie boxing a basic type of `type_id' into its
			-- corresponding reference type.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Box,
				class_mapping.item (type_id))
		end

	generate_unmetamorphose (type_id: INTEGER)  is
			-- Generate `unmetamorphose', ie unboxing a basic type of `type_id' into its
			-- corresponding reference type.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Unbox,
				class_mapping.item (type_id))
			generate_load_from_address (type_id)
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloca_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloca, n.to_integer_16)				
			end
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarga_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldarga, n.to_integer_16)				
			end
		end

	generate_current_address is
			-- Generate address of `Current'.
		do
			method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldarga_s, 0)
		end

	generate_result_address is
			-- Generate address of `Result'.
		do
			generate_local_address (result_position)
		end

	generate_attribute_address (type_id, feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_id'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldflda,
				feature_token (type_id, feature_id))
		end

	generate_routine_address (type_id, feature_id: INTEGER) is
			-- Generate address of routine of `feature_id' in class `type_id'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldvirtftn,
				feature_token (type_id, feature_id))
		end

	generate_load_from_address (type_id: INTEGER) is
			-- Load value of `type_i' type from address pushed on stack.
		do
				-- Possibly introduced a `generate_load_from_address_token'
		end

feature -- Assignments

	generate_is_instance_of (type_id: INTEGER) is
			-- Generate `Isinst' byte code instruction.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Isinst,
				class_mapping.item (type_id))
		end

	generate_check_cast (source_type_id, target_type_id: INTEGER) is
			-- Generate `checkcast' byte code instruction.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
				class_mapping.item (target_type_id))
		end	
	
	generate_attribute_assignment (type_id, feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, feature_token (type_id, feature_id))
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		do
			inspect
				n
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_0)				
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_3)
			else
				if n <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Stloc_s, n.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Stloc, n.to_integer_16)
				end
			end
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
			generate_local_assignment (result_position)
		end

feature -- Conversion

	convert_to_native_int is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i)
		end
		
	convert_to_integer8, convert_to_boolean is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i1)
		end
		
	convert_to_integer16, convert_to_character is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i2)
		end
		
	convert_to_integer32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i4)
		end

	convert_to_integer64 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i8)
		end
		
	convert_to_double is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_r8)
		end
		
	convert_to_real is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_r4)
		end
		
feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ret)
		end

feature -- Once management

	done_token, result_token: INTEGER
			-- Token for static fields holding value if once has been computed,
			-- and its value if computed.

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		do
			done_token := md_emit.define_field (create {UNI_STRING}.make (name + "_done"),
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Private | feature {MD_FIELD_ATTRIBUTES}.Static, done_sig)
		end

	generate_once_result_info (name: STRING; type_id: INTEGER) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_id'.
		local
			l_sig: MD_FIELD_SIGNATURE
		do
			create l_sig.make
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				class_mapping.item (type_id))
				
			result_token := md_emit.define_field (create {UNI_STRING}.make (name + "_result"),
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Private | feature {MD_FIELD_ATTRIBUTES}.Static, l_sig)
		end

	generate_once_computed is
			-- Mark current once as being computed.
		do
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, done_token)
		end

	generate_once_result_address is
			-- Generate test on `done' of once feature `name'.
		do
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsflda, result_token)
		end

	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, done_token)
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, result_token)
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, result_token)
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
		do
			inspect kind
			when Il_i1 then l_opcode := feature {MD_OPCODES}.Ldelem_i1
			when Il_i2 then l_opcode := feature {MD_OPCODES}.Ldelem_i2
			when Il_i4 then l_opcode := feature {MD_OPCODES}.Ldelem_i4
			when Il_i8, Il_u8 then l_opcode := feature {MD_OPCODES}.Ldelem_i8
			when Il_r4 then l_opcode := feature {MD_OPCODES}.Ldelem_r4
			when Il_r8 then l_opcode := feature {MD_OPCODES}.Ldelem_r8
			when Il_ref then l_opcode := feature {MD_OPCODES}.Ldelem_ref
			when Il_i then l_opcode := feature {MD_OPCODES}.Ldelem_i
			when Il_u1 then l_opcode := feature {MD_OPCODES}.Ldelem_u1
			when Il_u2 then l_opcode := feature {MD_OPCODES}.Ldelem_u2
			when Il_u4 then l_opcode := feature {MD_OPCODES}.Ldelem_u4
			else
				check
					not_reached: False
				end
				l_opcode := feature {MD_OPCODES}.Nop
			end
			method_body.put_opcode (l_opcode)
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
		do
			inspect kind
			when Il_i1, Il_u1 then l_opcode := feature {MD_OPCODES}.Stelem_i1
			when Il_i2, Il_u2 then l_opcode := feature {MD_OPCODES}.Stelem_i2
			when Il_i4, Il_u4 then l_opcode := feature {MD_OPCODES}.Stelem_i4
			when Il_i8, Il_u8 then l_opcode := feature {MD_OPCODES}.Stelem_i8
			when Il_r4 then l_opcode := feature {MD_OPCODES}.Stelem_r4
			when Il_r8 then l_opcode := feature {MD_OPCODES}.Stelem_r8
			when Il_ref then l_opcode := feature {MD_OPCODES}.Stelem_ref
			when Il_i then l_opcode := feature {MD_OPCODES}.Stelem_i
			else
				check
					not_reached: False
				end
				l_opcode := feature {MD_OPCODES}.Nop
			end
			method_body.put_opcode (l_opcode)
		end

	generate_array_creation (type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `type_id' corresponds
			-- to type id of `A'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Newarr, class_mapping.item (type_id))
		end

	generate_array_count is
			-- Get length of current NATIVE_ARRAY on stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldlen)
		end

	generate_array_upper is
			-- Generate call to `count - 1'.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldlen)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_1)
			method_body.put_opcode (feature {MD_OPCODES}.Sub)
		end

	generate_array_lower is
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
		end

feature --- Rescue

	rescue_label: INTEGER
			-- Label used for rescue clauses to mark end of `try-catch'.
			
	generate_start_exception_block is
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
			rescue_label := method_body.define_label
			method_body.exception_block.set_start_position (method_body.size)
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_catch_position (method_body.size)
			method_body.exception_block.set_type_token (system_exception_token)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_last_exception_token)			
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_end_position (method_body.size)
			method_body.mark_label (rescue_label)
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: INTEGER) is
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, ise_in_assertion_token)
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, end_of_assert)
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag to True.
		do
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_in_assertion_token)
		end

	generate_restore_assertion_status is
			-- Set `in_assertion' flag to False.
		do
			put_boolean_constant (false)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_in_assertion_token)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
		local
			l_label: INTEGER
			l_str_token: INTEGER
		do
			l_str_token := md_emit.define_string (create {UNI_STRING}.make (tag))
			l_label := method_body.define_label
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, l_label)
			generate_restore_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, exception_ctor_token, 1, False)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
			method_body.mark_label (l_label)
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
		do
			generate_restore_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, ise_assertion_tag_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, exception_ctor_token, 1, False)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
		end

	generate_precondition_check (tag: STRING; label_id: INTEGER) is
			-- If evaluation of precondition yield to False, we put on top of IL stack
			-- a string that will be used to raise an exception later at end of 
			-- preconditions evaluation.
		local
			l_str_token: INTEGER
		do
			l_str_token := md_emit.define_string (create {UNI_STRING}.make (tag))
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_assertion_tag_token)
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, label_id)
		end

	generate_invariant_checking (type_id: INTEGER) is
			-- Generate invariant checking on class `type_id'.
		do
			check
				not_yet_implemented: False
			end
		end

	mark_invariant (feature_id: INTEGER) is
			-- Mark current routine `feature_id' in current class being generated
			-- as invariant of current class.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Constants generation

	put_void is
			-- Put `Void' on IL stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldnull)
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		local
			l_string_token: INTEGER
			l_uni_string: UNI_STRING
		do
			create l_uni_string.make (s)
			l_string_token := md_emit.define_string (l_uni_string)
			method_body.put_string (l_string_token)
		end

	put_integer8_constant,
	put_integer16_constant,
	put_integer32_constant (i: INTEGER) is
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
			inspect
				i
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_3)
			when 4 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_4)
			when 5 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_5)
			when 6 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_6)
			when 7 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_7)
			when 8 then method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_8)
			else
				method_body.put_opcode_integer (feature {MD_OPCODES}.Ldc_i4, i)				
			end
		end
		
	put_integer64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		do
			method_body.put_opcode_integer_64 (feature {MD_OPCODES}.Ldc_i8, i)
		end

	put_real_constant (d: DOUBLE) is
			-- put `d' on IL stack as a real.
		local
			r: REAL
		do
			r := d
			method_body.put_opcode_real (feature {MD_OPCODES}.Ldc_r4, r)
		end
		
	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_real (feature {MD_OPCODES}.Ldc_r8, d)
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		do
			method_body.put_opcode_integer (feature {MD_OPCODES}.Ldc_i4, c.code)
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		do
			if b then
				method_body.put_opcode (feature {MD_OPCODES}.ldc_i4_1)
			else
				method_body.put_opcode (feature {MD_OPCODES}.ldc_i4_0)
			end
		end

feature -- Labels and branching

	branch_on_true (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, label)
		end

	branch_on_false (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, label)
		end

	branch_to (label: INTEGER) is
			-- Generate a branch instruction to `label'.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Br, label)
		end

	mark_label (label: INTEGER) is
			-- Mark a portion of code with `label'.
		do
			method_body.mark_label (label)
		end

	create_label: INTEGER is
			-- Create a new label.
		do
			Result := method_body.define_label
		end

feature -- Binary operator generation

	generate_lt is
			-- Generate `<' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Clt)
		end

	generate_le is
			-- Generate `<=' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Cgt)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
		end
		
	generate_gt is
			-- Generate `>' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Cgt)
		end
		
	generate_ge is
			-- Generate `>=' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Clt)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
		end

	generate_star is
			-- Generate `*' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Mul)
		end

	generate_power is
			-- Generate `^' operator.
		do
			method_body.put_call (feature {MD_OPCODES}.Call, power_method_token, 2, True)
		end

	generate_plus is
			-- Generate `+' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Add)
		end

	generate_mod is
			-- Generate `\\' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Rem)
		end

	generate_minus is
			-- Generate `-' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Sub)
		end

	generate_div is
			-- Generate `//' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Div)
		end

	generate_xor is
			-- Generate `xor' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Xor_opcode)
		end

	generate_or is
			-- Generate `or' and `or else' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Or_opcode)
		end

	generate_and is
			-- Generate `and' and `and then' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.And_opcode)
		end

	generate_eq is
			-- Generate `=' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
		end

	generate_ne is
			-- Generate `/=' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
		end

	generate_shl is
			-- Generate `|<<' operator (shift left)
		do
			method_body.put_opcode (feature {MD_OPCODES}.Shl)
		end

	generate_shr is
			-- Generate `|>>' operator (shift right)
		do
			method_body.put_opcode (feature {MD_OPCODES}.Shr)
		end

feature -- Unary operator generation

	generate_uminus is
			-- Generate '-' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Neg)
		end

	generate_not is
			-- Generate 'not' operator.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
			method_body.put_opcode (feature {MD_OPCODES}.Ceq)
		end

	generate_bitwise_not is
			-- Generate `bitwise not' operator
		do
			method_body.put_opcode (feature {MD_OPCODES}.Not_opcode)
		end

feature -- Basic feature

	generate_min (type_id: INTEGER) is
			-- Generate `min' on basic types.\
		local
			l_min_token: INTEGER
			l_type_token: INTEGER
			l_sig: MD_METHOD_SIGNATURE
		do
			l_type_token := class_mapping.item (type_id)
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_min_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Min"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_min_token, 2, True)
		end

	generate_max (type_id: INTEGER) is
			-- Generate `max' on basic types.
		local
			l_max_token: INTEGER
			l_type_token: INTEGER
			l_sig: MD_METHOD_SIGNATURE
		do
			l_type_token := class_mapping.item (type_id)
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_max_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Max"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_max_token, 2, True)
		end

	generate_abs (type_id: INTEGER) is
			-- Generate `abs' on basic types.
		local
			l_abs_token: INTEGER
			l_type_token: INTEGER
			l_sig: MD_METHOD_SIGNATURE
		do
			l_type_token := class_mapping.item (type_id)
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, l_type_token)
			l_abs_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Abs"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_abs_token, 1, True)
		end

	generate_to_string is
			-- Generate call on `ToString'.
		do
			method_body.put_call (feature {MD_OPCODES}.Callvirt, to_string_method_token, 0, True)
		end
	
feature -- Line Info for debugging

	put_line_info (n1, n2, n3: INTEGER) is
			-- Generate `file_name' and `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		do
		end

feature -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation

feature {NONE} -- Onces

	language_guid: COM_GUID is
			-- Language guid used to identify our language when debugging.
		once
			create Result.make (0x6805C61E, 0x8195, 0x490C,
				<<0x87, 0xEE, 0xA7, 0x13, 0x30, 0x1A, 0x67, 0x0C>>)
		end
		
	vendor_guid: COM_GUID is
			-- Vendor guid used to identify us when debugging.
		once
			create Result.make (0xB68AF30E, 0x9424, 0x485F,
				<<0x82, 0x64, 0xD4, 0xA7, 0x26, 0xC1, 0x62, 0xE7>>)
		end
		
	document_type_guid: COM_GUID is
			-- Document type guid.
		once
			create Result.make_empty
		end
		
feature {NONE} -- Once per type definition

	current_class_token: INTEGER
			-- Token of current class being generated.

feature {NONE} -- Once per feature definition

	result_position: INTEGER
			-- Position of `Result' local variable.

feature {NONE} -- Once per modules being generated.

	remap_external_token is
			-- Recompute all tokens in context of newly created module.
		do
			compute_mscorlib_token
			compute_mscorlib_type_tokens
			compute_power_method_token
			compute_to_string_method_token
			compute_ise_runtime_tokens
		end
	
	mscorlib_token: INTEGER
			-- Token for `mscorlib' assembly.
			
	object_type_token: INTEGER
			-- Token for `System.Object' in `mscorlib'.

	math_type_token: INTEGER
			-- Token for `System.Math' type in `mscorlib'.

	system_exception_token: INTEGER
			-- Token for `System.Exception' type in `mscorlib'.

	to_string_method_token: INTEGER
			-- Token for `System.Object.ToString' feature in `mscorlib'.

	power_method_token: INTEGER
			-- Token for `System.Math.Power' feature in `mscorlib'.

	exception_ctor_token: INTEGER
			-- Token for `System.Exception' constructor feature in `mscorlib'.

	ise_runtime_token: INTEGER
			-- Token for `ise_runtime' assembly

	ise_last_exception_token: INTEGER
			-- Token for `ISE.RUNTIME.last_exception' static field that holds
			-- exception object we got from `catch'.
			
	ise_in_assertion_token: INTEGER
			-- Token for `ISE.RUNTIME.in_assertion' static field that holds
			-- status of assertion checking.

	ise_assertion_tag_token: INTEGER
			-- Token for `ISE.RUNTIME.assertion_tag' static field that holds
			-- message for exception being thrown.

	compute_mscorlib_token is
			-- Compute `mscorlib_token'.
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN
		do
			create l_ass_info.make
			l_ass_info.set_major_version (1)
			l_ass_info.set_build_number (3300)
			
			create l_pub_key.make_from_array (
				<<0xB7, 0x7A, 0x5C, 0x56, 0x19, 0x34, 0xE0, 0x89>>)
				
			mscorlib_token := md_emit.define_assembly_ref (
				create {UNI_STRING}.make ("mscorlib"), l_ass_info, l_pub_key)
		end

	compute_mscorlib_type_tokens is
			-- Compute `double_type_token', `math_type_token'.
		require
			valid_mscorlib_token: mscorlib_token /= 0
			object_type_token_not_set: object_type_token = 0
			math_type_token_not_set: math_type_token = 0
			system_exception_token_not_set: system_exception_token = 0
		local
			l_sig: MD_METHOD_SIGNATURE
		do
			object_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Object"), mscorlib_token)
			math_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Math"), mscorlib_token)
			system_exception_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Exception"), mscorlib_token)
				
				-- Define `.ctor' from System.Exception
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			exception_ctor_token := md_emit.define_member_ref (
				create {UNI_STRING}.make (".ctor"), system_exception_token, l_sig)
		ensure
			object_type_token_set: object_type_token /= 0
			math_type_token_set: math_type_token /= 0
			system_exception_token_set: system_exception_token /= 0
		end
		
	compute_power_method_token is
			-- Compute `power_method_token'.
		require
			valid_math_type_token: math_type_token /= 0
		local
			l_sig: MD_METHOD_SIGNATURE
		do
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			power_method_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Pow"), math_type_token, l_sig)
		ensure
			power_method_token_set: power_method_token /= 0
		end

	compute_to_string_method_token is
			-- Compute `to_string_method_token'.
		local
			l_sig: MD_METHOD_SIGNATURE
		do
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			to_string_method_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("ToString"), object_type_token, l_sig)
		ensure
			to_string_method_token: to_string_method_token /= 0
		end

	compute_ise_runtime_tokens is
			-- Compute `ise_runtime_token'.
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN
			l_runtime_type_token, l_excep_man_token: INTEGER
			l_sig: MD_FIELD_SIGNATURE
		do
				-- Define `ise_runtime_token'.
			create l_ass_info.make
			l_ass_info.set_major_version (5)
			l_ass_info.set_minor_version (2)
			
			create l_pub_key.make_from_array (
				<<0xDE, 0xF2, 0x6F, 0x29, 0x6E, 0xFE, 0xF4, 0x69>>)
				
			ise_runtime_token := md_emit.define_assembly_ref (
				create {UNI_STRING}.make ("ise_runtime"), l_ass_info, l_pub_key)
				
				-- Define `ise_last_exception_token'.
			l_excep_man_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("ISE.Runtime.EXCEPTION_MANAGER"),
				ise_runtime_token)

			create l_sig.make
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				system_exception_token)
			
			ise_last_exception_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("last_exception"), l_excep_man_token,
				l_sig)
				
				-- Define `ise_in_assertion_token'.
			l_runtime_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("ISE.Runtime.RUN_TIME"),
				ise_runtime_token)

			create l_sig.make
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			
			ise_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("in_assertion"), l_runtime_type_token, l_sig)
				
				-- Define `ise_assertion_tag_token'.
			create l_sig.make
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			ise_assertion_tag_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("assertion_tag"), l_runtime_type_token, l_sig)
		end
	
feature {NONE} -- Mapping between Eiffel compiler and generated tokens

	class_mapping: ARRAY [INTEGER] is
			-- Array of type token indexed by their `type_id'.
		do
			check
				net_yet_implemented: False
			end
		end

	feature_token (type_id, feature_id: INTEGER): INTEGER is
			-- Given a `feature_id' in `type_id' return associated
			-- token
		do
			check
				net_yet_implemented: False
			end
		end
		
end -- class IL_CODE_GENERATOR_IMP
