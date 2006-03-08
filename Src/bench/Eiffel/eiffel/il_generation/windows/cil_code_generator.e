indexing
	description: "Generation of IL code using a bridge pattern."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CIL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR

	IL_CONST

	IL_PREDEFINED_CUSTOM_ATTRIBUTES
		export
			{NONE} all
		end

	IL_PREDEFINED_STRINGS
		export
			{NONE} all
		end

	SHARED_IL_CONSTANTS

	SHARED_IL_DEBUG_INFO_RECORDER

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

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_BN_STATELESS_VISITOR
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		local
			f: FEATURE_I
		do
			f := System.any_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.Standard_twin_name_id)
			if f = Void then
					-- "standard_twin" is not found in ANY
				standard_twin_body_index := -1
			else
				standard_twin_body_index := f.body_index
			end
			internal_finalize_rout_id := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
		end

feature -- Access

	current_class_type: CLASS_TYPE
			-- Currently class type being handled.

feature -- Status report

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information?

feature {IL_MODULE} -- Access

	is_single_inheritance_implementation: BOOLEAN is
			-- Is current generation of type SINGLE_IL_CODE_GENERATOR?
		deferred
		end

	method_body: MD_METHOD_BODY
			-- Body for currently generated routine.

	local_start_offset, local_end_offset: INTEGER
			-- Data for debugging information for current feature.

feature {CIL_CODE_GENERATOR, IL_MODULE} -- Access

	is_single_module: BOOLEAN
			-- Is current module generated as just a single module?
			-- Case of precompiled libraries or finalized systems.

feature {NONE} -- Access

	main_module: IL_MODULE
			-- Module containing assembly manifest.

	current_module: IL_MODULE
			-- Module being used for code generation.

	current_type_id: INTEGER
			-- Type_id of class being analyzed.

	current_class: CLASS_C
			-- Current class being treated.

	is_single_class: BOOLEAN
			-- Can current class only be single inherited?

	internal_finalize_rout_id: INTEGER
			-- Routine ID of `finalize' from ANY

	standard_twin_body_index: INTEGER
			-- Body index of `standard_twin' from ANY

	output_file_name: FILE_NAME
			-- File where assembly is stored.

	md_dispenser: MD_DISPENSER
			-- Access to MetaData generator.

	md_emit: MD_EMIT is
			-- Metadata emitter.
		do
			Result := current_module.md_emit
		ensure
			md_emit_not_void: Result /= Void
		end

	method_writer: MD_METHOD_WRITER is
			-- To store method bodys.
		do
			Result := current_module.method_writer
		ensure
			method_writer_not_void: Result /= Void
		end

	type_count: INTEGER is
			-- Number of generated types in Current system.
		do
			Result := (create {SHARED_COUNTER}).static_type_id_counter.count + 10
		ensure
			type_count_positive: type_count >= 0
		end

	done_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `done_token' so that we do not have
			-- to compute it too often

	exception_sig: MD_FIELD_SIGNATURE is
			-- Precomputed signature of `exception_token' so that we do not have
			-- to compute it too often
		do
				-- It is the same as `sync_sig'
			Result := sync_sig
		end

	sync_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `sync_token' so that we do not have
			-- to compute it too often

	default_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a feature with no arguments and no return type.
			-- Used to define default constructors and other features with same signature.

	method_sig: MD_METHOD_SIGNATURE
			-- Permanent signature for features.

	field_sig: MD_FIELD_SIGNATURE
			-- Permanent signature for attributes.

	local_sig: MD_LOCAL_SIGNATURE
			-- Permanent signature for locals.

	type_sig: MD_TYPE_SIGNATURE
			-- Permanent signature for types.

	property_sig: MD_PROPERTY_SIGNATURE
			-- Permanent signature for properties.

	boolean_native_signature: MD_NATIVE_TYPE_SIGNATURE is
			-- Marshaller signature for converting IL boolean to Eiffel C boolean
		once
			create Result.make
			Result.set_native_type ({MD_SIGNATURE_CONSTANTS}.native_type_i1)
		end

	local_types: ARRAYED_LIST [PAIR [TYPE_I, STRING]]
			-- To store types of local variables.

	uni_string: UNI_STRING
			-- Buffer for all unicode string conversion.

	is_console_application: BOOLEAN
			-- Is current a console application?

	is_dll: BOOLEAN
			-- Is current generated as a DLL?

	is_verifiable: BOOLEAN
			-- Does code generation has to be verifiable?

	is_cls_compliant: BOOLEAN
			-- Does code generation generate CLS compliant code?

	assembly_name: STRING
			-- Name of current assembly.

	c_module_name: STRING
			-- Name of C generated module containing all C externals.

	location_path: STRING
			-- Path where assemblies are being generated.

	current_feature_token: INTEGER
			-- Token of feature being generated in `generate_feature_code'.

	once_generation: BOOLEAN
			-- Are we currently generating a once feature?

feature {NONE} -- Debug info

	dbg_writer: DBG_WRITER is
			-- PDB writer.
		do
			Result := current_module.dbg_writer
		end

	dbg_offsets,
	dbg_start_lines,
	dbg_start_columns,
	dbg_end_lines,
	dbg_end_columns: ARRAY [INTEGER]
			-- Data holding debug information for current feature.

	dbg_offsets_count: INTEGER
			-- Number of meaningful elements in above arrays.

feature -- Access

	runtime_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_TYPE.

	class_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_CLASS_TYPE.

	basic_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_BASIC_TYPE.

	generic_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_GENERIC_TYPE.

	tuple_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_TUPLE_TYPE

	formal_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_FORMAL_TYPE.

	none_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.RT_NONE_TYPE.

	eiffel_type_info_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.EIFFEL_TYPE_INFO.

	generic_conformance_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.GENERIC_CONFORMANCE.

	assertion_level_enum_type_id: INTEGER
			-- Identifier for class EiffelSoftware.Runtime.Enums.ASSERTION_LEVEL_ENUM.

	public_key: MD_PUBLIC_KEY
			-- Public key if used of current assembly.

feature -- Settings

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

	set_tuple_type_id (an_id: like tuple_type_id) is
			-- Set `an_id' to `tuple_type_id'.
		require
			valid_id: an_id > 0
		do
			tuple_type_id := an_id
		ensure
			tuple_type_id_set: tuple_type_id = an_id
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

	set_assertion_level_enum_type_id (an_id: like assertion_level_enum_type_id) is
			-- Set `an_id' to `assertion_level_enum_type_id'.
		require
			valid_id: an_id > 0
		do
			assertion_level_enum_type_id := an_id
		ensure
			assertion_level_enum_type_id_set: assertion_level_enum_type_id = an_id
		end

	set_once_generation (v: BOOLEAN) is
			-- Set `once_generation' to `v'.
		do
			once_generation := v
		ensure
			once_generation_set: once_generation = v
		end

	set_current_module_for_class (class_c: CLASS_C) is
			-- Update `current_module' so that it refers to module in which
			-- data class for `class_c' is generated.
		require
			class_c_not_void: class_c /= Void
		do
			current_module := il_module_for_class (class_c)
				-- Refine so that only classes being generated in current compilation
				-- unit needs the module to be generated as well.
			if not current_module.is_generated then
				current_module.prepare (md_dispenser, type_count)
			end
		ensure
			current_module_set: current_module /= Void
			associated_current_module: current_module = il_module_for_class (class_c)
		end

	set_current_module_with (a_class_type: CLASS_TYPE) is
			-- Update `current_module' so that it refers to module in which
			-- `a_class_type' is generated.
		require
			a_class_type_not_void: a_class_type /= Void
		do
			current_module := il_module (a_class_type)
				-- Refine so that only classes being generated in current compilation
				-- unit needs the module to be generated as well.
			if a_class_type.is_generated and then not current_module.is_generated then
				current_module.prepare (md_dispenser, type_count)
			end
		ensure
			current_module_set: current_module /= Void
			associated_current_module: current_module = il_module (a_class_type)
		end

feature {NONE} -- Settings

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

feature -- Cleanup

	clean_debug_information (a_class_type: CLASS_TYPE) is
			-- Clean recorded debug information.
		do
			Il_debug_info_recorder.clean_class_type_info_for (a_class_type)
		end

	cleanup is
			-- Clean up all data structures that were used for this code generation.
		local
			i, nb: INTEGER
			l_mem: MEMORY
			l_module: IL_MODULE
		do
			if internal_il_modules /= Void then
				from
					i := internal_il_modules.lower
					nb := internal_il_modules.upper
				until
					i > nb
				loop
					l_module := internal_il_modules.item (i)
					if l_module /= Void then
						l_module.cleanup
					end
					i := i + 1
				end

					-- Now all underlying COM objects should have been unreferenced, so we
					-- can safely collect them. We really have to collect them now because
					-- some cannot wait. For example if you still have an instance of
					-- DBG_DOCUMENT_WRITER of an Eiffel source file, it will refuse to create
					-- a new instance if you haven't freed the first one.
				create l_mem
				l_mem.full_collect
			end
		end

feature -- Generation Structure

	start_assembly_generation (
			a_assembly_name, a_file_name: STRING;
			a_public_key: like public_key;
			location: STRING;
			assembly_info: ASSEMBLY_INFO;
			debug_mode: BOOLEAN)
		is
			-- Create Assembly with `name'.
		require
			a_assembly_name_not_void: a_assembly_name /= Void
			a_assembly_name_not_empty: not a_assembly_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		local
			l_assembly_flags: INTEGER
			l_host: CLR_HOST
		do
				--| Initialize recording of IL Information used for eStudio .NET debugger			
			Il_debug_info_recorder.start_recording_session (debug_mode)

				--| beginning of assembly generation
			location_path := location
			assembly_name := a_assembly_name

				-- Set CLR host to proper version if not yet done.
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (System.clr_runtime_version)
			check
				l_host_not_void: l_host /= Void
			end

				-- Create unicode string buffer.
			create uni_string.make_empty (1024)

				-- Name of `dll' containing all C externals.
			create c_module_name.make_from_string ("lib" + a_assembly_name + ".dll")

			create md_dispenser.make


				-- Create signature for `done' and `sync' in once computation.
			create done_sig.make
			done_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			create sync_sig.make
			sync_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

				-- Create default signature.
			create default_sig.make
			default_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			default_sig.set_parameter_count (0)
			default_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Create permanent signature for feature.
			create method_sig.make
			create field_sig.make
			create local_sig.make
			create type_sig.make
			create property_sig.make
			create local_types.make (5)

			last_non_recorded_feature_token := 0
			create override_counter

			public_key := a_public_key
			if public_key /= Void then
				l_assembly_flags := {MD_ASSEMBLY_FLAGS}.public_key
			end

			is_debug_info_enabled := debug_mode
			-- FIXME jfiat [2003/10/10 - 16:41] try without debug_mode, for no pdb info

			create output_file_name.make_from_string (location)
			output_file_name.set_file_name (a_file_name)

			create main_module.make (
				a_assembly_name,
				output_file_name,
				c_module_name,
				a_public_key,
				Current,
				assembly_info,
				1,
				is_debug_info_enabled,
				True -- Main assembly
				)
			current_module := main_module
			if is_console_application then
				main_module.set_console_application
			else
				main_module.set_window_application
			end

			if is_dll then
				main_module.set_dll
			end

			main_module.prepare (md_dispenser, type_count)

			is_single_module := System.in_final_mode or else Compilation_modes.is_precompiling
			if is_single_module then
				internal_il_modules.put (main_module, 1)
			end
		ensure
			assembly_name_set: assembly_name = a_assembly_name
		end

	start_module_generation (a_module_id: INTEGER) is
			-- Start generation of `a_module_id'.
		do
			current_module := internal_il_modules.item (a_module_id)
		end

	define_entry_point
			(creation_type: CLASS_TYPE; a_class_type: CLASS_TYPE; a_feature_id: INTEGER;
			a_has_arguments: BOOLEAN)
		is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_type_id'.
		require
			creation_type_not_void: creation_type /= Void
			a_class_type_not_void: a_class_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			l_cur_mod: like current_module
		do
			l_cur_mod := current_module
			current_module := main_module
			current_class_type := a_class_type
			main_module.define_entry_point (creation_type, a_class_type,
				a_feature_id, a_has_arguments)
			current_module := l_cur_mod
		end

	generate_runtime_helper is
			-- Generate a class for run-time needs.
		local
			l_cur_mod: like current_module
			helper_emit: MD_EMIT
			oms_field_cil_token: INTEGER
			oms_field_eiffel_token: INTEGER
			oms_method_token: INTEGER
			oms_array_type_cil_token: INTEGER
			oms_array_type_eiffel_token: INTEGER
			array_type_token: INTEGER
			array_copy_method_token: INTEGER
			check_body_index_range_label: IL_LABEL
			allocate_for_body_index_label: IL_LABEL
		do
			if workbench.precompilation_directories = Void or else workbench.precompilation_directories.is_empty then
					-- Generate code to handle once manifest strings.
				l_cur_mod := current_module
				current_module := main_module
				helper_emit := main_module.md_emit

					-- Define fields and methods to deal with once manifest strings.
				current_module.define_once_string_tokens
				oms_field_cil_token := current_module.once_string_field_token (true)
				oms_field_eiffel_token := current_module.once_string_field_token (false)
				oms_method_token := current_module.once_string_allocation_routine_token

					-- Generate allocation routine.

					-- Check if fields were initialized.
				start_new_body (oms_method_token)
				local_sig.reset
				local_sig.set_local_count (1)
				local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
				method_body.set_local_token (helper_emit.define_signature (local_sig))
				check_body_index_range_label := create_label
				allocate_for_body_index_label := create_label
				array_type_token := helper_emit.define_type_ref (create {UNI_STRING}.make ("System.Array"), current_module.mscorlib_token)
				method_sig.reset
				method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
				method_sig.set_parameter_count (3)
				method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, array_type_token)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, array_type_token)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
				array_copy_method_token := helper_emit.define_member_ref (create {UNI_STRING}.make ("Copy"), array_type_token, method_sig)

				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_cil_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				branch_on_true (check_body_index_range_label)

					-- Create array(s) indexed by body index.
					-- Remove null from stack top.
				method_body.put_opcode ({MD_OPCODES}.pop)
					-- Create "STRING[][]" and assign it to "oms_eiffel".
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (string_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_field_eiffel_token)
					-- Create "string[][]" and assign it to "oms_cil".
					-- Leave "string[][]" at stack top.
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
				oms_array_type_cil_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_cil_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_field_cil_token)
				branch_to (allocate_for_body_index_label)

				mark_label (check_body_index_range_label)
					-- Check whether body index fits current body index range.
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode ({MD_OPCODES}.ldlen)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode ({MD_OPCODES}.stloc_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode_label ({MD_OPCODES}.bgt, allocate_for_body_index_label.id)

					-- Body index is too large. Reallocate array(s).
					-- All previously stored data have to be preserved.
					-- Reallocate "string[][]".
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_cil_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_field_cil_token)
				method_body.put_opcode ({MD_OPCODES}.ldloc_0)
				method_body.put_static_call (array_copy_method_token, 3, false)
					-- Reallocate "STRING[][]".
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldloc_0)
				method_body.put_static_call (array_copy_method_token, 3, false)
					-- Leave "string[][]" on stack top.
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_cil_token)

				mark_label (allocate_for_body_index_label)
					-- Create array(s) indexed by manifest string number.
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, helper_emit.define_type_spec (type_sig))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, current_module.actual_class_type_token (string_type_id))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- Done.
				generate_return (false)
				method_writer.write_current_body

				current_module := l_cur_mod
			end
		end

	end_assembly_generation (a_signing: MD_STRONG_NAME) is
			-- Finish creation of current assembly.
		require
			a_signing_not_void: a_signing /= Void
			a_signing_exists: a_signing.exists
		local
			l_types: like class_types
			l_type: CLASS_TYPE
			l_class: CLASS_C
			i, nb: INTEGER
			l_uni_string: UNI_STRING
			l_module: IL_MODULE
			l_token, l_file_token: INTEGER
		do
			current_module := main_module

			if not is_single_module then
				from
					l_types := System.class_types
					i := l_types.lower
					nb := l_types.upper
					create l_uni_string.make_empty (0)
				until
					i > nb
				loop
					l_type := l_types.item (i)
					if l_type /= Void then
						if not l_type.is_external then
							define_assertion_level (l_type)
						end
						if l_type.is_generated then
							l_module := il_module (l_type)

							file_token.search (l_module)
							if file_token.found then
								l_file_token := file_token.found_item
							else
								l_file_token := define_file (main_module,
									l_module.module_file_name, l_module.module_name,
									{MD_FILE_FLAGS}.Has_meta_data, a_signing)
								file_token.put (l_file_token, l_module)
							end

							l_uni_string.set_string (l_type.full_il_type_name)
							l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
								l_type.last_type_token, {MD_TYPE_ATTRIBUTES}.Public)

							if l_type.implementation_id /= l_type.static_type_id then
								l_uni_string.set_string (l_type.full_il_implementation_type_name)
								l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
									l_type.last_implementation_type_token,
									{MD_TYPE_ATTRIBUTES}.Public)
							end

							l_class := l_type.associated_class
							if
								not l_class.is_deferred and
								(l_class.creators = Void or else not l_class.creators.is_empty)
							then
								l_uni_string.set_string (l_type.full_il_create_type_name)
								l_token := md_emit.define_exported_type (l_uni_string, l_file_token,
									l_type.last_create_type_token, {MD_TYPE_ATTRIBUTES}.Public)
							end
						end
					end
					i := i + 1
				end
			end

			define_assembly_attributes

			main_module.save_to_disk (a_signing)

			--| End recording session, (then Save IL Information used for eStudio .NET debugger)
			Il_debug_info_recorder.end_recording_session
		end

	generate_resources (a_resources: LIST [STRING]) is
			-- Generate all resources in assembly.
		require
			a_resources_not_void: a_resources /= Void
		local
			l_resource_generator: IL_RESOURCE_GENERATOR
		do
			create l_resource_generator.make (main_module, a_resources)
			l_resource_generator.generate
		end

	define_file (a_module: IL_MODULE; a_file, a_name: STRING; file_flags: INTEGER; a_signing: MD_STRONG_NAME): INTEGER is
			-- Add `a_file' of name `a_name' in list of files referenced by `a_module'.
		require
			a_module_not_void: a_module /= Void
			a_file_not_void: a_file /= Void
			a_name_not_void: a_name /= Void
			a_file_valid: a_file.has_substring (a_name) and
				a_name.is_equal (
					a_file.substring (a_file.count - a_name.count + 1, a_file.count))
			file_flags_valid:
				(file_flags = {MD_FILE_FLAGS}.Has_meta_data) or
				(file_flags = {MD_FILE_FLAGS}.Has_no_meta_data)
			a_signing_not_void: a_signing /= Void
			a_signing_exists: a_signing.exists
		local
			l_uni_string: UNI_STRING
			l_hash_res: MANAGED_POINTER
		do
			create l_uni_string.make (a_file)
			l_hash_res := a_signing.hash_of_file (l_uni_string)

			l_uni_string.set_string (a_name)
			Result := a_module.md_emit.define_file (l_uni_string, l_hash_res, file_flags)
		ensure
			valid_result: Result & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_file
		end

	define_assertion_level (class_type: CLASS_TYPE) is
			-- Define assertion level for `class_type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_assert_ca: MD_CUSTOM_ATTRIBUTE
			l_type_name: STRING
		do
			check
				main_module_not_void: main_module /= Void
			end
			create l_assert_ca.make
			if class_type.implementation_id /= class_type.static_type_id then
				l_type_name := class_type.full_il_implementation_type_name
			else
				l_type_name := class_type.full_il_type_name
			end
			if class_type.is_precompiled then
				l_type_name.append (", ")
				l_type_name.append (class_type.assembly_info.full_name)
			end
			l_assert_ca.put_string (l_type_name)
			l_assert_ca.put_integer_32 (class_type.associated_class.assertion_level.level)
			l_assert_ca.put_integer_16 (0)
			define_custom_attribute (main_module.associated_assembly_token,
				main_module.ise_assertion_level_attr_ctor_token, l_assert_ca)
		end

	define_interface_type (class_type: CLASS_TYPE; parent_token: INTEGER) is
			-- Define creation type for `class_type' in module generated for `class_type'.
			-- Needed for creating proper type in a formal generic creation.
		require
			class_type_not_void: class_type /= Void
		local
			l_assert_ca: MD_CUSTOM_ATTRIBUTE
			l_type_name: STRING
		do
			create l_assert_ca.make
			l_type_name := class_type.full_il_type_name
			if class_type.is_precompiled then
				l_type_name.append (", ")
				l_type_name.append (class_type.assembly_info.full_name)
			end
			l_assert_ca.put_string (l_type_name)
			l_assert_ca.put_integer_16 (0)
			define_custom_attribute (parent_token,
				current_module.ise_interface_type_attr_ctor_token, l_assert_ca)
		end

	end_module_generation (has_root_class: BOOLEAN; a_signing: MD_STRONG_NAME) is
			-- Finish creation of current module.
		require
			a_signing_not_void: a_signing /= Void
			a_signing_exists: a_signing.exists
		local
			a_class: CLASS_C
			root_feat: FEATURE_I
			l_decl_type: CL_TYPE_I
			entry_point_token: INTEGER
		do
			if
				not is_single_module and then
				(current_module /= Void and then current_module.is_generated)
			then
					-- Mark now entry point for debug information
				if has_root_class and is_debug_info_enabled and system.creation_name /= Void then
					a_class := system.root_class.compiled_class
					root_feat := a_class.feature_table.item (system.creation_name)
					l_decl_type := implemented_type (root_feat.origin_class_id,
						a_class.types.first.type)

					entry_point_token := current_module.implementation_feature_token (
						l_decl_type.associated_class_type.implementation_id,
						root_feat.origin_feature_id)
						-- Debugger API does not allow to use MethodRef token for user entry point
					if entry_point_token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def then
						current_module.dbg_writer.set_user_entry_point (entry_point_token)
					else
						fixme ("Regenerate root procedure to get MethodDef token or generate a fictious procedure with relevant debug information that will call root procedure.")
					end
				end
					-- Save module.
				current_module.save_to_disk (a_signing)
			end
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		do
			is_console_application := True
			is_dll := False
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		do
			is_console_application := False
			is_dll := False
		end

	set_dll is
			-- Current generated application is a DLL.
		do
			is_dll := True
			is_console_application := True
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER) is
			-- Assign current generated assembly with given version details.
		do
			check
				not_yet_implemented: False
			end
		end

	set_verifiability (verifiable: BOOLEAN) is
			-- Mark current generation to generate verifiable code.
		do
			is_verifiable := verifiable
		ensure then
			is_verifiable_set: is_verifiable = verifiable
		end

	set_cls_compliant (cls_compliant: BOOLEAN) is
			-- Mark current generation to generate cls_compliant code.
		do
			is_cls_compliant := cls_compliant
		ensure then
			is_cls_compliant_set: is_cls_compliant = cls_compliant
		end

feature -- Class info

	initialize_class_mappings (class_count: INTEGER) is
			-- Initialize structures that holds some system data during code generation.
		do
			create internal_il_modules.make (0, class_count)
			create file_token.make (10)
			create external_class_mapping.make (class_count)

				-- Predefined .NET basic types.
			external_class_mapping.put (create {BOOLEAN_I}, "System.Boolean")
			external_class_mapping.put (create {CHAR_I}.make (False), "System.Char")
			external_class_mapping.put (create {NATURAL_I}.make (8), "System.Byte")
			external_class_mapping.put (create {NATURAL_I}.make (16), "System.IUnt16")
			external_class_mapping.put (create {NATURAL_I}.make (32), "System.IUnt32")
			external_class_mapping.put (create {NATURAL_I}.make (64), "System.UInt64")
			external_class_mapping.put (create {INTEGER_I}.make (8), "System.SByte")
			external_class_mapping.put (create {INTEGER_I}.make (16), "System.Int16")
			external_class_mapping.put (create {INTEGER_I}.make (32), "System.Int32")
			external_class_mapping.put (create {INTEGER_I}.make (64), "System.Int64")
			external_class_mapping.put (create {REAL_32_I}, "System.Float")
			external_class_mapping.put (create {REAL_64_I}, "System.Double")
			external_class_mapping.put (create {POINTER_I}, "System.IntPtr")

			create signatures_table.make (0, class_count)
			create implementation_signatures_table.make (0, class_count)

				-- Debug data structure.
			internal_class_types := Void
		end

	generate_class_mappings (class_type: CLASS_TYPE; for_interface: BOOLEAN) is
			-- Define all types, both external and eiffel one.
		require
			class_type_not_void: class_type /= Void
			class_type_generated: class_type.is_generated
		do
			if for_interface then
				current_module.generate_interface_class_mapping (class_type)
			elseif not class_type.is_generated_as_single_type then
				current_module.generate_implementation_class_mapping (class_type)
			end
		end

	generate_class_interfaces (class_type: CLASS_TYPE; class_c: CLASS_C) is
			-- Initialize `class_interface' from `class_type' with info from `class_c'.
		require
			class_type_not_void: class_type /= Void
			class_c_not_void: class_c /= Void
		local
			pars: SEARCH_TABLE [CLASS_INTERFACE]
			class_interface: CLASS_INTERFACE
			parent_type: CL_TYPE_I
			parents: FIXED_LIST [CL_TYPE_A]
			l_native_array: NATIVE_ARRAY_CLASS_TYPE
			l_type: CL_TYPE_I
		do
			l_native_array ?= class_type
			if l_native_array /= Void then
				external_class_mapping.put (class_type.type, l_native_array.il_type_name)
			elseif
				class_type.is_external and then
				not (class_c.is_basic and then class_c.is_typed_pointer)
			then
					-- We do not process TYPED_POINTER as it is not a real class type in .NET so
					-- TYPED_POINTER doesn't really have a `full_il_type_name'.
				l_type := class_type.type
				external_class_mapping.put (l_type, class_type.full_il_type_name)
			end

			parents := class_c.parents
			create class_interface.make_from_context (class_c.class_interface, class_type)
			create pars.make (parents.count)

			from
				parents.start
			until
				parents.after
			loop
				parent_type ?= byte_context.real_type_in (parents.item.type_i, class_type)
				pars.force (parent_type.associated_class_type.class_interface)
				parents.forth
			end

			class_interface.set_parents (pars)
			class_type.set_class_interface (class_interface)
		end

	generate_class_attributes (class_type: CLASS_TYPE) is
			-- Define custom attributes of `class_type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_class: CLASS_C
			l_attributes: BYTE_LIST [BYTE_NODE]
		do
			current_class_type := class_type
			l_class := class_type.associated_class
			create l_ca_factory

				-- First we generate attributes common to both generated class and interface.
			l_attributes := l_class.custom_attributes
			if l_attributes /= Void then
				l_ca_factory.generate_custom_attributes (
					actual_class_type_token (class_type.implementation_id), l_attributes)
					-- Generate custome attribute on interface if it is generated.
				if class_type.static_type_id /= class_type.implementation_id then
					l_ca_factory.generate_custom_attributes (
						actual_class_type_token (class_type.static_type_id), l_attributes)
				end
			end

				-- Then we generate only class or interface specific attribute if we indeed
				-- generate a class and an interface associated to an Eiffel class.
			if class_type.static_type_id /= class_type.implementation_id then
				l_attributes := l_class.class_custom_attributes
				if l_attributes /= Void then
					l_ca_factory.generate_custom_attributes (
						actual_class_type_token (class_type.implementation_id), l_attributes)
				end
				l_attributes := l_class.interface_custom_attributes
				if l_attributes /= Void then
					l_ca_factory.generate_custom_attributes (
						actual_class_type_token (class_type.static_type_id), l_attributes)
				end
			end
			define_interface_type (class_type, actual_class_type_token (class_type.implementation_id))
		end

	define_assembly_attributes is
			-- Define custom attributes for current assembly.
		local
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_class: CLASS_C
			l_attributes: BYTE_LIST [BYTE_NODE]
			l_cur_mod: like current_module
		do
			if System.root_class /= Void and then System.root_class.is_compiled then
				l_cur_mod := current_module
				current_module := main_module
				l_class := System.root_class.compiled_class
				current_class_type := l_class.types.first
				create l_ca_factory

					-- First we generate attributes common to both generated class and interface.
				l_attributes := l_class.assembly_custom_attributes
				if l_attributes /= Void then
					l_ca_factory.generate_custom_attributes (main_module.associated_assembly_token,
						l_attributes)
				end
				current_module := l_cur_mod
			end

			if is_cls_compliant then
				define_custom_attribute (main_module.associated_assembly_token,
					main_module.cls_compliant_ctor_token, cls_compliant_ca)
			end
		end

	define_constructors (class_type: CLASS_TYPE; is_reference: BOOLEAN) is
			-- Define constructors for implementation of `class_type'
		require
			class_type_not_void: class_type /= Void
		do
			current_module.define_constructors (class_type, is_reference)
		end

	define_runtime_features (class_type: CLASS_TYPE) is
			-- Define all features needed by ISE .NET runtime. It generates
			-- `____class_name', `$$____type', `____set_type', `____type',
			-- `____copy', `____is_equal' and `____standard_twin'.
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_field_sig: like field_sig
			l_type_field_token: INTEGER
			l_class_token: INTEGER
			l_name_ca: MD_CUSTOM_ATTRIBUTE
			l_class_name: STRING
			l_meth_attr: INTEGER
			l_gen_type: GEN_TYPE_I
			i, nb: INTEGER
			l_type: TYPE_I
			l_ref: REFERENCE_I
			l_cl_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
			l_ext_class: EXTERNAL_CLASS_C
			l_feature: FEATURE_I
		do
			l_class_token := actual_class_type_token (class_type.implementation_id)
			l_class_name := class_type.associated_class.name_in_upper

			if class_type.is_generic then
				l_gen_type ?= class_type.type
				create l_name_ca.make
				l_name_ca.put_string (l_class_name)
				from
					l_name_ca.put_integer_32 (l_gen_type.meta_generic.count)
					i := l_gen_type.meta_generic.lower
					nb := l_gen_type.meta_generic.upper
				until
					i > nb
				loop
					l_type := l_gen_type.meta_generic.item (i)
					l_ref ?= l_type
					if l_ref /= Void then
							-- It is a formal, simply put ANY here
						l_class_type := any_type.associated_class_type
					else
							-- It is an expanded generic derivation
						l_cl_type ?= l_type
						check
							l_cl_type_not_void: l_cl_type /= Void
						end
						l_class_type := l_cl_type.associated_class_type
						if l_cl_type.is_external then
							l_ext_class ?= l_cl_type.base_class
						end
					end
					l_class_name := l_class_type.full_il_type_name
					if l_ext_class = Void then
							-- Case of an Eiffel class (including basic type)
						if
							l_class_type.is_precompiled and then
							not l_class_type.is_external
						then
							check
								has_assembly_info: l_class_type.assembly_info /= Void
							end
							l_class_name.append (", ")
							l_class_name.append (l_class_type.assembly_info.full_name)
						end
					else
							-- External class, add assembly full name only when it is
							-- not `mscorlib'.
						if not l_ext_class.assembly.assembly_name.is_equal ("mscorlib") then
							l_class_name.append (", ")
							l_class_name.append (l_ext_class.assembly.full_name)
						end
					end
					l_name_ca.put_string (l_class_name)
					i := i + 1
				end
				l_name_ca.put_integer_16 (0)
				define_custom_attribute (l_class_token,
					current_module.ise_eiffel_name_attr_generic_ctor_token, l_name_ca)
			else
				create l_name_ca.make
				l_name_ca.put_string (l_class_name)
				l_name_ca.put_integer_16 (0)
				define_custom_attribute (l_class_token,
					current_module.ise_eiffel_name_attr_ctor_token, l_name_ca)
			end

			if is_single_inheritance_implementation or else is_single_class then
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Virtual
			else
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Virtual |
					{MD_METHOD_ATTRIBUTES}.Final
			end

				-- Define `____class_name'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			uni_string.set_string ("____class_name")
			l_meth_token := md_emit.define_method (uni_string,
				l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

			if is_cls_compliant then
				define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end

			start_new_body (l_meth_token)
			put_system_string (l_class_name)
			generate_return (True)
			method_writer.write_current_body

			if
				not is_single_inheritance_implementation and then not current_class.has_internal_single_parent or else
				(class_type.static_type_id = any_type_id or else not
				class_type.associated_class.main_parent.simple_conform_to (System.any_class.compiled_class))
			then
				l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.Final

					-- Define `$$____type'.
				l_field_sig := field_sig
				l_field_sig.reset
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_generic_type_token)
				uni_string.set_string ("$$____type")
				l_type_field_token := md_emit.define_field (uni_string, l_class_token,
					{MD_FIELD_ATTRIBUTES}.Family, l_field_sig)

				if is_cls_compliant then
					define_custom_attribute (l_type_field_token,
						current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
				end

					-- Define `____set_type'.
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_generic_type_token)

				uni_string.set_string ("____set_type")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

				if is_cls_compliant then
					define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
						not_cls_compliant_ca)
				end

				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, l_type_field_token)
				generate_return (False)
				method_writer.write_current_body

					-- Define `____type'.
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (0)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_generic_type_token)

				uni_string.set_string ("____type")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

				if is_cls_compliant then
					define_custom_attribute (l_meth_token, current_module.cls_compliant_ctor_token,
						not_cls_compliant_ca)
				end

				start_new_body (l_meth_token)
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, l_type_field_token)
				generate_return (True)
				method_writer.write_current_body


					-- Define `____standard_twin'
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (0)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

				uni_string.set_string ("____standard_twin")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

				start_new_body (l_meth_token)
					-- If `current_class_type' is expanded, cloning is done by compiler.
				if not class_type.is_expanded then
					generate_current
					method_body.put_call ({MD_OPCODES}.Call,
						current_module.memberwise_clone_token, 0, True)
					generate_check_cast (Void, class_type.type)
					generate_return (True)
				else
					generate_current
					generate_load_from_address (class_type.type)
					generate_metamorphose (class_type.type)
					generate_return (True)
				end
				method_writer.write_current_body

					-- Define `____copy'
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

				uni_string.set_string ("____copy")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				if class_type.is_expanded then
					l_feature := class_type.associated_class.feature_of_rout_id (copy_rout_id)
					l_type := argument_actual_type (l_feature.arguments.first.type_i)
					if l_type.is_expanded then
							-- Unbox a value object.
						generate_unmetamorphose (l_type)
					end
					internal_generate_feature_access (class_type.implementation_id,
						l_feature.feature_id, 1, False, False)
				else
					internal_generate_feature_access (any_type_id, copy_feat_id, 1, False, True)
				end
				generate_return (False)
				method_writer.write_current_body

					-- Define `____is_equal'
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
				l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)

				uni_string.set_string ("____is_equal")
				l_meth_token := md_emit.define_method (uni_string,
					l_class_token, l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.Managed)

				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				if class_type.is_expanded then
					l_feature := class_type.associated_class.feature_of_rout_id (is_equal_rout_id)
					l_type := argument_actual_type (l_feature.arguments.first.type_i)
					if l_type.is_expanded then
							-- Unbox a value object.
						generate_unmetamorphose (l_type)
					end
					internal_generate_feature_access (class_type.implementation_id,
						l_feature.feature_id, 1, True, False)
				else
					internal_generate_feature_access (any_type_id, is_equal_feat_id, 1, True, True)
				end
				generate_return (True)
				method_writer.write_current_body
			end
		end

	define_system_object_features (class_type: CLASS_TYPE) is
			-- Define all features of SYSTEM_OBJECT on Eiffel types so that
			-- they have a meaning. It includes:
			-- to_string, finalize, equals, get_hash_code
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			l_feat_tbl: FEATURE_TABLE
			l_select_tbl: SELECT_TABLE
			l_feat: FEATURE_I
			l_class_id: INTEGER
		do
				-- To generate those routines, we first check if they are
				-- redefined in the current class. If they are, we keep the
				-- definition given by the user, otherwise we put the Eiffel one.

				-- Gets current feature table.
			l_feat_tbl := class_type.associated_class.feature_table
			l_select_tbl := l_feat_tbl.origin_table
			l_class_id := class_type.associated_class.class_id

				-- Process `equals'
			if l_select_tbl.has (equals_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id then
					define_equals_routine (class_type)
				end
			else
				define_equals_routine (class_type)
			end

				-- Process `finalize'
			if l_select_tbl.has (finalize_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id then
					define_finalize_routine (class_type)
				end
			else
				define_finalize_routine (class_type)
			end

				-- Process `get_hash_code'
			if l_select_tbl.has (get_hash_code_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id then
					define_get_hash_code_routine (class_type)
				end
			else
				define_get_hash_code_routine (class_type)
			end

				-- Process `to_string'
			if l_select_tbl.has (to_string_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id then
					define_to_string_routine (class_type)
				end
			else
				define_to_string_routine (class_type)
			end
		end

feature {NONE} -- SYSTEM_OBJECT features

	define_equals_routine (class_type: CLASS_TYPE) is
			-- Define Eiffel implementation of `equals' from SYSTEM_OBJECT.
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
			has_any_class: system.any_class /= Void
			has_compiled_any_class: system.any_class.compiled_class /= Void
			has_feature_table_in_any_class: system.any_class.compiled_class.has_feature_table
			has_feature_table: class_type.associated_class.has_feature_table
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_class_token: INTEGER
			l_meth_attr: INTEGER
			l_label, l_end_label: IL_LABEL
			feature_i: FEATURE_I
			class_c: CLASS_C
			type_i: TYPE_I
			arg_type: TYPE_I
		do
			class_c := system.any_class.compiled_class
			feature_i := class_c.feature_table.item_id ({PREDEFINED_NAMES}.is_equal_name_id)
			if feature_i /= Void then
					-- Provide implementation matching definition of feature "out" from class ANY
				debug ("fixme")
					fixme ("Check that the signature of the feature is as expected.")
				end
				if class_type.is_expanded then
						-- Call feature directly from implementation class
					class_c := class_type.associated_class
					feature_i := class_c.feature_table.feature_of_rout_id (feature_i.rout_id_set.first)
					check
						feature_i_not_void: feature_i /= Void
					end
					type_i := class_type.type
				else
					type_i := class_c.actual_type.type_i
				end
				l_class_token := actual_class_type_token (class_type.implementation_id)
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual

				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_boolean, 0)
				l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_object, 0)

				uni_string.set_string ("Equals")
				l_meth_token := md_emit.define_method (uni_string, l_class_token,
					l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.managed)

				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				generate_is_instance_of (class_type.type)
				duplicate_top

				l_label := create_label
				l_end_label := create_label
				branch_on_false (l_label)

				arg_type := argument_actual_type (feature_i.arguments.first.type_i)
				if arg_type.is_expanded then
						-- Load value of the value object to the stack.
					generate_unmetamorphose (arg_type)
				end
				generate_feature_access (type_i, feature_i.feature_id, 1, True, True)

				branch_to (l_end_label)
				mark_label (l_label)
					-- We need to pop both Current and argument
				pop
				pop
				put_boolean_constant (False)
				mark_label (l_end_label)

				generate_return (True)
				method_writer.write_current_body
			end
		end

	define_finalize_routine (class_type: CLASS_TYPE) is
			-- Define Eiffel implementation of `finalize' from SYSTEM_OBJECT.
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
			has_feature_table: class_type.associated_class.has_feature_table
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_class_token: INTEGER
			l_meth_attr: INTEGER
			l_feat: FEATURE_I
			l_code: FEATURE_B
		do
			if System.disposable_descendants.has (class_type.associated_class) then
				l_class_token := actual_class_type_token (class_type.implementation_id)
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual

				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
				l_sig.set_parameter_count (0)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)

				uni_string.set_string ("Finalize")
				l_meth_token := md_emit.define_method (uni_string, l_class_token,
					l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.managed)

				l_feat := system.disposable_class.compiled_class.feature_table.
					item_id ({PREDEFINED_NAMES}.dispose_name_id)
				if class_type.is_expanded then
						-- Call feature directly from implementation class
					l_feat := class_type.associated_class.feature_table.feature_of_rout_id (l_feat.rout_id_set.first)
					check
						l_feat_not_void: l_feat /= Void
					end
				end
				l_code ?= l_feat.access (void_c_type)
				check
					l_code_not_void: l_code /= Void
				end

				start_new_body (l_meth_token)
				cil_node_generator.generate_il_node (Current, l_code)
				generate_return (False)
				method_writer.write_current_body
			end
		end

	define_get_hash_code_routine (class_type: CLASS_TYPE) is
			-- Define Eiffel implementation of `get_hash_code' from SYSTEM_OBJECT.
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
			has_feature_table: class_type.associated_class.has_feature_table
		local
			l_hashable_class_id: INTEGER
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_class_token: INTEGER
			l_meth_attr: INTEGER
			class_c: CLASS_C
			feature_i: FEATURE_I
			type_i: TYPE_I
		do
			l_hashable_class_id := hashable_class_id
			if l_hashable_class_id > 0 then
				if class_type.associated_class.feature_table.origin_table.has (hash_code_rout_id) then
					class_c := hashable_type.base_class
					feature_i := class_c.feature_table.item_id ({PREDEFINED_NAMES}.hash_code_name_id)
					debug ("fixme")
						fixme ("Check that the signature of the feature is as expected.")
					end
					if class_type.is_expanded then
							-- Call feature directly from implementation class
						class_c := class_type.associated_class
						feature_i := class_c.feature_table.feature_of_rout_id (feature_i.rout_id_set.first)
						check
							feature_i_not_void: feature_i /= Void
						end
						type_i := class_type.type
					else
						type_i := class_c.actual_type.type_i
					end
					l_class_token := actual_class_type_token (class_type.implementation_id)
					l_meth_attr := {MD_METHOD_ATTRIBUTES}.public |
						{MD_METHOD_ATTRIBUTES}.hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.virtual

					l_sig := method_sig
					l_sig.reset
					l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
					l_sig.set_parameter_count (0)
					l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)

					uni_string.set_string ("GetHashCode")
					l_meth_token := md_emit.define_method (uni_string, l_class_token,
						l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.managed)

					start_new_body (l_meth_token)
					generate_current
					generate_feature_access (type_i, feature_i.feature_id, 0, True, True)
					generate_return (True)
					method_writer.write_current_body
				end
			end
		end

	define_to_string_routine (class_type: CLASS_TYPE) is
			-- Define Eiffel implementation of `to_string' from SYSTEM_OBJECT.
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
			has_any_class: system.any_class /= Void
			has_compiled_any_class: system.any_class.compiled_class /= Void
			has_feature_table_in_any_class: system.any_class.compiled_class.has_feature_table
			has_feature_table: class_type.associated_class.has_feature_table
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_class_token: INTEGER
			l_meth_attr: INTEGER
			class_c: CLASS_C
			feature_i: FEATURE_I
			type_i: TYPE_I
		do
			class_c := system.any_class.compiled_class
			feature_i := class_c.feature_table.item_id ({PREDEFINED_NAMES}.out_name_id)
			if feature_i /= Void then
					-- Provide implementation matching definition of feature "out" from class ANY
				debug ("fixme")
					fixme ("Check that the signature of the feature is as expected.")
				end
				if class_type.is_expanded then
						-- Call feature directly from implementation class
					class_c := class_type.associated_class
					feature_i := class_c.feature_table.feature_of_rout_id (feature_i.rout_id_set.first)
					check
						feature_i_not_void: feature_i /= Void
					end
					type_i := class_type.type
				else
					type_i := class_c.actual_type.type_i
				end
				l_class_token := actual_class_type_token (class_type.implementation_id)
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.public |
					{MD_METHOD_ATTRIBUTES}.hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.virtual

				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
				l_sig.set_parameter_count (0)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

				uni_string.set_string ("ToString")
				l_meth_token := md_emit.define_method (uni_string, l_class_token,
					l_meth_attr, l_sig, {MD_METHOD_ATTRIBUTES}.managed)

				start_new_body (l_meth_token)

				generate_current
				generate_feature_access (type_i, feature_i.feature_id, 0, True, True)
				internal_generate_feature_access (string_type_id, to_cil_feat_id, 0, True, True)

				generate_return (True)
				method_writer.write_current_body
			end
		end

feature {NONE} -- Class info

	generate_class_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for class invariant of `class_c' and other internal
			-- features required by run-time, CIL, etc.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
				-- Define all features used by ISE runtime
			define_runtime_features (class_type)
				-- Define definition of SYSTEM_OBJECT features for .NET types
			define_system_object_features (class_type)
				-- Generate invariant routine
			generate_invariant_feature (class_c.invariant_feature)
		end

	clean_implementation_class_data is
			-- Clean current class implementation data.
		require
			current_type_id_set: current_type_id > 0
		do
			current_module.clean_implementation_class_data (current_type_id)
		end

feature -- Features info

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			type_feature_processor: PROCEDURE [ANY, TUPLE [TYPE_FEATURE_I]]
		do
			set_current_class (class_c)
			set_current_class_type (class_type)
			inst_context.set_cluster (class_c.cluster)
			is_single_class := class_type.is_generated_as_single_type

			set_current_type_id (class_type.static_type_id)
			current_class_token := actual_class_type_token (current_type_id)

			debug ("debugger_il_info_trace")
				print ("### SINGLE CLEANING " + class_type.associated_class.name_in_upper + "---%N")
			end
			clean_debug_information (class_type)

			if is_single_class then
					-- Define implementation features on Eiffel classes
				generate_features (class_c, class_type, False)
			else
					-- Define interface features on Eiffel classes
				generate_features (class_c, class_type, True)
				type_feature_processor := agent generate_type_feature_description
			end
				-- Define implementation features on Eiffel classes
			generate_il_features (class_c, class_type,
				Void,
				agent generate_local_feature_description,
				agent generate_inherited_feature_description,
				type_feature_processor)
		end

	generate_local_feature_description (local_feature: FEATURE_I; inherited_feature: FEATURE_I; class_type: CLASS_TYPE; is_replicated: BOOLEAN) is
			-- Define local feature `local_feature' with a possible precursor feature `inherited_feature' from `class_type'.
		require
			local_feature_not_void: local_feature /= Void
			class_type_not_void: class_type /= Void
		do
			generate_inherited_feature_description (local_feature, inherited_feature, class_type)
		end

	generate_inherited_feature_description (local_feature: FEATURE_I; inherited_feature: FEATURE_I; class_type: CLASS_TYPE) is
			-- Define local feature `local_feature' with a possible precursor feature `inherited_feature' from `class_type'.
		require
			local_feature_not_void: local_feature /= Void
			class_type_not_void: class_type /= Void
		local
			duplicated_feature: FEATURE_I
			proc: PROCEDURE_I
		do
			if inherited_feature /= Void then
				if
					is_method_impl_needed (local_feature, inherited_feature, class_type) or else
					is_local_signature_changed (local_feature)
				then
					generate_feature (local_feature, False, False, False)
				else
						-- Generate local definition signature using the parent
						-- signature. We do not do it on the parent itself because
						-- its `feature_id' is not appropriate in `current_class_type'.
					duplicated_feature := local_feature.duplicate
					if duplicated_feature.is_routine then
						proc ?= duplicated_feature
						proc.set_arguments (inherited_feature.arguments)
					end
					duplicated_feature.set_type (inherited_feature.type, inherited_feature.assigner_name_id)
					implementation_generate_feature (duplicated_feature, False, False, False, False, class_type)
				end
			elseif not is_single_class then
				generate_feature (local_feature, False, False, False)
			end
			if current_class_type.is_expanded and then local_feature.is_attribute then
				generate_feature (local_feature, False, True, False)
			end
		end

	generate_type_feature_description (type_feature: TYPE_FEATURE_I) is
			-- Define type feature `type_feature'.
		require
			type_feature_not_void: type_feature /= Void
		do
			generate_feature (type_feature, False, False, False)
		end

	generate_features (class_c: CLASS_C; class_type: CLASS_TYPE; is_interface: BOOLEAN) is
			-- Generate features written in `class_c' for interface
			-- (`is_interface' is `True') or implementation (`is_interface' is `False').
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			sorted_array: SORTABLE_ARRAY [FEATURE_I]
			i: INTEGER
		do
				-- Features have to be generated in alphabetical order
				-- as this order is expected by COM Interop that defines
				-- the virtual table this way.
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				i := features.count
				create sorted_array.make (1, i)
				features.start
			invariant
				consistent_index: (i = 0) = features.after
			until
				i = 0
			loop
				sorted_array.put (select_tbl.item (features.item_for_iteration), i)
				features.forth
				i := i - 1
			end
			sorted_array.sort
			sorted_array.do_all (agent generate_feature (?, is_interface, False, False))

				-- Generate type features for formal generic parameters.
			if class_c.generic_features /= Void then
				generate_type_features (class_c.generic_features, class_c.class_id, is_interface)
			end

				-- Generate type features for feature used as anchor.
			if class_c.anchored_features /= Void then
				generate_type_features (class_c.anchored_features, class_c.class_id, is_interface)
			end
		end

	define_feature_reference (a_type_id, a_feature_id: INTEGER;
			in_interface, is_static, is_override: BOOLEAN)
		is
			-- Define reference to feature `a_feature_id' defined in `a_type_id'.
		require
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
		local
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
			l_meth_token, l_setter_token: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_I
			i: INTEGER
			l_signature: ARRAY [INTEGER]
			l_is_c_external: BOOLEAN
			l_class_token: like current_class_token
			l_ext: IL_EXTENSION_I
			l_naming_convention: BOOLEAN
			l_is_single_class: BOOLEAN
			l_is_static: BOOLEAN
			l_is_attribute_generated_as_field: BOOLEAN
			l_declaration_class: CLASS_C
		do
			l_class_type := class_types.item (a_type_id)
			l_class_token := actual_class_type_token (a_type_id)
			l_feat := l_class_type.associated_class.feature_of_feature_id (a_feature_id)
			l_is_single_class := l_class_type.is_generated_as_single_type

			l_is_attribute := l_feat.is_attribute
			l_is_c_external := l_feat.is_c_external

			if l_feat.is_il_external then
				l_ext ?= l_feat.extension
				check
					has_extension: l_ext /= Void
				end
				l_is_static := not l_ext.need_current (l_ext.type)
			elseif l_class_type.is_expanded and then l_is_attribute then
				l_is_static := True
			elseif not l_is_single_class then
				l_is_static := is_static
			end

			l_parameter_count := l_feat.argument_count

			create l_signature.make (0, l_parameter_count)
			l_signature.compare_references

			l_return_type := result_type_in (l_feat, l_class_type)

			l_is_attribute_generated_as_field := l_is_attribute and (l_is_single_class or (not in_interface and l_is_static))

			if not l_feat.is_type_feature then
					-- Only for not automatically generated feature do we use the
					-- naming convention chosen by user.
				l_naming_convention := l_class_type.is_dotnet_name
			end

				-- When we are handling with an external feature, we have to extract its
				-- real name, not the Eiffel one.
			if l_ext /= Void then
				l_name := l_ext.alias_name
			else
				if l_feat.is_type_feature then
					l_name := l_feat.feature_name
				else
					if l_is_static then
						if l_is_c_external then
							l_name := encoder.feature_name (l_class_type.static_type_id,
								l_feat.body_index)
						else
							if l_is_attribute then
								l_name := "$$" + il_casing.camel_casing (
									l_naming_convention, l_feat.feature_name)
							else
								l_name := "$$" + il_casing.pascal_casing (
									l_naming_convention, l_feat.feature_name,
									{IL_CASING_CONVERSION}.lower_case)
							end
						end
					else
						l_name := il_casing.pascal_casing (
							l_naming_convention, l_feat.feature_name,
							{IL_CASING_CONVERSION}.lower_case)
						if l_is_attribute then
							prepare_property_getter (l_name, l_return_type)
							current_module.insert_property_getter (md_emit.define_member_ref
								(uni_string, l_class_token, method_sig), a_type_id, l_feat.feature_id)
							prepare_property_setter (l_name, l_return_type)
							current_module.insert_property_setter (md_emit.define_member_ref
								(uni_string, l_class_token, method_sig), a_type_id, l_feat.feature_id)
							if
								l_is_single_class and then not is_override and then
								(l_feat.export_status.is_all or else
								 l_feat.assigner_name_id /= 0 and then l_feat.assigner_in (l_class_type).export_status.is_all)
							then
									-- Use a field name different from the property name.
								l_name := "$$" + il_casing.camel_casing (
									l_naming_convention, l_feat.feature_name)
							end
						end
					end
				end
			end

			uni_string.set_string (l_name)

			if l_is_attribute_generated_as_field then
					-- Evaluate signature of the field.
				l_field_sig := field_sig
				l_field_sig.reset
				set_signature_type (l_field_sig, l_return_type)
				l_signature.put (l_return_type.static_type_id, 0)

				if l_feat.origin_class_id = 0 then
					l_declaration_class := system.class_of_id (l_feat.access_in)
				else
					l_declaration_class := system.class_of_id (l_feat.origin_class_id)
				end
				if
					l_declaration_class.is_external or else
					l_declaration_class.is_single and then l_declaration_class /= l_class_type.associated_class
				then
						-- No field is generated because it is inherited.
					check
						is_single_class: is_single_class
					end
					l_meth_token := attribute_token (implemented_type
						(l_declaration_class.class_id, current_class_type.type).associated_class_type.static_type_id,
						l_declaration_class.feature_of_rout_id (l_feat.rout_id_set.first).feature_id)
				else
					l_meth_token := md_emit.define_member_ref (uni_string, l_class_token,
						l_field_sig)
				end
				insert_attribute (l_meth_token, a_type_id, l_feat.feature_id)
				if l_is_single_class then
					insert_signature (l_signature, a_type_id, l_feat.feature_id)
				end
			else
					-- Normal method.
					-- Evaluate its signature.
				l_meth_sig := method_sig
				l_meth_sig.reset
				if l_is_static and not in_interface then
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if l_is_static and not l_is_c_external then
					l_meth_sig.set_parameter_count (l_parameter_count + 1)
				else
					l_meth_sig.set_parameter_count (l_parameter_count)
				end

				if l_feat.is_function or l_is_attribute or l_feat.is_constant then
					set_method_return_type (l_meth_sig, l_return_type)
					l_signature.put (l_return_type.static_type_id, 0)
				elseif l_feat.is_type_feature then
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.ise_type_token)
				else
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

				if l_is_static and not l_is_c_external then
					set_signature_type (l_meth_sig, l_class_type.type)
				end

				if l_feat.has_arguments then
					from
						l_feat_arg := l_feat.arguments
						l_feat_arg.start
						i := 0
					until
						l_feat_arg.after
					loop
						l_type_i := argument_actual_type_in (l_feat_arg.item.type_i, l_class_type)
						set_signature_type (l_meth_sig, l_type_i)
						l_signature.put (l_type_i.static_type_id, i + 1)
						i := i + 1
						l_feat_arg.forth
					end
				end

				l_meth_token := md_emit.define_member_ref (uni_string, l_class_token,
					l_meth_sig)

				if not l_is_static and l_is_attribute and not is_override then
						-- Let's define attribute setter.
					l_meth_sig.reset
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					set_signature_type (l_meth_sig, l_return_type)
					uni_string.set_string (setter_prefix + l_name)
					l_setter_token := md_emit.define_member_ref (uni_string,
						l_class_token, l_meth_sig)

					insert_setter (l_setter_token, a_type_id, l_feat.feature_id)
				end

				if not is_override then
					if l_is_single_class then
						insert_implementation_feature (l_meth_token, a_type_id,
							l_feat.feature_id)
						insert_implementation_signature (l_signature, a_type_id,
							l_feat.feature_id)
						insert_feature (l_meth_token, a_type_id, l_feat.feature_id)
						insert_signature (l_signature, a_type_id, l_feat.feature_id)
					else
						if l_is_static then
							insert_implementation_feature (l_meth_token, a_type_id,
								l_feat.feature_id)
							insert_implementation_signature (l_signature, a_type_id,
								l_feat.feature_id)
						else
							insert_feature (l_meth_token, a_type_id, l_feat.feature_id)
							insert_signature (l_signature, a_type_id, l_feat.feature_id)
						end
					end
				else
					last_non_recorded_feature_token := l_meth_token
				end
			end
		end

	generate_feature (feat: FEATURE_I; in_interface, is_static, is_override_or_c_external: BOOLEAN) is
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		do
			implementation_generate_feature (feat, in_interface, is_static, is_override_or_c_external, False, byte_context.class_type)
		end

	implementation_generate_feature (
			feat: FEATURE_I; in_interface, is_static, is_override_or_c_external, is_empty: BOOLEAN; signature_declaration_type: CLASS_TYPE)
		is
			-- Generate interface `feat' description using for `signature_declaration_type' for signature evaluation.
		require
			feat_not_void: feat /= Void
			signature_declaration_type_not_void: signature_declaration_type /= Void
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_feature: TYPE_FEATURE_I
			l_type_i: TYPE_I
			l_type_a: TYPE_A
			l_meth_token, l_setter_token: INTEGER
			l_param_token: INTEGER
			l_meth_attr: INTEGER
			l_field_attr: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_I
			l_has_arguments: BOOLEAN
			i, j: INTEGER
			l_signature: ARRAY [INTEGER]
			l_is_c_external: BOOLEAN
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_naming_convention: BOOLEAN
			l_name_ca: MD_CUSTOM_ATTRIBUTE
			l_is_attribute_generated_as_field: BOOLEAN
			l_is_field_hidden: BOOLEAN
			l_declaration_class: CLASS_C
			l_assigner: FEATURE_I
			l_getter: INTEGER
			l_setter: INTEGER
			l_property_token: INTEGER
		do
			last_property_getter_token :=  {MD_TOKEN_TYPES}.md_method_def
			last_property_setter_token :=  {MD_TOKEN_TYPES}.md_method_def
			l_is_attribute := feat.is_attribute
			l_is_c_external := feat.is_c_external
			l_parameter_count := feat.argument_count

			create l_signature.make (0, l_parameter_count)
			l_signature.compare_references

			l_return_type := result_type_in (feat, signature_declaration_type)
			l_is_attribute_generated_as_field := l_is_attribute and then
				((is_single_class and not current_class_type.is_expanded and not is_override_or_c_external) or
				(not in_interface and is_static))
			if l_is_attribute_generated_as_field then
				l_field_sig := field_sig
				l_field_sig.reset
				set_signature_type (l_field_sig, l_return_type)
				l_signature.put (l_return_type.static_type_id, 0)
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if is_static and not in_interface then
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if is_static and not l_is_c_external then
					l_meth_sig.set_parameter_count (l_parameter_count + 1)
				else
					l_meth_sig.set_parameter_count (l_parameter_count)
				end

				if feat.is_function or l_is_attribute or feat.is_constant then
					set_method_return_type (l_meth_sig, l_return_type)
					l_signature.put (l_return_type.static_type_id, 0)
				elseif feat.is_type_feature then
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.ise_type_token)
				else
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

				if is_static and not l_is_c_external then
					set_signature_type (l_meth_sig, current_class_type.type)
				end

				if feat.has_arguments then
					l_has_arguments := True
					from
						l_feat_arg := feat.arguments
						l_feat_arg.start
						i := 0
					until
						l_feat_arg.after
					loop
						l_type_i := argument_actual_type_in (l_feat_arg.item.type_i, signature_declaration_type)
						set_signature_type (l_meth_sig, l_type_i)
						l_signature.put (l_type_i.static_type_id, i + 1)
						i := i + 1
						l_feat_arg.forth
					end
				end
			end

			if not feat.is_type_feature then
					-- Only for not automatically generated feature do we use the
					-- naming convention chosen by user.
				l_naming_convention := System.dotnet_naming_convention
			end
			if is_static then
				if l_is_c_external then
					l_name := encoder.feature_name (current_class_type.static_type_id,
						feat.body_index)
				else
					if l_is_attribute then
						l_name := "$$" + il_casing.camel_casing (
							l_naming_convention, feat.feature_name)
							-- Ensure the field is not accessible outside Eiffel system.
						l_is_field_hidden := True
					else
						l_name := "$$" + il_casing.pascal_casing (
							l_naming_convention, feat.feature_name,
							{IL_CASING_CONVERSION}.lower_case)
					end
				end
			else
				l_name := il_casing.pascal_casing (
					l_naming_convention, feat.feature_name,
					{IL_CASING_CONVERSION}.lower_case)
				if l_is_attribute then
						-- Define property for an attribute.
					l_getter := {MD_TOKEN_TYPES}.md_method_def
					l_setter := {MD_TOKEN_TYPES}.md_method_def
					l_meth_sig := method_sig
					if in_interface then
						l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
							{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
							{MD_METHOD_ATTRIBUTES}.Virtual |
							{MD_METHOD_ATTRIBUTES}.Abstract
					else
						l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
							{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
							{MD_METHOD_ATTRIBUTES}.Virtual
					end
						-- Define setter method.
					prepare_property_setter (l_name, l_return_type)
					debug ("refactor_to_implement")
						to_implement ("Support special name for setter.")
						-- l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.special_name
					end
					l_setter := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)
					if is_override_or_c_external then
						last_property_setter_token := l_setter
					else
						current_module.insert_property_setter (l_setter, current_type_id, feat.feature_id)
					end
					l_assigner := feat.assigner_in (signature_declaration_type)
					if l_assigner = Void or else not l_assigner.export_status.is_all then
							-- Avoid listing this method as a property setter.
						l_setter := {MD_TOKEN_TYPES}.md_method_def
					end
						-- Define getter method.
					prepare_property_getter (l_name, l_return_type)
					debug ("refactor_to_implement")
						to_implement ("Support special name for getter.")
						-- l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.special_name
					end
					l_getter := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)
					if is_override_or_c_external then
						last_property_getter_token := l_getter
					else
						current_module.insert_property_getter (l_getter, current_type_id, feat.feature_id)
					end
					if not feat.export_status.is_all then
							-- Avoid listing this method as a property getter.
						l_getter := {MD_TOKEN_TYPES}.md_method_def
					end
					if (is_single_class or else in_interface) and then not is_override_or_c_external and then
						(l_getter /= {MD_TOKEN_TYPES}.md_method_def or else l_setter /= {MD_TOKEN_TYPES}.md_method_def)
					then
							-- Define property on a single class or interface only.
						uni_string.set_string (l_name)
						property_sig.reset
						property_sig.set_property_type ({MD_SIGNATURE_CONSTANTS}.property_sig | {MD_SIGNATURE_CONSTANTS}.has_current)
						property_sig.set_parameter_count (0)
						set_signature_type (property_sig, l_return_type)
						l_property_token := md_emit.define_property (current_class_token, uni_string, 0, property_sig, l_setter, l_getter)
						if l_is_attribute_generated_as_field then
								-- Use a field name different from the property name.
							l_name := "$$" + il_casing.camel_casing (
								l_naming_convention, feat.feature_name)
								-- Ensure the field is not accessible outside Eiffel system.
							l_is_field_hidden := True
						end
					end
				end
			end

			uni_string.set_string (l_name)

			if l_is_attribute_generated_as_field then
				if feat.origin_class_id = 0 then
					l_declaration_class := system.class_of_id (feat.access_in)
				else
					l_declaration_class := system.class_of_id (feat.origin_class_id)
				end
				if
					l_declaration_class.is_external or else
					l_declaration_class.is_single and then l_declaration_class /= current_class
				then
						-- No field is generated because it is inherited.
					check
						is_single_class: is_single_class
					end
					l_meth_token := attribute_token (implemented_type
						(l_declaration_class.class_id, current_class_type.type).associated_class_type.static_type_id,
						l_declaration_class.feature_of_rout_id (feat.rout_id_set.first).feature_id)
				else
					if l_is_field_hidden and then not Compilation_modes.is_precompiling then
						l_field_attr := {MD_FIELD_ATTRIBUTES}.family_or_assembly
					else
						l_field_attr := {MD_FIELD_ATTRIBUTES}.public
					end

					l_meth_token := md_emit.define_field (uni_string, current_class_token,
						l_field_attr, l_field_sig)

						-- Define associated name corresponding to the Eiffel name
					create l_name_ca.make
					l_name_ca.put_string (feat.feature_name)
					l_name_ca.put_integer_16 (0)
					define_custom_attribute (l_meth_token,
						current_module.ise_eiffel_name_attr_ctor_token, l_name_ca)

						-- Define name of routine used to find out the attribute static type
						-- if it is generic or a formal.
					l_type_a := feat.type.actual_type
					if l_type_a.is_formal or l_type_a.has_generics then
							-- Lookup associated TYPE_FEATURE_I to get its name
						l_type_feature := current_class_type.associated_class.anchored_features.item
							(feat.rout_id_set.first)
						check
							l_type_feature_not_void: l_type_feature /= Void
						end
						create l_name_ca.make
						l_name_ca.put_string (l_type_feature.feature_name)
						l_name_ca.put_integer_16 (0)
						define_custom_attribute (l_meth_token,
							current_module.ise_type_feature_attr_ctor_token, l_name_ca)
					elseif
						l_type_a.has_associated_class and then
						l_type_a.associated_class.lace_class = system.any_class
					then
							-- Type is ANY, so because we actually generate a field of type SYSTEM_OBJECT
							-- we generate a special custom attribute that says it is actually ANY, and not
							-- a field of type SYSTEM_OBJECT
						define_interface_type (l_type_a.associated_class.types.first, l_meth_token)
					end
				end

				insert_attribute (l_meth_token, current_type_id, feat.feature_id)
				if is_single_class then
					insert_signature (l_signature, current_type_id, feat.feature_id)
				end
			else
				l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature

				if in_interface then
					l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.Virtual |
						{MD_METHOD_ATTRIBUTES}.Abstract |
						{MD_METHOD_ATTRIBUTES}.New_slot
				else
					if is_static then
						l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.Static
					else
						l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.Virtual
						if feat.is_origin then
							l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.New_slot
						end
						if feat.is_deferred and not is_empty and not is_override_or_c_external then
							l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.Abstract
						end
					end
				end

				if is_static and l_is_c_external then
						-- Let's define Pinvoke here.
					l_meth_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed |
						{MD_METHOD_ATTRIBUTES}.Preserve_sig)
					md_emit.define_pinvoke_map (l_meth_token,
						{MD_PINVOKE_CONSTANTS}.Charset_ansi |
						{MD_PINVOKE_CONSTANTS}.Stdcall, uni_string,
						current_module.c_module_token)
				else
						-- Normal method
					l_meth_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)
				end

				if is_cls_compliant and (is_static or feat.is_type_feature) then
					define_custom_attribute (l_meth_token,
						current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
				end
				if feat.is_type_feature then
					define_custom_attribute (l_meth_token,
						current_module.com_visible_ctor_token, not_com_visible_ca)
				end

				if not is_static and l_is_attribute and not is_override_or_c_external then
						-- Let's define attribute setter.
					if in_interface then
						l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
							{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
							{MD_METHOD_ATTRIBUTES}.Virtual |
							{MD_METHOD_ATTRIBUTES}.Abstract
					else
						l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
							{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
							{MD_METHOD_ATTRIBUTES}.Virtual
					end

					l_meth_sig.reset
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					set_signature_type (l_meth_sig, l_return_type)
					uni_string.set_string (setter_prefix + l_name)
					l_setter_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)

					insert_setter (l_setter_token, current_type_id, feat.feature_id)

					create l_ca_factory
					l_ca_factory.set_feature_custom_attributes (feat, l_setter_token)

					if is_cls_compliant then
						define_custom_attribute (l_setter_token,
							current_module.cls_compliant_ctor_token, not_cls_compliant_ca)
					end
				end

					-- Let's generate argument names now.
				if is_static and not l_is_c_external then
						-- Offset for static features as we generate one more argument.
					j := 1
						-- Current needs to be generated only for static wrapper of Eiffel
						-- feature so that metadata consumer can pick the name (e.g. debugger)
						-- but it is not needed when it is defined as an instance method.
					uni_string.set_string ("Current")
					l_param_token := md_emit.define_parameter (l_meth_token, uni_string, j,
						{MD_PARAM_ATTRIBUTES}.In)
				end

				if is_static and then l_is_c_external then
					if l_return_type /= Void and then l_return_type.is_boolean then
						uni_string.set_string ("Result")
						l_param_token := md_emit.define_parameter (l_meth_token,
							uni_string, 0, 0)
						md_emit.set_field_marshal (l_param_token, boolean_native_signature)
					end
				end

				if l_has_arguments then
					from
						l_feat_arg := feat.arguments
						i := 1
					until
						i > l_parameter_count
					loop
						uni_string.set_string (l_feat_arg.item_name (i))
						l_param_token := md_emit.define_parameter (l_meth_token, uni_string,
							i + j, {MD_PARAM_ATTRIBUTES}.In)
						i := i + 1
					end
				end

				if not is_override_or_c_external then
					if is_single_class then
						insert_implementation_feature (l_meth_token, current_type_id,
							feat.feature_id)
						insert_implementation_signature (l_signature, current_type_id,
							feat.feature_id)
						insert_feature (l_meth_token, current_type_id, feat.feature_id)
						insert_signature (l_signature, current_type_id, feat.feature_id)
					else
						if is_static then
							insert_implementation_feature (l_meth_token, current_type_id,
								feat.feature_id)
							insert_implementation_signature (l_signature, current_type_id,
								feat.feature_id)
						else
							insert_feature (l_meth_token, current_type_id, feat.feature_id)
							insert_signature (l_signature, current_type_id, feat.feature_id)
						end
					end
				else
					last_non_recorded_feature_token := l_meth_token
				end
			end
			if not is_override_or_c_external and (not is_static or else l_is_attribute) then
				create l_ca_factory
				l_ca_factory.set_feature_custom_attributes (feat, l_meth_token)
				if l_property_token /= 0 then
					l_ca_factory.set_feature_custom_attributes (feat, l_property_token)
				end
			end
			if is_debug_info_enabled and l_is_attribute then
				Il_debug_info_recorder.set_record_context (is_single_class, l_is_attribute, is_static, in_interface)
				Il_debug_info_recorder.record_il_feature_info (current_module, current_class_type, feat, current_class_token, l_meth_token)
			end
		end

	argument_actual_type (a_type: TYPE_I): TYPE_I is
			-- Compute real type of Current in current generated class.
		require
			a_type_not_void: a_type /= Void
		do
			if a_type.is_none then
				Result := System.any_class.compiled_class.types.first.type
			else
				Result := byte_context.real_type (a_type)
			end
		ensure
			valid_result: Result /= Void
		end

	result_type (feature_i: FEATURE_I): TYPE_I is
			-- Actual type of a result of feature `feature_i'
		require
			feature_i_not_viod: feature_i /= Void
		do
			Result := argument_actual_type (feature_i.type.type_i)
		ensure
			result_not_void: Result /= Void
			void_if_procedure: not feature_i.has_return_value implies Result.is_void
		end

	argument_actual_type_in (a_type: TYPE_I; class_type: CLASS_TYPE): TYPE_I is
			-- Compute real type of `a_type' in `class_type'.
		require
			a_type_not_void: a_type /= Void
			class_type_not_void: class_type /= Void
		do
			if a_type.is_none then
				Result := System.any_class.compiled_class.types.first.type
			else
				Result := byte_context.real_type_in (a_type, class_type)
			end
		ensure
			valid_result: Result /= Void
		end

	result_type_in (feature_i: FEATURE_I; class_type: CLASS_TYPE): TYPE_I is
			-- Actual type of a result of feature `feature_i' in `class_type'
		require
			feature_i_not_viod: feature_i /= Void
			class_type_not_void: class_type /= Void
		do
			Result := argument_actual_type_in (feature_i.type.type_i, class_type)
		ensure
			result_not_void: Result /= Void
			void_if_procedure: not feature_i.has_return_value implies Result.is_void
		end

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		do
			current_module.set_method_return_type (a_sig, a_type)
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		do
			current_module.set_signature_type (a_sig, a_type)
		end

	generate_type_features (feats: HASH_TABLE [TYPE_FEATURE_I, INTEGER]; class_id: INTEGER; is_interface: BOOLEAN) is
			-- Generate all TYPE_FEATURE_I that must be generated in
			-- interface corresponding to class ID `class_id'.
		require
			feats_not_void: feats /= Void
		local
			l_type_feature: TYPE_FEATURE_I
		do
			from
				feats.start
			until
				feats.after
			loop
				l_type_feature := feats.item_for_iteration
				if is_interface implies l_type_feature.origin_class_id = class_id then
					generate_feature (l_type_feature, is_interface, False, False)
				end
				feats.forth
			end
		end

	prepare_property_getter (name: STRING; return_type: TYPE_I) is
			-- Fill `uni_string' and `method_sig' with a property getter data.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			return_type_not_void: return_type /= Void
		local
			l_meth_sig: like method_sig
		do
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			l_meth_sig.set_parameter_count (0)
			set_signature_type (l_meth_sig, return_type)
			debug ("refactor_to_implement")
				to_implement ("Support special name for getter.")
			end
			uni_string.set_string (property_getter_prefix + name)
		end

	prepare_property_setter (name: STRING; return_type: TYPE_I) is
			-- Fill `uni_string' and `method_sig' with a property setter data.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			return_type_not_void: return_type /= Void
		local
			l_meth_sig: like method_sig
		do
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
			set_signature_type (l_meth_sig, return_type)
			debug ("refactor_to_implement")
				to_implement ("Support special name for setter.")
			end
			uni_string.set_string (property_setter_prefix + name)
		end

feature -- IL Generation

	generate_creation_procedures (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for creation procedures in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			create_name: STRING
			l_attributes: INTEGER
			l_creators: HASH_TABLE [EXPORT_I, STRING]
			l_feat_tbl: FEATURE_TABLE
			l_feat: FEATURE_I
			l_type_token: INTEGER
			l_is_generic: BOOLEAN
		do
			l_creators := class_c.creators

				-- Let's define factory class if needed, i.e.:
				-- 1 - class is not deferred
				-- 2 - class has exported creation procedure
				-- 3 - class has automatic `default_create' procedure
			if not class_c.is_deferred and (l_creators = Void or else not l_creators.is_empty) then
				l_is_generic := class_c.is_generic
				create_name := class_type.full_il_create_type_name
				l_attributes := {MD_TYPE_ATTRIBUTES}.Public |
					{MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Is_class
				uni_string.set_string (create_name)
				l_type_token := md_emit.define_type (uni_string, l_attributes,
					current_module.object_type_token, Void)

				if not is_single_module then
					class_type.set_last_create_type_token (l_type_token)
				end

				current_class_token := l_type_token
				current_class_type := class_type

				if l_creators = Void then
					l_feat := class_c.default_create_feature
						-- It is not guaranteed that a class defines `default_create', e.g.
						-- a class that does not inherit from ANY.
					if l_feat /= Void then
						generate_creation_procedure (class_c, class_type, l_feat, l_is_generic)
					end
				else
					from
						l_creators.start
						l_feat_tbl := class_c.feature_table
					until
						l_creators.after
					loop
						l_feat := l_feat_tbl.item (l_creators.key_for_iteration)
						generate_creation_procedure (class_c, class_type, l_feat, l_is_generic)
						l_creators.forth
					end
				end
			end
		end

	generate_creation_procedure (class_c: CLASS_C; class_type: CLASS_TYPE; feat: FEATURE_I; is_generic: BOOLEAN) is
			-- Generate IL code for creation procedures in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
			feat_not_void: feat /= Void
			feat_not_attribute: not feat.is_attribute
			feat_not_function: not feat.is_function
			feat_not_deferred: not feat.is_deferred
			feat_not_constant: not feat.is_constant
			feat_not_type_feature: not feat.is_type_feature
		local
			l_meth_sig: like method_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_external_i: EXTERNAL_I
			l_is_il_external: BOOLEAN
			l_type_i: TYPE_I
			l_meth_token, l_meth_attr: INTEGER
			l_count: INTEGER
			i, nb: INTEGER
		do
			if class_type.associated_class.name_in_upper.is_equal (once "SPECIAL") or class_c.name_in_upper.is_equal (once "SPECIAL") then
				nb := feat.argument_count
			end

			nb := feat.argument_count
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			if is_generic then
				l_meth_sig.set_parameter_count (nb + 1)
			else
				l_meth_sig.set_parameter_count (nb)
			end
			set_method_return_type (l_meth_sig, current_class_type.type)

			if feat.is_external then
				l_external_i ?= feat
				if l_external_i /= Void then
					l_is_il_external := l_external_i.extension.is_il
				end
			end

			if nb > 0 then
					-- Only added arguments when calling parent ctor with arguments
				from
					l_feat_arg := feat.arguments
					l_feat_arg.start
				until
					l_feat_arg.after
				loop
					l_type_i := argument_actual_type (l_feat_arg.item.type_i)
					set_signature_type (l_meth_sig, l_type_i)
					l_feat_arg.forth
				end
			end
			if is_generic then
				l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
					current_module.ise_generic_type_token)
			end

			l_name := il_casing.pascal_casing (System.dotnet_naming_convention,
				feat.feature_name, {IL_CASING_CONVERSION}.lower_case)

			uni_string.set_string (l_name)

			l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public |
				{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
				{MD_METHOD_ATTRIBUTES}.Static

				-- Normal method
			l_meth_token := md_emit.define_method (uni_string, current_class_token,
				l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)

			start_new_body (l_meth_token)

				-- Generate constructor arguments
			if l_is_il_external and then nb > 0 then
				l_count := feat.argument_count
				from
					i := 0
				until
					i = nb
				loop
					generate_argument (i)
					i := i + 1
				end
			end

			if l_is_il_external then
				create_object_with_args (current_class_type.implementation_id, feat.argument_count)
			else
				create_object (current_class_type.implementation_id)
			end

			if not l_is_il_external then
				if current_class_type.is_expanded then
						-- Box expanded object.
					generate_metamorphose (current_class_type.type)
				end
				if is_generic then
					duplicate_top
					generate_argument (nb)
					method_body.put_call ({MD_OPCODES}.callvirt,
						current_module.ise_set_type_token, 1, False)
				end
				if current_class_type.is_expanded then
						-- Take address of expanded object.
					generate_load_address (current_class_type.type)
				end
				duplicate_top
				if nb > 0 then
					from
					until
						i >= nb
					loop
						generate_argument (i)
						i := i + 1
					end
				end
				if current_class_type.is_expanded then
					method_body.put_call ({MD_OPCODES}.Call,
						feature_token (current_class_type.implementation_id,
							current_class_type.associated_class.feature_of_rout_id (feat.rout_id_set.first).feature_id), nb, False)
				else
					method_body.put_call ({MD_OPCODES}.callvirt,
						feature_token (implemented_type (feat.origin_class_id, current_class_type.type).static_type_id, feat.origin_feature_id),
						nb, False)
				end
				fixme ("Generate class invariant check (if enabled).")
				if current_class_type.is_expanded then
						-- Load expanded object value.
					generate_load_from_address (current_class_type.type)
				end
			end

			generate_return (True)
			store_locals (l_meth_token)
			method_writer.write_current_body
			byte_context.clear_feature_data
		end

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		deferred
		end

	generate_il_features (class_c: CLASS_C; class_type: CLASS_TYPE;
			implemented_feature_processor: PROCEDURE [ANY, TUPLE [FEATURE_I, CLASS_TYPE, FEATURE_I]];
			local_feature_processor: PROCEDURE [ANY, TUPLE [FEATURE_I, FEATURE_I, CLASS_TYPE, BOOLEAN]];
			inherited_feature_processor: PROCEDURE [ANY, TUPLE [FEATURE_I, FEATURE_I, CLASS_TYPE]];
			type_feature_processor: PROCEDURE [ANY, TUPLE [TYPE_FEATURE_I]])
		is
			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			local_feature_processor_not_void: local_feature_processor /= Void
			inherited_feature_processor_not_void: inherited_feature_processor /= Void
			not_external_class_type: not class_type.is_external
		deferred
		end

	generate_empty_body (a_feat: FEATURE_I) is
			-- Generate a valid empty body for `a_feat' in `current_type_id'.
		require
			feature_not_void: a_feat /= Void
		local
			l_meth_token: INTEGER
			l_type: TYPE_I
		do
			l_meth_token := feature_token (current_type_id, a_feat.feature_id)
			start_new_body (l_meth_token)
			l_type := result_type (a_feat)
			if not l_type.is_void then
				put_default_value (l_type)
			end
			generate_return (not l_type.is_void)
			method_writer.write_current_body
		end

	generate_feature_il (feat: FEATURE_I; a_type_id, code_feature_id: INTEGER) is
			-- Specifies for which feature `feat' of `feat.feature_id' written in class of
			-- `a_type_id' IL code will be generated. If `a_type_id' is different from current
			-- type id, it means that `a_feature_id' is simply a delegation to a call on
			-- `code_feature_id' defined in `a_type_id': call to static version of feature if
			-- not `imp_inherited'.
		require
			feature_not_void: feat /= Void
			positive_type_id: a_type_id > 0
			positive_code_feature_id: code_feature_id > 0
		local
			l_token: INTEGER
			l_meth_token: INTEGER
			l_cur_sig: ARRAY [INTEGER]
			l_impl_sig: ARRAY [INTEGER]
			i, nb: INTEGER
			l_is_external: BOOLEAN
			l_sequence_point: like sequence_point
			l_sequence_point_list: LIST [like sequence_point]
			l_class_type: CLASS_TYPE
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)

			if feat.is_attribute then
				l_token := attribute_token (a_type_id, code_feature_id)
				start_new_body (l_meth_token)
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, l_token)
				generate_return (True)
				method_writer.write_current_body

				l_meth_token := setter_token (current_type_id, feat.feature_id)
				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				generate_check_cast (Void, result_type (feat))
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, l_token)
				generate_return (False)
				method_writer.write_current_body
			else
				l_token := implementation_feature_token (a_type_id, code_feature_id)
				l_cur_sig := signatures (current_type_id, feat.feature_id)
				l_impl_sig := implementation_signatures (a_type_id, code_feature_id)

				l_is_external := feat.is_external or feat.is_il_external

				l_class_type := class_types.item (a_type_id)

				if
						-- False here because of a few things:
						-- 1 - It is not clear that generated executable are faster by
						--     having the code inlined. It depends on the JIT quality which
						--     we don't know much about it.
						-- 2 - For EiffelStudio debugger, it is not easy to perform mapping
						--     between breakpoints and generated code.
						-- 3 - For code using $Current, it does not work as in this fake
						--     duplication `$Current' is of type address of Impl.CLASS
						--     instead of being address of CLASS. Makes the generated code
						--     unverifiable.
						--
						-- However we keep this code as it might be usefull in the future
						-- if we introduce a new project settings option to turn this on
						-- or off.
					False and then
					(not l_is_external and then not l_class_type.is_precompiled and then
					il_module (current_class_type) = il_module (l_class_type) and then
					(l_cur_sig = Void or else l_cur_sig.is_equal (l_impl_sig)))
				then
					if is_debug_info_enabled then
						dbg_writer.open_method (l_meth_token)
						l_sequence_point_list :=
							current_module.method_sequence_points.item (l_token)
						from
							l_sequence_point_list.start
						until
							l_sequence_point_list.after
						loop
							l_sequence_point := l_sequence_point_list.item
							dbg_offsets_count := l_sequence_point.integer_item (1)
							dbg_offsets ?= l_sequence_point.item (2)
							dbg_start_lines ?= l_sequence_point.item (3)
							dbg_start_columns ?= l_sequence_point.item (4)
							dbg_end_lines ?= l_sequence_point.item (5)
							dbg_end_columns ?= l_sequence_point.item (6)
							dbg_writer.define_sequence_points (
								dbg_documents (l_sequence_point.integer_item (7)),
								dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
								dbg_end_lines, dbg_end_columns)
							l_sequence_point_list.forth
						end
						generate_local_debug_info (l_token)
						dbg_writer.close_method
					end
					method_writer.write_duplicate_body (l_token, l_meth_token)
				else
					if is_debug_info_enabled then
							-- Enable debugger to go through stub definition.
						define_custom_attribute (l_meth_token,
							current_module.debugger_step_through_ctor_token, Void)
						define_custom_attribute (l_meth_token,
							current_module.debugger_hidden_ctor_token, Void)
					end

					start_new_body (l_meth_token)
					if not feat.is_c_external then
						generate_current
					end
					from
						i := 1
						nb := feat.argument_count
					until
						i > nb
					loop
						generate_argument (i)
						if is_verifiable and l_cur_sig.item (i) /= l_impl_sig.item (i) then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_impl_sig.item (i)))
						end
						i := i + 1
					end
					if not feat.is_c_external then
						method_body.put_call ({MD_OPCODES}.call, l_token, nb,
							feat.has_return_value)
					else
						method_body.put_static_call (l_token, nb, feat.has_return_value)
					end
					if feat.has_return_value then
						if is_verifiable and l_cur_sig.item (0) /= l_impl_sig.item (0) then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_cur_sig.item (0)))
						end
					end
					generate_return (feat.has_return_value)
					method_writer.write_current_body
				end
			end
		end

	generate_external_il (feat: FEATURE_I) is
			-- Generate call to external feature `feat'. Its token is `last_non_recorded_feature_token'.
		require
			feature_not_void: feat /= Void
			feature_is_c_external: feat.is_c_external
		local
			l_token: INTEGER
			l_meth_token: INTEGER
			i, nb: INTEGER
		do
			l_token := last_non_recorded_feature_token
			l_meth_token := feature_token (current_type_id, feat.feature_id)

			if is_debug_info_enabled then
					-- Enable debugger to go through stub definition.
				define_custom_attribute (l_meth_token,
					current_module.debugger_step_through_ctor_token, Void)
				define_custom_attribute (l_meth_token,
					current_module.debugger_hidden_ctor_token, Void)
			end

			start_new_body (l_meth_token)
			from
				i := 1
				nb := feat.argument_count
			until
				i > nb
			loop
				generate_argument (i)
				i := i + 1
			end
			method_body.put_static_call (l_token, nb, feat.has_return_value)
			generate_return (feat.has_return_value)
			method_writer.write_current_body
		end

	generate_feature_code (feat: FEATURE_I; is_implementation: BOOLEAN) is
			-- Generate IL code for feature `feat' using its implementation
			-- token iff `is_implementation' is true.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
			l_sequence_point_list: LINKED_LIST [like sequence_point]
		do
			if not feat.is_attribute and then not feat.is_c_external and not feat.is_deferred then
				if is_implementation then
					l_meth_token := implementation_feature_token (current_type_id, feat.feature_id)
				else
					l_meth_token := feature_token (current_type_id, feat.feature_id)
				end
				current_feature_token := l_meth_token
				start_new_body (l_meth_token)

				if is_debug_info_enabled then
					dbg_writer.open_method (l_meth_token)
					local_start_offset := method_body.count
					create dbg_offsets.make (0, 5)
					create dbg_start_lines.make (0, 5)
					create dbg_start_columns.make (0, 5)
					create dbg_end_lines.make (0, 5)
					create dbg_end_columns.make (0, 5)
					dbg_offsets_count := 0
				end

				current_class_type.generate_il_feature (feat)
				local_end_offset := method_body.count
				store_locals (l_meth_token)
				method_writer.write_current_body

				if is_debug_info_enabled then
					generate_local_debug_info (l_meth_token)
					dbg_writer.define_sequence_points (
						dbg_documents (current_class.class_id),
						dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
						dbg_end_lines, dbg_end_columns)
					dbg_writer.close_method
					l_sequence_point_list :=
						current_module.method_sequence_points.item (l_meth_token)
					if l_sequence_point_list = Void then
						create l_sequence_point_list.make
						current_module.method_sequence_points.put (l_sequence_point_list,
							l_meth_token)
					end
					l_sequence_point_list.extend ([dbg_offsets_count, dbg_offsets, dbg_start_lines,
						dbg_start_columns, dbg_end_lines, dbg_end_columns, feat.written_in])


						--| feature is not attribute |--
						-- we assume the feature concerned by `generate_feature_code'
						-- here are static and not in_interface
					Il_debug_info_recorder.set_record_context (is_single_class, False, True, False)
					Il_debug_info_recorder.record_il_feature_info (current_module,
								current_class_type, feat, current_class_token, l_meth_token)
				end
			end
		end

	generate_property (f: FEATURE_I) is
			-- Generate property methods associated with feature `f' (if any).
		require
			f_not_void: f /= Void
			f_is_attribute: f.is_attribute
		local
			target_type: CL_TYPE_I
			target_feature: FEATURE_I
		do
			start_new_body (current_module.property_setter_token (current_type_id, f.feature_id))
				-- Look for assigner command.
			target_feature := f.ancestor_assigner_in (current_class)
			if target_feature /= Void then
				target_type := current_class_type.type
				if not target_type.is_expanded then
					target_type := implemented_type (target_feature.access_in, target_type)
				end
				target_feature := target_type.base_class.feature_of_rout_id (target_feature.rout_id_set.first)
				generate_current
				generate_argument (1)
				generate_feature_access (target_type, target_feature.feature_id, 1, false, true)
			end
			generate_return (false)
			method_writer.write_current_body
			target_type := current_class_type.type
			if target_type.is_expanded or else not target_type.is_generated_as_single_type then
				target_feature := f
			else
				target_type := implemented_type (f.access_in, target_type)
				target_feature := target_type.base_class.feature_of_rout_id (f.rout_id_set.first)
			end
			start_new_body (current_module.property_getter_token (current_type_id, f.feature_id))
			generate_current
			method_body.put_opcode_mdtoken ({MD_OPCODES}.ldfld, attribute_token (target_type.associated_class_type.implementation_id, target_feature.feature_id))
			generate_check_cast (byte_context.real_type_in
				(target_feature.type.type_i, target_type.associated_class_type),
				byte_context.real_type (f.type.type_i))
			generate_return (true)
			method_writer.write_current_body
		end

	generate_feature_standard_twin (feat: FEATURE_I) is
			-- Generate IL code for feature `standard_twin' from ANY.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
			type_i: TYPE_I
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)
			start_new_body (l_meth_token)
			generate_current
				-- If `current_class_type' is expanded, cloning is done by compiler.
			type_i := current_class_type.type
			if type_i.is_expanded then
					-- Stack contains a pointer to value type object.
					-- Load a value of the object.
				generate_load_from_address (type_i)
					-- Now it has to be converted to a ... (see below)
				if result_type_in (feat, current_class_type).is_expanded then
						-- ... unboxed value.
						-- (Already done.)
				else
						-- ... boxed value.
					generate_metamorphose (type_i)
				end
			else
				method_body.put_call ({MD_OPCODES}.Call,
					current_module.memberwise_clone_token, 0, True)
				generate_check_cast (Void, type_i)
			end
			generate_return (True)
			method_writer.write_current_body
		end

	generate_call_to_standard_copy is
			-- Generate a call to run-time feature `standard_copy'
			-- assuming that Current and argument are on the evaluation stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"standard_copy", Static_type,
				<<system_object_class_name, system_object_class_name>>,
				Void, False)
		end

	generate_object_equality_test is
			-- Generate comparison of two objects.
			-- (The feature is invoked with a current object on the stack,
			-- i.e. takes 3 arguments: Current, some, other.)
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"is_equal", Static_type,
				<<system_object_class_name, system_object_class_name>>,
				"System.Boolean", False)
		end

	start_new_body (method_token: INTEGER) is
			-- Start a new body definition for method `method_token'.
		require
			valid_method_token: method_token /= 0
		do
			method_body := method_writer.new_method_body (method_token)
			result_position := -1
		ensure
			method_body_set: method_body /= Void
		end

	last_non_recorded_feature_token: INTEGER
			-- Token of last defined feature that we did not record or last override.

	last_property_setter_token: INTEGER
			-- Token of last defined property setter method resulted from override.

	last_property_getter_token: INTEGER
			-- Token of last defined property getter method resulted from override.

	override_counter: COUNTER
			-- Number of generated override methods.

	is_method_impl_needed (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE): BOOLEAN is
			-- Is a MethodImpl needed between `inh_feat' and `feat'?
		require
			feat_not_void: feat /= Void
			inh_feat_not_void: inh_feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_ext: IL_EXTENSION_I
			l_naming_convention: BOOLEAN
		do
			l_naming_convention := System.dotnet_naming_convention
			if l_naming_convention /= class_type.is_dotnet_name then
				l_ext ?= inh_feat.extension
				if l_ext /= Void then
 					Result := not il_casing.pascal_casing (l_naming_convention,
						feat.feature_name,
 						{IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
				else
					Result := not il_casing.pascal_casing (l_naming_convention,
							feat.feature_name, {IL_CASING_CONVERSION}.lower_case).is_equal (
						il_casing.pascal_casing (class_type.is_dotnet_name,
							inh_feat.feature_name, {IL_CASING_CONVERSION}.lower_case))
				end
			else
				Result := feat.feature_name_id /= inh_feat.feature_name_id
	 			if not Result then
	 				l_ext ?= inh_feat.extension
	 				if l_ext /= Void then
	 					Result := not il_casing.pascal_casing (System.dotnet_naming_convention,
							feat.feature_name,
	 						{IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
	 				end
	 			end
			end
			if not Result then
					-- When we handle an attribute defined in an inherited Eiffel class in a class now
					-- generated as `is_single_class' we have to generate a MethodImpl, because
					-- in the interface it is defined as a function, thus the generated MethodImpl will actually implement
					-- the function to retrieve the attribute field.
				Result := is_single_class and then not feat.written_class.is_single	and then
					feat.is_attribute and then feat.written_in /= current_class.class_id and then
					not feat.written_class.is_external
			end
		end

	generate_method_impl (cur_feat: FEATURE_I; parent_type: CLASS_TYPE; inh_feat: FEATURE_I) is
			-- Generate a MethodImpl from `parent_type' and `inh_feat'
			-- to `current_class_type' and `cur_feat'.
		require
			cur_feat_not_void: cur_feat /= Void
			parent_type_not_void: parent_type /= Void
			inh_feat_not_void: inh_feat /= Void
		local
			l_cur_sig: ARRAY [INTEGER]
			l_inh_sig: ARRAY [INTEGER]
			l_same_signature: BOOLEAN
			l_setter_token: INTEGER
			i, nb: INTEGER
			l_name_id: INTEGER
			l_meth_attr: INTEGER
			l_meth_sig: MD_METHOD_SIGNATURE
			l_parent_type_id: INTEGER
			l_name: STRING
			l_return_type: TYPE_I
			l_token: like last_non_recorded_feature_token
			l_args: FEAT_ARG
			l_type_i: like argument_actual_type
			l_call_opcode: INTEGER_16
		do
			l_parent_type_id := parent_type.static_type_id
			l_cur_sig := signatures (current_type_id, cur_feat.feature_id)
			l_inh_sig := signatures (l_parent_type_id, inh_feat.feature_id)

				-- Notion of same signature depends on wether or not we handle an attribute which is directly implemented
				-- as a field rather than a function when it occurs in class generated as `is_single_class'.
			l_same_signature := l_cur_sig.is_equal (l_inh_sig) and (not is_single_class or else not cur_feat.is_attribute)

			if l_same_signature then
				md_emit.define_method_impl (current_class_token, feature_token (current_type_id,
					cur_feat.feature_id), feature_token (l_parent_type_id, inh_feat.feature_id))

				if cur_feat.is_attribute and then inh_feat.is_attribute then
					md_emit.define_method_impl (current_class_token, setter_token (current_type_id,
						cur_feat.feature_id), setter_token (l_parent_type_id, inh_feat.feature_id))
				end
				if inh_feat.is_attribute then
					md_emit.define_method_impl (current_class_token, current_module.property_getter_token
						(current_type_id, cur_feat.feature_id), current_module.property_getter_token (l_parent_type_id, inh_feat.feature_id))
					md_emit.define_method_impl (current_class_token, current_module.property_setter_token
						(current_type_id, cur_feat.feature_id), current_module.property_setter_token (l_parent_type_id, inh_feat.feature_id))
				end
			elseif not is_single_class or else not inh_feat.is_attribute or else not parent_type.associated_class.is_single then
				l_name_id := inh_feat.feature_name_id
				l_name := inh_feat.feature_name
				inh_feat.set_feature_name (Override_prefix + l_name + override_counter.next.out)

					-- We have to generate body of `inh_feat' in context of
					-- `parent_type' in order to correctly evaluate its
					-- signature in current context.
				implementation_generate_feature (inh_feat, False, False, True, False, parent_type)
				l_return_type := result_type_in (inh_feat, parent_type)

					-- We need to restore the name right away.
				inh_feat.set_feature_name_id (l_name_id, inh_feat.alias_name_id)
				inh_feat.set_has_convert_mark (inh_feat.has_convert_mark)

				l_token := last_non_recorded_feature_token
				start_new_body (l_token)
				generate_current
				nb := cur_feat.argument_count
				if nb > 0 then
					from
						i := 1
						l_args := cur_feat.arguments
						l_args.start
					until
						i > nb
					loop
						generate_argument (i)
						if l_cur_sig.item (i) /= l_inh_sig.item (i) then
							l_type_i := argument_actual_type (l_args.item.type_i)
							if l_type_i.is_expanded then
								generate_unmetamorphose (l_type_i)
							elseif is_verifiable then
								method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
									mapped_class_type_token (l_cur_sig.item (i)))
							end
						end
						l_args.forth
						i := i + 1
					end
				end

				if cur_feat.is_attribute and is_single_class then
						-- Attribute was already generated as a field, we simply generate a routine to
						-- perform the MethodImpl.
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, attribute_token (current_type_id,
						cur_feat.feature_id))
				elseif current_class_type.is_expanded then
						-- Call feature directly.
					method_body.put_call ({MD_OPCODES}.Call, feature_token (current_type_id,
						cur_feat.feature_id), nb, cur_feat.has_return_value)
				else
						-- Call feature polymorphically.
					method_body.put_call ({MD_OPCODES}.Callvirt, feature_token (current_type_id,
						cur_feat.feature_id), nb, cur_feat.has_return_value)
				end

				if cur_feat.has_return_value then
					if l_cur_sig.item (0) /= l_inh_sig.item (0) then
						l_type_i := result_type (cur_feat)
						if l_type_i.is_expanded then
							generate_metamorphose (l_type_i)
						elseif is_verifiable then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_inh_sig.item (0)))
						end
					end
				end
				generate_return (cur_feat.has_return_value)
				method_writer.write_current_body

				md_emit.define_method_impl (current_class_token, l_token,
					feature_token (l_parent_type_id, inh_feat.feature_id))
				if cur_feat.is_attribute and then inh_feat.is_attribute then
					l_meth_attr := {MD_METHOD_ATTRIBUTES}.Virtual |
						{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.Private

					l_meth_sig := method_sig
					l_meth_sig.reset
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

					set_signature_type (l_meth_sig, l_return_type)

					uni_string.set_string (Override_prefix + setter_prefix + l_name +
						override_counter.next.out)

					l_setter_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_setter_token)
					generate_current
					generate_argument (1)
					if is_verifiable and l_cur_sig.item (0) /= l_inh_sig.item (0) then
						method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
							mapped_class_type_token (l_cur_sig.item (0)))
					end
						-- Hard coded `1' for number of arguments since there is one,
						-- we cannot use `nb' as it is `0' for attributes.
					if is_single_class then
							-- Attribute was already generated as a field, we simply generate a routine to
							-- perform the MethodImpl on the setter.
						method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, attribute_token (current_type_id,
							cur_feat.feature_id))
					else
						method_body.put_call ({MD_OPCODES}.Callvirt,
							setter_token (current_type_id, cur_feat.feature_id), 1, False)
					end

					generate_return (False)
					method_writer.write_current_body

					md_emit.define_method_impl (current_class_token, l_setter_token,
						setter_token (l_parent_type_id, inh_feat.feature_id))
				end
				if last_property_setter_token /= {MD_TOKEN_TYPES}.md_method_def then
						-- Generate property setter implementation.
					start_new_body (last_property_setter_token)
					generate_current
					generate_argument (1)
					if current_class_type.is_expanded then
						l_call_opcode := {MD_OPCODES}.call
					else
						l_call_opcode := {MD_OPCODES}.callvirt
					end
					method_body.put_call (l_call_opcode,
						current_module.property_setter_token (current_type_id, cur_feat.feature_id), 1, False)
					generate_return (False)
					method_writer.write_current_body
					if inh_feat.is_attribute then
						md_emit.define_method_impl (current_class_token, last_property_setter_token,
							current_module.property_setter_token (l_parent_type_id, inh_feat.feature_id))
					end
				end
				if last_property_getter_token /= {MD_TOKEN_TYPES}.md_method_def then
						-- Generate property getter implementation.
					start_new_body (last_property_getter_token)
					generate_current
					if current_class_type.is_expanded then
						l_call_opcode := {MD_OPCODES}.call
					else
						l_call_opcode := {MD_OPCODES}.callvirt
					end
					method_body.put_call (l_call_opcode,
						current_module.property_getter_token (current_type_id, cur_feat.feature_id), 0, True)
					generate_return (True)
					method_writer.write_current_body
					if inh_feat.is_attribute then
						md_emit.define_method_impl (current_class_token, last_property_getter_token,
							current_module.property_getter_token (l_parent_type_id, inh_feat.feature_id))
					end
				end
			end
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		local
			l_type_token: INTEGER
		do
			l_type_token := current_module.external_token_mapping (base_name)
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), is_virtual)
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_I; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER)
		is
			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		local
			l_type_id: INTEGER
			l_type_token: INTEGER
		do
			l_type_id := a_actual_type.implementation_id
			l_type_token := actual_class_type_token (l_type_id)
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), False)
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER
		is
			-- Get token for feature specified by `base_name' and `member_name'
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
			l_parameters_string: ARRAY [STRING]
			l_return_type: STRING
		do
			l_class_token := current_module.external_token_mapping (base_name)
			l_parameters_string := Names_heap.convert_to_string_array (parameters_type)
			l_return_type := Names_heap.item (return_type)

			inspect ext_kind
			when Field_type, Static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				set_type_in_signature (l_field_sig, l_return_type)
				uni_string.set_string (member_name)
				Result := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
			when Set_field_type, Set_static_field_type then
				check
					l_parameters_string_not_void: l_parameters_string /= Void
					l_parameters_string_count_is_one: l_parameters_string.count = 1
				end
				l_field_sig := field_sig
				l_field_sig.reset
					-- Type of field is actually the first argument of our setter routine.
				set_type_in_signature (l_field_sig, l_parameters_string.item (1))
				uni_string.set_string (member_name)
				Result := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if ext_kind = Static_type or ext_kind = Operator_type then
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if l_parameters_string /= Void then
					nb := l_parameters_string.count
				end

				l_meth_sig.set_parameter_count (nb)

					-- Set return type if any in `l_meth_sig'.
				if l_return_type /= Void then
					set_type_in_signature (l_meth_sig, l_return_type)
				else
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

					-- Set arguments in `l_meth_sig'.
				from
					i := 1
				until
					i > nb
				loop
					set_type_in_signature (l_meth_sig, l_parameters_string.item (i))
					i := i + 1
				end

				if member_name = Void then
					uni_string.set_string (".ctor")
				else
					uni_string.set_string (member_name)
				end

				Result := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)
			end
		end

	internal_generate_external_call (an_assembly_token, a_type_token: INTEGER; base_name: STRING;
			member_name: STRING; ext_kind: INTEGER;
			parameters_string: ARRAY [STRING]; return_type: STRING;
			is_virtual: BOOLEAN)
		is
			-- Generate call to `member_name' with signature `parameters_type' + `return_type'.
		require
			valid_external_type: valid_type (ext_kind)
		local
			l_token: INTEGER
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
		do
 			if base_name /= Void then
 				uni_string.set_string (base_name)
 				l_class_token := md_emit.define_type_ref (uni_string, an_assembly_token)
 			else
				l_class_token := a_type_token
			end

			inspect ext_kind
			when Field_type, Static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				set_type_in_signature (l_field_sig, return_type)
				uni_string.set_string (member_name)
				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
				if ext_kind = field_type then
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, l_token)
				else
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, l_token)
				end
			when Set_field_type, Set_static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				check
					parameters_string_not_void: parameters_string /= Void
					parameters_string_count_is_one: parameters_string.count = 1
				end
					-- Type of field is actually the first argument of our setter routine.
				set_type_in_signature (l_field_sig, parameters_string.item (1))
				uni_string.set_string (member_name)
				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
				if ext_kind = set_field_type then
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, l_token)
				else
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, l_token)
				end
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if ext_kind = Static_type or ext_kind = Operator_type then
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if parameters_string /= Void then
					nb := parameters_string.count
				end

				l_meth_sig.set_parameter_count (nb)

					-- Set return type if any in `l_meth_sig'.
				if return_type /= Void then
					set_type_in_signature (l_meth_sig, return_type)
				else
					l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

					-- Set arguments in `l_meth_sig'.
				from
					i := 1
				until
					i > nb
				loop
					set_type_in_signature (l_meth_sig, parameters_string.item (i))
					i := i + 1
				end

				if member_name = Void then
					uni_string.set_string (".ctor")
				else
					uni_string.set_string (member_name)
				end

				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)

				inspect ext_kind
				when Creator_call_type then
					method_body.put_call ({MD_OPCODES}.Call, l_token, nb, return_type /= Void)
				when Static_type, Operator_type then
					method_body.put_static_call (l_token, nb, return_type /= Void)
				when Normal_type, Deferred_type then
					if is_virtual then
						method_body.put_call (
							{MD_OPCODES}.Callvirt, l_token, nb, return_type /= Void)
					else
						method_body.put_call (
							{MD_OPCODES}.Call, l_token, nb, return_type /= Void)
					end
				when Creator_type then
					method_body.put_newobj (l_token, nb)
				end
			end
		end

feature {NONE} -- Implementation

	is_local_signature_changed (local_feature: FEATURE_I): BOOLEAN is
			-- Is signature of a local feature `local_feature' changed
			-- from the one of the associated interface?
		local
			arguments: FEAT_ARG
		do
			if current_class_type.is_expanded then
					-- Take into account signature changes due to "like Current" type
				if local_feature.type.type_i.is_anchored then
					Result := True
				elseif local_feature.arguments /= Void then
					from
						arguments := local_feature.arguments
						arguments.start
					until
						arguments.after
					loop
						if arguments.item.type_i.is_anchored then
							Result := True
							arguments.finish
						end
						arguments.forth
					end
				end
			end
		end

	set_type_in_signature (a_sig: MD_SIGNATURE; a_type_name: STRING) is
			-- Set `a_type_name' into `a_sig'. It properly analyzes `a_type_name'
			-- to detect if it is an array type or a byref.
		require
			a_sig_not_void: a_sig /= Void
			a_type_name_not_void: a_type_name /= Void
		local
			l_is_by_ref, l_is_array: BOOLEAN
			l_real_type: STRING
			l_type: TYPE_I
		do
			l_real_type := a_type_name
			if l_real_type.item (l_real_type.count) = '&' then
				l_is_by_ref := True
				l_real_type := l_real_type.substring (1, l_real_type.count - 1)
			else
				l_is_by_ref := False
			end
			if l_real_type.item (l_real_type.count) = ']' then
				l_is_array := True
				l_real_type := l_real_type.substring (1, l_real_type.count - 2)
			else
				l_is_array := False
			end
			l_type := external_class_mapping.item (l_real_type)
			if l_is_by_ref then
				a_sig.set_type (
					{MD_SIGNATURE_CONSTANTS}.Element_type_byref, 0)
			end
			if l_is_array then
				a_sig.set_type (
					{MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			end
			if l_type /= Void then
				set_signature_type (a_sig, l_type)
			else
					-- A runtime type.
				if l_real_type.is_equal (Assertion_level_enum_class_name) then
					a_sig.set_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
						current_module.external_token_mapping (l_real_type))
				else
					a_sig.set_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.external_token_mapping (l_real_type))
				end
			end
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER) is
			-- Set `local_count' to `a_count'.
		do
			local_count := a_count
		end

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		do
			if not once_generation then
				result_position := 0
				local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "Result"))
			end
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				Names_heap.item (name_id)))
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "_" + name_id.out))
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				"_dummy_" + name_id.out))
		end

feature -- Local saving

	reset_local_types is
			-- Reset `local_types'.
		do
			create local_types.make (5)
		end

	store_locals (a_meth_token: INTEGER) is
			-- Store `local_types' into `method_body' for routine `a_meth_token'.
		require
			method_token_valid: a_meth_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
		do
			current_module.store_locals (local_types, a_meth_token)
		end

	generate_local_debug_info (a_method_token: INTEGER) is
			-- Generate local information about routine `method_token'.
		require
			debug_info_requested: is_debug_info_enabled
			method_token_valid: a_method_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
		do
			current_module.generate_local_debug_info (a_method_token)
		end

feature -- Object creation

	create_object (a_type_id: INTEGER) is
			-- Create object of `a_type_id'.
		do
			method_body.put_newobj (constructor_token (a_type_id), 0)
		end

	create_object_with_args (a_type_id: INTEGER; a_arg_count: INTEGER) is
			-- Create object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
			a_arg_count_not_negative: a_arg_count >= 0
		do
			method_body.put_newobj (constructor_token (a_type_id), a_arg_count)
		end

	create_like_object is
			-- Create object of same type as object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_like_object", Static_type, <<type_info_class_name>>,
				type_info_class_name,
				False)
		end

	load_type is
			-- Load on stack type of object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"load_type_of_object", Static_type, <<type_info_class_name>>,
				type_class_name,
				False)
		end

	create_type is
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_type", Static_type, <<type_class_name,
				type_info_class_name>>, type_info_class_name,
				False)
		end

	initialize_expanded_variable (variable_class_type: CLASS_TYPE) is
			-- Initialize an expanded variable of type `variable_class_type' assuming
			-- that its address is currently on the evaluation stack.
		local
			creation_procedure: FEATURE_I
		do
			creation_procedure := variable_class_type.associated_class.creation_feature
			if creation_procedure /= Void then
					-- Duplicate current to call creation procedure.
				duplicate_top
			end
				-- Initialize inner expanded attributes.
			method_body.put_call ({MD_OPCODES}.call, constructor_token (variable_class_type.implementation_id), 0, False)
				-- Call creation procedure (if any).
			if creation_procedure /= Void then
				generate_feature_access (variable_class_type.type, creation_procedure.feature_id, 0, False, False)
			end
		end

feature {IL_MODULE} -- Initialization of expanded attributes

	initialize_expanded_attributes (class_type: CLASS_TYPE) is
			-- Initialize expanded attributes of `class_type'
			-- assuming that a reference or a pointer to the object
			-- of type `class_type' is on the stack.
		require
			class_type_not_void: class_type /= Void
		local
			attribute_type: CL_TYPE_I
			desc: EXPANDED_DESC
			skeleton: SKELETON
		do
			from
				skeleton := class_type.skeleton
				skeleton.go_expanded
			until
				skeleton.off or else skeleton.item.level /= skeleton.expanded_level
			loop
				desc ?= skeleton.item
				attribute_type := desc.cl_type_i
				if attribute_type.is_true_expanded and then not attribute_type.is_external then
					duplicate_top
					method_body.put_opcode_mdtoken ({MD_OPCODES}.ldflda, attribute_token (class_type.implementation_id, skeleton.item.feature_id))
					initialize_expanded_variable (attribute_type.associated_class_type)
				end
				skeleton.forth
			end
		end

	is_initialization_required (class_type: CLASS_TYPE): BOOLEAN is
			-- Is initialization of class attributes is required for `class_type'?
		require
			class_type_not_void: class_type /= Void
		local
			attribute_type: CL_TYPE_I
			desc: EXPANDED_DESC
			skeleton: SKELETON
		do
			from
				skeleton := class_type.skeleton
				skeleton.go_expanded
			until
				Result or else skeleton.off or else skeleton.item.level /= skeleton.expanded_level
			loop
				desc ?= skeleton.item
				attribute_type := desc.cl_type_i
				Result := attribute_type.is_true_expanded and then not attribute_type.is_external
				skeleton.forth
			end
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Dup)
		end

	pop is
			-- Remove top element of IL stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Pop)
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldarg_0)
		end

	generate_current_as_reference is
			-- Generate access to `Current' in its reference form.
			-- (I.e. box value type object if required.)
		local
			type_i: TYPE_I
		do
			generate_current
			if current_class_type.is_expanded then
					-- Box expanded object.
				type_i := current_class_type.type
				generate_load_from_address (type_i)
				generate_metamorphose (type_i)
			end
		end

	generate_result is
			-- Generate access to `Result'.
		do
			if once_generation then
				generate_once_result
			else
				generate_local (result_position)
			end
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		local
			cl_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class_type := cl_type.associated_class_type
			end
			if
				l_class_type /= Void and then
				(l_class_type.is_generated_as_single_type or l_class_type.is_expanded)
			then
				if need_target then
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld,
						attribute_token (cl_type.implementation_id, a_feature_id))
				else
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld,
						attribute_token (cl_type.implementation_id, a_feature_id))
				end
			else
					-- Attribute are accessed through their feature encapsulation.
				internal_generate_feature_access (type_i.static_type_id, a_feature_id,
					0, True, True)
			end
		end

	generate_feature_access (type_i: TYPE_I; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		local
			l_type_id: INTEGER
			l_virtual: BOOLEAN
		do
			if type_i.is_expanded then
				l_type_id := type_i.implementation_id
				l_virtual := False
			else
				l_type_id := type_i.static_type_id
				l_virtual := True
			end
			internal_generate_feature_access (l_type_id, a_feature_id, nb,
				is_function, l_virtual)
		end

	generate_precompiled_feature_access (type_i: TYPE_I; a_feature: FEATURE_I) is
			-- Generate a call to a precompiled library.
		require
			type_i_not_void: type_i /= Void
			a_feature_not_void: a_feature /= Void
		do
		end

	internal_generate_feature_access (a_type_id, a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `a_type_id'.
		require
			positive_type_id: a_type_id > 0
			positive_feature_id: a_feature_id > 0
		local
			l_opcode: INTEGER_16
		do
			if is_virtual then
				l_opcode := {MD_OPCODES}.Callvirt
			else
				l_opcode := {MD_OPCODES}.Call
			end

			method_body.put_call (l_opcode, feature_token (a_type_id, a_feature_id), nb,
				is_function)
		end

	generate_precursor_feature_access (type_i: TYPE_I; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		do
			method_body.put_call ({MD_OPCODES}.Call,
				implementation_feature_token (type_i.implementation_id, a_feature_id),
				nb, is_function)
		end

	generate_type_feature_call (f: TYPE_FEATURE_I) is
			-- Generate a call to a type feature `f' on current.
		local
			target_type: CL_TYPE_I
			target_feature_id: INTEGER
			target_routine_id: INTEGER
			anchored_features: HASH_TABLE [TYPE_FEATURE_I, INTEGER]
		do
			generate_current
			target_type := current_class_type.type
			if target_type.is_expanded then
					-- Call feature directly.
				target_routine_id := f.rout_id_set.first
				anchored_features := target_type.base_class.anchored_features
				anchored_features.search (target_routine_id)
				if anchored_features.found then
					target_feature_id := anchored_features.found_item.feature_id
				else
					target_feature_id := target_type.base_class.generic_features.item (target_routine_id).feature_id
				end
			else
					-- Call feature using parent type.
				target_type := implemented_type (f.origin_class_id, target_type)
				target_feature_id := f.origin_feature_id
			end
			generate_feature_access (target_type, target_feature_id, 0, True, True)
		end

	put_type_token (a_type_id: INTEGER) is
			-- Put token associated to `a_type_id' on stack.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldtoken,
				actual_class_type_token (a_type_id))
		end

	put_type_instance (a_type: TYPE_I) is
			-- Put instance of System.Type corresponding to `a_type' on stack.
		do
			put_type_token (a_type.static_type_id)
			internal_generate_external_call (current_module.mscorlib_token, 0,
				system_type_class_name, "GetTypeFromHandle",
				static_type, << type_handle_class_name >>,
				system_type_class_name, False)
		end

	put_method_token (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldtoken,
				feature_token (type_i.static_type_id, a_feature_id))
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		do
			inspect
				n
			when 0 then method_body.put_opcode ({MD_OPCODES}.Ldarg_0)
			when 1 then method_body.put_opcode ({MD_OPCODES}.Ldarg_1)
			when 2 then method_body.put_opcode ({MD_OPCODES}.Ldarg_2)
			when 3 then method_body.put_opcode ({MD_OPCODES}.Ldarg_3)
			else
				if n <= 255 then
					method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldarg_s, n.to_integer_8)
				else
					method_body.put_opcode_integer_16 ({MD_OPCODES}.Ldarg, n.to_integer_16)
				end
			end
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode ({MD_OPCODES}.Ldloc_0)
			when 1 then method_body.put_opcode ({MD_OPCODES}.Ldloc_1)
			when 2 then method_body.put_opcode ({MD_OPCODES}.Ldloc_2)
			when 3 then method_body.put_opcode ({MD_OPCODES}.Ldloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 ({MD_OPCODES}.Ldloc,
						l_pos.to_integer_16)
				end
			end
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		do
				-- It has to be the `implementation_id' because for us `box'
				-- can only be applied to expanded types and only `implementation_id'
				-- refers to the value type implementation for Eiffel generated types,
				-- and for .NET classes `static_type_id' and `implementation_id' are
				-- the same.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Box,
				actual_class_type_token (type_i.implementation_id))
		end


	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
			generate_load_address (type_i)
			generate_load_from_address (type_i)
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			if l_pos <= 255 then
				method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldloca_s, l_pos.to_integer_8)
			else
				method_body.put_opcode_integer_16 ({MD_OPCODES}.Ldloca, l_pos.to_integer_16)
			end
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldarga_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 ({MD_OPCODES}.Ldarga, n.to_integer_16)
			end
		end

	generate_current_address is
			-- Generate address of `Current'.
		do
			method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldarga_s, 0)
		end

	generate_result_address is
			-- Generate address of `Result'.
		do
			if once_generation then
				generate_once_result_address
			else
				generate_local_address (result_position)
			end
		end

	generate_attribute_address (type_i: TYPE_I; attr_type: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		local
			cl_type: CL_TYPE_I
			local_number: INTEGER
			l_class_type: CLASS_TYPE
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class_type := cl_type.associated_class_type
			end
			if
				l_class_type /= Void and then
				l_class_type.is_generated_as_single_type
			then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldflda,
					attribute_token (cl_type.implementation_id, a_feature_id))
			else
					-- Attribute are accessed through their feature encapsulation.
				internal_generate_feature_access (type_i.static_type_id, a_feature_id,
					0, True, True)
				Byte_context.add_local (attr_type)
				local_number := Byte_context.local_list.count
				put_dummy_local_info (attr_type, local_number)
				generate_local_assignment (local_number)
				generate_local_address (local_number)
			end
		end

	generate_routine_address (type_i: TYPE_I; a_feature_id: INTEGER; is_last_argument_current: BOOLEAN) is
			-- Generate address of routine of `a_feature_id' in class `type_i'
			-- assuming that previous argument is Current if `is_last_argument_current' is true.
		local
			opcode: INTEGER_16
			type_id: INTEGER
		do
			if type_i.is_expanded then
				opcode := {MD_OPCODES}.ldftn
				type_id := type_i.implementation_id
			else
				opcode := {MD_OPCODES}.ldvirtftn
				type_id := type_i.static_type_id
					-- Target object is used to calculate address.
				if is_last_argument_current then
						-- Use code sequence that can be verified
						-- when calling a delegate constructor.
					generate_check_cast (Void, type_i)
					method_body.put_opcode ({MD_OPCODES}.Dup)
				else
					generate_current
				end
			end
			method_body.put_opcode_mdtoken (opcode, feature_token (type_id, a_feature_id))
		end

	generate_load_address (type_i: TYPE_I) is
			-- Generate code that takes address of a boxed value object of type `type_i'.
		do
				-- See comment on `generate_metamorphose' on why we chose `implementation_id'.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Unbox,
				actual_class_type_token (type_i.implementation_id))
		end

	generate_load_from_address (a_type: TYPE_I) is
			-- Load value of `a_type' type from address pushed on stack.
		do
			inspect a_type.element_type
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i1)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i2)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i4)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i8)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_u1)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_u2)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_u4)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_u8)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i1)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				method_body.put_opcode ({MD_OPCODES}.Ldind_i2)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_r4)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				method_body.put_opcode ({MD_OPCODES}.Ldind_r8)
			else
					-- See comment on `generate_metamorphose' to see why we
					-- use `implementation_id'.
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldobj,
					actual_class_type_token (a_type.implementation_id))
			end
		end

feature -- Assignments

	generate_is_true_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		local
			l_token: INTEGER
		do
				-- We use `actual_class_type_token' because we really want to know
				-- if we inherit really from ANY.
			if type_i.is_expanded then
				l_token := actual_class_type_token (type_i.implementation_id)
			else
				l_token := actual_class_type_token (type_i.static_type_id)
			end
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Isinst, l_token)
		end

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction where ANY is replaced by SYSTEM_OBJECT.
		local
			l_token: INTEGER
		do
				-- We use `mapped_class_type_token' because if we do:
				-- a: ANY
				-- o: SYSTEM_OBJECT
				-- a := o -- valid because SYSTEM_OBJECT inherits from ANY
				-- a ?= o -- should also be valid.
			if type_i.is_expanded then
				l_token := mapped_class_type_token (type_i.implementation_id)
			else
				l_token := mapped_class_type_token (type_i.static_type_id)
			end
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Isinst, l_token)
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		local
			l_source, l_target: CL_TYPE_I
			l_token: INTEGER
		do
			if is_verifiable and not target_type.is_expanded then
				l_source ?= source_type
				l_target ?= target_type
				if
					source_type = Void or else
					l_source = Void or else l_target = Void or else
					not l_source.base_class.simple_conform_to (l_target.base_class)
				then
					if target_type.is_expanded then
						l_token := mapped_class_type_token (target_type.implementation_id)
					else
						l_token := mapped_class_type_token (target_type.static_type_id)
					end
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass, l_token)
				end
			end
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class.
		local
			cl_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class_type := cl_type.associated_class_type
			end
			if
				l_class_type /= Void and then
				l_class_type.is_generated_as_single_type
			then
				if need_target then
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld,
						attribute_token (type_i.static_type_id, a_feature_id))
				else
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld,
						attribute_token (type_i.static_type_id, a_feature_id))
				end
			elseif l_class_type.is_expanded then
				method_body.put_call ({MD_OPCODES}.Call,
					setter_token (type_i.implementation_id, a_feature_id), 1, False)
			else
				method_body.put_call ({MD_OPCODES}.Callvirt,
					setter_token (type_i.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_expanded_attribute_assignment (type_i, attr_type: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		local
			cl_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
		do
			cl_type ?= type_i
			if cl_type /= Void then
				l_class_type := cl_type.associated_class_type
			end
			if
				l_class_type = Void or else
				not l_class_type.is_generated_as_single_type
			then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldobj,
					actual_class_type_token (attr_type.static_type_id))
				method_body.put_call ({MD_OPCODES}.Callvirt,
					setter_token (type_i.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode ({MD_OPCODES}.Stloc_0)
			when 1 then method_body.put_opcode ({MD_OPCODES}.Stloc_1)
			when 2 then method_body.put_opcode ({MD_OPCODES}.Stloc_2)
			when 3 then method_body.put_opcode ({MD_OPCODES}.Stloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 ({MD_OPCODES}.Stloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 ({MD_OPCODES}.Stloc,
						l_pos.to_integer_16)
				end
			end
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
			if once_generation then
				generate_once_store_result
			else
				generate_local_assignment (result_position)
			end
		end

feature -- Conversion

	convert_to (type: TYPE_I) is
			-- Convert top of stack into `type'.
		do
			inspect
				type.element_type
			when {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then convert_to_boolean
			when {MD_SIGNATURE_CONSTANTS}.Element_type_char then convert_to_character
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then convert_to_real_32
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then convert_to_real_64
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then convert_to_natural_8
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then convert_to_natural_16
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then convert_to_natural_32
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then convert_to_natural_64
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i then convert_to_native_int
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then convert_to_integer_8
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then convert_to_integer_16
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then convert_to_integer_32
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then convert_to_integer_64
			else
				check
					False
				end
			end
		end

	convert_to_native_int is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i)
		end

	convert_to_integer_8, convert_to_boolean is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i1)
		end

	convert_to_integer_16, convert_to_character is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i2)
		end

	convert_to_integer_32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i4)
		end

	convert_to_integer_64 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i8)
		end

	convert_to_natural_8 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u1)
		end

	convert_to_natural_16 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u2)
		end

	convert_to_natural_32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u4)
		end

	convert_to_natural_64 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u8)
		end


	convert_to_real_64 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_r8)
		end

	convert_to_real_32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_r4)
		end

feature -- Return statements

	generate_return (has_return_value: BOOLEAN) is
			-- Generate simple end of routine
		do
			method_body.put_opcode ({MD_OPCODES}.Ret)
			if has_return_value then
					-- We need to remove `1' to the current stack depth since
					-- we remove the return value from the stack with the `ret'
					-- statement.
				method_body.update_stack_depth (-1)
			end
		end

feature {NONE} -- Once management

	once_done_name (feature_name: STRING): STRING is
			-- Name of the field that indicates whether once routine has been executed or not
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_done"
		ensure
			result_not_void: Result /= Void
		end

	once_exception_name (feature_name: STRING): STRING is
			-- Name of the field that holds exception raised during execution of once routine
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_exception"
		ensure
			result_not_void: Result /= Void
		end

	once_result_name (feature_name: STRING): STRING is
			-- Name of the field that stores result of a once function
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_result"
		ensure
			result_not_void: Result /= Void
		end

	once_ready_name (feature_name: STRING): STRING is
			-- Name of flag that indicates that once data is ready to use from a different thread
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_ready"
		ensure
			result_not_void: Result /= Void
		end

	once_sync_name (feature_name: STRING): STRING is
			-- Name of the field that is used to synchronize access to once routine data
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_sync"
		ensure
			result_not_void: Result /= Void
		end

feature -- Once management

	generate_once_data (class_c: CLASS_C) is
			-- Generate IL class that is used to store results of once routines declared in `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			feature_table: FEATURE_TABLE
			feature_i: FEATURE_I
			class_constructor_token: INTEGER
			l_method_sig: like method_sig
		do
				-- Set current module and class
			set_current_module_for_class (class_c)
			current_class := class_c
				-- Avoid generating class data when there are no once routines
			current_class_token := 0
			method_body := Void
				-- Generate data for once features in class `class_c'
				-- (they are either immediate or replicated in it)
			from
				feature_table := class_c.feature_table
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration
				if feature_i.is_once and then feature_i.access_in = class_c.class_id then
					if current_class_token = 0 then
						current_class_token := current_module.class_data_token (class_c)
					end
					sync_token := 0
					generate_once_data_info (feature_i)
					if sync_token /= 0 then
							-- Static field has to be initialized in a class constructor
						if class_constructor_token = 0 then
							l_method_sig := method_sig
							l_method_sig.reset
							l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
							l_method_sig.set_parameter_count (0)
							l_method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
							uni_string.set_string (".cctor")
							class_constructor_token := md_emit.define_method (
								uni_string,
								current_class_token,
								{MD_METHOD_ATTRIBUTES}.private |
								{MD_METHOD_ATTRIBUTES}.static |
								{MD_METHOD_ATTRIBUTES}.special_name |
								{MD_METHOD_ATTRIBUTES}.rt_special_name |
								{MD_METHOD_ATTRIBUTES}.hide_by_signature,
								l_method_sig,
								{MD_METHOD_ATTRIBUTES}.il | {MD_METHOD_ATTRIBUTES}.managed)
							start_new_body (class_constructor_token)
						end
						method_body.put_newobj (constructor_token (current_module.object_type_id), 0)
						method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, sync_token)
					end
				end
				feature_table.forth
			end
			if method_body /= Void then
				generate_return (false)
				method_writer.write_current_body
			end
		end

	done_token, result_token, exception_token: INTEGER
			-- Token for static fields holding value if once has been computed,
			-- its value if computed.
			-- Ok to use token in a non-module specific code here, because they
			-- are only local to current feature generation.

	ready_token, sync_token: INTEGER
			-- Token for static fields holding ready-to-use flag and synchronization object
			-- for process-relative once routines.
			-- Ok to use token in a non-module specific code here, because they
			-- are only local to current feature generation.

	once_done_label: IL_LABEL
			-- Label which is used in test of a "done" flag `done_token'

	once_ready_label: IL_LABEL
			-- Label which is used in test of a "ready" flag `ready_token'

	generate_once_data_info (feat: FEATURE_I) is
			-- Generate declaration of variables required to store data of once feature `feat'.
		require
			feat_not_void: feat /= Void
			feat_is_once: feat.is_once
		local
			name: STRING
			result_sig: like field_sig
		do
			name := feat.feature_name

				-- Generate field that indicates whether result is calculated or not
			uni_string.set_string (once_done_name (name))
			done_token := md_emit.define_field (uni_string,
				current_class_token,
				{MD_FIELD_ATTRIBUTES}.Public | {MD_FIELD_ATTRIBUTES}.Static,
				done_sig)
			if not feat.is_process_relative then
				current_module.define_thread_static_attribute (done_token)
			end

				-- Generate field that holds exception raised during evaluation
			uni_string.set_string (once_exception_name (name))
			exception_token := md_emit.define_field (uni_string,
				current_class_token,
				{MD_FIELD_ATTRIBUTES}.Public | {MD_FIELD_ATTRIBUTES}.Static,
				exception_sig)
			if not feat.is_process_relative then
				current_module.define_thread_static_attribute (exception_token)
			end

			if not feat.type.is_void then
					-- Generate field for result
				result_sig := field_sig
				result_sig.reset
				set_signature_type (result_sig, feat.type.type_i)

				uni_string.set_string (once_result_name (name))
				result_token := md_emit.define_field (uni_string,
					current_class_token,
					{MD_FIELD_ATTRIBUTES}.Public | {MD_FIELD_ATTRIBUTES}.Static, result_sig)
				if not feat.is_process_relative then
					current_module.define_thread_static_attribute (result_token)
				end
			end

			Il_debug_info_recorder.record_once_info_for_class (current_class_token, done_token, result_token, exception_token, feat, current_class)

			if feat.is_process_relative then
					-- Generate flag that indicates that once data fields are ready to use
				uni_string.set_string (once_ready_name (name))
				sync_token := md_emit.define_field (
					uni_string,
					current_class_token,
					{MD_FIELD_ATTRIBUTES}.Public | {MD_FIELD_ATTRIBUTES}.Static,
					done_sig)
					-- Generate field to synchronize access to other data fields
				uni_string.set_string (once_sync_name (name))
				sync_token := md_emit.define_field (
					uni_string,
					current_class_token,
					{MD_FIELD_ATTRIBUTES}.Public | {MD_FIELD_ATTRIBUTES}.Static,
					sync_sig)
			end
		end

	generate_once_access_info (feature_i: FEATURE_I) is
			-- Initialize tokens for fields that are used to store result of `feature_i'.
		require
			feature_i_not_void: feature_i /= Void
			once_feature: feature_i.is_once
		local
			class_data_token: INTEGER
			name: STRING
			l_sig: like field_sig
		do
			name := feature_i.feature_name
			class_data_token := current_module.class_data_token (system.class_of_id (feature_i.access_in))
			uni_string.set_string (once_done_name (name))
			done_token := md_emit.define_member_ref (uni_string, class_data_token, done_sig)
			uni_string.set_string (once_exception_name (name))
			exception_token := md_emit.define_member_ref (uni_string, class_data_token, exception_sig)
			if feature_i.has_return_value then
				l_sig := field_sig
				l_sig.reset
				set_signature_type (l_sig, result_type (feature_i))
				uni_string.set_string (once_result_name (name))
				result_token := md_emit.define_member_ref (uni_string, class_data_token, l_sig)
			else
				result_token := 0
			end
			if feature_i.is_process_relative then
				uni_string.set_string (once_ready_name (name))
				ready_token := md_emit.define_member_ref (uni_string, class_data_token, done_sig)
				uni_string.set_string (once_sync_name (name))
				sync_token := md_emit.define_member_ref (uni_string, class_data_token, sync_sig)
			else
				ready_token := 0
				sync_token := 0
			end
		ensure
			done_token_set: done_token /= 0
			result_token_set: feature_i.has_return_value = (result_token /= 0)
			ready_token_set: feature_i.is_process_relative = (ready_token /= 0)
			sync_token_set: feature_i.is_process_relative = (sync_token /= 0)
		end

	generate_once_prologue is
			-- Generate prologue for once feature.
			-- The feature is used with `generate_once_epilogue' as follows:
			--    generate_once_prologue
			--    ... -- code of once feature body
			--    generate_once_epilogue
--		require
			-- current_feature_not_void: byte_context.current_feature /= Void
			-- current_feature_is_once: byte_context.current_feature.is_once
		do
				-- Body of a once feature is guarded by try/fault blocks
				-- to avoid storing invalid result in case of exception:
				--       done := true
				--       try {
				--          ... -- code of once feature body (including rescue clause)
				--       }
				--       catch (Object e) {
				--          exception := e
				--          volatile ready := true -- only in process-relative code
				--          rethrow
				--       }

				-- Thread-relative code looks like
				--    if not done then
				--       guarded_body -- see above
				--    end
				--    if exception /= Void then
				--       raise (exception)
				--    end
				--    return result -- if required

				-- Process-relative code uses double-check algorithm and looks like
				--    if not volatile ready then
				--       try {
				--          lock (sync)
				--          if not done then
				--             guarded_body -- see above
				--             volatile ready := true
				--          end
				--       }
				--       finally {
				--          unlock (sync)
				--       }
				--    end
				--    if exception /= Void then
				--       raise (exception)
				--    end
				--    return result -- if required

				-- Initialize once code generation
			set_once_generation (True)
			generate_once_access_info (byte_context.current_feature)

			if ready_token /= 0 then
				check sync_token /= 0 end
					-- Generate synchronization for process-relative feature:
					--    if not volatile ready then
					--       try {
					--          lock (sync)
				method_body.put_opcode ({MD_OPCODES}.volatile)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, ready_token)
				once_ready_label := create_label
				branch_on_true (once_ready_label)
				method_body.once_finally_block.set_try_offset (method_body.count)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, sync_token)
				method_body.put_static_call (current_module.define_monitor_method_token ("Enter"), 1, False)
			end

				-- Generate code that is common for thread-relative and process-relative case:
				--    if not done then
				--       done := true
				--       try {
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, done_token)
			once_done_label := create_label
			branch_on_true (once_done_label)
			put_boolean_constant (True)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, done_token)
			method_body.once_catch_block.set_try_offset (method_body.count)
		ensure then
			once_generation: once_generation
			done_token_set: done_token /= 0
			result_token_set: byte_context.current_feature.has_return_value = (result_token /= 0)
			ready_token_set: byte_context.current_feature.is_process_relative = (ready_token /= 0)
			sync_token_set: byte_context.current_feature.is_process_relative = (sync_token /= 0)
			once_done_label_set: once_done_label /= Void
			once_ready_label_set: (ready_token /= 0) = (once_ready_label /= Void)
		end

	generate_once_epilogue is
			-- Generate epilogue for once feature.
--		require
			-- current_feature_not_void: byte_context.current_feature /= Void
			-- current_feature_is_once: byte_context.current_feature.is_once
		local
			fault_label: IL_LABEL
			return_label: IL_LABEL
			is_process_relative: BOOLEAN
			has_result: BOOLEAN
		do
				-- Close try block and start fault block
				--       }
				--       catch (Object e) {
				--          exception := e
				--          volatile ready := true -- only in process-relative code
				--          rethrow
				--       }
			fault_label := create_label
			generate_leave_to (fault_label)
			method_body.once_catch_block.set_try_end (method_body.count)
			method_body.once_catch_block.set_class_token (current_module.object_type_token)
			method_body.update_stack_depth (1)
			method_body.once_catch_block.set_handler_offset (method_body.count)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, exception_token)
			if ready_token /= 0 then
					-- Notify other threads that result is ready:
					--          volatile ready := true
				check sync_token /= 0 end
				check once_ready_label /= Void end
				is_process_relative := True
				put_boolean_constant (True)
				method_body.put_opcode ({MD_OPCODES}.volatile)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, ready_token)
			end
				-- Rethrow exception to make original stack trace available to application
				-- as otherwise it will be lost
			method_body.put_rethrow
			method_body.once_catch_block.set_handler_end (method_body.count)
			mark_label (fault_label)

			if is_process_relative then
					-- Notify other threads that result is ready:
					--          volatile ready := true
				put_boolean_constant (True)
				method_body.put_opcode ({MD_OPCODES}.volatile)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, ready_token)
			end

				-- Close "if not done" block:
				--       end
			mark_label (once_done_label)

			if is_process_relative then
					-- Unlock synchronization object and close "if not volatile ready" block in process-relative case:
					--       }
					--       finally {
					--          unlock (sync)
					--       }
					--    end
				generate_leave_to (once_ready_label)
				method_body.once_finally_block.set_try_end (method_body.count)
				method_body.once_finally_block.set_handler_offset (method_body.count)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, sync_token)
				method_body.put_static_call (current_module.define_monitor_method_token ("Exit"), 1, False)
				method_body.put_opcode ({MD_OPCODES}.endfinally)
				method_body.once_finally_block.set_handler_end (method_body.count)
				mark_label (once_ready_label)
			end

				-- Check if there was an exception:
				--    if exception /= Void then
				--       raise (exception)
				--    end
			return_label := create_label
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, exception_token)
			branch_on_false (return_label)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, exception_token)
			method_body.put_throw
			mark_label (return_label)

			if result_token /= 0 then
				has_result := True
					-- Load result of a feature:
					-- return result -- if required
				generate_once_result
			end
			generate_return (has_result)

			done_token := 0
			exception_token := 0
			result_token := 0
			ready_token := 0
			sync_token := 0
			once_done_label := Void
			once_ready_label := Void
			set_once_generation (False)
		ensure then
			not_once_generation: not once_generation
			done_token_unset: done_token = 0
			result_token_unset: result_token = 0
			ready_token_unset: ready_token = 0
			sync_token_unset: sync_token = 0
			once_done_label_unset: once_done_label = Void
			once_ready_label_unset: once_ready_label = Void
		end

	generate_once_result_address is
			-- Generate test on `done' of once feature `name'.
		require
			result_token_set: result_token /= 0
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsflda, result_token)
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
--		require
--			result_token_set: result_token /= 0
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, result_token)
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, result_token)
		end

feature -- Once manifest string manipulation

	generate_once_string_allocation (count: INTEGER) is
			-- Generate code that allocates memory required for `count'
			-- once manifest strings of the current routine.
		local
			allocate_array_label: IL_LABEL
			done_label: IL_LABEL
		do
			if count > 0 then
				allocate_array_label := create_label
				done_label := create_label
					-- Check if the array is already allocated.
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, current_module.once_string_field_token (true))
				method_body.put_opcode ({MD_OPCODES}.dup)
				branch_on_false (allocate_array_label)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode ({MD_OPCODES}.ldlen)
				put_integer_32_constant (byte_context.original_body_index)
				method_body.put_opcode_label ({MD_OPCODES}.ble, allocate_array_label.id)
				put_integer_32_constant (byte_context.original_body_index)
				method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
				method_body.put_opcode ({MD_OPCODES}.dup)
				branch_on_true (done_label)
				mark_label (allocate_array_label)
					-- Array is not allocated.
					-- Call allocation routine.
				put_integer_32_constant (byte_context.original_body_index)
				put_integer_32_constant (count)
				method_body.put_static_call (current_module.once_string_allocation_routine_token, 2, false)
					-- Done.
				mark_label (done_label)
					-- Remove null from stack top.
				method_body.put_opcode ({MD_OPCODES}.pop)
			end
		end

	generate_once_string (number: INTEGER; value: STRING; is_cil_string: BOOLEAN) is
			-- Generate code for once string in a current routine with the given
			-- `number' and `value' using CIL string type if `is_cil_string' is `true'
			-- or Eiffel string type otherwise.
		local
			once_string_field_token: INTEGER
			assign_string_label: IL_LABEL
			done_label: IL_LABEL
		do
			once_string_field_token := current_module.once_string_field_token (is_cil_string)
			assign_string_label := create_label
			done_label := create_label
				-- Check if the string is already created.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, once_string_field_token)
			put_integer_32_constant (byte_context.original_body_index)
			method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
			put_integer_32_constant (number)
			method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
			method_body.put_opcode ({MD_OPCODES}.dup)
				-- String is already created.
			branch_on_true (done_label)
				-- Remove null from stack top.
			method_body.put_opcode ({MD_OPCODES}.pop)
			mark_label (assign_string_label)
				-- String is not stored in array.
				-- Let's create it and store.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, once_string_field_token)
			put_integer_32_constant (byte_context.original_body_index)
			method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
			method_body.put_opcode ({MD_OPCODES}.dup)
			put_integer_32_constant (number)
			if is_cil_string then
				put_system_string (value)
			else
				put_manifest_string (value)
			end
			method_body.put_opcode ({MD_OPCODES}.stelem_ref)
			put_integer_32_constant (number)
			method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
				-- Done.
			mark_label (done_label)
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER; a_type_id: INTEGER) is
			-- Generate call to `item' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
			l_token: INTEGER
		do
			if kind = Il_expanded then
				l_token := actual_class_type_token (a_type_id)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldelema, l_token)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldobj, l_token)
			else
				inspect kind
				when Il_i1 then l_opcode := {MD_OPCODES}.Ldelem_i1
				when Il_i2 then l_opcode := {MD_OPCODES}.Ldelem_i2
				when Il_i4 then l_opcode := {MD_OPCODES}.Ldelem_i4
				when Il_i8, Il_u8 then l_opcode := {MD_OPCODES}.Ldelem_i8
				when Il_r4 then l_opcode := {MD_OPCODES}.Ldelem_r4
				when Il_r8 then l_opcode := {MD_OPCODES}.Ldelem_r8
				when Il_ref then l_opcode := {MD_OPCODES}.Ldelem_ref
				when Il_i then l_opcode := {MD_OPCODES}.Ldelem_i
				when Il_u1 then l_opcode := {MD_OPCODES}.Ldelem_u1
				when Il_u2 then l_opcode := {MD_OPCODES}.Ldelem_u2
				when Il_u4 then l_opcode := {MD_OPCODES}.Ldelem_u4
				when Il_expanded then
				else
					check
						not_reached: False
					end
				end
				method_body.put_opcode (l_opcode)
			end
		end

	generate_array_write_preparation (a_type_id: INTEGER) is
			-- Prepare call to `put' from NATIVE_ARRAY in case of expanded elements.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldelema,
				actual_class_type_token (a_type_id))
		end

	generate_array_write (kind: INTEGER; a_type_id: INTEGER) is
			-- Generate call to `put' of NATIVE_ARRAY.
		local
			l_opcode: INTEGER_16
		do
			if kind = il_expanded then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stobj,
					actual_class_type_token (a_type_id))
			else
				inspect kind
				when Il_i1, Il_u1 then l_opcode := {MD_OPCODES}.Stelem_i1
				when Il_i2, Il_u2 then l_opcode := {MD_OPCODES}.Stelem_i2
				when Il_i4, Il_u4 then l_opcode := {MD_OPCODES}.Stelem_i4
				when Il_i8, Il_u8 then l_opcode := {MD_OPCODES}.Stelem_i8
				when Il_r4 then l_opcode := {MD_OPCODES}.Stelem_r4
				when Il_r8 then l_opcode := {MD_OPCODES}.Stelem_r8
				when Il_ref then l_opcode := {MD_OPCODES}.Stelem_ref
				when Il_i then l_opcode := {MD_OPCODES}.Stelem_i
				else
					check
						not_reached: False
					end
				end
				method_body.put_opcode (l_opcode)
			end
		end

	generate_array_initialization (actual_generic: CLASS_TYPE) is
			-- Initialize native array with actual parameter type
			-- `actual_generic' on the top of the stack.
		local
			enter_loop_label: IL_LABEL
			continue_loop_label: IL_LABEL
			local_number: INTEGER
		do
			if actual_generic.type.is_true_expanded and then not actual_generic.is_external then
					-- Initialize elements with their default values:
					-- int i = array.count;
					-- while (i != 0) {
					--   i--;
					--   array [i].ctor ();
					--   array [i].default_create ();
					-- }
				enter_loop_label := create_label
				continue_loop_label := create_label
				byte_context.add_local (int32_c_type)
				local_number := byte_context.local_list.count
				put_dummy_local_info (int32_c_type, local_number)
				duplicate_top
				generate_array_count
				generate_local_assignment (local_number)
				branch_to (enter_loop_label)
				mark_label (continue_loop_label)
				duplicate_top
				generate_local (local_number)
				put_integer_8_constant (1)
				generate_binary_operator (il_minus)
				duplicate_top
				generate_local_assignment (local_number)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldelema, actual_class_type_token (actual_generic.static_type_id))
				initialize_expanded_variable (actual_generic)
				mark_label (enter_loop_label)
				generate_local (local_number)
				branch_on_true (continue_loop_label)
			end
		end

	generate_array_creation (a_type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Newarr,
				actual_class_type_token (a_type_id))
		end

	generate_generic_array_creation (a_formal: FORMAL_I) is
			-- Create a new NATIVE_ARRAY [X] where X is a formal type `a_formal'.
		do
			a_formal.generate_gen_type_il (Current, True)
			method_body.put_opcode ({MD_OPCODES}.ldarg_0)
			put_type_token (any_type.implementation_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_array", Static_type, <<integer_32_class_name, type_class_name,
				type_info_class_name, type_handle_class_name>>, system_object_class_name,
				False)
		end

	generate_array_count is
			-- Get length of current NATIVE_ARRAY on stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldlen)
			convert_to_integer_32
		end

	generate_array_upper is
			-- Generate call to `count - 1'.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldlen)
			method_body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			method_body.put_opcode ({MD_OPCODES}.Sub)
		end

	generate_array_lower is
			-- Always `0' for native arrays as they are zero-based one
			-- dimensional array.
		do
				-- First we pop pushed array as it is not needed and
				-- then we push `0'.
			method_body.put_opcode ({MD_OPCODES}.Pop)
			method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
		end

feature -- Exception handling

	rescue_label: INTEGER
			-- Label used for rescue clauses to mark end of `try-catch'.

	generate_start_exception_block is
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
			rescue_label := method_body.define_label
			method_body.exception_block.set_start_position (method_body.count)
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_catch_position (method_body.count)
			method_body.exception_block.set_type_token (current_module.system_exception_token)
				-- We need to increment stack depth of 1 because CLI runtime automatically
				-- puts the exception object on top of stack and there is no automatic
				-- way to add it.
			method_body.update_stack_depth (1)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld,
				current_module.ise_last_exception_token)
		end

	generate_leave_to (a_label: IL_LABEL) is
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Leave, a_label.id)
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
			put_integer_32_constant ({EXCEP_CONST}.routine_failure)
			put_void
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld,
				current_module.ise_last_exception_token)
			method_body.put_newobj (current_module.ise_eiffel_exception_chained_ctor_token, 3)
			method_body.put_throw
			method_body.exception_block.set_end_position (method_body.count)
			method_body.mark_label (rescue_label)
		end

feature -- Assertions

	generate_in_assertion_status is
			-- Generate value of `in_assertion' on stack.
		do
			method_body.put_static_call (current_module.ise_in_assertion_token, 0, True)
		end

	generate_is_assertion_checked (level: INTEGER) is
			-- Check wether or not we need to check assertion for current type.
		do
			if System.in_final_mode then
				method_body.put_static_call (current_module.ise_in_assertion_token, 0, True)
				method_body.put_opcode ({MD_OPCODES}.ldc_i4_0);
				method_body.put_opcode ({MD_OPCODES}.ceq)
			else
				generate_current_as_reference
				internal_generate_external_call (current_module.mscorlib_token, 0, System_object_class_name,
					"GetType", Normal_type, <<>>, System_type_class_name, False)
				put_integer_32_constant (level)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					runtime_class_name, "is_assertion_checked", Static_type,
					<<System_type_class_name, Assertion_level_enum_class_name>>, "System.Boolean", False)
			end
		end

	generate_set_assertion_status is
			-- Set `in_assertion' flag with top of stack.
		do
			method_body.put_static_call (current_module.ise_set_in_assertion_token, 1, False)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		local
			type_assert: INTEGER
			l_label: INTEGER
		do
			inspect
				assert_type
			when In_postcondition then
				type_assert := {EXCEP_CONST}.postcondition
			when In_check then
				type_assert := {EXCEP_CONST}.check_instruction
			when In_loop_invariant then
				type_assert := {EXCEP_CONST}.loop_invariant
			when In_loop_variant then
				type_assert := {EXCEP_CONST}.loop_variant
			when In_invariant then
				type_assert := {EXCEP_CONST}.class_invariant
			end

			l_label := method_body.define_label
			method_body.put_opcode_label ({MD_OPCODES}.Brtrue, l_label)
			put_boolean_constant (False)
			generate_set_assertion_status

			generate_raise_exception (type_assert, tag)

			method_body.mark_label (l_label)
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL) is
			-- Generate test after a precondition is generated
			-- If result of test is False we put `tag' in an
			-- exception object and go check next block of inherited
			-- preconditions and check them. If no more block, we raise
			-- an exception with exception object.
		local
			l_str_token: INTEGER
		do
			if tag = Void then
				put_void
			else
				uni_string.set_string (tag)
				l_str_token := md_emit.define_string (uni_string)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr, l_str_token)
			end
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld,
				current_module.ise_assertion_tag_token)
			method_body.put_opcode_label ({MD_OPCODES}.Brfalse, failure_block.id)
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
			put_boolean_constant (False)
			generate_set_assertion_status
			put_integer_32_constant ({EXCEP_CONST}.precondition)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld,
				current_module.ise_assertion_tag_token)
			method_body.put_newobj (current_module.ise_eiffel_exception_ctor_token, 2)
			method_body.put_throw
		end

	generate_raise_exception (a_code: INTEGER; a_tag: STRING) is
			-- Generate an exception of type EIFFEL_EXCEPTION with code
			-- `a_code' and with tag `a_tag'.
		do
			put_integer_32_constant (a_code)
			if a_tag = Void then
				put_void
			else
				uni_string.set_string (a_tag)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldstr,
					md_emit.define_string (uni_string))
			end
			method_body.put_newobj (current_module.ise_eiffel_exception_ctor_token, 2)
			method_body.put_throw
		end

	generate_invariant_feature (feat: INVARIANT_FEAT_I) is
			-- Generate `_invariant' that checks `current_class_type' invariants.
		local
			l_invariant_token: INTEGER
			l_dotnet_invariant_token: INTEGER
			l_sig: like method_sig
		do
			if feat = Void or else not current_class_type.is_expanded then
					-- Generate instance invariant feature even though class invariant is not defined.
				uni_string.set_string ("_invariant")
				l_dotnet_invariant_token := md_emit.define_method (uni_string, current_class_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Virtual,
					default_sig, {MD_METHOD_ATTRIBUTES}.Managed)
			end
			if current_class_type.is_expanded then
					-- Code for expanded class does not use static features.
				if feat = Void then
						-- Generate code for inherited invariants only.
					start_new_body (l_dotnet_invariant_token)
					generate_invariant_body (Void)
					method_writer.write_current_body
				else
						-- Generate code for immediate and inherited invariants.
					generate_feature (feat, False, False, False)
					generate_feature_code (feat, False)
				end
			else
					-- First we generate the `$$_invariant' feature
					-- which only contains invariant for Current class.
				if feat /= Void then
					generate_feature (feat, False, True, False)
					generate_feature_code (feat, True)
					l_invariant_token := implementation_feature_token (current_type_id, feat.feature_id)
				else
						-- Generate empty invariant feature that does nothing.
						-- Will be used in descendant.
					l_sig := method_sig
					l_sig.reset
					l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
					l_sig.set_parameter_count (1)
					l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					set_signature_type (l_sig, current_class_type.type)

					uni_string.set_string ("$$_invariant")
					l_invariant_token := md_emit.define_method (uni_string, current_class_token,
						{MD_METHOD_ATTRIBUTES}.Public |
						{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.Static, l_sig,
						{MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_invariant_token)
					generate_invariant_body (Void)
					method_writer.write_current_body
				end

				current_module.internal_invariant_token.
					put (l_invariant_token, current_class_type.implementation_id)

					-- Generate invariant feature that calls above static version.
				start_new_body (l_dotnet_invariant_token)
				generate_current
				method_body.put_call ({MD_OPCODES}.Call, l_invariant_token, 0, False)
				generate_return (False)
				method_writer.write_current_body
			end
		end

	generate_invariant_body (byte_list: BYTE_LIST [BYTE_NODE]) is
			-- Generate body of the routine that checks class invariant of the current class
			-- represented by `byte_list' (if any) as well as class invariant of ancestors.
		local
			l_end_of_invariant: IL_LABEL
		do
			l_end_of_invariant := create_label
			generate_invariant_checked_for (l_end_of_invariant)
			if byte_list /= Void then
				byte_list.process (cil_node_generator)
			end
			generate_inherited_invariants
			mark_label (l_end_of_invariant)
			generate_return (False)
		end

	generate_inherited_invariants is
			-- Generate call to all directly inherited invariant features.
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			cl_type: CLASS_TYPE
			i, id: INTEGER
			l_list: SEARCH_TABLE [INTEGER]
		do
			from
				parents := current_class_type.associated_class.parents
				create l_list.make (parents.count)
				parents.start
			until
				parents.after
			loop
				parent_type ?= byte_context.real_type (parents.item.type_i)
				cl_type := parent_type.associated_class_type
				id := cl_type.implementation_id
				if not l_list.has (id) then
					l_list.force (id)
					if not cl_type.is_external then
						generate_current_as_reference
						method_body.put_call ({MD_OPCODES}.Call,
							invariant_token (id), 0, False)
					end
					i := i + 1
				end
				parents.forth
			end
		end

	generate_invariant_checked_for (a_label: IL_LABEL) is
			-- Generate check to find out if we should check invariant or not.
		do
			put_type_token (current_class_type.type.static_type_id)
			method_body.put_static_call (current_module.ise_is_invariant_checked_for_token, 1, True)
			branch_on_true (a_label)
		end

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call, it assumes that
			-- target has already been pushed onto evaluation stack.
		do
			put_boolean_constant (System.in_final_mode)
			method_body.put_static_call (current_module.ise_check_invariant_token, 2, False)
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		do
			inspect
				type.element_type
			when {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				put_boolean_constant (False)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				put_character_constant ('%U')
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				put_real_64_constant (0.0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				put_real_32_constant (0.0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then
				put_natural_8_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then
				put_natural_16_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then
				put_natural_32_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then
				put_natural_64_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				put_integer_32_constant (0)
				convert_to_native_int
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then
				put_integer_8_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then
				put_integer_16_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then
				put_integer_32_constant (0)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then
				put_integer_64_constant (0)
			else
				put_void
			end
		end

	put_void is
			-- Add a Void element on stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldnull)
		end

	put_manifest_string_from_system_string_local (n: INTEGER) is
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		do
			create_object (string_implementation_id)
			duplicate_top
			generate_local (n)
			internal_generate_feature_access (string_type_id, string_make_feat_id, 1, False, True)
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		do
			create_object (string_implementation_id)
			duplicate_top
			put_system_string (s)
			internal_generate_feature_access (string_type_id, string_make_feat_id, 1, False, True)
		end

	put_system_string (s: STRING) is
			-- Put `System.String' object corresponding to `s' on IL stack.
		local
			l_string_token: INTEGER
		do
			uni_string.set_string (s)
			l_string_token := md_emit.define_string (uni_string)
			method_body.put_string (l_string_token)
		end

	put_numeric_integer_constant (type: TYPE_I; i: INTEGER) is
			-- Put `i' as a constant of type `type'.
		do
			inspect
				type.element_type
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				put_real_64_constant (i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				put_real_32_constant (i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then
				put_natural_8_constant (i.as_natural_8)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then
				put_natural_16_constant (i.as_natural_16)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then
				put_natural_32_constant (i.as_natural_32)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then
				put_natural_64_constant (i.as_natural_64)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then
				put_integer_8_constant (i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then
				put_integer_16_constant (i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then
				put_integer_32_constant (i)
			when {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then
				put_integer_64_constant (i)
			else
				check
					False
				end
			end
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER) is
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
			inspect
				i
			when 0 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
			when 1 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			when 2 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_2)
			when 3 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_3)
			when 4 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_4)
			when 5 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_5)
			when 6 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_6)
			when 7 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_7)
			when 8 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_8)
			else
				method_body.put_opcode_integer ({MD_OPCODES}.Ldc_i4, i)
			end
		end

	put_integer_64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		do
			method_body.put_opcode_integer_64 ({MD_OPCODES}.Ldc_i8, i)
		end

	put_natural_8_constant,
	put_natural_16_constant,
	put_natural_32_constant (n: NATURAL_32) is
			-- Put `n' as NATURAL_8, NATURAL_16, NATURAL_32 on IL stack.
		do
			fixme ("Remove conversion to INTEGER_32 after bootstrap.")
			inspect
				n.as_integer_32
			when 0 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
			when 1 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			when 2 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_2)
			when 3 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_3)
			when 4 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_4)
			when 5 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_5)
			when 6 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_6)
			when 7 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_7)
			when 8 then method_body.put_opcode ({MD_OPCODES}.Ldc_i4_8)
			else
				method_body.put_opcode_natural_32 ({MD_OPCODES}.Ldc_i4, n)
			end
		end

	put_natural_64_constant (n: NATURAL_64) is
			-- Put `n' as NATURAL_64 on IL stack.
		do
			method_body.put_opcode_natural_64 ({MD_OPCODES}.Ldc_i8, n)
		end

	put_real_32_constant (r: REAL) is
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_real_32 ({MD_OPCODES}.Ldc_r4, r)
		end

	put_real_64_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_real_64 ({MD_OPCODES}.Ldc_r8, d)
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		do
			method_body.put_opcode_integer ({MD_OPCODES}.Ldc_i4, c.code)
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		do
			if b then
				method_body.put_opcode ({MD_OPCODES}.ldc_i4_1)
			else
				method_body.put_opcode ({MD_OPCODES}.ldc_i4_0)
			end
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Brtrue, label.id)
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Brfalse, label.id)
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Br, label.id)
		end

	branch_on_condition (comparison: INTEGER_16; label: IL_LABEL) is
			-- Generate a branch instruction to `label' if two top-level operands on
			-- IL stack when compared using conditional instruction `comparison' yield True.
		do
			method_body.put_opcode_label (comparison, label.id)
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		do
			method_body.mark_label (label.id)
		end

	create_label: IL_LABEL is
			-- Create a new label
		do
			create Result.make (method_body.define_label)
		end

feature -- Switch instruction

	put_switch_start (count: INTEGER) is
			-- Generate start of a switch instruction with `count' items.
		do
			method_body.put_opcode_integer ({MD_OPCODES}.switch, count)
			switch_count := count
		end

	put_switch_label (label: IL_LABEL) is
			-- Generate a branch to `label' in switch instruction.
		do
			switch_count := switch_count - 1
				-- Labels of switch instruction are calculated relative to instruction end
			method_body.put_label (label.id, - switch_count * 4)
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_le then
				method_body.put_opcode ({MD_OPCODES}.Cgt)
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)
			when il_lt then method_body.put_opcode ({MD_OPCODES}.Clt)
			when il_ge then
				method_body.put_opcode ({MD_OPCODES}.Clt)
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)
			when il_gt then method_body.put_opcode ({MD_OPCODES}.Cgt)
			when il_star then method_body.put_opcode ({MD_OPCODES}.Mul)
			when il_power then
				method_body.put_static_call (current_module.power_method_token, 2, True)
			when il_plus then method_body.put_opcode ({MD_OPCODES}.Add)
			when il_mod then method_body.put_opcode ({MD_OPCODES}.Rem)
			when il_minus then method_body.put_opcode ({MD_OPCODES}.Sub)
			when il_div, il_slash then method_body.put_opcode ({MD_OPCODES}.Div)
			when il_xor then method_body.put_opcode ({MD_OPCODES}.Xor_opcode)
			when il_or then method_body.put_opcode ({MD_OPCODES}.Or_opcode)
			when il_and then method_body.put_opcode ({MD_OPCODES}.And_opcode)
			when il_eq then method_body.put_opcode ({MD_OPCODES}.Ceq)
			when il_ne then
				method_body.put_opcode ({MD_OPCODES}.Ceq)
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)
			when il_shl then method_body.put_opcode ({MD_OPCODES}.Shl)
			when il_shr then method_body.put_opcode ({MD_OPCODES}.Shr)
			end
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_uplus then -- Nothing to be done here.
			when il_uminus then method_body.put_opcode ({MD_OPCODES}.Neg)
			when il_not then
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)
			when il_bitwise_not then method_body.put_opcode ({MD_OPCODES}.Not_opcode)
			end
		end

feature -- Basic feature

	generate_upper_lower (is_upper: BOOLEAN) is
			-- Generate upper if `is_upper', lower otherwise on CHARACTER.
		local
			l_rout_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Char_c_type)
			set_signature_type (l_sig, Char_c_type)

			if is_upper then
				uni_string.set_string ("ToUpper")
			else
				uni_string.set_string ("ToLower")
			end
			l_rout_token := md_emit.define_member_ref (uni_string,
				current_module.char_type_token, l_sig)

			method_body.put_static_call (l_rout_token, 1, True)
		end

	generate_is_query_on_character (query_name: STRING) is
			-- Generate is_`query_name' on CHARACTER returning a boolean.
		local
			l_query_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Boolean_c_type)
			set_signature_type (l_sig, Char_c_type)

			uni_string.set_string (query_name)
			l_query_token := md_emit.define_member_ref (uni_string,
				current_module.char_type_token, l_sig)

			method_body.put_static_call (l_query_token, 1, True)
		end

	generate_min (type: TYPE_I) is
			-- Generate `min' on basic types.
		local
			l_min_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			uni_string.set_string ("Min")
			l_min_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_static_call (l_min_token, 2, True)
		end

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		local
			l_max_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			uni_string.set_string ("Max")
			l_max_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_static_call (l_max_token, 2, True)
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		local
			l_abs_token: INTEGER
			l_sig: like method_sig
		do
			create l_sig.make
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			uni_string.set_string ("Abs")
			l_abs_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_static_call (l_abs_token, 1, True)
		end

	generate_to_string is
			-- Generate call on `ToString'.
		do
			method_body.put_call ({MD_OPCODES}.Callvirt,
				current_module.to_string_method_token, 0, True)
		end

	generate_hash_code is
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
			convert_to_integer_32
			put_integer_32_constant (0x7FFFFFFF)
			method_body.put_opcode ({MD_OPCODES}.And_opcode)
		end

	generate_out (type: TYPE_I) is
			-- Generate `out' on basic types.
		local
			local_number: INTEGER
		do
				-- Generate `out' representation in IL format
			generate_metamorphose (type)
			generate_to_string

				-- Store value
			byte_context.add_local (System_string_type)
			local_number := byte_context.local_list.count
			put_dummy_local_info (System_string_type, local_number)
			generate_local_assignment (local_number)

			create_object (string_implementation_id)
			duplicate_top
			generate_local (local_number)
			internal_generate_feature_access (string_type_id, string_make_feat_id, 1, False, True)

			if type.is_feature_pointer then
					-- Handling a POINTER type, we need to prepend `0x' to the output.
				duplicate_top
				put_manifest_string ("0x")
				internal_generate_feature_access (string_type_id, string_prepend_feat_id, 1, False, True)
			end
		end

feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		local
			l_pos: INTEGER
		do
			if is_debug_info_enabled then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (n, l_pos)
				dbg_start_columns.force (0, l_pos)
				dbg_end_lines.force (n, l_pos)
				dbg_end_columns.force (1000, l_pos)
				dbg_offsets_count := l_pos + 1

				Il_debug_info_recorder.record_line_info (current_class_type, Byte_context.current_feature, method_body.count, n)
				method_body.put_nop
			end
		end

	put_silent_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.			
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
			if is_debug_info_enabled then
				Il_debug_info_recorder.ignore_next_debug_info
				put_line_info (n)
			end
		end

	put_debug_info (location: LOCATION_AS) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		local
			l_pos: INTEGER
		do
			if is_debug_info_enabled then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (location.line, l_pos)
				dbg_start_columns.force (location.column, l_pos)
				dbg_end_lines.force (location.line, l_pos)
				dbg_end_columns.force (location.final_column, l_pos)
				dbg_offsets_count := l_pos + 1

				Il_debug_info_recorder.record_line_info (current_class_type,
					Byte_context.current_feature, method_body.count, location.line)
				method_body.put_nop
			end
		end

	put_ghost_debug_infos (a_line_n:INTEGER; a_nb: INTEGER) is
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal with the not generated debug clauses
			-- but displayed in eStudio during debugging
		do
			if is_debug_info_enabled then
				Il_debug_info_recorder.record_ghost_debug_infos (current_class_type, Byte_context.current_feature, method_body.count, a_line_n, a_nb)
			end
		end

	put_silent_debug_info (location: LOCATION_AS) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
			if is_debug_info_enabled then
				Il_debug_info_recorder.ignore_next_debug_info
				put_debug_info (location)
			end
		end

	flush_sequence_points (a_class_type: CLASS_TYPE) is
			-- Flush all sequence points.
		local
			l_sequence_point_list: LINKED_LIST [like sequence_point]
		do
			if is_debug_info_enabled then
				dbg_writer.define_sequence_points (
					dbg_documents (a_class_type.associated_class.class_id),
					dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
					dbg_end_lines, dbg_end_columns)

				l_sequence_point_list :=
					current_module.method_sequence_points.item (current_feature_token)
				if l_sequence_point_list = Void then
					create l_sequence_point_list.make
					current_module.method_sequence_points.put (l_sequence_point_list,
						current_feature_token)
				end
				l_sequence_point_list.extend ([dbg_offsets_count, dbg_offsets, dbg_start_lines,
					dbg_start_columns, dbg_end_lines, dbg_end_columns,
					a_class_type.associated_class.class_id])

					-- Reset offsets.
				create dbg_offsets.make (0, 5)
				create dbg_start_lines.make (0, 5)
				create dbg_start_columns.make (0, 5)
				create dbg_end_lines.make (0, 5)
				create dbg_end_columns.make (0, 5)
				dbg_offsets_count := 0
			end
		end

feature -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation

feature -- Convenience

	implemented_type (implemented_in: INTEGER; current_type: CL_TYPE_I): CL_TYPE_I is
			-- Return static_type_id of class that defined `feat'.
		local
			cl_type_a: CL_TYPE_A
			written_class: CLASS_C
			class_id: INTEGER
		do
			class_id := current_type.class_id

				-- If a feature is defined in current class, that's easy and we
				-- return `current_type'. Otherwise we have to find the
				-- correct CLASS_TYPE object where the feature is written.
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

	generate_call_on_void_target_exception is
			-- Generate call on void target exception.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"generate_call_on_void_target_exception",
				static_type, <<>>, Void, False)
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		local
			l_type_id: INTEGER
		do
			if cl_type.is_basic then
				l_type_id := basic_type_id
			else
				l_type_id := class_type_id
			end
			create_object (l_type_id)
			duplicate_top
			put_type_token (cl_type.implementation_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				class_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		do
			create_object (generic_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_tuple_type_instance (n: INTEGER) is
			-- Generate a RT_TUPLE_TYPE instance corresponding that will hold `n' items.
		do
			create_object (tuple_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_generics", Normal_type, <<type_array_class_name>>, Void, True);

			duplicate_top
			put_type_token (gen_type.implementation_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_none_type_instance is
			-- Generate a NONE_TYPE instance.
		do
			create_object (none_type_id)
		end

	assign_computed_type is
			-- Given elements on stack, compute associated type and set it to
			-- newly created object.
		do
				-- First object on stack is newly created object on which we
				-- want to assign the computed type.
				-- Second object is the array containing the type array.
				-- Last, we push current object to the stack.
			generate_current_as_reference
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"compute_type", Static_type, <<type_info_class_name, type_class_name,
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
			l_tuple_type: TUPLE_TYPE_I
			l_formal_type: FORMAL_I
			l_type_i: TYPE_I
			l_type_id, i, nb: INTEGER
		do
			l_type_i := a_type_feature.type.type_i

				-- We are now evaluation `l_type_i' in the context of current CLASS_TYPE
				-- generation.
			check
					-- If we have some formals, we are clearly in a generic class.
				is_generic_type: l_type_i.has_true_formal implies current_class_type.is_generic
			end
			l_type_i := l_type_i.complete_instantiation_in (current_class_type)

			if l_type_i.is_formal then
				l_formal_type ?= l_type_i
				l_type_id := formal_type_id
			elseif l_type_i.is_none then
				l_type_id := none_type_id
			else
				l_cl_type ?= l_type_i
				if l_cl_type.is_basic then
					l_type_id := basic_type_id
				else
					l_gen_type ?= l_cl_type
					if l_gen_type /= Void then
						l_tuple_type ?= l_gen_type
						if l_tuple_type /= Void then
							l_type_id := tuple_type_id
						else
							l_type_id := generic_type_id
						end
					else
						l_type_id := class_type_id
					end
				end
			end

			start_new_body (feature_token (current_type_id, a_type_feature.feature_id))

				-- Set position of `result' local variable. Does not make sense to
				-- call `put_result_info' as we don't know its associated CL_TYPE_I.
			result_position := 0

			create_object (l_type_id)

			if l_type_id = formal_type_id then
				duplicate_top
				put_integer_32_constant (l_formal_type.position)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					formal_type_class_name,
					"set_position",
					Normal_type, <<integer_32_class_name>>, Void, True)
			elseif l_type_id = none_type_id then
					-- Nothing to be done, it is enough to create an instance of NONE_TYPE	
			elseif l_type_id = class_type_id then
					-- Non-generic class.
				duplicate_top
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					class_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			elseif l_type_id = basic_type_id then
				duplicate_top
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					basic_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			else
				duplicate_top

				put_integer_32_constant (l_gen_type.meta_generic.count)
				generate_array_creation (runtime_type_id)

				from
					i := l_gen_type.true_generics.lower
					check
						i_start_at_one: i = 1
					end
					nb := l_gen_type.true_generics.upper
				until
					i > nb
				loop
					duplicate_top
					put_integer_32_constant (i - 1)
					l_gen_type.true_generics.item (i).generate_gen_type_il (Current, True)
					generate_array_write ({IL_CONST}.il_ref, 0)
					i := i + 1
				end

				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_generics", normal_type, <<type_array_class_name>>, Void, True)
				duplicate_top
				put_type_token (l_gen_type.implementation_id)
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_type", normal_type, <<type_handle_class_name>>, Void, True)
			end
			generate_return (True)
			method_writer.write_current_body
		end

feature {CIL_CODE_GENERATOR} -- Implementation: convenience

	System_string_type: TYPE_I is
			-- Type of string object
		once
			Result := System.system_string_class.compiled_class.types.first.type
		end

	string_type: TYPE_I is
			-- Type of string object
		once
			Result := System.string_class.compiled_class.types.first.type
		end

	string_implementation_id: INTEGER is
			-- Type ID of string implementation.
		once
			Result := string_type.implementation_id
		end

	string_type_id: INTEGER is
			-- Type of string interface.
		once
			Result := string_type.static_type_id
		end

	string_prepend_feat_id: INTEGER is
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_class.compiled_class.
				feature_table.item ("prepend").feature_id
		ensure
			string_prepend_feat_id_positive: Result > 0
		end

	string_make_feat_id: INTEGER is
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		ensure
			string_make_feat_id_positive: Result > 0
		end

	any_type: CL_TYPE_I is
			-- Type of ANY
		once
			Result := system.any_class.compiled_class.actual_type.type_i
		end

	any_type_id: INTEGER is
			-- Type of ANY interface.
		once
			Result := any_type.static_type_id
		end

	is_equal_feat_id: INTEGER is
			-- Feature ID of `is_equal' of ANY.
		once
			Result := System.any_class.compiled_class.feature_with_rout_id (is_equal_rout_id).feature_id
		ensure
			is_equal_feat_id_positive: Result > 0
		end

	is_equal_rout_id: INTEGER is
			-- Routine ID of `is_equal' of ANY.
		once
			Result := System.any_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.is_equal_name_id).rout_id_set.first
		ensure
			is_equal_rout_id_positive: Result > 0
		end

	copy_feat_id: INTEGER is
			-- Feature ID of `copy' of ANY.
		once
			Result := System.any_class.compiled_class.feature_with_rout_id (copy_rout_id).feature_id
		ensure
			copy_feat_id_positive: Result > 0
		end

	copy_rout_id: INTEGER is
			-- Routine ID of `copy' of ANY.
		once
			Result := System.any_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.copy_name_id).rout_id_set.first
		ensure
			copy_rout_id_positive: Result > 0
		end

	equals_rout_id: INTEGER is
			-- Routine ID of `equals' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.equals_name_id).rout_id_set.first
		ensure
			equals_rout_id_positive: Result > 0
		end

	finalize_rout_id: INTEGER is
			-- Routine ID of `finalize' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
		ensure
			finalize_rout_id_positive: Result > 0
		end

	get_hash_code_rout_id: INTEGER is
			-- Routine ID of `get_hash_code' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.get_hash_code_name_id).rout_id_set.first
		ensure
			get_hash_code_rout_id_positive: Result > 0
		end

	to_string_rout_id: INTEGER is
			-- Routine ID of `to_string' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.to_string_name_id).rout_id_set.first
		ensure
			to_string_rout_id_positive: Result > 0
		end

	out_feat_id: INTEGER is
			-- Feature ID of `out' of ANY.
		once
			Result := system.any_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.out_name_id).feature_id
		ensure
			out_feat_id_positive: Result > 0
		end

	to_cil_feat_id: INTEGER is
			-- Feature ID of `to_cil' of STRING.
		once
			Result := system.string_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.to_cil_name_id).feature_id
		ensure
			to_cil_feat_id_positive: Result > 0
		end

	hashable_class_id: INTEGER is
			-- Class ID of `HASHABLE' if present, `0' otherwise.
		local
			l_hash_classes: LIST [CLASS_I]
			l_hash_class: CLASS_I
		once
			l_hash_classes := universe.classes_with_name ("HASHABLE")
			if l_hash_classes.count = 1 then
				l_hash_class := l_hash_classes.first
				if l_hash_class.is_compiled then
					Result := l_hash_class.compiled_class.class_id
				end
			end
		ensure
			hashable_class_id_non_negative: Result >= 0
		end

	hashable_type: CL_TYPE_I is
			-- Type `HASHABLE', Void otherwise.
		once
			if hashable_class_id > 0 then
				create Result.make (hashable_class_id)
			end
		end

	hash_code_rout_id: INTEGER is
			-- Routine ID of `hash_code' from HASHABLE if found,
			-- otherwise `0'.
		local
			l_hash_class: CLASS_C
		once
			if hashable_class_id > 0 then
				l_hash_class := system.class_of_id (hashable_class_id)
				check
					has_feature_table: l_hash_class.has_feature_table
				end
				Result := l_hash_class.feature_table.
					item_id ({PREDEFINED_NAMES}.hash_code_name_id).rout_id_set.first
			end
		ensure
			hash_code_rout_id_non_negative: Result >= 0
		end

	hash_code_feat_id: INTEGER is
			-- Feature ID of `hash_code' from HASHABLE if found,
			-- otherwise `0'.
		local
			l_hash_class: CLASS_C
		once
			if hashable_class_id > 0 then
				l_hash_class := system.class_of_id (hashable_class_id)
				check
					has_feature_table: l_hash_class.has_feature_table
				end
				Result := l_hash_class.feature_table.
					item_id ({PREDEFINED_NAMES}.hash_code_name_id).feature_id
			end
		ensure
			hash_code_feat_id_non_negative: Result >= 0
		end

feature {CIL_CODE_GENERATOR, IL_MODULE, CUSTOM_ATTRIBUTE_GENERATOR} -- Custom attribute definition

	define_custom_attribute (token: INTEGER; ctor_token: INTEGER; data: MD_CUSTOM_ATTRIBUTE) is
			-- Define a custom attribute on `token' using constructor `ctor_token' with
			-- arguments `data'.
			-- Same as `md_emit.define_custom_attribute' but we do not care about return type.
		local
			l_ca_token: INTEGER
		do
			l_ca_token := md_emit.define_custom_attribute (token, ctor_token, data)
		end

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

feature -- Once per feature definition

	result_position: INTEGER
			-- Position of `Result' local variable.

feature -- Mapping between Eiffel compiler and generated tokens

	il_module_for_class (a_class: CLASS_C): IL_MODULE is
			-- Perform lookup for module associated with `a_class'. If not
			-- found then create a module used for reference only.
		require
			a_class_not_void: a_class /= Void
		local
			l_type_id: INTEGER
			l_output: FILE_NAME
			l_module_name: STRING
		do
			if is_single_module then
				l_type_id := 1
			else
				l_type_id := a_class.class_id // System.msil_classes_per_module + 1
			end
			Result := internal_il_modules.item (l_type_id)
			if Result = Void then
				create l_output.make_from_string (location_path)
				l_module_name := "module_" + l_type_id.out + ".dll"
				l_output.set_file_name (l_module_name)
				create Result.make (
					l_module_name,
					l_output,
					c_module_name,
					Void,
					Current,
					Void,
					l_type_id,
					is_debug_info_enabled,
					False)
				internal_il_modules.put (Result, l_type_id)
			end
		ensure
			module_not_void: Result /= Void
		end

	il_module (a_class_type: CLASS_TYPE): IL_MODULE is
			-- Perform lookup for module associated with `a_class_type'. If not
			-- found then create a module used for reference only.
		require
			a_class_type_not_void: a_class_type /= Void
		do
			Result := il_module_for_class (a_class_type.associated_class)
		ensure
			module_not_void: Result /= Void
		end

	internal_il_modules: ARRAY [IL_MODULE]
			-- Array of IL_MODULE indexed by CLASS_TYPE.packet_number

	external_class_mapping: HASH_TABLE [CL_TYPE_I, STRING]
			-- Quickly find a type given its external name.

	constructor_token (a_type_id: INTEGER): INTEGER is
			-- Token identifier for default constructor of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.constructor_token (a_type_id)
		ensure
			constructor_token_valid: Result /= 0
		end

	actual_class_type_token (a_type_id: INTEGER): INTEGER is
			-- Given `a_type_id' returns its associated metadata token.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.actual_class_type_token (a_type_id)
		ensure
			class_token_valid: Result /= 0
		end

	mapped_class_type_token (a_type_id: INTEGER): INTEGER is
			-- Given `a_type_id' returns its associated metadata token
			-- to be used in signatures and code generation token where
			-- ANY needs to be mapped into System.Object.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.mapped_class_type_token (a_type_id)
		ensure
			class_token_valid: Result /= 0
		end

	invariant_token (a_type_id: INTEGER): INTEGER is
			-- Metadata token of invariant feature in class type `a_type_id'.
		require
			type_id_valid: a_type_id > 0
		do
			Result := current_module.invariant_token (a_type_id)
		ensure
			invariant_token_valid: Result /= 0
		end

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
		do
			if internal_class_types = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					i := System.class_types.lower
					nb := System.class_types.upper
					create Result.make (0, System.Static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := System.class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
			Result := internal_class_types
		ensure
			class_types_not_void: class_types /= Void
			class_types_not_empty: class_types.count > 0
		end

	feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.feature_token (a_type_id, a_feature_id)
		ensure
			feature_token_valid: Result /= 0
		end

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token that sets it.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.setter_token (a_type_id, a_feature_id)
		ensure
			setter_token_valid: Result /= 0
		end

	signatures (a_type_id, a_feature_id: INTEGER): ARRAY [INTEGER] is
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_feats := signatures_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
			if Result = Void then
				define_feature_reference (a_type_id, a_feature_id, False, False, False)
				Result := signatures (a_type_id, a_feature_id)
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_signatures (a_type_id, a_feature_id: INTEGER): ARRAY [INTEGER] is
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_feats := implementation_signatures_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
				if Result = Void then
					define_feature_reference (a_type_id, a_feature_id, False, False, False)
					Result := implementation_signatures (a_type_id, a_feature_id)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.implementation_feature_token (a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.attribute_token (a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	file_token: HASH_TABLE [INTEGER, IL_MODULE]
			-- File token associated to `a_module' in `main_module'.

	table_token (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_type_id, a_feature_id: INTEGER): INTEGER
		is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			a_table_not_void: a_table /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [INTEGER, INTEGER]
		do
			l_feats := a_table.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
		end

	sequence_point: TUPLE [
			INTEGER,			-- Offset count
			ARRAY [INTEGER],	-- Offsets
			ARRAY [INTEGER],	-- Start lines
			ARRAY [INTEGER],	-- Start columns
			ARRAY [INTEGER],	-- End lines
			ARRAY [INTEGER],	-- End columns
			INTEGER]			-- Written in class ID
		is
			-- For type definition purpose.
		do
		end

	local_debug_info: TUPLE [INTEGER, INTEGER, INTEGER, like local_types] is
			-- For type definition purpose.
		do
		end

	dbg_documents (a_class_id: INTEGER): DBG_DOCUMENT_WRITER is
			-- Associated document to `a_class_id'.
		require
			in_debug_mode: is_debug_info_enabled
		do
			Result := current_module.dbg_documents (a_class_id)
		ensure
			dbg_documents_not_void: Result /= Void
		end

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

	implementation_signatures_table, signatures_table: ARRAY [HASH_TABLE [ARRAY [INTEGER], INTEGER]]
			-- Array of signatures indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are an array of type id representation signature of
			-- feature `feature_id' in `type_id'.

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_feature (a_token, a_type_id, a_feature_id)
		ensure
			inserted: feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_setter (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_setter (a_token, a_type_id, a_feature_id)
		ensure
			inserted: setter_token (a_type_id, a_feature_id) = a_token
		end

	insert_implementation_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_implementation_feature (a_token, a_type_id, a_feature_id)
		ensure
			inserted: implementation_feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_attribute (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_attribute (a_token, a_type_id, a_feature_id)
		ensure
			inserted: attribute_token (a_type_id, a_feature_id) = a_token
		end

	insert_in_table (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_token, a_type_id, a_feature_id: INTEGER)
		is
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			a_table_not_void: a_table /= Void
			token_valid: a_token /= 0
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
			not_inserted: a_table.item (a_type_id) /= Void implies
				not a_table.item (a_type_id).has (a_feature_id)
		local
			l_hash: HASH_TABLE [INTEGER, INTEGER]
		do
			l_hash := a_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				a_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_token, a_feature_id)
		ensure
			inserted: a_table.item (a_type_id).item (a_feature_id) = a_token
		end

	insert_implementation_signature (a_signature: ARRAY [INTEGER];
			a_type_id, a_feature_id: INTEGER)
		is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in
			-- `implementation_signatures_table'.
		require
			implementation_signatures_table_not_void: implementation_signatures_table /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_hash := implementation_signatures_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				implementation_signatures_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: implementation_signatures_table.item (a_type_id).item (a_feature_id).is_equal (a_signature)
		end

	insert_signature (a_signature: ARRAY [INTEGER]; a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `signatures_table'.
		require
			signatures_table_not_void: signatures_table /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [ARRAY [INTEGER], INTEGER]
		do
			l_hash := signatures_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				signatures_table.put (l_hash, a_type_id)
			end

			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: signatures_table.item (a_type_id).item (a_feature_id).is_equal (a_signature)
		end

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
			check
				not_callable: False
			end
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
