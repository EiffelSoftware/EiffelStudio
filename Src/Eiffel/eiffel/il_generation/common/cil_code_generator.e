note
	description: "Generation of IL code using a bridge pattern."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CIL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR
		rename
			generate_last_exception as generate_get_last_exception
		end

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

	SHARED_TYPES
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

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

	CLI_EMITTER_SERVICE
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
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

feature -- Status report

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information?

	is_implementation_generated: BOOLEAN
			-- Is implementation of a class type being generated rather than interface?
		require
			not_current_class_type_is_single: not current_class_type.is_generated_as_single_type
		do
			Result := current_class_type.implementation_id = current_type_id
		ensure
			definition: Result = (current_class_type.implementation_id = current_type_id)
		end

feature {IL_MODULE} -- Access

	is_single_inheritance_implementation: BOOLEAN
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

	is_single_class: BOOLEAN
			-- Can current class only be single inherited?

	internal_finalize_rout_id: INTEGER
			-- Routine ID of `finalize' from ANY

	standard_twin_body_index: INTEGER
			-- Body index of `standard_twin' from ANY

	output_file_name: READABLE_STRING_32
			-- File where assembly is stored.

	md_dispenser: MD_DISPENSER
			-- Access to MetaData generator.

	md_emit: MD_EMIT
			-- Metadata emitter.
		do
			Result := current_module.md_emit
		ensure
			md_emit_not_void: Result /= Void
		end

	method_writer: MD_METHOD_WRITER
			-- To store method bodys.
		do
			Result := current_module.method_writer
		ensure
			method_writer_not_void: Result /= Void
		end

	type_count: INTEGER
			-- Number of generated types in Current system.
		do
			Result := (create {SHARED_COUNTER}).static_type_id_counter.count + 10
		ensure
			type_count_positive: type_count >= 0
		end

	done_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `done_token' so that we do not have
			-- to compute it too often

	exception_sig: MD_FIELD_SIGNATURE
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

	boolean_native_signature: MD_NATIVE_TYPE_SIGNATURE
			-- Marshaller signature for converting IL boolean to Eiffel C boolean
		once
			create Result.make
			Result.set_native_type ({MD_SIGNATURE_CONSTANTS}.native_type_i1)
		end

	local_types: ARRAYED_LIST [PAIR [TYPE_A, STRING]]
			-- To store types of local variables.

	uni_string: CLI_STRING
			-- Buffer for all Unicode string conversion.

	is_console_application: BOOLEAN
			-- Is current a console application?

	is_dll: BOOLEAN
			-- Is current generated as a DLL?

	is_32bits: BOOLEAN
			-- Is current generated as a 32bit application?

	is_verifiable: BOOLEAN
			-- Does code generation has to be verifiable?

	is_cls_compliant: BOOLEAN
			-- Does code generation generate CLS compliant code?

	assembly_name: STRING
			-- Name of current assembly.

	c_module_name: STRING
			-- Name of C generated module containing all C externals.

	location_path: PATH
			-- Path where assemblies are being generated.

	current_feature_token: INTEGER
			-- Token of feature being generated in `generate_feature_code'.

	once_generation: BOOLEAN
			-- Are we currently generating a once feature?

	object_relative_once_generation: BOOLEAN
			-- Are we currently generating a once per object feature?

feature {NONE} -- Debug info

	dbg_writer: DBG_WRITER
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

	set_runtime_type_id (an_id: like runtime_type_id)
			-- Set `an_id' to `runtime_type_id'.
		require
			valid_id: an_id > 0
		do
			runtime_type_id := an_id
		ensure
			runtime_type_id_set: runtime_type_id = an_id
		end

	set_class_type_id (an_id: like class_type_id)
			-- Set `an_id' to `class_type_id'.
		require
			valid_id: an_id > 0
		do
			class_type_id := an_id
		ensure
			class_type_id_set: class_type_id = an_id
		end

	set_generic_type_id (an_id: like generic_type_id)
			-- Set `an_id' to `generic_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_type_id := an_id
		ensure
			generic_type_id_set: generic_type_id = an_id
		end

	set_tuple_type_id (an_id: like tuple_type_id)
			-- Set `an_id' to `tuple_type_id'.
		require
			valid_id: an_id > 0
		do
			tuple_type_id := an_id
		ensure
			tuple_type_id_set: tuple_type_id = an_id
		end

	set_formal_type_id (an_id: like formal_type_id)
			-- Set `an_id' to `formal_type_id'.
		require
			valid_id: an_id > 0
		do
			formal_type_id := an_id
		ensure
			formal_type_id_set: formal_type_id = an_id
		end

	set_none_type_id (an_id: like none_type_id)
			-- Set `an_id' to `none_type_id'.
		require
			valid_id: an_id > 0
		do
			none_type_id := an_id
		ensure
			none_type_id_set: none_type_id = an_id
		end

	set_eiffel_type_info_type_id (an_id: like eiffel_type_info_type_id)
			-- Set `an_id' to `eiffel_type_info_type_id'.
		require
			valid_id: an_id > 0
		do
			eiffel_type_info_type_id := an_id
		ensure
			eiffel_type_info_type_id_set: eiffel_type_info_type_id = an_id
		end

	set_basic_type_id (an_id: like basic_type_id)
			-- Set `an_id' to `basic_type_id'.
		require
			valid_id: an_id > 0
		do
			basic_type_id := an_id
		ensure
			basic_type_id_set: basic_type_id = an_id
		end

	set_generic_conformance_type_id (an_id: like generic_conformance_type_id)
			-- Set `an_id' to `generic_conformance_type_id'.
		require
			valid_id: an_id > 0
		do
			generic_conformance_type_id := an_id
		ensure
			generic_conformance_type_id_set: generic_conformance_type_id = an_id
		end

	set_assertion_level_enum_type_id (an_id: like assertion_level_enum_type_id)
			-- Set `an_id' to `assertion_level_enum_type_id'.
		require
			valid_id: an_id > 0
		do
			assertion_level_enum_type_id := an_id
		ensure
			assertion_level_enum_type_id_set: assertion_level_enum_type_id = an_id
		end

	set_once_generation (v: BOOLEAN)
			-- Set `once_generation' to `v'.
		do
			once_generation := v
		ensure
			once_generation_set: once_generation = v
		end

	set_object_relative_once_generation (v: BOOLEAN)
			-- Set `object_relative_once_generation' to `v'.
		do
			object_relative_once_generation := v
		ensure
			object_relative_once_generation_set: object_relative_once_generation = v
		end

	set_current_module_for_class (class_c: CLASS_C)
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

	set_current_module_with (a_class_type: CLASS_TYPE)
			-- Update `current_module' so that it refers to module in which
			-- `a_class_type' is generated.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_old_module: like current_module
		do
			l_old_module := current_module
			current_module := il_module (a_class_type)
				-- Refine so that only classes being generated in current compilation
				-- unit needs the module to be generated as well.
			debug ("il_emitter")
				if attached current_module as m then
					if l_old_module = Void or else l_old_module /= m then
						print (generator + ".set_current_module_with (...) -> switched to "+ m.module_name_with_extension +"%N")
					end
				end
			end
			if a_class_type.is_generated and then not current_module.is_generated then
				current_module.prepare (md_dispenser, type_count)
			end
		ensure
			current_module_set: current_module /= Void
			associated_current_module: current_module = il_module (a_class_type)
		end

feature -- Cleanup

	clean_debug_information (a_class_type: CLASS_TYPE)
			-- Clean recorded debug information.
		do
			Il_debug_info_recorder.clean_class_type_info_for (a_class_type)
		end

	cleanup
			-- Clean up all data structures that were used for this code generation.
		local
			retried: BOOLEAN
		do
			if not retried then
					--| End recording session, (then Save IL Information used for eStudio .NET debugger)
				Il_debug_info_recorder.end_recording_session
					--| Clean up data
				if internal_il_modules /= Void then
					across
						internal_il_modules as m
					loop
						if attached m.item as module then
							module.cleanup
						end
					end
						-- Now all underlying COM objects should have been unreferenced, so we
						-- can safely collect them. We really have to collect them now because
						-- some cannot wait. For example if you still have an instance of
						-- DBG_DOCUMENT_WRITER of an Eiffel source file, it will refuse to create
						-- a new instance if you haven't freed the first one.
					;(create {MEMORY}).full_collect
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Generation Structure

	start_assembly_generation (
			a_assembly_name: STRING; a_file_name: READABLE_STRING_GENERAL;
			a_public_key: like public_key;
			location: PATH;
			assembly_info: ASSEMBLY_INFO;
			debug_mode: BOOLEAN)

			-- Create Assembly with `name'.
		require
			a_assembly_name_not_void: a_assembly_name /= Void
			a_assembly_name_not_empty: not a_assembly_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			location_not_void: location /= Void
			location_not_empty: not location.is_empty
		do
				-- For netcore, use multi-assemblies instead of multi-modules.
			is_using_multi_assemblies := system.is_il_netcore

				--| Initialize recording of IL Information used for eStudio .NET debugger			
			Il_debug_info_recorder.start_recording_session (debug_mode)

				--| beginning of assembly generation
			location_path := location
			assembly_name := a_assembly_name

				-- Set CLR host to proper version if not yet done.
			setup_cil_code_generation (System.clr_runtime_version)

				-- Create Unicode string buffer.
			create uni_string.make_empty (1024)

				-- Name of `dll' containing all C externals.
			create c_module_name.make_from_string ("lib" + a_assembly_name + ".dll")

			md_dispenser := md_factory.dispenser

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

			is_debug_info_enabled := debug_mode
			-- FIXME jfiat [2003/10/10 - 16:41] try without debug_mode, for no pdb info

			output_file_name := location.extended (a_file_name).name

			create main_module.make (
				a_assembly_name,
				output_file_name,
				c_module_name,
				a_public_key,
				Current,
				assembly_info,
				1,
				is_debug_info_enabled,
				True, is_using_multi_assemblies -- Main assembly
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
			if is_32bits then
				main_module.set_32bits
			end

			main_module.prepare (md_dispenser, type_count)

			is_single_module := System.in_final_mode or else Compilation_modes.is_precompiling
			if is_single_module then
				internal_il_modules.put (main_module, 1)
			end
		ensure
			assembly_name_set: assembly_name = a_assembly_name
		end

	start_module_generation (a_module_id: INTEGER)
			-- Start generation of `a_module_id'.
		do
			current_module := internal_il_modules.item (a_module_id)
		end

	define_entry_point
			(creation_type: CLASS_TYPE; a_class_type: CLASS_TYPE; a_feature_id: INTEGER;
			a_has_arguments: BOOLEAN)

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

	generate_runtime_helper
			-- Generate a class for run-time needs.
		local
			l_cur_mod: like current_module
			helper_emit: MD_EMIT
			oms_field_cil_token: INTEGER
			oms_field_eiffel_token,
			oms_32_field_eiffel_token,
			omis_8_field_eiffel_token,
			omis_32_field_eiffel_token: INTEGER
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
				oms_field_cil_token := current_module.once_string_field_token (string_type_cil)
				oms_field_eiffel_token := current_module.once_string_field_token (string_type_string)
				oms_32_field_eiffel_token := current_module.once_string_field_token (string_type_string_32)
				omis_8_field_eiffel_token := current_module.once_string_field_token (string_type_immutable_string_8)
				omis_32_field_eiffel_token := current_module.once_string_field_token (string_type_immutable_string_32)

					-- Generate allocation routine.

					-- Check if fields were initialized.
				start_new_body (current_module.once_string_allocation_routine_token)
				local_sig.reset
				local_sig.set_local_count (1)
				local_sig.add_local_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
				method_body.set_local_token (helper_emit.define_signature (local_sig))
				check_body_index_range_label := create_label
				allocate_for_body_index_label := create_label
				array_type_token := helper_emit.define_type_ref (create {CLI_STRING}.make ("System.Array"), current_module.mscorlib_token)
				method_sig.reset
				method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
				method_sig.set_parameter_count (3)
				method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, array_type_token)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, array_type_token)
				method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
				array_copy_method_token := helper_emit.define_member_ref (create {CLI_STRING}.make ("Copy"), array_type_token, method_sig)

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
					-- Create "STRING_32[][]" and assign it to "oms32_eiffel".
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (string_32_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_32_field_eiffel_token)
					-- Create "IMMUTABLE_STRING_8[][]" and assign it to "omis8_eiffel".
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (immutable_string_8_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, omis_8_field_eiffel_token)
					-- Create "IMMUTABLE_STRING_32[][]" and assign it to "omis32_eiffel".
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (immutable_string_32_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, omis_32_field_eiffel_token)
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
				method_body.put_static_call (array_copy_method_token, 3, False)
					-- Reallocate "STRING[][]".
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (string_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldloc_0)
				method_body.put_static_call (array_copy_method_token, 3, False)
					-- Reallocate "STRING_32[][]".
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (string_32_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, oms_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldloc_0)
				method_body.put_static_call (array_copy_method_token, 3, False)
					-- Reallocate "IMMUTABLE_STRING_32[][]".
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, omis_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				put_integer_32_constant (1)
				method_body.put_opcode ({MD_OPCODES}.add)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class, current_module.actual_class_type_token (immutable_string_32_type_id))
				oms_array_type_eiffel_token := helper_emit.define_type_spec (type_sig)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, oms_array_type_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.dup)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, omis_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldloc_0)
				method_body.put_static_call (array_copy_method_token, 3, False)
					-- Leave "string[][]" on stack top.
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_cil_token)

				mark_label (allocate_for_body_index_label)
					-- Create array(s) indexed by manifest string number.
					-- oms_cil
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				type_sig.reset
				type_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, helper_emit.define_type_spec (type_sig))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- oms_eiffel
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, current_module.actual_class_type_token (string_type_id))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- oms32_eiffel
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, oms_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, current_module.actual_class_type_token (string_32_type_id))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- omis8_eiffel
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, omis_8_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, current_module.actual_class_type_token (immutable_string_8_type_id))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- omis32_eiffel
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, omis_32_field_eiffel_token)
				method_body.put_opcode ({MD_OPCODES}.ldarg_0)
				method_body.put_opcode ({MD_OPCODES}.ldarg_1)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.newarr, current_module.actual_class_type_token (immutable_string_32_type_id))
				method_body.put_opcode ({MD_OPCODES}.stelem_ref)
					-- Done.
				generate_return (False)
				method_writer.write_current_body

				current_module := l_cur_mod
			end
		end

	end_assembly_generation (a_signing: MD_STRONG_NAME)
			-- Finish creation of current assembly.
		require
			a_signing_exists: a_signing /= Void and then a_signing.exists
		local
			l_types: like class_types
			l_type: CLASS_TYPE
			l_class: CLASS_C
			i, nb: INTEGER
			l_uni_string: CLI_STRING
			l_module: IL_MODULE
			l_file_token: INTEGER
			l_assembly_ref_token: INTEGER
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
						l_class := l_type.associated_class
						if l_type.is_generated and then not l_class.is_typed_pointer then
							l_module := il_module (l_type)

							if is_using_multi_assemblies then
								l_assembly_ref_token := main_module.module_reference_token (l_module)

								l_uni_string.set_string (l_type.full_il_type_name)
								md_emit.define_exported_type (l_uni_string, l_assembly_ref_token,
									l_type.last_type_token, {MD_TYPE_ATTRIBUTES}.Public).do_nothing

								if l_type.implementation_id /= l_type.static_type_id then
									l_uni_string.set_string (l_type.full_il_implementation_type_name)
									md_emit.define_exported_type (l_uni_string, l_assembly_ref_token,
										l_type.last_implementation_type_token,
										{MD_TYPE_ATTRIBUTES}.Public).do_nothing
								end

								if
									not l_class.is_deferred and
									(attached l_class.creators as cs implies not cs.is_empty)
								then
									l_uni_string.set_string (l_type.full_il_create_type_name)
									md_emit.define_exported_type (l_uni_string, l_assembly_ref_token,
										l_type.last_create_type_token, {MD_TYPE_ATTRIBUTES}.Public).do_nothing
								end

							else
								file_token.search (l_module)
								if file_token.found then
									l_file_token := file_token.found_item
								else
									l_file_token := define_file (main_module,
										l_module.module_file_name, l_module.module_name_with_extension,
										{MD_FILE_FLAGS}.Has_meta_data, a_signing)
									file_token.put (l_file_token, l_module)
								end

								l_uni_string.set_string (l_type.full_il_type_name)
								md_emit.define_exported_type (l_uni_string, l_file_token,
									l_type.last_type_token, {MD_TYPE_ATTRIBUTES}.Public).do_nothing

								if l_type.implementation_id /= l_type.static_type_id then
									l_uni_string.set_string (l_type.full_il_implementation_type_name)
									md_emit.define_exported_type (l_uni_string, l_file_token,
										l_type.last_implementation_type_token,
										{MD_TYPE_ATTRIBUTES}.Public).do_nothing
								end

								if
									not l_class.is_deferred and
									(attached l_class.creators as cs implies not cs.is_empty)
								then
									l_uni_string.set_string (l_type.full_il_create_type_name)
									md_emit.define_exported_type (l_uni_string, l_file_token,
										l_type.last_create_type_token, {MD_TYPE_ATTRIBUTES}.Public).do_nothing
								end
							end
						end
					end
					i := i + 1
				end
			elseif system.keep_assertions then
				from
					l_types := System.class_types
					i := l_types.lower
					nb := l_types.upper
				until
					i > nb
				loop
					l_type := l_types.item (i)
					if attached l_type and then not l_type.is_external then
						define_assertion_level (l_type)
					end
					i := i + 1
				end
			end

			define_assembly_attributes

			main_module.save_to_disk (a_signing)

			--| End recording session, (then Save IL Information used for eStudio .NET debugger)
			-- The real end of recording is done in `cleanup'
		end

	generate_resources (a_resources: LIST [CONF_EXTERNAL_RESOURCE])
			-- Generate all resources in assembly.
		require
			a_resources_not_void: a_resources /= Void
		do
			(create {IL_RESOURCE_GENERATOR}.make (main_module, a_resources)).generate
		end

	define_file (a_module: IL_MODULE; a_file: READABLE_STRING_GENERAL; a_name: STRING; file_flags: INTEGER; a_signing: detachable MD_STRONG_NAME): INTEGER
			-- Add `a_file' of name `a_name' in list of files referenced by `a_module'.
		require
			a_module_not_void: a_module /= Void
			a_file_not_void: a_file /= Void
			a_name_not_void: a_name /= Void
			a_file_valid: a_file.has_substring (a_name) and
				a_name.same_string_general (
					a_file.substring (a_file.count - a_name.count + 1, a_file.count))
			file_flags_valid:
				(file_flags = {MD_FILE_FLAGS}.Has_meta_data) or
				(file_flags = {MD_FILE_FLAGS}.Has_no_meta_data)
			a_signing_exists: a_signing /= Void and then a_signing.exists
		local
			l_uni_string: CLI_STRING
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

	define_assertion_level (class_type: CLASS_TYPE)
			-- Define assertion level for `class_type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_assert_ca: MD_CUSTOM_ATTRIBUTE
			l_type_name: STRING_32
		do
			check
				main_module_not_void: main_module /= Void
			end
			create l_assert_ca.make
			if class_type.implementation_id = class_type.static_type_id then
				create l_type_name.make_from_string_general (escape_type_name (class_type.full_il_type_name))
			else
				create l_type_name.make_from_string_general (escape_type_name (class_type.full_il_implementation_type_name))
			end
			if class_type.is_precompiled then
				l_type_name.append_string_general (", ")
				l_type_name.append (class_type.assembly_info.full_name)
			end
			l_assert_ca.put_string (l_type_name)
			l_assert_ca.put_integer_32 (class_type.associated_class.assertion_level.level)
			l_assert_ca.put_integer_16 (0)
			define_custom_attribute (main_module.associated_assembly_token,
				main_module.ise_assertion_level_attr_ctor_token, l_assert_ca)
		end

	define_interface_type (class_type: CLASS_TYPE; parent_token: INTEGER)
			-- Define creation type for `class_type' in module generated for `class_type'.
			-- Needed for creating proper type in a formal generic creation.
		require
			class_type_not_void: class_type /= Void
		local
			l_assert_ca: MD_CUSTOM_ATTRIBUTE
			l_type_name: STRING_32
		do
			create l_assert_ca.make
			create l_type_name.make_from_string_general (escape_type_name (class_type.full_il_type_name))
			if class_type.is_precompiled then
				l_type_name.append_string_general (", ")
				l_type_name.append (class_type.assembly_info.full_name)
			end
			l_assert_ca.put_string (l_type_name)
			l_assert_ca.put_integer_16 (0)
			define_custom_attribute (parent_token,
				current_module.ise_interface_type_attr_ctor_token, l_assert_ca)
		end

	end_module_generation (has_root_type: BOOLEAN; a_signing: detachable MD_STRONG_NAME)
			-- Finish creation of current module.
		require
			a_signing_exists: a_signing /= Void and then a_signing.exists
		local
			a_class: CLASS_C
			root_feat: FEATURE_I
			l_decl_type: CL_TYPE_A
			entry_point_token: INTEGER
		do
			if
				not is_single_module and then
				(current_module /= Void and then current_module.is_generated)
			then
					-- Mark now entry point for debug information
				if
					is_debug_info_enabled and then
					has_root_type and then not
					system.root_creation_name.is_empty
				then
					a_class := system.root_type.base_class
					root_feat := a_class.feature_table.item (system.root_creation_name)
					l_decl_type := system.root_class_type (system.root_type).type.implemented_type (root_feat.origin_class_id)

					entry_point_token := current_module.implementation_feature_token (
						l_decl_type.associated_class_type (system.root_class_type (system.root_type).type).implementation_id,
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

	set_console_application
			-- Current generated application is a CONSOLE application.
		do
			is_console_application := True
			is_dll := False
		end

	set_window_application
			-- Current generated application is a WINDOW application.
		do
			is_console_application := False
			is_dll := False
		end

	set_dll
			-- Current generated application is a DLL.
		do
			is_dll := True
			is_console_application := True
		end

	set_32bits
			-- Current generated application is a 32bit application
		do
			is_32bits := True
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER)
			-- Assign current generated assembly with given version details.
		do
			check
				not_yet_implemented: False
			end
		end

	set_verifiability (verifiable: BOOLEAN)
			-- Mark current generation to generate verifiable code.
		do
			is_verifiable := verifiable
		ensure then
			is_verifiable_set: is_verifiable = verifiable
		end

	set_cls_compliant (cls_compliant: BOOLEAN)
			-- Mark current generation to generate cls_compliant code.
		do
			is_cls_compliant := cls_compliant
		ensure then
			is_cls_compliant_set: is_cls_compliant = cls_compliant
		end

feature -- Class info

	initialize_class_mappings (class_count: INTEGER)
			-- Initialize structures that holds some system data during code generation.
		do
			create internal_il_modules.make_filled (Void, 0, class_count)
			create file_token.make (10)
			create external_class_mapping.make (class_count)

				-- Predefined .NET basic types.
			external_class_mapping.put (create {BOOLEAN_A}, "System.Boolean")
			external_class_mapping.put (create {CHARACTER_A}.make (False), "System.Char")
			external_class_mapping.put (create {NATURAL_A}.make (8), "System.Byte")
			external_class_mapping.put (create {NATURAL_A}.make (16), "System.UInt16")
			external_class_mapping.put (create {NATURAL_A}.make (32), "System.UInt32")
			external_class_mapping.put (create {NATURAL_A}.make (64), "System.UInt64")
			external_class_mapping.put (create {INTEGER_A}.make (8), "System.SByte")
			external_class_mapping.put (create {INTEGER_A}.make (16), "System.Int16")
			external_class_mapping.put (create {INTEGER_A}.make (32), "System.Int32")
			external_class_mapping.put (create {INTEGER_A}.make (64), "System.Int64")
			external_class_mapping.put (create {REAL_A}.make (32), "System.Single")
			external_class_mapping.put (create {REAL_A}.make (64), "System.Double")
			external_class_mapping.put (create {POINTER_A}, "System.IntPtr")

				-- Debug data structure.
			internal_class_types := Void
		end

	generate_class_mappings (class_type: CLASS_TYPE; for_interface: BOOLEAN)
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

	generate_class_interfaces (class_type: CLASS_TYPE; class_c: CLASS_C)
			-- Initialize `class_interface' from `class_type' with info from `class_c'.
		require
			class_type_not_void: class_type /= Void
			class_c_not_void: class_c /= Void
		local
			pars: ARRAYED_LIST [CLASS_INTERFACE]
			class_interface: CLASS_INTERFACE
			parents: FIXED_LIST [CL_TYPE_A]
		do
			if attached {NATIVE_ARRAY_CLASS_TYPE} class_type as l_native_array then
				external_class_mapping.put (class_type.type, l_native_array.il_type_name)
			elseif
				class_type.is_external and then
				not (class_c.is_basic and then class_c.is_typed_pointer)
			then
					-- We do not process TYPED_POINTER as it is not a real class type in .NET so
					-- TYPED_POINTER doesn't really have a `full_il_type_name'.
				external_class_mapping.put (class_type.type, class_type.full_il_type_name)
			end

			parents := class_c.parents
			create class_interface.make_from_context (class_c.class_interface, class_type)
			create pars.make (parents.count)

			across
				parents as p
			loop
				pars.force (p.item.associated_class_type (class_type.type).class_interface)
			end

			class_interface.set_parents (pars)
			class_type.set_class_interface (class_interface)
		end

	generate_class_attributes (class_type: CLASS_TYPE)
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

	define_assembly_attributes
			-- Define custom attributes for current assembly.
		local
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_class: CLASS_C
			l_attributes: BYTE_LIST [BYTE_NODE]
			l_cur_mod: like current_module
		do
			if System.root_type /= Void and then System.root_type.base_class.original_class.is_compiled then
				l_cur_mod := current_module
				current_module := main_module
				current_class_type := System.root_class_type (system.root_type)
				l_class := current_class_type.associated_class
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
			define_custom_attribute (main_module.associated_assembly_token, main_module.ise_eiffel_consumable_attr_ctor_token, eiffel_non_consumable_ca)
		end

	define_constructors (class_type: CLASS_TYPE; is_reference: BOOLEAN)
			-- Define constructors for implementation of `class_type'
		require
			class_type_not_void: class_type /= Void
		do
			current_module.define_constructors (class_type, is_reference)
		end

	define_runtime_features (class_type: CLASS_TYPE)
			-- Define all features needed by ISE .NET runtime. It generates
			-- `____class_name', `$$____type', `____type',
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
			l_ca: MD_CUSTOM_ATTRIBUTE
			l_class_name: STRING_32
			l_meth_attr: INTEGER
			i, nb: INTEGER
			l_type: TYPE_A
			l_class_type: CLASS_TYPE
			l_ext_class: EXTERNAL_CLASS_C
			l_feature: FEATURE_I
		do
			l_class_token := actual_class_type_token (class_type.implementation_id)
			create l_class_name.make_from_string_general (class_type.associated_class.name_in_upper)

			create l_ca.make
			l_ca.put_string (l_class_name)

			if attached {GEN_TYPE_A} class_type.type as l_gen_type then
				from
					l_ca.put_integer_32 (l_gen_type.generics.count)
					i := l_gen_type.generics.lower
					nb := l_gen_type.generics.upper
				until
					i > nb
				loop
					l_ext_class := Void
					l_type := l_gen_type.generics.i_th (i)
					if l_type.is_formal then
							-- It is a formal, simply put ANY here
						l_class_type := any_type.associated_class_type (Void)
					elseif attached {CL_TYPE_A} l_type as l_cl_type then
							-- It is an expanded generic derivation
						l_class_type := l_cl_type.associated_class_type (class_type.type)
						if l_cl_type.is_external then
							l_ext_class := {EXTERNAL_CLASS_C} / l_cl_type.base_class
						end
					end
					if l_class_type.is_basic and then l_class_type.type.generics = Void then
							-- Use built-in type.
						l_class_name := l_class_type.associated_class.external_class_name.twin
					else
						l_class_name := escape_type_name (l_class_type.full_il_type_name)
					end
					if l_ext_class = Void then
							-- Case of an Eiffel class
						if
							l_class_type.is_precompiled and then
							not l_class_type.associated_class.is_external
						then
							check
								has_assembly_info: l_class_type.assembly_info /= Void
							end
							l_class_name.append_string_general (", ")
							l_class_name.append (l_class_type.assembly_info.full_name)
						end
					else
							-- External class, add assembly full name only when it is
							-- not `mscorlib'.
						if not l_ext_class.assembly.assembly_name.same_string_general ("mscorlib") then
							l_class_name.append_string_general (", ")
							l_class_name.append (l_ext_class.assembly.full_name)
						end
					end
					l_ca.put_string (l_class_name)
					i := i + 1
				end
				l_ca.put_integer_16 (0)
				define_custom_attribute (l_class_token,
					current_module.ise_eiffel_name_attr_generic_ctor_token, l_ca)
			else
				l_ca.put_integer_16 (0)
				define_custom_attribute (l_class_token,
					current_module.ise_eiffel_name_attr_ctor_token, l_ca)
			end

			if attached class_type.associated_class.storable_version as l_version and then not l_version.is_empty then
				create l_ca.make
				l_ca.put_string (l_version)
				define_custom_attribute (l_class_token, current_module.ise_eiffel_version_attr_ctor_token, l_ca)
			end
			if not class_type.type.has_no_mark then
				create l_ca.make
				l_ca.put_integer_32 (class_type.type.declaration_mark)
				l_ca.put_integer_16 (0)
				define_custom_attribute (l_class_token,
					current_module.ise_eiffel_class_type_mark_attr_ctor_token, l_ca)
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
			store_locals (l_meth_token, class_type)
			method_writer.write_current_body

			if
				(is_single_inheritance_implementation and (class_type.static_type_id = any_type_id)) or
				(not is_single_inheritance_implementation and (not is_single_class or else (current_class.has_external_main_parent or class_type.is_expanded)))
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
					generate_load_from_address_as_object (class_type.type)
					generate_metamorphose (class_type.type)
					generate_return (True)
				end
				store_locals (l_meth_token, class_type)
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
					l_type := argument_actual_type_in (l_feature.arguments.first, current_class_type)
					if l_type.is_basic then
							-- Unbox a value object.
						generate_load_address (l_type)
						generate_load_from_address_as_basic (l_type)
					elseif l_type.is_expanded then
							-- Unbox a value object.
						generate_unmetamorphose (l_type)
					end
					internal_generate_feature_access (class_type.implementation_id,
						l_feature.feature_id, 1, False, False)
				else
					internal_generate_feature_access (any_type_id, copy_feat_id, 1, False, True)
				end
				generate_return (False)
				store_locals (l_meth_token, class_type)
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
					l_type := argument_actual_type_in (l_feature.arguments.first, current_class_type)
					if l_type.is_basic then
							-- Unbox a value object.
						generate_load_address (l_type)
						generate_load_from_address_as_basic (l_type)
					elseif l_type.is_expanded then
							-- Unbox a value object.
						generate_unmetamorphose (l_type)
					end
					internal_generate_feature_access (class_type.implementation_id,
						l_feature.feature_id, 1, True, False)
				else
					internal_generate_feature_access (any_type_id, is_equal_feat_id, 1, True, True)
				end
				generate_return (True)
				store_locals (l_meth_token, class_type)
				method_writer.write_current_body
			end
		end

	define_system_object_features (class_type: CLASS_TYPE)
			-- Define all features of SYSTEM_OBJECT on Eiffel types so that
			-- they have a meaning. It includes:
			-- to_string, finalize, equals, get_hash_code
		require
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			l_select_tbl: SELECT_TABLE
			l_feat: FEATURE_I
			l_class_id: INTEGER
		do
				-- To generate those routines, we first check if they are
				-- redefined in the current class. If they are, we keep the
				-- definition given by the user, otherwise we put the Eiffel one.
				-- We only do the later if the .NET one was not frozen to begin with.

				-- Gets current feature table.
			l_select_tbl := class_type.associated_class.feature_table.select_table
			l_class_id := class_type.associated_class.class_id

				-- Process `equals'
			if l_select_tbl.has_key (equals_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id and not l_feat.is_frozen then
					define_equals_routine (class_type)
				end
			else
				define_equals_routine (class_type)
			end

				-- Process `finalize'
			if l_select_tbl.has_key (finalize_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id and not l_feat.is_frozen then
					define_finalize_routine (class_type)
				end
			else
				define_finalize_routine (class_type)
			end

				-- Process `get_hash_code'
			if l_select_tbl.has_key (get_hash_code_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id and not l_feat.is_frozen then
					define_get_hash_code_routine (class_type)
				end
			else
				define_get_hash_code_routine (class_type)
			end

				-- Process `to_string'
			if l_select_tbl.has_key (to_string_rout_id) then
				l_feat := l_select_tbl.found_item
				if l_feat.written_in /= l_class_id and not l_feat.is_frozen then
					define_to_string_routine (class_type)
				end
			else
				define_to_string_routine (class_type)
			end
		end

feature {NONE} -- SYSTEM_OBJECT features

	define_equals_routine (class_type: CLASS_TYPE)
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
			type_i: TYPE_A
			arg_type: TYPE_A
		do
			class_c := system.any_class.compiled_class
			feature_i := class_c.feature_table.item_id ({PREDEFINED_NAMES}.is_equal_name_id)
			if feature_i /= Void then
					-- Provide implementation matching definition of feature "is_equal" from class ANY
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
					type_i := class_c.actual_type
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

				arg_type := argument_actual_type_in (feature_i.arguments.first, class_type)
				if arg_type.is_basic then
					generate_external_unmetamorphose (arg_type)
				elseif arg_type.is_expanded then
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

	define_finalize_routine (class_type: CLASS_TYPE)
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
				start_new_body (l_meth_token)
				cil_node_generator.generate_il_node (Current, l_feat.access (void_type, False, False))
				generate_return (False)
				method_writer.write_current_body
			end
		end

	define_get_hash_code_routine (class_type: CLASS_TYPE)
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
			type_i: TYPE_A
		do
			l_hashable_class_id := hashable_class_id
			if
				l_hashable_class_id > 0 and then
				class_type.associated_class.feature_table.select_table.has (hash_code_rout_id)
			then
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
					type_i := class_c.actual_type
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

	define_to_string_routine (class_type: CLASS_TYPE)
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
			type_i: TYPE_A
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
					type_i := class_c.actual_type
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
				internal_generate_feature_access (to_cil_feat.static_type_id, to_cil_feat.feature_id, 0, True, True)

				generate_return (True)
				method_writer.write_current_body
			end
		end

feature {NONE} -- Class info

	generate_class_features (class_c: CLASS_C; class_type: CLASS_TYPE)
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

	clean_implementation_class_data
			-- Clean current class implementation data.
		require
			current_type_id_set: current_type_id > 0
		do
			current_module.clean_implementation_class_data (current_type_id)
		end

feature -- Features info

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE)
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			type_feature_processor: PROCEDURE [TYPE_FEATURE_I]
		do
			set_current_class_type (class_type)
			set_current_type_id (class_type.static_type_id)
			inst_context.set_group (class_c.group)
			is_single_class := class_type.is_generated_as_single_type
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
				type_feature_processor,
				agent generate_feature (?, False, True, False))
		end

	generate_local_feature_description (local_feature: FEATURE_I; inherited_feature: FEATURE_I; class_type: CLASS_TYPE; is_replicated: BOOLEAN)
			-- Define local feature `local_feature' with a possible precursor feature `inherited_feature' from `class_type'.
		require
			local_feature_not_void: local_feature /= Void
			class_type_not_void: class_type /= Void
		do
			generate_inherited_feature_description (local_feature, inherited_feature, class_type)
		end

	generate_inherited_feature_description (local_feature: FEATURE_I; inherited_feature: FEATURE_I; class_type: CLASS_TYPE)
			-- Define local feature `local_feature' with a possible precursor feature `inherited_feature' from `class_type'.
		require
			local_feature_not_void: local_feature /= Void
			class_type_not_void: class_type /= Void
		local
			duplicated_feature: FEATURE_I
		do
			if inherited_feature /= Void then
				if
					is_method_impl_needed (local_feature, inherited_feature, class_type) or else
					is_local_signature_changed (inherited_feature, local_feature)
				then
					generate_feature (local_feature, False, False, False)
				else
						-- Generate local definition signature using the parent
						-- signature. We do not do it on the parent itself because
						-- its `feature_id' is not appropriate in `current_class_type'.
					duplicated_feature := local_feature.duplicate
					if duplicated_feature.is_routine and then attached {PROCEDURE_I} duplicated_feature as proc then
						proc.set_arguments (inherited_feature.arguments)
					end
					duplicated_feature.set_type (inherited_feature.type, inherited_feature.assigner_name_id)
					duplicated_feature.set_rout_id_set (inherited_feature.rout_id_set)
					implementation_generate_feature (duplicated_feature, False, False, False, False, False, class_type)
				end
			elseif not is_single_class then
				generate_feature (local_feature, False, False, False)
			end
			if current_class_type.is_expanded and then local_feature.is_attribute then
				generate_feature (local_feature, False, True, False)
			end
		end

	generate_type_feature_description (type_feature: TYPE_FEATURE_I)
			-- Define type feature `type_feature'.
		require
			type_feature_not_void: type_feature /= Void
		do
			generate_feature (type_feature, False, False, False)
		end

	generate_features (class_c: CLASS_C; class_type: CLASS_TYPE; is_interface: BOOLEAN)
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
				select_tbl := class_c.feature_table.select_table
				features := class_type.class_interface.features
				i := features.count
				features.start
				if features.after then
					create sorted_array.make_empty
				else
					create sorted_array.make_filled (select_tbl.item (features.item_for_iteration), 1, i)
				end
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

			-- Define reference to feature `a_feature_id' defined in `a_type_id'.
		require
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
		local
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
		do
			l_class_type := class_types.item (a_type_id)
			l_feat := l_class_type.associated_class.feature_of_feature_id (a_feature_id)
			check
				same_feature_id: l_feat.feature_id = a_feature_id
			end

			define_feature_i_reference (a_type_id, l_feat, in_interface, is_static, is_override)
		end

	define_feature_i_reference (a_type_id: INTEGER; a_feature_i: FEATURE_I;
			in_interface, is_static, is_override: BOOLEAN)

			-- Define reference to feature `a_feature_i' defined in `a_type_id'.
		require
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_i /= Void
		local
			l_feature_id: INTEGER
			l_class_type: CLASS_TYPE
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_type_i: TYPE_A
			l_meth_token, l_setter_token: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_A
			l_is_c_external: BOOLEAN
			l_class_token: like current_class_token
			l_naming_convention: BOOLEAN
			l_is_single_class: BOOLEAN
			l_is_static: BOOLEAN
			l_is_attribute_generated_as_field: BOOLEAN
			l_declaration_class: CLASS_C
		do
			l_class_type := class_types.item (a_type_id)
			l_feature_id := a_feature_i.feature_id

			l_class_token := actual_class_type_token (a_type_id)
			l_is_single_class := l_class_type.is_generated_as_single_type

			l_is_attribute := a_feature_i.is_attribute
			l_is_c_external := a_feature_i.is_c_external

			if attached {IL_EXTENSION_I} a_feature_i.extension as e then
				l_is_static := not e.need_current (e.type)
				l_name := e.alias_name
			elseif l_class_type.is_expanded and then l_is_attribute then
				l_is_static := True
			elseif not l_is_single_class then
				l_is_static := is_static
			end

			l_parameter_count := a_feature_i.argument_count
			l_return_type := result_type_in (a_feature_i, l_class_type)
			l_is_attribute_generated_as_field := l_is_attribute and (l_is_single_class or (not in_interface and l_is_static))

			if not a_feature_i.is_type_feature then
					-- Only for not automatically generated feature do we use the
					-- naming convention chosen by user.
				l_naming_convention := l_class_type.is_dotnet_name
			end

				-- When we are handling with an external feature, we have to extract its
				-- real name, not the Eiffel one.
			if not attached l_name then
				if a_feature_i.is_type_feature then
					l_name := a_feature_i.feature_name
				else
					if l_is_static then
						if l_is_c_external then
							l_name := encoder.feature_name (l_class_type.type_id,
								a_feature_i.body_index)
						else
							if l_is_attribute then
								l_name := "$$" + il_casing.camel_casing (
									l_naming_convention, a_feature_i.feature_name)
							else
								l_name := "$$" + il_casing.pascal_casing (
									l_naming_convention, a_feature_i.feature_name,
									{IL_CASING_CONVERSION}.lower_case)
							end
						end
					else
						l_name := il_casing.pascal_casing (
							l_naming_convention, a_feature_i.feature_name,
							{IL_CASING_CONVERSION}.lower_case)
						if a_feature_i.has_property_getter then
							prepare_property_getter (a_feature_i, l_class_type, l_name, l_return_type, l_class_type)
							current_module.insert_property_getter (md_emit.define_member_ref
								(uni_string, l_class_token, method_sig), a_type_id, l_feature_id)
						end
						if a_feature_i.has_property_setter then
							l_type_i := l_return_type
							if l_type_i.is_void then
								l_type_i := argument_actual_type_in (a_feature_i.arguments.first, l_class_type)
							end
							prepare_property_setter (a_feature_i, l_class_type, l_name, l_type_i, l_class_type)
							current_module.insert_property_setter (md_emit.define_member_ref
								(uni_string, l_class_token, method_sig), a_type_id, l_feature_id)
						end
						if
							a_feature_i.has_property and then
							l_is_single_class and then
							not is_override and then
							l_is_attribute_generated_as_field
						then
								-- Use a field name different from the property name.
							l_name := "$$" + il_casing.camel_casing (l_naming_convention, a_feature_i.feature_name)
						end
						check l_name_attached: l_name /= Void end
					end
				end
			end

			uni_string.set_string (l_name)

			if l_is_attribute_generated_as_field then
					-- Evaluate signature of the field.
				l_field_sig := field_sig
				l_field_sig.reset
				set_signature_type (l_field_sig, l_return_type, l_class_type)
				if a_feature_i.origin_class_id = 0 then
					l_declaration_class := system.class_of_id (a_feature_i.access_in)
				else
					l_declaration_class := system.class_of_id (a_feature_i.origin_class_id)
				end
				if
					l_declaration_class.is_true_external or else
					(l_declaration_class.is_single and then l_declaration_class /= l_class_type.associated_class)
				then
						-- No field is generated because it is inherited or if this was a .NET class
						-- it has already been generated.
					check
						is_single_class: is_single_class
					end
					l_meth_token := attribute_token (l_class_type.type.implemented_type
						(l_declaration_class.class_id).associated_class_type (l_class_type.type).static_type_id,
						l_declaration_class.feature_of_rout_id (a_feature_i.rout_id_set.first).feature_id)
				else
					l_meth_token := md_emit.define_member_ref (uni_string, l_class_token,
						l_field_sig)
				end
				insert_attribute (l_meth_token, a_type_id, l_feature_id)
				if l_is_single_class then
					insert_signature ([l_class_type, a_feature_i.rout_id_set.first], a_type_id, l_feature_id)
				end
			else
					-- Normal method.
					-- Evaluate its signature.
				l_meth_sig := method_sig
				l_meth_sig.reset
				l_meth_sig.set_method_type
					(if l_is_static and not in_interface then
						{MD_SIGNATURE_CONSTANTS}.Default_sig
					else
						{MD_SIGNATURE_CONSTANTS}.Has_current
					end)

				l_meth_sig.set_parameter_count  (l_parameter_count + (l_is_static and not l_is_c_external).to_integer)

				if a_feature_i.is_type_feature then
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.ise_type_token)
				elseif l_return_type.is_void then
					l_meth_sig.set_return_type ( {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				else
					set_method_return_type (l_meth_sig, l_return_type, l_class_type)
				end

				if l_is_static and not l_is_c_external then
					set_signature_type (l_meth_sig, l_class_type.type, l_class_type)
				end

				if a_feature_i.has_arguments then
					across
						a_feature_i.arguments as a
					loop
						set_signature_type (l_meth_sig, argument_actual_type_in (a.item, l_class_type), l_class_type)
					end
				end

				l_meth_token := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)

				if not l_is_static and l_is_attribute and not is_override then
						-- Let's define attribute setter.
					l_meth_sig.reset
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					set_signature_type (l_meth_sig, l_return_type, l_class_type)
					uni_string.set_string (setter_prefix + l_name)
					l_setter_token := md_emit.define_member_ref (uni_string,
						l_class_token, l_meth_sig)

					insert_setter (l_setter_token, a_type_id, l_feature_id)
				end

				if not is_override then
					if l_is_single_class then
						insert_implementation_feature (l_meth_token, a_type_id, l_feature_id)
						insert_implementation_signature ([l_class_type, a_feature_i.rout_id_set.first],
							a_type_id, l_feature_id)
						insert_feature (l_meth_token, a_type_id, l_feature_id)
						insert_signature ([l_class_type, a_feature_i.rout_id_set.first],
							a_type_id, l_feature_id)
					else
						if l_is_static then
							insert_implementation_feature (l_meth_token, a_type_id, l_feature_id)
							insert_implementation_signature ([l_class_type, a_feature_i.rout_id_set.first],
								a_type_id, l_feature_id)
						else
							insert_feature (l_meth_token, a_type_id, l_feature_id)
							insert_signature ([l_class_type, a_feature_i.rout_id_set.first],
								a_type_id, l_feature_id)
						end
					end
				else
					last_non_recorded_feature_token := l_meth_token
				end
			end
		end

	generate_feature (feat: FEATURE_I; in_interface, is_static, is_c_external: BOOLEAN)
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		do
			implementation_generate_feature (feat, in_interface, is_static, is_c_external, False, False, current_class_type)
		end

	implementation_generate_feature (
			feat: FEATURE_I; in_interface, is_static, is_external, is_override, is_empty: BOOLEAN; signature_declaration_type: CLASS_TYPE)

			-- Generate interface `feat' description using for `signature_declaration_type' for signature evaluation.
		require
			feat_not_void: feat /= Void
			signature_declaration_type_not_void: signature_declaration_type /= Void
			found_feature_in_declaration_type:
				(not feat.is_inline_agent and not feat.is_hidden) implies
				signature_declaration_type.associated_class.feature_of_rout_id (feat.rout_id_set.first) /= Void
		local
			is_override_or_c_external: BOOLEAN
			l_feature_name: STRING
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_type_feature: TYPE_FEATURE_I
			l_type_i: TYPE_A
			l_type_a: TYPE_A
			l_meth_token, l_setter_token: INTEGER
			l_param_token: INTEGER
			l_meth_attr: INTEGER
			l_field_attr: INTEGER
			l_parameter_count: INTEGER
			l_is_attribute: BOOLEAN
			l_return_type: TYPE_A
			l_has_arguments: BOOLEAN
			l_feat_arg: like {FEATURE_I}.arguments
			i, j: INTEGER
			l_is_c_external: BOOLEAN
			l_ca_factory: CUSTOM_ATTRIBUTE_FACTORY
			l_naming_convention: BOOLEAN
			l_name_ca: MD_CUSTOM_ATTRIBUTE
			l_is_attribute_generated_as_field: BOOLEAN
			-- l_is_field_hidden: BOOLEAN
			l_declaration_class: CLASS_C
			l_getter: INTEGER
			l_setter: INTEGER
			l_property_name: STRING
			l_property_token: INTEGER
			l_has_property: BOOLEAN
		do
			is_override_or_c_external := is_external or is_override
			l_feature_name := feat.feature_name
			if is_override then
				l_feature_name := Override_prefix + l_feature_name + override_counter.next.out
			end
			last_property_getter_token := {MD_TOKEN_TYPES}.md_method_def
			last_property_setter_token := {MD_TOKEN_TYPES}.md_method_def
			l_is_attribute := feat.is_attribute
			l_is_c_external := feat.is_c_external
			l_parameter_count := feat.argument_count

			l_return_type := result_type_in (feat, signature_declaration_type)
			l_is_attribute_generated_as_field := l_is_attribute and then
				((is_single_class and not current_class_type.is_expanded and not is_override_or_c_external) or
				(not in_interface and is_static))
			if l_is_attribute_generated_as_field then
				l_field_sig := field_sig
				l_field_sig.reset
				set_signature_type (l_field_sig, l_return_type, signature_declaration_type)
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				l_meth_sig.set_method_type
					(if is_static and not in_interface then
						{MD_SIGNATURE_CONSTANTS}.Default_sig
					else
						{MD_SIGNATURE_CONSTANTS}.Has_current
					end)

				l_meth_sig.set_parameter_count (l_parameter_count + (is_static and not l_is_c_external).to_integer)

				if feat.is_type_feature then
					l_meth_sig.set_return_type
						({MD_SIGNATURE_CONSTANTS}.Element_type_class,
						current_module.ise_type_token)
				elseif l_return_type.is_void then
					l_meth_sig.set_return_type ( {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				else
					set_method_return_type (l_meth_sig, l_return_type, signature_declaration_type)
				end

				if is_static and not l_is_c_external then
					set_signature_type (l_meth_sig, current_class_type.type, current_class_type)
				end

				if feat.has_arguments then
					l_has_arguments := True
					across
						feat.arguments as a
					loop
						set_signature_type (l_meth_sig, argument_actual_type_in (a.item, signature_declaration_type), signature_declaration_type)
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
					l_name := encoder.feature_name (current_class_type.type_id, feat.body_index)
				else
					if l_is_attribute then
						l_name := "$$" + il_casing.camel_casing (
							l_naming_convention, l_feature_name)
							-- Ensure the field is not accessible outside Eiffel system.
						-- l_is_field_hidden := True
					else
						l_name := "$$" + il_casing.pascal_casing (
							l_naming_convention, l_feature_name,
							{IL_CASING_CONVERSION}.lower_case)
					end
				end
			else
				l_name := il_casing.pascal_casing (
					l_naming_convention, l_feature_name,
					{IL_CASING_CONVERSION}.lower_case)
				if feat.has_property_getter or else feat.has_property_setter then
						-- Define property.
					l_meth_sig := method_sig
					l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public ⦶
						{MD_METHOD_ATTRIBUTES}.Hide_by_signature ⦶
						{MD_METHOD_ATTRIBUTES}.Virtual ⦶
						({MD_METHOD_ATTRIBUTES}.Abstract ⊗ (- in_interface.to_integer.to_integer_16))
					if feat.has_property and then
						(is_single_class or else in_interface) and then
						not is_override_or_c_external
					then
						l_has_property := True
						l_meth_attr := l_meth_attr | {MD_METHOD_ATTRIBUTES}.special_name
					end
					if feat.has_property_setter then
						if is_property_setter_generated (feat, signature_declaration_type) then
							l_property_name := feat.property_name
							if is_override then
								l_property_name := Override_prefix + l_property_name + override_counter.value.out
							end
							l_type_i := l_return_type
							if l_type_i.is_void then
								l_type_i := argument_actual_type_in (feat.arguments.first, signature_declaration_type)
							end
								-- Define setter method.
							prepare_property_setter (feat, current_class_type, l_property_name, l_type_i, signature_declaration_type)
							l_setter := md_emit.define_method (uni_string, current_class_token,
								l_meth_attr | {MD_METHOD_ATTRIBUTES}.New_slot, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)
							if is_override_or_c_external then
								last_property_setter_token := l_setter
							else
								current_module.insert_property_setter (l_setter, current_type_id, feat.feature_id)
							end
						elseif not is_override then
								-- Eiffel method is used as a setter.
							postponed_property_setters.extend (create {PAIR [INTEGER, INTEGER]}.make (feat.feature_id, current_type_id))
						end
					end
					if is_property_getter_generated (feat, signature_declaration_type) then
						l_property_name := feat.property_name
						if is_override then
							l_property_name := Override_prefix + l_property_name + override_counter.value.out
						end
							-- Define getter method.
						prepare_property_getter (feat, current_class_type, l_property_name, l_return_type, signature_declaration_type)
						l_getter := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr | {MD_METHOD_ATTRIBUTES}.New_slot, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)
						if is_override_or_c_external then
							last_property_getter_token := l_getter
						else
							current_module.insert_property_getter (l_getter, current_type_id, feat.feature_id)
						end
					end
					if l_has_property then
							-- Define property on a single class or interface only.
						properties.extend (feat.feature_id)
						if l_is_attribute_generated_as_field then
								-- Use a field name different from the property name.
							l_name := "$$" + il_casing.camel_casing (
								l_naming_convention, l_feature_name)
								-- Ensure the field is not accessible outside Eiffel system.
							-- l_is_field_hidden := True
						end
					end
				end
			end

			uni_string.set_string (l_name)

			if l_is_attribute_generated_as_field then
				l_declaration_class := system.class_of_id
					(if feat.origin_class_id = 0 then feat.access_in else feat.origin_class_id end)
				if
					l_declaration_class.is_true_external or else
					(l_declaration_class.is_single and then l_declaration_class /= current_class)
				then
						-- No field is generated because it is inherited or if this was a .NET class
						-- it has already been generated.
					check
						is_single_class: is_single_class
					end
					l_meth_token := attribute_token (current_class_type.type.implemented_type
						(l_declaration_class.class_id).associated_class_type (current_class_type.type).static_type_id,
						l_declaration_class.feature_of_rout_id (feat.rout_id_set.first).feature_id)
				else
						-- The field could be made non-public. But some third-party
						-- auto-generated code relies on the fact that it is public.
					-- if l_is_field_hidden and then not Compilation_modes.is_precompiling then
					-- 	l_field_attr := {MD_FIELD_ATTRIBUTES}.family_or_assembly
					-- else
						l_field_attr := {MD_FIELD_ATTRIBUTES}.public
					-- end

					l_meth_token := md_emit.define_field (uni_string, current_class_token,
						l_field_attr, l_field_sig)

						-- Define associated name corresponding to the Eiffel name
					create l_name_ca.make
					l_name_ca.put_string (l_feature_name)
					l_name_ca.put_integer_16 (0)
					define_custom_attribute (l_meth_token,
						current_module.ise_eiffel_name_attr_ctor_token, l_name_ca)

					if feat.is_transient then
						define_custom_attribute (l_meth_token, current_module.dotnet_non_serialized_attr_ctor_token, empty_ca)
					end

						-- Define name of routine used to find out the attribute static type
						-- if it is generic or a formal.
					l_type_a := result_type_in (feat, signature_declaration_type).actual_type
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
						l_type_a.base_class.lace_class = system.any_class
					then
							-- Type is ANY, so because we actually generate a field of type SYSTEM_OBJECT
							-- we generate a special custom attribute that says it is actually ANY, and not
							-- a field of type SYSTEM_OBJECT
						define_interface_type (l_type_a.base_class.types.first, l_meth_token)
					end
				end

				insert_attribute (l_meth_token, current_type_id, feat.feature_id)
				if is_single_class then
					insert_signature ([signature_declaration_type, feat.rout_id_set.first],
						current_type_id, feat.feature_id)
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
						l_meth_attr := l_meth_attr ⦶
							{MD_METHOD_ATTRIBUTES}.Virtual ⦶
							({MD_METHOD_ATTRIBUTES}.New_slot ⊗ (- feat.is_origin.to_integer.to_integer_16)) ⦶
							({MD_METHOD_ATTRIBUTES}.Abstract ⊗ (- (feat.is_deferred and not is_empty and not is_override_or_c_external).to_integer.to_integer_16))
					end
				end

				if is_static and l_is_c_external then
						-- Let's define Pinvoke here.
						-- The COM interface updates the method definition attributes behind the scenes,
						-- so it is not necessary to update the method attribute with p_invoke_implementation.
						-- However, with IL_EMITTER, we need to explicitly update the method attribute
						-- with p_invoke_implementation.
					if system.is_il_netcore then
						l_meth_attr :=  l_meth_attr | {MD_METHOD_ATTRIBUTES}.pinvoke_implementation
					end

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
					l_meth_attr := {MD_METHOD_ATTRIBUTES}.Public ⦶
						{MD_METHOD_ATTRIBUTES}.Hide_by_signature ⦶
						{MD_METHOD_ATTRIBUTES}.Virtual ⦶
						({MD_METHOD_ATTRIBUTES}.Abstract ⊗ (- in_interface.to_integer.to_integer_16))

					l_meth_sig.reset
					l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					set_signature_type (l_meth_sig, l_return_type, signature_declaration_type)
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
					md_emit.define_parameter (l_meth_token, uni_string, j,
						{MD_PARAM_ATTRIBUTES}.In).do_nothing
				end

				if
					is_static and then
					l_is_c_external and then
					attached l_return_type and then
					l_return_type.is_boolean
				then
					uni_string.set_string ("Result")
					l_param_token := md_emit.define_parameter (l_meth_token,
						uni_string, 0, 0)
					md_emit.set_field_marshal (l_param_token, boolean_native_signature)
				end

				if l_has_arguments then
					from
						l_feat_arg := feat.arguments
						i := 1
					until
						i > l_parameter_count
					loop
						uni_string.set_string (l_feat_arg.item_name_32 (i))
						md_emit.define_parameter (l_meth_token, uni_string,
							i + j, {MD_PARAM_ATTRIBUTES}.In).do_nothing
						i := i + 1
					end
				end

				if not is_override_or_c_external then
					if is_single_class then
						insert_implementation_feature (l_meth_token, current_type_id,
							feat.feature_id)
						insert_implementation_signature ([signature_declaration_type, feat.rout_id_set.first],
							current_type_id, feat.feature_id)
						insert_feature (l_meth_token, current_type_id, feat.feature_id)
						insert_signature ([signature_declaration_type, feat.rout_id_set.first],
							current_type_id, feat.feature_id)
					else
						if is_static then
							insert_implementation_feature (l_meth_token, current_type_id,
								feat.feature_id)
							insert_implementation_signature ([signature_declaration_type, feat.rout_id_set.first],
								current_type_id, feat.feature_id)
						else
							insert_feature (l_meth_token, current_type_id, feat.feature_id)
							insert_signature ([signature_declaration_type, feat.rout_id_set.first],
								current_type_id, feat.feature_id)
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

	argument_actual_type_in (a_type: TYPE_A; class_type: CLASS_TYPE): TYPE_A
			-- Compute real type of `a_type' in `class_type'.
		require
			a_type_not_void: a_type /= Void
			class_type_not_void: class_type /= Void
		do
			if a_type.is_none then
				Result := System.any_class.compiled_class.types.first.type
			else
				Result := byte_context.real_type_in (a_type, class_type.type)
			end
		ensure
			valid_result: Result /= Void
		end

	result_type_in (feature_i: FEATURE_I; class_type: CLASS_TYPE): TYPE_A
			-- Actual type of a result of feature `feature_i' in `class_type'
		require
			feature_i_not_viod: feature_i /= Void
			class_type_not_void: class_type /= Void
		do
			Result :=
				if feature_i.is_once_creation (class_type.associated_class) then
					class_type.type
				else
					argument_actual_type_in (feature_i.type, class_type)
				end
		ensure
			result_not_void: Result /= Void
			void_if_procedure: not feature_i.has_return_value implies Result.is_void
		end

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_A; a_context_type: CLASS_TYPE)
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		do
			current_module.set_method_return_type (a_sig, a_type, a_context_type)
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_A; a_context_type: CLASS_TYPE)
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		do
			current_module.set_signature_type (a_sig, a_type, a_context_type)
		end

	generate_type_features (feats: HASH_TABLE [TYPE_FEATURE_I, INTEGER]; class_id: INTEGER; is_interface: BOOLEAN)
			-- Generate all TYPE_FEATURE_I that must be generated in
			-- interface corresponding to class ID `class_id'.
		require
			feats_not_void: feats /= Void
		local
			l_type_feature: TYPE_FEATURE_I
		do
			across
				feats as f
			loop
				l_type_feature := f.item
				if is_interface implies l_type_feature.origin_class_id = class_id then
					generate_feature (l_type_feature, is_interface, False, False)
				end
			end
		end

	prepare_property_getter (f: FEATURE_I; s: CLASS_TYPE; property_name: STRING; return_type: TYPE_A; t: CLASS_TYPE)
			-- Fill `uni_string' and `method_sig' with a property getter data
			-- in class type `t'.
		require
			f_attached: f /= Void
			s_attached: s /= Void
			property_name_attached: property_name /= Void
			property_name_not_empty: not property_name.is_empty
			return_type_attached: return_type /= Void
			t_attached: t /= Void
		local
			l_meth_sig: like method_sig
			n: STRING
		do
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			l_meth_sig.set_parameter_count (0)
			set_signature_type (l_meth_sig, return_type, t)
			n := property_getter_prefix + property_name
			if s.associated_class.feature_named (n) /= Void then
					-- Property getter name conflicts with the feature name.
				n := property_getter_prefix + t.associated_class.name + "." + f.feature_name
			end
			uni_string.set_string (n)
		end

	prepare_property_setter (f: FEATURE_I; s: CLASS_TYPE; property_name: STRING; return_type: TYPE_A; t: CLASS_TYPE)
			-- Fill `uni_string' and `method_sig' with a property setter data
			-- in class type `t'.
		require
			f_attached: f /= Void
			property_name_attached: property_name /= Void
			property_name_not_empty: not property_name.is_empty
			return_type_attached: return_type /= Void
			t_attached: t /= Void
		local
			l_meth_sig: like method_sig
			n: STRING
		do
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
			set_signature_type (l_meth_sig, return_type, t)
			n := property_setter_prefix + property_name
			if s.associated_class.feature_named (n) /= Void then
					-- Property setter name conflicts with the feature name.
				n := property_setter_prefix + t.associated_class.name + "." + f.feature_name
			end
			uni_string.set_string (n)
		end

	is_property_getter_generated (f: FEATURE_I; t: CLASS_TYPE): BOOLEAN
			-- Is property getter method explicitly generated for `f' in `t'?
		require
			f_attached: f /= Void
			t_attached: t /= Void
		local
			n: STRING
		do
			if f.has_property_getter then
				n := il_casing.pascal_casing (t.is_dotnet_name, f.feature_name, {IL_CASING_CONVERSION}.lower_case)
				if n.is_equal (property_getter_prefix + f.property_name) then
					Result := f.written_class.is_single and then f.written_in /= t.type.class_id
				else
					Result := True
				end
			end
		end

	is_property_setter_generated (f: FEATURE_I; t: CLASS_TYPE): BOOLEAN
			-- Is property setter method explicitly generated for `f' in `t'?
		require
			f_attached: f /= Void
			t_attached: t /= Void
		local
			s: FEATURE_I
			sn: STRING
		do
			if f.has_property_setter then
				s := f.property_setter_in (t)
				if s /= Void then
					sn := il_casing.pascal_casing (t.is_dotnet_name, s.feature_name, {IL_CASING_CONVERSION}.lower_case)
					if sn.is_equal (property_setter_prefix + f.property_name) then
						Result := s.written_class.is_single and then s.written_in /= t.type.class_id
					else
						Result := True
					end
				end
			end
		end

feature -- IL Generation

	generate_creation_procedures (class_c: CLASS_C; class_type: CLASS_TYPE)
			-- Generate IL code for creation procedures in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		local
			create_name: STRING
			l_attributes: INTEGER
			l_creators: like {CLASS_C}.creators
			l_feat_tbl: FEATURE_TABLE
			l_type_token: INTEGER
			l_is_generic: BOOLEAN
		do
			l_creators := class_c.creators

				-- Let's define factory class if needed, i.e.:
				-- 1 - class is not deferred
				-- 2 - class has exported creation procedure
				-- 3 - class has automatic `default_create' procedure
			if not class_c.is_deferred and (attached l_creators implies not l_creators.is_empty) then
				l_is_generic := class_c.is_generic or else class_c.is_tuple
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

				if attached l_creators then
					l_feat_tbl := class_c.feature_table
					across
						l_creators as c
					loop
						generate_creation_procedure (class_c, class_type, l_feat_tbl.item_id (c.key), l_is_generic)
					end
				elseif attached class_c.default_create_feature as f then
						-- It is not guaranteed that a class defines `default_create', e.g.
						-- a class that does not inherit from ANY.
					generate_creation_procedure (class_c, class_type, f, l_is_generic)
				end
			end
		end

	generate_creation_procedure (class_c: CLASS_C; class_type: CLASS_TYPE; feat: FEATURE_I; is_generic: BOOLEAN)
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
			l_is_il_external: BOOLEAN
			l_meth_token, l_meth_attr: INTEGER
			i, nb: INTEGER
			is_once_creation: BOOLEAN
		do
			nb := feat.argument_count
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (nb + is_generic.to_integer)
			set_method_return_type (l_meth_sig, current_class_type.type, current_class_type)

			if feat.is_external and then attached {EXTERNAL_I} feat as l_external_i then
				l_is_il_external := l_external_i.extension.is_il
			end

			if nb > 0 then
					-- Only add arguments when calling parent ctor with arguments.
				across
					feat.arguments as a
				loop
					set_signature_type (l_meth_sig, argument_actual_type_in (a.item, class_type), class_type)
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

			if l_is_il_external then
					-- Generate constructor arguments
				from
					i := 0
				until
					i = nb
				loop
					generate_argument (i)
					i := i + 1
				end
				if is_generic then
					generate_argument (nb)
					create_object_with_args (current_class_type.implementation_id, feat.feature_id, nb + 1)
				else
					create_object_with_args (current_class_type.implementation_id, feat.feature_id, nb)
				end
			else
				if is_generic then
					generate_argument (nb)
					create_generic_object (current_class_type.implementation_id)
				else
					create_object (current_class_type.implementation_id)
				end
				if current_class_type.is_expanded then
						-- Box expanded object.
					generate_metamorphose (current_class_type.type)
						-- Take address of expanded object.
					generate_load_address (current_class_type.type)
				end
				if class_c.is_once then
						-- Result is computed by the called creation method.
					is_once_creation := True
				else
						-- Result is the newly created object.
					duplicate_top
				end
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
							current_class_type.associated_class.feature_of_rout_id (feat.rout_id_set.first).feature_id), nb, is_once_creation)
				else
					method_body.put_call ({MD_OPCODES}.callvirt,
						feature_token (current_class_type.type.implemented_type (feat.origin_class_id).static_type_id (Void), feat.origin_feature_id),
						nb, is_once_creation)
				end
				fixme ("Generate class invariant check (if enabled).")
				if current_class_type.type.is_basic then
						-- Load basic object value.
					generate_load_from_address_as_basic (current_class_type.type)
				elseif current_class_type.is_expanded then
						-- Load expanded object value.
					generate_load_from_address (current_class_type.type)
				end
			end

			generate_return (True)
			store_locals (l_meth_token, class_type)
			method_writer.write_current_body
			byte_context.clear_feature_data
		end

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE)
			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
		deferred
		end

	generate_il_features (class_c: CLASS_C; class_type: CLASS_TYPE;
			implemented_feature_processor: PROCEDURE [FEATURE_I, CLASS_TYPE, FEATURE_I];
			local_feature_processor: PROCEDURE [FEATURE_I, FEATURE_I, CLASS_TYPE, BOOLEAN];
			inherited_feature_processor: PROCEDURE [FEATURE_I, FEATURE_I, CLASS_TYPE];
			type_feature_processor: PROCEDURE [TYPE_FEATURE_I]
			inline_agent_processor: PROCEDURE [FEATURE_I])

			-- Generate IL code for feature in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			local_feature_processor_not_void: local_feature_processor /= Void
			inherited_feature_processor_not_void: inherited_feature_processor /= Void
			inline_agent_processor_attached: inline_agent_processor /= Void
			not_external_class_type: not class_type.is_external
		deferred
		end

	generate_empty_body (a_feat: FEATURE_I)
			-- Generate a valid empty body for `a_feat' in `current_type_id'.
		require
			feature_not_void: a_feat /= Void
		local
			l_type: TYPE_A
		do
			start_new_body (feature_token (current_type_id, a_feat.feature_id))
			l_type := result_type_in (a_feat, current_class_type)
			if not l_type.is_void then
				put_default_value (l_type)
			end
			generate_return (not l_type.is_void)
			method_writer.write_current_body
		end

	generate_feature_il (feat: FEATURE_I; a_type_id, code_feature_id: INTEGER)
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
			l_cur_sig, l_impl_sig: like signature
			l_cur_feat, l_impl_feat: FEATURE_I
			l_cur_type, l_impl_type: CLASS_TYPE
			i, nb: INTEGER
			l_is_external: BOOLEAN
			l_sequence_point: like sequence_point
			l_class_type: CLASS_TYPE
			l_type_i, l_impl_type_i: TYPE_A
			l_same_signature: BOOLEAN
			has_return_value: BOOLEAN
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
					-- To verify if it should be `current_class_type' or the one from `a_type_id'.
				generate_check_cast (Void, result_type_in (feat, current_class_type))
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, l_token)
				generate_return (False)
				method_writer.write_current_body
			else
				l_token := implementation_feature_token (a_type_id, code_feature_id)
					-- Retrieve the information about the routine.
				l_cur_sig := signature (current_type_id, feat.feature_id)
				l_impl_sig := implementation_signature (a_type_id, code_feature_id)
				l_same_signature := (l_cur_sig.class_type = l_impl_sig.class_type) and
					(l_cur_sig.routine_id = l_impl_sig.routine_id)
				if not l_same_signature then
					l_cur_type := l_cur_sig.class_type
					l_impl_type := l_impl_sig.class_type
					l_cur_feat := l_cur_type.associated_class.feature_of_rout_id (l_cur_sig.routine_id)
					l_impl_feat := l_impl_type.associated_class.feature_of_rout_id (l_impl_sig.routine_id)
					l_same_signature := same_signature (l_cur_feat, l_impl_feat, l_cur_type, l_impl_type)
				end

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
						-- However we keep this code as it might be useful in the future
						-- if we introduce a new project settings option to turn this on
						-- or off.
					False and then
					(not l_is_external and then not l_class_type.is_precompiled and then
					il_module (current_class_type) = il_module (l_class_type) and then
					l_same_signature)
				then
					if is_debug_info_enabled then
						dbg_writer.open_method (l_meth_token)
						across
							current_module.method_sequence_points.item (l_token) as p
						loop
							l_sequence_point := p.item
							dbg_offsets_count := l_sequence_point.offset_count
							dbg_offsets := l_sequence_point.offsets
							dbg_start_lines := l_sequence_point.start_lines
							dbg_start_columns := l_sequence_point.start_columns
							dbg_end_lines := l_sequence_point.end_lines
							dbg_end_columns := l_sequence_point.end_columns
							dbg_writer.define_sequence_points (
								dbg_documents (l_sequence_point.written_class_id),
								dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
								dbg_end_lines, dbg_end_columns
								)
						end
						generate_local_debug_info (l_token, l_class_type)
						dbg_writer.close_method
					end
					method_writer.write_duplicate_body (l_token, l_meth_token)
				else
					if is_debug_info_enabled then
							-- Enable debugger to go through stub definition.
						define_custom_attribute (l_meth_token,
							current_module.debugger_step_through_ctor_token, empty_ca)
						define_custom_attribute (l_meth_token,
							current_module.debugger_hidden_ctor_token, empty_ca)
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
						if is_verifiable and not l_same_signature then
							l_type_i := argument_actual_type_in (l_cur_feat.arguments.i_th (i), l_cur_type).adapted_in (l_cur_type)
							l_impl_type_i := argument_actual_type_in (l_impl_feat.arguments.i_th (i), l_impl_type).adapted_in (l_impl_type)
								-- Ideally a conformance check would possibly remove some unnecessary casts.
							if not l_impl_type_i.is_expanded and not l_type_i.is_safe_equivalent (l_impl_type_i) then
								method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
									mapped_class_type_token (l_impl_type_i.static_type_id (l_impl_type.type)))
							end
						end
						i := i + 1
					end
					has_return_value :=
						feat.has_return_value or else
						feat.is_once_creation (l_class_type.associated_class)
					if not feat.is_c_external then
						method_body.put_call ({MD_OPCODES}.call, l_token, nb, has_return_value)
					else
						method_body.put_static_call (l_token, nb, has_return_value)
					end
					if
						has_return_value and then
						is_verifiable and then
						not l_same_signature
					then
						l_type_i := result_type_in (l_cur_feat, l_cur_type).adapted_in (l_cur_type)
						l_impl_type_i := result_type_in (l_impl_feat, l_impl_type).adapted_in (l_impl_type)
							-- Ideally a conformance check would possibly remove some unnecessary casts.
						if not l_type_i.is_expanded and not l_type_i.is_safe_equivalent (l_impl_type_i) then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_type_i.static_type_id (l_cur_type.type)))
						end
					end
					generate_return (has_return_value)
					method_writer.write_current_body
				end
			end
		end

	generate_external_il (feat: FEATURE_I)
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
					current_module.debugger_step_through_ctor_token, empty_ca)
				define_custom_attribute (l_meth_token,
					current_module.debugger_hidden_ctor_token, empty_ca)
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

	generate_feature_code (feat: FEATURE_I; is_implementation: BOOLEAN)
			-- Generate IL code for feature `feat' using its implementation
			-- token if `is_implementation' is true.
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
					create dbg_offsets.make_filled (0, 0, 5)
					create dbg_start_lines.make_filled (0, 0, 5)
					create dbg_start_columns.make_filled (0, 0, 5)
					create dbg_end_lines.make_filled (0, 0, 5)
					create dbg_end_columns.make_filled (0, 0, 5)
					dbg_offsets_count := 0
				end

				current_class_type.generate_il_feature (feat)
				local_end_offset := method_body.count
				store_locals (l_meth_token, current_class_type)
				method_writer.write_current_body

				if is_debug_info_enabled then
					generate_local_debug_info (l_meth_token, current_class_type)
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

	generate_property (f: FEATURE_I; i: FEATURE_I; parent_type: CLASS_TYPE; is_impl_required: BOOLEAN)
			-- Generate property methods associated with feature `f' (if any)
			-- given that the inherited feature is `i' (if any) from parent
			-- class type `parent_type'.
		require
			f_attached: f /= Void
			parent_type_attached: i /= Void implies parent_type /= Void
		do
			if is_property_setter_generated (f, current_class_type) then
				start_new_body (current_module.property_setter_token (current_type_id, f.feature_id))
					-- Look for assigner command.
				generate_property_setter_body (f)
				method_writer.write_current_body
				if is_impl_required and then i /= Void and then is_property_setter_generated (i, parent_type) then
					md_emit.define_method_impl (current_class_token,
						current_module.property_setter_token (current_type_id, f.feature_id),
						current_module.property_setter_token (parent_type.static_type_id, i.feature_id))
				end
			end
			if is_property_getter_generated (f, current_class_type) then
				start_new_body (current_module.property_getter_token (current_type_id, f.feature_id))
				generate_property_getter_body (f)
				method_writer.write_current_body
				if is_impl_required and then i /= Void and then is_property_getter_generated (i, parent_type) then
					md_emit.define_method_impl (current_class_token,
						current_module.property_getter_token (current_type_id, f.feature_id),
						current_module.property_getter_token (parent_type.static_type_id, i.feature_id))
				end
			end
		end

	generate_property_setter_body (f: FEATURE_I)
			-- Generate property setter body for feature `f'.
		require
			f_not_void: f /= Void
		local
			target_type: CL_TYPE_A
			target_feature: FEATURE_I
		do
				-- Look for a property setter.
			target_feature := f.ancestor_property_setter_in (current_class)
			if target_feature /= Void then
				target_type := current_class_type.type
				if not target_type.is_expanded then
					target_type := target_type.implemented_type (target_feature.access_in)
				end
				target_feature := target_type.base_class.feature_of_rout_id (target_feature.rout_id_set.first)
				generate_current
				generate_argument (1)
				generate_feature_access (target_type, target_feature.feature_id, 1, False, True)
			end
			generate_return (False)
		end

	generate_property_getter_body (f: FEATURE_I)
			-- Generate property getter body for feature `f'.
		require
			f_not_void: f /= Void
		local
			target_type: CL_TYPE_A
			target_feature: FEATURE_I
		do
			target_type := current_class_type.type
			if not target_type.is_expanded then
				if f.origin_class_id = 0 then
					target_type := target_type.implemented_type (f.access_in)
				else
					target_type := target_type.implemented_type (f.origin_class_id)
				end
			end
			target_feature := target_type.base_class.feature_table.feature_of_rout_id_set (f.rout_id_set)
			generate_current
			if f.is_attribute then
				generate_attribute (True, target_type, target_feature.feature_id)
			else
				generate_feature_access (target_type, target_feature.feature_id, 0, True, True)
			end
			generate_check_cast (byte_context.real_type_in
				(target_feature.type, target_type.associated_class_type (current_class_type.type).type),
				byte_context.real_type (f.type))
			generate_return (True)
		end

	generate_feature_standard_twin (feat: FEATURE_I)
			-- Generate IL code for feature `standard_twin' from ANY.
		require
			feat_not_void: feat /= Void
		local
			type_i: TYPE_A
		do
			start_new_body (feature_token (current_type_id, feat.feature_id))
			generate_current
				-- If `current_class_type' is expanded, cloning is done by compiler.
			type_i := current_class_type.type
			if type_i.is_expanded then
					-- Stack contains a pointer to value type object.
					-- Load a value of the object.
				if type_i.is_basic then
					generate_load_from_address_as_basic (type_i)
				else
					generate_load_from_address (type_i)
				end
			else
				method_body.put_call ({MD_OPCODES}.Call, current_module.memberwise_clone_token, 0, True)
				generate_check_cast (Void, type_i)
			end
			generate_return (True)
			method_writer.write_current_body
		end

	generate_call_to_standard_copy
			-- Generate a call to run-time feature `standard_copy'
			-- assuming that Current and argument are on the evaluation stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"standard_copy", Static_type,
				<<system_object_class_name, system_object_class_name>>,
				Void, False)
		end

	generate_object_equality_test
			-- Generate comparison of two objects.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"is_equal", Static_type,
				<<system_object_class_name, system_object_class_name>>,
				"System.Boolean", False)
		end

	generate_same_type_test
			-- Generate comparison of two objects.
			-- (The feature is invoked with a current object on the stack,
			-- i.e. takes 3 arguments: Current, some, other.)
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"same_type", Static_type,
				<<system_object_class_name, system_object_class_name>>,
				"System.Boolean", False)
		end

	start_new_body (method_token: INTEGER)
			-- Start a new body definition for method `method_token'.
		require
			valid_method_token: method_token /= 0
		do
			method_body := method_writer.new_method_body (method_token)
			result_position := -1
			check
				local_count = 0
				local_types.is_empty
			end
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

	is_method_impl_needed (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE): BOOLEAN
			-- Is a MethodImpl needed between `inh_feat' and `feat'?
		require
			feat_not_void: feat /= Void
			inh_feat_not_void: inh_feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_naming_convention: BOOLEAN
		do
			l_naming_convention := System.dotnet_naming_convention
			if l_naming_convention = class_type.is_dotnet_name then
				Result := feat.feature_name_id /= inh_feat.feature_name_id
	 			if
	 				not Result and then
	 				attached {IL_EXTENSION_I} inh_feat.extension as l_ext
	 			then
 					Result := not il_casing.pascal_casing (System.dotnet_naming_convention,
						feat.feature_name,
 						{IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
	 			end
			else
				if attached {IL_EXTENSION_I} inh_feat.extension as l_ext then
 					Result := not il_casing.pascal_casing (l_naming_convention,
						feat.feature_name,
 						{IL_CASING_CONVERSION}.lower_case).is_equal (l_ext.alias_name)
				else
					Result := not il_casing.pascal_casing (l_naming_convention,
							feat.feature_name, {IL_CASING_CONVERSION}.lower_case).is_equal (
						il_casing.pascal_casing (class_type.is_dotnet_name,
							inh_feat.feature_name, {IL_CASING_CONVERSION}.lower_case))
				end
			end
			if Result and then class_type.is_external then
					-- Ensure the feature is declared in `class_type'
					-- to avoid generating a MethodImpl twice.
				Result := inh_feat.written_in = class_type.associated_class.class_id
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

	generate_method_impl (cur_feat: FEATURE_I; parent_type: CLASS_TYPE; inh_feat: FEATURE_I)
			-- Generate a MethodImpl from `parent_type' and `inh_feat'
			-- to `current_class_type' and `cur_feat'.
		require
			cur_feat_not_void: cur_feat /= Void
			parent_type_not_void: parent_type /= Void
			inh_feat_not_void: inh_feat /= Void
		local
			l_cur_sig, l_inh_sig: like signature
			l_cur_type, l_inh_type: CLASS_TYPE
			l_cur_feat, l_inh_feat: FEATURE_I
			l_same_signature: BOOLEAN
			l_setter_token: INTEGER
			i, nb: INTEGER
			l_meth_attr: INTEGER
			l_meth_sig: MD_METHOD_SIGNATURE
			l_parent_type_id: INTEGER
			l_return_type: TYPE_A
			l_token: like last_non_recorded_feature_token
			l_args: FEAT_ARG
			l_type_i: like argument_actual_type_in
			l_parent_arg_type_i: like argument_actual_type_in
		do
			l_parent_type_id := parent_type.static_type_id
				-- Very tricky part here. We are going to retrieve the FEATURE_I instance that
				-- was actually used to define the signature of the current implementation and store
				-- it in `l_cur_feat'. We do the same for the parent one in `l_inh_feat'.
				-- These are the FEATURE_I objects we need to use to compare signature.
			l_cur_sig := signature (current_type_id, cur_feat.feature_id)
			l_cur_type := l_cur_sig.class_type
			l_cur_feat := l_cur_type.associated_class.feature_of_rout_id (l_cur_sig.routine_id)
			l_inh_sig := signature (l_parent_type_id, inh_feat.feature_id)
			l_inh_type := l_inh_sig.class_type
			l_inh_feat := l_inh_type.associated_class.feature_of_rout_id (l_inh_sig.routine_id)

				-- Notion of same signature depends on wether or not we handle an attribute which is
				-- directly implemented as a field rather than a function when it occurs in class
				-- generated as `is_single_class'.
			l_same_signature := (not is_single_class or else not cur_feat.is_attribute) and then
				same_signature (l_inh_feat, l_cur_feat, l_inh_type, l_cur_type)

			if l_same_signature then
				md_emit.define_method_impl (current_class_token, feature_token (current_type_id,
					cur_feat.feature_id), feature_token (l_parent_type_id, inh_feat.feature_id))

				if cur_feat.is_attribute and then inh_feat.is_attribute then
					md_emit.define_method_impl (current_class_token, setter_token (current_type_id,
						cur_feat.feature_id), setter_token (l_parent_type_id, inh_feat.feature_id))
				end
				if is_property_getter_generated (inh_feat, parent_type) then
					md_emit.define_method_impl (current_class_token, current_module.property_getter_token
						(current_type_id, cur_feat.feature_id), current_module.property_getter_token (l_parent_type_id, inh_feat.feature_id))
				end
				if is_property_setter_generated (inh_feat, parent_type) then
					md_emit.define_method_impl (current_class_token, current_module.property_setter_token
						(current_type_id, cur_feat.feature_id), current_module.property_setter_token (l_parent_type_id, inh_feat.feature_id))
				end
			elseif not is_single_class or else not inh_feat.is_attribute or else not parent_type.associated_class.is_single then
					-- We have to generate body of `inh_feat' in context of
					-- `parent_type' in order to correctly evaluate its
					-- signature in current context.
				implementation_generate_feature (inh_feat, False, False, False, True, False, parent_type)
				l_return_type := result_type_in (inh_feat, parent_type)

				byte_context.clear_feature_data
				l_token := last_non_recorded_feature_token
				start_new_body (l_token)
				generate_current
				nb := l_cur_feat.argument_count
				if nb > 0 then
					from
						i := 1
						l_args := l_cur_feat.arguments
						l_args.start
					until
						i > nb
					loop
						generate_argument (i)
						l_type_i := argument_actual_type_in (l_args.item, l_cur_type).adapted_in (l_cur_type)
						l_parent_arg_type_i := argument_actual_type_in (l_inh_feat.arguments [i], l_inh_type).adapted_in (l_inh_type)
							-- Ideally a conformance check would possibly remove some unnecessary casts.
						if not l_type_i.is_safe_equivalent (l_parent_arg_type_i) then
							if l_type_i.is_basic then
									-- Do nothing if a TYPED_POINTER derivation is being reattached to another TYPED_POINTER derivation.
								if not l_parent_arg_type_i.is_basic then
									generate_load_address (l_type_i)
									generate_load_from_address_as_basic (l_type_i)
								end
							elseif l_type_i.is_expanded then
								generate_unmetamorphose (l_type_i)
							elseif is_verifiable then
								method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
									mapped_class_type_token (l_type_i.static_type_id (l_cur_type.type)))
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
					l_type_i := result_type_in (l_cur_feat, l_cur_type).adapted_in (l_cur_type)
					l_parent_arg_type_i := result_type_in (l_inh_feat, l_inh_type).adapted_in (l_inh_type)
						-- Ideally a conformance check would possibly remove some unnecessary casts.
					if not l_type_i.is_safe_equivalent (l_parent_arg_type_i) then
						if l_type_i.is_basic then
							if attached {BASIC_A} l_type_i as b then
								generate_eiffel_metamorphose (b)
							else
								check from_condition: False then end
							end
						elseif l_type_i.is_expanded then
							generate_metamorphose (l_type_i)
						elseif is_verifiable and not l_parent_arg_type_i.is_expanded then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_parent_arg_type_i.static_type_id (l_inh_type.type)))
						end
					end
				end
				generate_return (cur_feat.has_return_value)
				store_locals (l_token, current_class_type)
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

					set_signature_type (l_meth_sig, l_return_type, parent_type)

					uni_string.set_string (Override_prefix + setter_prefix + inh_feat.feature_name +
						override_counter.next.out)

					l_setter_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, {MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_setter_token)
					generate_current
					generate_argument (1)
					l_type_i := result_type_in (l_cur_feat, l_cur_type).adapted_in (l_cur_type)
					if l_return_type.is_reference and then l_type_i.is_expanded then
							-- Unbox argument.
						generate_external_unmetamorphose (l_type_i)
					elseif is_verifiable then
						l_parent_arg_type_i := result_type_in (l_inh_feat, l_inh_type).adapted_in (l_inh_type)
							-- Ideally a conformance check would possibly remove some unnecessary casts.
						if not l_type_i.is_expanded and not l_type_i.is_safe_equivalent (l_parent_arg_type_i) then
							method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass,
								mapped_class_type_token (l_type_i.static_type_id (l_cur_type.type)))
						end
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
					generate_property_setter_body (cur_feat)
					method_writer.write_current_body
					if is_property_setter_generated (inh_feat, parent_type) then
						md_emit.define_method_impl (current_class_token, last_property_setter_token,
							current_module.property_setter_token (l_parent_type_id, inh_feat.feature_id))
					end
				end
				if last_property_getter_token /= {MD_TOKEN_TYPES}.md_method_def then
						-- Generate property getter implementation.
					start_new_body (last_property_getter_token)
					generate_property_getter_body (cur_feat)
					method_writer.write_current_body
					if is_property_getter_generated (inh_feat, parent_type) then
						md_emit.define_method_impl (current_class_token, last_property_getter_token,
							current_module.property_getter_token (l_parent_type_id, inh_feat.feature_id))
					end
				end
			end
		end

	generate_runtime_builtin_call (a_feature: FEATURE_I)
			-- Generate the call to the corresponding builtin routine in ISE_RUNTIME for the implementation of `a_feature'
		local
			l_token: INTEGER
			l_method_sig: like method_sig
			nb: INTEGER
			m: INTEGER
		do
			if attached {BUILT_IN_EXTENSION_I} a_feature.extension as l_ext then
				l_method_sig := method_sig
				l_method_sig.reset
				l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)

				nb := a_feature.argument_count
				m := nb
				if l_ext.is_static then
					l_method_sig.set_parameter_count (nb)
				else
					generate_current
					m := nb + 1
					l_method_sig.set_parameter_count (m)
				end
				if a_feature.has_return_value then
					set_method_return_type (l_method_sig, a_feature.type, current_class_type)
				else
					l_method_sig.set_return_type (
						{MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
				end
				if m /= nb then
						-- Call is not static, but the builtin declaration is, so we need to provide
						-- Current's type to the routine
					l_method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_object, 0)
				end
				if nb > 0 then
					from
						a_feature.arguments.start
					until
						a_feature.arguments.after
					loop
						set_signature_type (l_method_sig, a_feature.arguments.item, current_class_type)
						generate_argument (a_feature.arguments.index)
						a_feature.arguments.forth
					end
				end
				uni_string.set_string ("builtin_" + a_feature.written_class.name + "_" + a_feature.feature_name)
				l_token := md_emit.define_member_ref (uni_string, current_module.ise_runtime_type_token, l_method_sig)
				method_body.put_static_call (l_token, m, a_feature.has_return_value)
				generate_return (a_feature.has_return_value)
			end
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER;
			is_virtual: BOOLEAN)

			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		local
			l_type_token: INTEGER
		do
			l_type_token := current_module.external_token_mapping (base_name)
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), is_virtual)
		end

	generate_external_creation_call (a_actual_type: CL_TYPE_A; name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER)

			-- Generate call to `name' with signature `parameters_type' + `return_type'.
		local
			l_type_id: INTEGER
			l_type_token: INTEGER
			l_argument_types: ARRAY [STRING]
		do
			l_type_id := a_actual_type.implementation_id (current_class_type.type)
			l_type_token := actual_class_type_token (l_type_id)
			l_argument_types := Names_heap.convert_to_string_array (parameters_type)
			if not a_actual_type.is_external and then a_actual_type.generics /= Void and then ext_kind = creator_type then
					-- Supply generic type information.
				generate_generic_type_info (a_actual_type)
				l_argument_types.force (generic_type_class_name, l_argument_types.upper + 1)
			end
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					l_argument_types,
					Names_heap.item (return_type), False)
		end

	external_token (base_name: STRING; member_name: STRING; ext_kind: INTEGER;
			parameters_type: ARRAY [INTEGER]; return_type: INTEGER) : INTEGER

			-- Get token for feature specified by `base_name' and `member_name'
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
			l_parameters_string: ARRAY [STRING]
			l_return_type: STRING
			l_context_class_type: CLASS_TYPE
		do
			l_context_class_type := current_class_type
			l_class_token := current_module.external_token_mapping (base_name)
			l_parameters_string := Names_heap.convert_to_string_array (parameters_type)
			l_return_type := Names_heap.item (return_type)

			inspect ext_kind
			when Field_type, Static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				set_type_in_signature (l_field_sig, l_return_type, l_context_class_type)
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
				set_type_in_signature (l_field_sig, l_parameters_string.item (1), l_context_class_type)
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
					set_type_in_signature (l_meth_sig, l_return_type, l_context_class_type)
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
					set_type_in_signature (l_meth_sig, l_parameters_string.item (i), l_context_class_type)
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

			-- Generate call to `member_name' with signature `parameters_type' + `return_type'.
		require
			valid_external_type: valid_type (ext_kind)
		local
			l_token: INTEGER
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_class_token: INTEGER
			i, nb: INTEGER
			l_context_class_type: CLASS_TYPE
		do
			l_context_class_type := current_class_type
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
				set_type_in_signature (l_field_sig, return_type, l_context_class_type)
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
				set_type_in_signature (l_field_sig, parameters_string.item (1), l_context_class_type)
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
					set_type_in_signature (l_meth_sig, return_type, l_context_class_type)
				else
					l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end

					-- Set arguments in `l_meth_sig'.
				from
					i := 1
				until
					i > nb
				loop
					set_type_in_signature (l_meth_sig, parameters_string.item (i), l_context_class_type)
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

	is_local_signature_changed (inherited_feature, local_feature: FEATURE_I): BOOLEAN
			-- Is signature of a local feature `local_feature' changed
			-- from the one of the associated interface?
		require
			inherited_feature_not_void: inherited_feature /= Void
			local_feature_not_void: local_feature /= Void
			same_arguments_count: inherited_feature.argument_count = local_feature.argument_count
		local
			l_inh_arguments, l_arguments: FEAT_ARG
			l_is_expanded: BOOLEAN
		do
				-- Optimization as many times `inherited_feature' and `local_feature' are the same.
			if inherited_feature /= local_feature then
				l_is_expanded := current_class_type.is_expanded
				Result := (inherited_feature.type.is_reference and local_feature.type.is_expanded) or
					(l_is_expanded and local_feature.type.has_like_current)
				l_arguments := local_feature.arguments
				if not Result and attached l_arguments then
					across
						l_arguments as a
					from
						l_inh_arguments := inherited_feature.arguments
						l_inh_arguments.start
					until
						Result
					loop
						if
							(l_inh_arguments.item.is_reference and a.item.is_expanded) or
							(l_is_expanded and a.item.has_like_current)
						then
							Result := True
						end
						l_inh_arguments.forth
					end
				end
			end
		end

	set_type_in_signature (a_sig: MD_SIGNATURE; a_type_name: STRING; a_context_type: CLASS_TYPE)
			-- Set `a_type_name' into `a_sig'. It properly analyzes `a_type_name'
			-- to detect if it is an array type or a byref.
		require
			a_sig_not_void: a_sig /= Void
			a_type_name_not_void: a_type_name /= Void
		local
			l_is_by_ref, l_is_array: BOOLEAN
			l_real_type: STRING
			l_type: TYPE_A
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
				set_signature_type (a_sig, l_type, a_context_type)
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

	set_local_count (a_count: INTEGER)
			-- Set `local_count' to `a_count'.
		do
			local_count := a_count
		end

	put_result_info (type_i: TYPE_A)
			-- Specifies `type_i' of type of result.
		do
			if not once_generation then
				result_position := 0
				local_types.extend (create {PAIR [TYPE_A, STRING]}.make (type_i, "Result"))
			end
		end

	put_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_A, STRING]}.make (type_i,
				Names_heap.item (name_id)))
		end

	put_nameless_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_A, STRING]}.make (type_i, "_" + name_id.out))
		end

	put_dummy_local_info (type_i: TYPE_A; name_id: INTEGER)
			-- Specifies `type_i' of type of local.
		do
			local_types.extend (create {PAIR [TYPE_A, STRING]}.make (type_i,
				"_dummy_" + name_id.out))
		end

feature -- Local saving

	reset_local_types
			-- Reset `local_types'.
		do
			create local_types.make (5)
		end

	store_locals (a_meth_token: INTEGER; a_context_type: CLASS_TYPE)
			-- Store `local_types' into `method_body' for routine `a_meth_token'.
		require
			method_token_valid: a_meth_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
			a_context_type_not_void: a_context_type /= Void
		do
			current_module.store_locals (local_types, a_meth_token, a_context_type)
			local_count := 0
		end

	generate_local_debug_info (a_method_token: INTEGER; a_context_type: CLASS_TYPE)
			-- Generate local information about routine `method_token'.
		require
			debug_info_requested: is_debug_info_enabled
			method_token_valid: a_method_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
			a_context_type_not_void: a_context_type /= Void
		do
			current_module.generate_local_debug_info (a_method_token, a_context_type)
		end

feature -- Object creation

	create_object (a_type_id: INTEGER)
			-- Create non-generic object of `a_type_id'.
		do
			method_body.put_newobj (constructor_token (a_type_id), 0)
		end

	create_generic_object (a_type_id: INTEGER)
			-- Create generic object of `a_type_id'.
		require
			type_generic: class_types.item (a_type_id).is_generic
		do
			method_body.put_newobj (constructor_token (a_type_id), 1)
		end

	create_object_with_args (a_type_id: INTEGER; a_feature_id: INTEGER; a_arg_count: INTEGER)
			-- Create object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
			a_arg_count_not_negative: a_arg_count >= 0
		do
			method_body.put_newobj (inherited_constructor_token (a_type_id, a_feature_id), a_arg_count)
		end

	create_like_object
			-- Create object of same type as object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_like_object", Static_type, <<type_info_class_name>>,
				type_info_class_name,
				False)
		end

	load_type
			-- Load on stack type of object on top of stack.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"load_type_of_object", Static_type, <<system_object_class_name>>,
				type_class_name,
				False)
		end

	create_type
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_type", Static_type, <<type_class_name,
				type_info_class_name>>, type_info_class_name,
				False)
		end

	create_expanded_object (t: CL_TYPE_A)
			-- Create an object of expanded type `t'.
		local
			creation_procedure: FEATURE_I
		do
				-- Initialize inner expanded attributes and set type information.
			generate_creation (t)
				-- Load address of a value type object.
			generate_load_address (t)
				-- Call creation procedure (if any).
			creation_procedure := t.base_class.creation_feature
			if creation_procedure /= Void then
				duplicate_top
				generate_feature_access (t, creation_procedure.feature_id, 0, False, False)
			end
			generate_load_from_address (t)
		end

	generate_creation (a_type: TYPE_A)
			-- Generate IL code for a hardcoded creation type `a_type'.
			-- Expanded object will be boxed after creation.
		local
			local_index: INTEGER
		do
			if a_type.is_expanded and a_type.is_true_external then
					-- Load a default value of a local variable.
				byte_context.add_local (a_type)
				local_index := byte_context.local_list.count
				put_dummy_local_info (a_type, local_index)
				generate_local (local_index)
			elseif attached {GEN_TYPE_A} a_type as gen_type_i then
					-- Create object using default constructor.
				generate_generic_type_info (gen_type_i)
				create_generic_object (a_type.implementation_id (current_class_type.type))
			else
					-- Create object using default constructor.
				create_object (a_type.implementation_id (current_class_type.type))
			end
			if a_type.is_expanded then
					-- Box expanded object.
				generate_metamorphose (a_type)
			end
		end

feature {NONE} -- Object creation

	generate_generic_type_info (t: CL_TYPE_A)
			-- Generate code that evaluates and puts
			-- generic type information on the stack
		require
			t_attached: t /= Void
		local
			generic_type_token: INTEGER
		do
			t.generate_gen_type_il (Current, True)
			generate_current_as_reference
			method_body.put_call ({MD_OPCODES}.callvirt,
				current_module.ise_get_type_token, 0, True)
			generic_type_token := actual_class_type_token (generic_type_id)
			internal_generate_external_call (current_module.ise_runtime_token,
				generic_type_token, Void,
				"evaluated_type", normal_type, <<generic_type_class_name>>,
				type_class_name, True)
			if is_verifiable then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.castclass, generic_type_token)
			end
		end

feature {IL_MODULE} -- Initialization of expanded attributes

	initialize_expanded_attributes (class_type: CLASS_TYPE)
			-- Initialize expanded attributes of `class_type'
			-- assuming that a reference or a pointer to the object
			-- of type `class_type' is on the stack.
		require
			class_type_not_void: class_type /= Void
		local
			skeleton: SKELETON
		do
			from
				skeleton := class_type.skeleton
				skeleton.go_expanded
			until
				skeleton.off or else skeleton.item.level /= skeleton.expanded_level
			loop
				if
					attached {EXPANDED_DESC} skeleton.item as desc and then
					attached {CL_TYPE_A} desc.cl_type_i as attribute_type and then
					attribute_type.is_true_expanded and then
					not attribute_type.is_external
				then
					duplicate_top
					create_expanded_object (attribute_type)
					method_body.put_opcode_mdtoken ({MD_OPCODES}.stfld, attribute_token (class_type.implementation_id, skeleton.item.feature_id))
				end
				skeleton.forth
			end
		end

	is_initialization_required (class_type: CLASS_TYPE): BOOLEAN
			-- Is initialization of class attributes is required for `class_type'?
		require
			class_type_not_void: class_type /= Void
		local
			attribute_type: TYPE_A
			skeleton: SKELETON
		do
			from
				skeleton := class_type.skeleton
				skeleton.go_expanded
			until
				Result or else skeleton.off or else skeleton.item.level /= skeleton.expanded_level
			loop
				if attached {EXPANDED_DESC} skeleton.item as desc then
					attribute_type := desc.cl_type_i
					Result := attribute_type.is_true_expanded and then not attribute_type.is_external
				end
				skeleton.forth
			end
		end

feature -- IL stack managment

	duplicate_top
			-- Duplicate top element of IL stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Dup)
		end

	pop
			-- Remove top element of IL stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Pop)
		end

feature -- Variables access

	generate_current
			-- Generate access to `Current'.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldarg_0)
		end

	generate_current_as_reference
			-- Generate access to `Current' in its reference form.
			-- (I.e. box value type object if required.)
		local
			type_i: TYPE_A
		do
			type_i := current_class_type.type
			generate_current
			if type_i.is_expanded then
					-- Box expanded object.
				generate_load_from_address_as_object (type_i)
				generate_metamorphose (type_i)
			elseif type_i.base_class = any_type.base_class then
					-- Special case where we need to cast to EIFFEL_TYPE_INFO
					-- since all routines of ANY are taking System.Object and not ANY as argument.
					-- This fixes a verification error when generating the code for {ANY}.generating_type.
				method_body.put_opcode_mdtoken ({MD_OPCODES}.castclass, current_module.ise_eiffel_type_info_type_token)
			end
		end

	generate_current_as_basic
			-- Load `Current' as a basic value.
		do
			generate_current
			generate_load_from_address_as_basic (current_class_type.type)
		end

	generate_result
			-- Generate access to `Result'.
		do
			if once_generation then
				generate_once_result
			else
				generate_local (result_position)
			end
		end

	generate_attribute (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		do
			if
				attached {CL_TYPE_A} type_i as cl_type and then
				attached cl_type.associated_class_type (current_class_type.type) as l_class_type and then
				(l_class_type.is_generated_as_single_type or l_class_type.is_expanded)
			then
				if need_target then
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld,
						attribute_token (cl_type.implementation_id (current_class_type.type), a_feature_id))
				else
					method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld,
						attribute_token (cl_type.implementation_id (current_class_type.type), a_feature_id))
				end
			else
					-- Attribute are accessed through their feature encapsulation.
				internal_generate_feature_access (type_i.static_type_id (current_class_type.type), a_feature_id,
					0, True, True)
			end
		end

	generate_feature_access (type_i: TYPE_A; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i'.
		local
			l_type_id: INTEGER
			l_virtual: BOOLEAN
		do
			if type_i.is_expanded then
				l_type_id := type_i.implementation_id (current_class_type.type)
				l_virtual := False
			else
				l_type_id := type_i.static_type_id (current_class_type.type)
				l_virtual := True
			end
			internal_generate_feature_access (l_type_id, a_feature_id, nb,
				is_function, l_virtual)
		end

	generate_precompiled_feature_access (type_i: TYPE_A; a_feature: FEATURE_I)
			-- Generate a call to a precompiled library.
		require
			type_i_not_void: type_i /= Void
			a_feature_not_void: a_feature /= Void
		do
		end

	internal_generate_feature_access (a_type_id, a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)

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

	generate_precursor_feature_access (type_i: TYPE_A; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)

			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		do
			method_body.put_call ({MD_OPCODES}.Call,
				implementation_feature_token (type_i.implementation_id (current_class_type.type), a_feature_id),
				nb, is_function)
		end

	generate_type_feature_call_on_type (f: TYPE_FEATURE_I; t: CL_TYPE_A)
			-- <Precursor>
		local
			target_type: CL_TYPE_A
			target_feature_id: INTEGER
			target_routine_id: INTEGER
			anchored_features: HASH_TABLE [TYPE_FEATURE_I, INTEGER]
		do
			if t.is_expanded then
					-- Call feature directly.
				target_type := t
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
				target_type := t.implemented_type (f.origin_class_id)
				target_feature_id := f.origin_feature_id
			end
			generate_feature_access (target_type, target_feature_id, 0, True, True)
		end

	generate_type_feature_call (f: TYPE_FEATURE_I)
			-- Generate a call to a type feature `f' on current.
		do
			generate_current
			generate_type_feature_call_on_type (f, current_class_type.type)
		end

	generate_type_feature_call_for_formal (a_position: INTEGER)
			-- Generate a call to a type feature for formal at position `a_position'.
		do
			generate_type_feature_call (current_class_type.associated_class.formal_at_position (a_position))
		end

	put_type_token (a_type_id: INTEGER)
			-- Put token associated to `a_type_id' on stack.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldtoken,
				actual_class_type_token (a_type_id))
		end

	put_type_instance (a_type: TYPE_A)
			-- <Precursor>
		do
			put_type_token (a_type.external_id (current_class_type.type))
			internal_generate_external_call (current_module.mscorlib_token, 0,
				system_type_class_name, "GetTypeFromHandle",
				static_type, << type_handle_class_name >>,
				system_type_class_name, False)
		end

	put_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldtoken,
				feature_token (type_i.static_type_id (current_class_type.type), a_feature_id))
		end

	put_impl_method_token (type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate access to feature of `a_feature_id' in `type_i'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldtoken,
				implementation_feature_token (type_i.implementation_id (current_class_type.type), a_feature_id))
		end

	generate_argument (n: INTEGER)
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

	generate_local (n: INTEGER)
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

	generate_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		do
				-- It has to be the `implementation_id' because for us `box'
				-- can only be applied to expanded types and only `implementation_id'
				-- refers to the value type implementation for Eiffel generated types,
				-- and for .NET classes `static_type_id' and `implementation_id' are
				-- the same.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Box,
				actual_class_type_token (type_i.implementation_id (current_class_type.type)))
		end

	generate_external_metamorphose (type_i: TYPE_A)
			-- Generate `metamorphose', ie boxing an expanded type `type_i'
			-- using an associated external type (if any).
		do
				-- See comment in `generate_metamorphose'.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Box,
				actual_class_type_token (type_i.external_id (current_class_type.type)))
		end

	generate_eiffel_metamorphose (a_type: BASIC_A)
			-- Generate a metamorphose of `a_type' into a _REF type.
		local
			l_local_number: INTEGER
			l_feat: FEATURE_I
		do
				-- FIXME: We only half support metamorphose of basic types
				-- through the `set_item' routine.
				-- Assign value to a temporary local variable.
			byte_context.add_local (a_type)
			l_local_number := byte_context.local_list.count
			put_dummy_local_info (a_type, l_local_number)
			generate_local_assignment (l_local_number)
				-- Create a new (boxed) instance.
			generate_creation (a_type)
				-- Call `set_item' from the _REF class.
			duplicate_top
			generate_load_address (a_type)
			generate_local (l_local_number)
			l_feat := a_type.base_class.feature_table.item_id ({PREDEFINED_NAMES}.set_item_name_id)
			generate_feature_access (a_type,
				l_feat.feature_id, l_feat.argument_count, l_feat.has_return_value, False)
		end

	generate_unmetamorphose (type_i: TYPE_A)
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
			generate_load_address (type_i)
			generate_load_from_address (type_i)
		end

	generate_external_unmetamorphose (type_i: TYPE_A)
			-- Generate `unmetamorphose', ie unboxing an external reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		do
			generate_load_address_as_external (type_i)
			generate_load_from_address (type_i)
		end

feature -- Addresses

	generate_local_address (n: INTEGER)
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

	generate_argument_address (n: INTEGER)
			-- Generate address of `n'-th argument variable.
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldarga_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 ({MD_OPCODES}.Ldarga, n.to_integer_16)
			end
		end

	generate_current_address
			-- Generate address of `Current'.
		do
			method_body.put_opcode_integer_8 ({MD_OPCODES}.Ldarga_s, 0)
		end

	generate_result_address
			-- Generate address of `Result'.
		do
			if once_generation then
				generate_once_result_address
			else
				generate_local_address (result_position)
			end
		end

	generate_attribute_address (type_i: TYPE_A; attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate address to attribute of `a_feature_id' in `type_i'.
		local
			local_number: INTEGER
		do
			if
				attached {CL_TYPE_A} type_i as cl_type and then
				attached cl_type.associated_class_type (current_class_type.type) as l_class_type and then
				l_class_type.is_generated_as_single_type
			then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldflda,
					attribute_token (cl_type.implementation_id (current_class_type.type), a_feature_id))
			else
					-- Attribute are accessed through their feature encapsulation.
				internal_generate_feature_access (type_i.static_type_id (current_class_type.type), a_feature_id,
					0, True, True)
				Byte_context.add_local (attr_type)
				local_number := Byte_context.local_list.count
				put_dummy_local_info (attr_type, local_number)
				generate_local_assignment (local_number)
				generate_local_address (local_number)
			end
		end

	generate_routine_address (type_i: TYPE_A; a_feature_id: INTEGER; is_last_argument_current: BOOLEAN)
			-- Generate address of routine of `a_feature_id' in class `type_i'
			-- assuming that previous argument is Current if `is_last_argument_current' is true.
		local
			opcode: INTEGER_16
			type_id: INTEGER
		do
			if type_i.is_expanded then
				opcode := {MD_OPCODES}.ldftn
				type_id := type_i.implementation_id (current_class_type.type)
			else
				opcode := {MD_OPCODES}.ldvirtftn
				type_id := type_i.static_type_id (current_class_type.type)
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

	generate_load_address (type_i: TYPE_A)
			-- <Precursor>
		do
				-- See comment on `generate_metamorphose' on why we chose `implementation_id'.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Unbox,
				actual_class_type_token (type_i.implementation_id (current_class_type.type)))
		end

	generate_load_address_as_external (type_i: TYPE_A)
			-- <Precursor>
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Unbox,
				actual_class_type_token (type_i.external_id (current_class_type.type)))
		end

	generate_load_from_address (a_type: TYPE_A)
			-- <Precursor>
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
					actual_class_type_token (a_type.implementation_id (current_class_type.type)))
			end
		end

	generate_load_from_address_as_object (a_type: TYPE_A)
			-- Load value of non-built-in `a_type' type from address pushed on stack.
		do
				-- See comment on `generate_metamorphose' to see why we
				-- use `implementation_id'.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldobj,
				actual_class_type_token (a_type.implementation_id (current_class_type.type)))
		end

	generate_load_from_address_as_basic (a_type: TYPE_A)
			-- Load value of a basic type `a_type' from address of an Eiffel object pushed on stack.
		local
			l_table: FEATURE_TABLE
			l_feat: FEATURE_I
		do
			if attached {CL_TYPE_A} a_type as l_cl_type then
				l_table := l_cl_type.base_class.feature_table
					-- Try to get an attribute by name.
				l_feat := l_table.item_id ({PREDEFINED_NAMES}.item_name_id)
				if l_feat = Void or else not l_feat.is_attribute then
						-- Find attribute explicitly.
					from
						l_table.start
					until
						l_table.after or else l_table.item_for_iteration.is_attribute
					loop
						l_table.forth
					end
					l_feat := l_table.item_for_iteration
				end
				check
					l_feat_attached: l_feat /= Void -- This is ensured by {CLASS_B}.check_validity
				end
				generate_attribute (True, l_cl_type, l_feat.feature_id)
			end
		end

feature -- Assignments

	generate_is_true_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction.
		local
			l_token: INTEGER
		do
				-- We use `actual_class_type_token' because we really want to know
				-- if we inherit really from ANY.
			if type_i.is_expanded then
				l_token := actual_class_type_token (type_i.implementation_id (current_class_type.type))
			else
				l_token := actual_class_type_token (type_i.static_type_id (current_class_type.type))
			end
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Isinst, l_token)
		end

	generate_is_instance_of (type_i: TYPE_A)
			-- Generate `Isinst' byte code instruction where ANY is replaced by SYSTEM_OBJECT.
		local
			l_token: INTEGER
			l_type: TYPE_A
		do
			l_type := type_i.actual_type

			if l_type.is_none or l_type.is_formal then
					-- Nothing to be done because those types are mapped to
					-- System.Object the ancestor to all objects. So we
					-- simply preserve the value on the stack.
			else
					-- We use `mapped_class_type_token' because if we do:
					-- a: ANY
					-- o: SYSTEM_OBJECT
					-- a := o -- valid because SYSTEM_OBJECT inherits from ANY
					-- a ?= o -- should also be valid.
				if type_i.is_expanded then
					l_token := mapped_class_type_token (type_i.implementation_id (current_class_type.type))
				else
					l_token := mapped_class_type_token (type_i.static_type_id (current_class_type.type))
				end
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Isinst, l_token)
			end
		end

	generate_is_instance_of_external (type_i: CL_TYPE_A)
			-- Generate `Isinst' byte code instruction for external variant of the type `type_i'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Isinst, mapped_class_type_token (type_i.external_id (current_class_type.type)))
		end

	generate_check_cast (source_type, target_type: TYPE_A)
			-- Generate `checkcast' byte code instruction.
		local
			l_token: INTEGER
			l_sig: MD_TYPE_SIGNATURE
			l_target_type: TYPE_A
		do
				-- It makes sense to cast if and only if target is not expanded, nor a formal or NONE.
				-- In the last two cases it is useless because those types are mapped to System.Object.
			l_target_type := target_type.actual_type
			if
				is_verifiable and
				not l_target_type.is_expanded and
				not l_target_type.is_none and
				not l_target_type.is_formal and then
				(not attached source_type or else
				not attached {CL_TYPE_A} source_type as s or else
				not attached {CL_TYPE_A} l_target_type as t or else
				not s.base_class.simple_conform_to (t.base_class))
			then
				if attached {NATIVE_ARRAY_TYPE_A} l_target_type as l_native_array then
						-- Try to optimize this a little bit more.
					create l_sig.make
					set_signature_type (l_sig, l_native_array, current_class_type)
					l_token := md_emit.define_type_spec (l_sig)
				else
					l_token := mapped_class_type_token (l_target_type.static_type_id (current_class_type.type))
				end
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass, l_token)
			end
		end

	generate_attribute_assignment (need_target: BOOLEAN; type_i: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class.
		local
			l_class_type: CLASS_TYPE
		do
			check
				has_type: type_i.has_associated_class_type (current_class_type.type)
			end
			l_class_type := type_i.associated_class_type (current_class_type.type)
			if l_class_type.is_generated_as_single_type then
				method_body.put_opcode_mdtoken
					(if need_target then {MD_OPCODES}.Stfld else {MD_OPCODES}.Stsfld end,
						attribute_token (l_class_type.static_type_id, a_feature_id))
			elseif l_class_type.is_expanded then
				method_body.put_call ({MD_OPCODES}.Call,
					setter_token (l_class_type.implementation_id, a_feature_id), 1, False)
			else
				method_body.put_call ({MD_OPCODES}.Callvirt,
					setter_token (l_class_type.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_expanded_attribute_assignment (type_i, attr_type: TYPE_A; a_feature_id: INTEGER)
			-- Generate assignment to attribute of `a_feature_id' in current class
			-- when direct access to attribute is not possible.
		local
			l_class_type: CLASS_TYPE
		do
			check
				has_type: type_i.has_associated_class_type (current_class_type.type)
			end
			l_class_type := type_i.associated_class_type (current_class_type.type)
			if not l_class_type.is_generated_as_single_type then
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldobj,
					actual_class_type_token (attr_type.static_type_id (current_class_type.type)))
				method_body.put_call ({MD_OPCODES}.Callvirt,
					setter_token (l_class_type.static_type_id, a_feature_id), 1, False)
			end
		end

	generate_argument_assignment (n: INTEGER)
			-- Generate assignment to `n'-th argument of current feature.
		do
			if n <= 255 then
				method_body.put_opcode_integer_8 ({MD_OPCODES}.Starg_s, n.to_integer_8)
			else
				method_body.put_opcode_integer_16 ({MD_OPCODES}.Starg, n.to_integer_16)
			end
		end

	generate_local_assignment (n: INTEGER)
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

	generate_result_assignment
			-- Generate assignment to Result variable of current feature.
		do
			if once_generation then
				generate_once_store_result
			else
				generate_local_assignment (result_position)
			end
		end

feature -- Conversion

	convert_to (type: TYPE_A)
			-- Convert top of stack into `type'.
		do
			inspect
				type.element_type
			when {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then convert_to_boolean
			when {MD_SIGNATURE_CONSTANTS}.Element_type_char then convert_to_character_8
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
				--check
				--	False
				--end
			end
		end

	convert_to_native_int
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i)
		end

	convert_to_integer_8, convert_to_boolean
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i1)
		end

	convert_to_integer_16, convert_to_character_8
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i2)
		end

	convert_to_integer_32
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i4)
		end

	convert_to_integer_64
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_i8)
		end

	convert_to_natural_8
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u1)
		end

	convert_to_natural_16
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u2)
		end

	convert_to_natural_32, convert_to_character_32
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u4)
		end

	convert_to_natural_64
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_u8)
		end

	convert_to_real_64
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_r8)
		end

	convert_to_real_32
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode ({MD_OPCODES}.Conv_r4)
		end

feature -- Return statements

	generate_return (has_return_value: BOOLEAN)
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

	once_done_name (feature_name: STRING): STRING
			-- Name of the field that indicates whether once routine has been executed or not
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_done"
		ensure
			result_not_void: Result /= Void
		end

	once_exception_name (feature_name: STRING): STRING
			-- Name of the field that holds exception raised during execution of once routine
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_exception"
		ensure
			result_not_void: Result /= Void
		end

	once_result_name (feature_name: STRING): STRING
			-- Name of the field that stores result of a once function
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_result"
		ensure
			result_not_void: Result /= Void
		end

	once_ready_name (feature_name: STRING): STRING
			-- Name of flag that indicates that once data is ready to use from a different thread
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_ready"
		ensure
			result_not_void: Result /= Void
		end

	once_sync_name (feature_name: STRING): STRING
			-- Name of the field that is used to synchronize access to once routine data
		require
			feature_name_not_void: feature_name /= Void
		do
			Result := feature_name + "_sync"
		ensure
			result_not_void: Result /= Void
		end

feature -- Once management

	generate_once_data (class_c: CLASS_C; a_context_type: CLASS_TYPE)
			-- Generate IL class that is used to store results of once routines declared in `class_c'.
		require
			class_c_not_void: class_c /= Void
			a_context_type_not_void: a_context_type /= Void
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
				-- ca_ignore: "CA024", "Internal and external coursors have different implementation."
			from
				feature_table := class_c.feature_table
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration
				if
					feature_i.is_once and then feature_i.is_process_or_thread_relative_once and then
					feature_i.access_in = class_c.class_id
				then
					if current_class_token = 0 then
						current_class_token := current_module.class_data_token (class_c)
					end
					sync_token := 0
					generate_once_data_info (feature_i, a_context_type)
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
				generate_return (False)
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

	generate_once_data_info (feat: FEATURE_I; a_context_type: CLASS_TYPE)
			-- Generate declaration of variables required to store data of once feature `feat'.
		require
			feat_not_void: feat /= Void
			feat_is_once: feat.is_once
			a_context_type_not_void: a_context_type /= Void
		local
			name: STRING
			result_sig: like field_sig
			result_type: TYPE_A
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

			result_type := result_type_in (feat, a_context_type)
			if not result_type.is_void then
					-- Generate field for result
				result_sig := field_sig
				result_sig.reset
				set_signature_type (result_sig, result_type, a_context_type)

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

	generate_once_access_info (feature_i: FEATURE_I; is_once_creation: BOOLEAN)
			-- Initialize tokens for fields that are used to store result of `feature_i'.
		require
			feature_i_not_void: feature_i /= Void
			once_feature: feature_i.is_once
		local
			class_data_token: INTEGER
			name: STRING
			l_sig: like field_sig
			cl_token: INTEGER
			l_once_info: detachable OBJECT_RELATIVE_ONCE_INFO
		do
			name := feature_i.feature_name
			if feature_i.is_object_relative_once then
				cl_token := current_class_token
				l_once_info := current_class.object_relative_once_info_of_rout_id_set (feature_i.rout_id_set)
				check has_obj_relative_once_info: l_once_info /= Void end

				uni_string.set_string (l_once_info.called_name)
				done_token := md_emit.define_field (uni_string, cl_token, {MD_FIELD_ATTRIBUTES}.Private, done_sig)

				uni_string.set_string (l_once_info.exception_name)
				exception_token := md_emit.define_field (uni_string, cl_token, {MD_FIELD_ATTRIBUTES}.Private, exception_sig)

				if l_once_info.has_result then
					l_sig := field_sig
					l_sig.reset
					set_signature_type (l_sig, l_once_info.result_type_a, current_class_type)
					uni_string.set_string (l_once_info.result_name)
					result_token := md_emit.define_field (uni_string, cl_token, {MD_FIELD_ATTRIBUTES}.Private, l_sig)
				else
					result_token := 0
				end
				Il_debug_info_recorder.record_once_info_for_class (current_class_token, done_token, result_token, exception_token, feature_i, current_class)
			else
				class_data_token := current_module.class_data_token (system.class_of_id (feature_i.access_in))

				uni_string.set_string (once_done_name (name))
				done_token := md_emit.define_member_ref (uni_string, class_data_token, done_sig)
				uni_string.set_string (once_exception_name (name))
				exception_token := md_emit.define_member_ref (uni_string, class_data_token, exception_sig)
				if feature_i.has_return_value or else is_once_creation then
					l_sig := field_sig
					l_sig.reset
					set_signature_type (l_sig, result_type_in (feature_i, current_class_type), current_class_type)
					uni_string.set_string (once_result_name (name))
					result_token := md_emit.define_member_ref (uni_string, class_data_token, l_sig)
				else
					result_token := 0
				end
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

	generate_once_prologue (is_once_creation: BOOLEAN)
			-- Generate prologue for once feature.
			-- The feature is used with `generate_once_epilogue' as follows:
			--    generate_once_prologue
			--    ... -- code of once feature body
			--    generate_once_epilogue
--		require
			-- current_feature_not_void: byte_context.current_feature /= Void
			-- current_feature_is_once: byte_context.current_feature.is_once
		local
			l_once_info: detachable OBJECT_RELATIVE_ONCE_INFO
		do
				-- Body of a once feature is guarded by try/fault blocks
				-- to avoid storing invalid result in case of exception:
				--       done := True
				--       try {
				--          ... -- code of once feature body (including rescue clause)
				--       }
				--       catch (Object e) {
				--          exception := e
				--          volatile ready := True -- only in process-relative code
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
				--             volatile ready := True
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

				-- Object-relative code
				--    if not done then
				--       guarded_body -- see above
				--    end
				--    if exception /= Void then
				--       raise (exception)
				--    end
				--    return result -- if required

				-- Initialize once code generation
			set_once_generation (True)
			if byte_context.current_feature.is_object_relative_once then
				set_object_relative_once_generation (True)
				l_once_info := current_class.object_relative_once_info_of_rout_id_set (byte_context.current_feature.rout_id_set)
			else
				set_object_relative_once_generation (False)
			end
			generate_once_access_info (byte_context.current_feature, is_once_creation)

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
				--       done := True
				--       try {
			if l_once_info /= Void then
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldfld, done_token)
				put_boolean_constant (True)
				method_body.put_opcode ({MD_OPCODES}.ceq)
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, done_token)
			end
			once_done_label := create_label
			branch_on_true (once_done_label)
			if l_once_info /= Void then
				generate_current
				put_boolean_constant (True)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, done_token)
			else
				put_boolean_constant (True)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, done_token)
			end
			method_body.once_catch_block.set_try_offset (method_body.count)
		ensure then
			once_generation: once_generation
			done_token_set: done_token /= 0
			result_token_set: (byte_context.current_feature.has_return_value or is_once_creation) = (result_token /= 0)
			ready_token_set: byte_context.current_feature.is_process_relative = (ready_token /= 0)
			sync_token_set: byte_context.current_feature.is_process_relative = (sync_token /= 0)
			once_done_label_set: once_done_label /= Void
			once_ready_label_set: (ready_token /= 0) = (once_ready_label /= Void)
		end

	generate_once_epilogue
			-- Generate epilogue for once feature.
--		require
			-- current_feature_not_void: byte_context.current_feature /= Void
			-- current_feature_is_once: byte_context.current_feature.is_once
		local
			fault_label: IL_LABEL
			return_label: IL_LABEL
			is_process_relative: BOOLEAN
			has_result: BOOLEAN
			l_once_info: detachable OBJECT_RELATIVE_ONCE_INFO
			local_number: INTEGER
		do

			if byte_context.current_feature.is_object_relative_once then
				l_once_info := current_class.object_relative_once_info_of_rout_id_set (byte_context.current_feature.rout_id_set)
			end
				-- Close try block and start fault block
				--       }
				--       catch (Object e) {
				--          exception := e
				--          volatile ready := True -- only in process-relative code
				--          rethrow
				--       }
			fault_label := create_label
			generate_leave_to (fault_label)
			method_body.once_catch_block.set_try_end (method_body.count)
			method_body.once_catch_block.set_class_token (current_module.object_type_token)
			method_body.update_stack_depth (1)
			method_body.once_catch_block.set_handler_offset (method_body.count)

			if l_once_info /= Void then
					-- Store value
				byte_context.add_local (System_object_type)
				local_number := byte_context.local_list.count
				put_dummy_local_info (System_object_type, local_number)
				generate_local_assignment (local_number)
				generate_current
				generate_local (local_number)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, exception_token)
				-- FIXME:jfiat: should we reset the "result" value? to avoid memory leaks?
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, exception_token)
			end
			if ready_token /= 0 then
					-- Notify other threads that result is ready:
					--          volatile ready := True
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
					--          volatile ready := True
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
			if l_once_info /= Void then
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, exception_token)
				put_void
				method_body.put_opcode ({MD_OPCODES}.ceq)
				put_boolean_constant (False)
				method_body.put_opcode ({MD_OPCODES}.ceq)
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, exception_token)
			end
			branch_on_false (return_label)
			if l_once_info /= Void then
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, exception_token)
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, exception_token)
			end
				-- Only System.Exception can be saved. The type saved exception object could be changed to System.Exception.
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Castclass, current_module.system_exception_token)
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
			set_object_relative_once_generation (False)
		ensure then
			done_token_unset: done_token = 0
			result_token_unset: result_token = 0
			ready_token_unset: ready_token = 0
			sync_token_unset: sync_token = 0
			once_done_label_unset: once_done_label = Void
			once_ready_label_unset: once_ready_label = Void
			not_once_generation: not once_generation
			not_object_relative_once_generation: not object_relative_once_generation
		end

	generate_once_result_address
			-- Generate test on `done' of once feature `name'.
		require
			result_token_set: result_token /= 0
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsflda, result_token)
		end

	generate_once_result
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
--		require
--			result_token_set: result_token /= 0
		do
			if object_relative_once_generation then
				generate_current
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldfld, result_token)
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld, result_token)
			end
		end

	generate_once_store_result
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		local
			local_number: INTEGER
		do
			if object_relative_once_generation then
				byte_context.add_local (System_object_type)
				local_number := byte_context.local_list.count
				put_dummy_local_info (System_object_type, local_number)
				generate_local_assignment (local_number)
				generate_current
				generate_local (local_number)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld, result_token)
			else
				method_body.put_opcode_mdtoken ({MD_OPCODES}.Stsfld, result_token)
			end
		end

feature -- Once manifest string manipulation

	generate_once_string_allocation (count: INTEGER)
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
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldsfld, current_module.once_string_field_token (string_type_cil))
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
				method_body.put_static_call (current_module.once_string_allocation_routine_token, 2, False)
					-- Done.
				mark_label (done_label)
					-- Remove null from stack top.
				method_body.put_opcode ({MD_OPCODES}.pop)
			end
		end

	generate_once_string (number: INTEGER; value: READABLE_STRING_32; type: INTEGER)
			-- Generate code for once string in a current routine with the given
			-- `number' and `value' using CIL string type if `is_cil_string' is `True'
			-- or Eiffel string type otherwise.
		local
			once_string_field_token: INTEGER
			assign_string_label: IL_LABEL
			done_label: IL_LABEL
		do
			once_string_field_token := current_module.once_string_field_token (type)
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
			if type = string_type_cil then
				put_system_string_32 (value)
			else
				if type = string_type_string_32 then
					put_manifest_string_32 (value)
				elseif type = string_type_string then
					put_manifest_string (value)
				elseif type = string_type_immutable_string_32 then
					put_immutable_manifest_string_32 (value)
				elseif type = string_type_immutable_string_8 then
					put_immutable_manifest_string_8 (value)
				end
			end
			method_body.put_opcode ({MD_OPCODES}.stelem_ref)
			put_integer_32_constant (number)
			method_body.put_opcode ({MD_OPCODES}.ldelem_ref)
				-- Done.
			mark_label (done_label)
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER; a_type_id: INTEGER)
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

	generate_array_write_preparation (a_type_id: INTEGER)
			-- Prepare call to `put' from NATIVE_ARRAY in case of expanded elements.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldelema,
				actual_class_type_token (a_type_id))
		end

	generate_array_write (kind: INTEGER; a_type_id: INTEGER)
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

	generate_array_initialization (array_type: CL_TYPE_A; actual_generic: CLASS_TYPE)
			-- Initialize native array with actual parameter type
			-- `actual_generic' on the top of the stack.
		local
			enter_loop_label: IL_LABEL
			continue_loop_label: IL_LABEL
			array_variable: INTEGER
			index_variable: INTEGER
		do
			if actual_generic.is_true_expanded and not actual_generic.is_external then
					-- Initialize elements with their default values:
					-- int i = array.count;
					-- while (i != 0) {
					--   i--;
					--   array [i].ctor ();
					--   array [i].default_create ();
					-- }
				enter_loop_label := create_label
				continue_loop_label := create_label
				byte_context.add_local (array_type)
				array_variable := byte_context.local_list.count
				put_dummy_local_info (array_type, array_variable)
				byte_context.add_local (integer_32_type)
				index_variable := byte_context.local_list.count
				put_dummy_local_info (integer_32_type, index_variable)
				duplicate_top
				generate_local_assignment (array_variable)
				generate_array_count
				generate_local_assignment (index_variable)
				branch_to (enter_loop_label)
				mark_label (continue_loop_label)
				generate_local (array_variable)
				generate_local (index_variable)
				put_integer_8_constant (1)
				generate_binary_operator (il_minus, False)
				duplicate_top
				generate_local_assignment (index_variable)
				method_body.put_opcode_mdtoken ({MD_OPCODES}.ldelema, actual_class_type_token (actual_generic.static_type_id))
				if attached {CL_TYPE_A} array_type.generics.first as cl_type_i then
					create_expanded_object (cl_type_i)
					method_body.put_opcode_mdtoken ({MD_OPCODES}.stobj, actual_class_type_token (actual_generic.static_type_id))
				else
					check is_type_expected: False end
				end
				mark_label (enter_loop_label)
				generate_local (index_variable)
				branch_on_true (continue_loop_label)
				generate_local (array_variable)
			end
		end

	generate_array_creation (a_type_id: INTEGER)
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Newarr,
				actual_class_type_token (a_type_id))
		end

	generate_generic_array_creation (a_formal: FORMAL_A)
			-- Create a new NATIVE_ARRAY [X] where X is a formal type `a_formal'.
		do
			a_formal.generate_gen_type_il (Current, True)
			method_body.put_opcode ({MD_OPCODES}.ldarg_0)
			put_type_token (any_type.implementation_id (Void))
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_conformance_class_name,
				"create_array", Static_type, <<integer_32_class_name, type_class_name,
				type_info_class_name, type_handle_class_name>>, system_object_class_name,
				False)
		end

	generate_array_count
			-- Get length of current NATIVE_ARRAY on stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldlen)
			convert_to_integer_32
		end

	generate_array_upper
			-- Generate call to `count - 1'.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldlen)
			method_body.put_opcode ({MD_OPCODES}.Ldc_i4_1)
			method_body.put_opcode ({MD_OPCODES}.Sub)
		end

	generate_array_lower
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
			-- Used at entry of the `try-catch' block.

	catch_label: INTEGER
			-- The second label used for rescue clauses to mark end of `try-catch'.
			-- Used in `catch' block.

	old_label: IL_LABEL
			-- Label used for marking the end of `try-catch' of old expression evaluation

	generate_start_exception_block
			-- Mark starting point for a routine that has
			-- a rescue clause.
		do
			rescue_label := method_body.define_label
			catch_label := method_body.define_label
			method_body.exception_block.set_start_position (method_body.count)
		end

	generate_start_rescue
			-- Mark beginning of rescue clause.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_catch_position (method_body.count)
			method_body.exception_block.set_type_token (current_module.system_exception_token)

				-- Increase rescue level
			method_body.put_static_call (current_module.ise_enter_rescue_token, 0, False)

				-- We need to increment stack depth of 1 because CLI runtime automatically
				-- puts the exception object on top of stack and there is no automatic
				-- way to add it.
			method_body.update_stack_depth (1)
			method_body.put_static_call (current_module.ise_set_last_exception_token, 1, False)
		end

	generate_leave_to (a_label: IL_LABEL)
			-- Instead of using `branch_to' which is forbidden in a `try-catch' clause,
			-- we generate a `leave' opcode that has the same semantic except that it
			-- should branch outside the `try-catch' clause.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Leave, a_label.id)
		end

	generate_end_exception_block
			-- Mark end of rescue clause.
		do
			put_boolean_constant (False)
			method_body.put_static_call (current_module.ise_rethrow_token, 1, False)
				-- Never invoked, but the CLI standards need this to terminate the catch block.
			method_body.put_opcode_label ({MD_OPCODES}.Leave, catch_label)
			method_body.exception_block.set_end_position (method_body.count)
			method_body.mark_label (rescue_label)
			method_body.mark_label (catch_label)
		end

	generate_get_last_exception
			-- Generate value of `get_last_exception' on stack.
		do
			method_body.put_static_call (current_module.ise_get_last_exception_token, 0, True)
		end

	generate_restore_last_exception
			-- Restores `last_exception' using the local.
		do
			method_body.put_static_call (current_module.ise_restore_last_exception_token, 1, False)
		end

	generate_start_old_try_block (a_ex_local: INTEGER)
			-- Generate start of try block at entry to evaluate old expression.
			-- `a_ex_local' is the local declaration position for the exception.
		do
			check
				current_old_exception_catch_block_not_void: method_body.current_old_exception_catch_block /= Void
			end
			old_label := create_label
			method_body.current_old_exception_catch_block.set_start_position (method_body.count)
			put_void
			generate_local_assignment (a_ex_local)
		end

	generate_catch_old_exception_block (a_ex_local: INTEGER)
			-- Generate catch block for old expression evaluatation
			-- `a_ex_local' is the local declaration position for the exception.
		do
			check
				current_old_exception_catch_block_not_void: method_body.current_old_exception_catch_block /= Void
			end
			generate_leave_to (old_label)
			method_body.current_old_exception_catch_block.set_catch_position (method_body.count)
			method_body.current_old_exception_catch_block.set_type_token (current_module.system_exception_token)

				---- Generate catch block to save possible exception occurs at old expression evaluation.
				-- We need to increment stack depth of 1 because CLI runtime automatically
				-- puts the exception object on top of stack and there is no automatic
				-- way to add it.
			method_body.update_stack_depth (1)
			generate_local_assignment (a_ex_local)
			generate_leave_to (old_label)

			method_body.current_old_exception_catch_block.set_end_position (method_body.count)
			mark_label (old_label)
			if not method_body.is_last_old_expression_exception_block then
				method_body.forth_old_expression_exception_block
			end
		end

	prepare_old_expresssion_blocks (a_count: INTEGER)
			-- Prepare to generate `a_count' blocks for old expression evaluation
		do
			method_body.create_old_exception_catch_blocks (a_count)
		end

	generate_raising_old_exception (a_ex_local: INTEGER)
			-- Generate raising old violation exception when there was exception saved
		local
			l_label: IL_LABEL
		do
			generate_local (a_ex_local)
			put_void
			l_label := create_label
			method_body.put_opcode ({MD_OPCODES}.Ceq)
			branch_on_true (l_label)

				-- Raise old violation
			generate_local (a_ex_local)
			method_body.put_static_call (current_module.ise_raise_old_token, 1, False)

			mark_label (l_label)
		end

	generate_get_rescue_level
			-- Generate `get_rescue_level' on stack.
		do
			method_body.put_static_call (current_module.ise_get_rescue_level_token, 0, True)
		end

	generate_set_rescue_level
			-- Generate `set_rescue_level' using the local.
		do
			method_body.put_static_call (current_module.ise_set_rescue_level_token, 1, False)
		end

feature -- Assertions

	generate_in_assertion_status
			-- Generate value of `in_assertion' on stack.
		do
			method_body.put_static_call (current_module.ise_in_assertion_token, 0, True)
		end

	generate_save_supplier_precondition
			-- Generate code to save the current supplier precondition in a local.
		do
			if current_class_type.is_expanded then
					-- Type is known at compile time.
				put_type_instance (current_class_type.type)
			else
					-- Type is evaluated at run time.
				generate_current
				internal_generate_external_call (current_module.mscorlib_token, 0, System_object_class_name,
					"GetType", Normal_type, <<>>, System_type_class_name, False)
			end
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name, "save_supplier_precondition", Static_type,
				<<System_type_class_name>>, "System.Boolean", False)
		end

	generate_restore_supplier_precondition
			-- Restores the supplier precondition flag using the local.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name, "restore_supplier_precondition", Static_type,
				<<"System.Boolean">>, Void, False)
		end

	generate_is_assertion_checked (level: INTEGER)
			-- Check wether or not we need to check assertion for current type.
		do
			if current_class_type.is_expanded then
					-- Type is known at compile time.
				put_type_instance (current_class_type.type)
			else
					-- Type is evaluated at run time.
				generate_current
				internal_generate_external_call (current_module.mscorlib_token, 0, System_object_class_name,
					"GetType", Normal_type, <<>>, System_type_class_name, False)
			end
			put_integer_32_constant (level)
			generate_local (byte_context.saved_supplier_precondition)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name, "is_assertion_checked", Static_type,
				<<System_type_class_name, Assertion_level_enum_class_name, "System.Boolean">>, "System.Boolean", False)
		end

	generate_set_assertion_status
			-- Set `in_assertion' flag with top of stack.
		do
			method_body.put_static_call (current_module.ise_set_in_assertion_token, 1, False)
		end

	generate_in_precondition_status
			-- Generate value of `in_assertion' on stack.
		do
			method_body.put_static_call (current_module.ise_in_precondition_token, 0, True)
		end

	generate_set_precondition_status
			-- Set `in_precondition' flag with top of stack.
		do
			method_body.put_static_call (current_module.ise_set_in_precondition_token, 1, False)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING)
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
			when In_check, in_guard then
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
				-- Before raising the assertion violation we reset `in_assertion' but only
				-- when it is not a guard because guard do not use `in_assertion'.
			if assert_type /= in_guard then
				put_boolean_constant (False)
				generate_set_assertion_status
			end

			generate_raise_exception (type_assert, tag)

			method_body.mark_label (l_label)
		end

	generate_precondition_check (tag: STRING; failure_block: IL_LABEL)
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

	generate_precondition_violation
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
			put_boolean_constant (False)
			generate_set_precondition_status
			put_boolean_constant (False)
			generate_set_assertion_status
			put_integer_32_constant ({EXCEP_CONST}.precondition)
			method_body.put_opcode_mdtoken ({MD_OPCODES}.Ldsfld,
				current_module.ise_assertion_tag_token)
			method_body.put_static_call (current_module.ise_raise_code_token, 2, False)
		end

	generate_raise_exception (a_code: INTEGER; a_tag: STRING)
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
			method_body.put_static_call (current_module.ise_raise_code_token, 2, False)
		end

	generate_invariant_feature (feat: INVARIANT_FEAT_I)
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
					store_locals (l_dotnet_invariant_token, current_class_type)
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
					set_signature_type (l_sig, current_class_type.type, current_class_type)

					uni_string.set_string ("$$_invariant")
					l_invariant_token := md_emit.define_method (uni_string, current_class_token,
						{MD_METHOD_ATTRIBUTES}.Public |
						{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
						{MD_METHOD_ATTRIBUTES}.Static, l_sig,
						{MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_invariant_token)
					generate_invariant_body (Void)
					store_locals (l_invariant_token, current_class_type)
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

	generate_invariant_body (byte_list: BYTE_LIST [BYTE_NODE])
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

	generate_inherited_invariants
			-- Generate call to all directly inherited invariant features.
		local
			parents: FIXED_LIST [CL_TYPE_A]
			cl_type: CLASS_TYPE
			i, id: INTEGER
			l_list: SEARCH_TABLE [INTEGER]
		do
			parents := current_class_type.associated_class.parents
			create l_list.make (parents.count)
			across
				parents as p
			loop
				cl_type := byte_context.real_type (p.item).associated_class_type (current_class_type.type)
				id := cl_type.implementation_id
				if not l_list.has (id) then
					l_list.force (id)
					if not cl_type.is_external then
						generate_current_as_reference
						if
							system.il_verifiable and then
							not current_class.simple_conform_to (cl_type.associated_class)
						then
							generate_check_cast (current_class_type.type, cl_type.type)
						end
						method_body.put_call ({MD_OPCODES}.Call, invariant_token (id), 0, False)
					end
					i := i + 1
				end
			end
		end

	generate_invariant_checked_for (a_label: IL_LABEL)
			-- Generate check to find out if we should check invariant or not.
		do
			put_type_token (current_class_type.type.static_type_id (Void))
			method_body.put_static_call (current_module.ise_is_invariant_checked_for_token, 1, True)
			branch_on_true (a_label)
		end

	generate_invariant_checking (type_i: TYPE_A; entry: BOOLEAN)
			-- Generate an invariant check after routine call, it assumes that
			-- target has already been pushed onto evaluation stack.
			-- Is the invariant checking `entry'?
		do
			put_boolean_constant (entry)
			method_body.put_static_call (current_module.ise_check_invariant_token, 2, False)
		end

feature -- Constants generation

	put_default_value (type: TYPE_A)
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
				put_real_32_constant ({REAL_32} 0.0)
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

	put_void
			-- Add a Void element on stack.
		do
			method_body.put_opcode ({MD_OPCODES}.Ldnull)
		end

	put_manifest_string_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		do
			create_object (string_implementation_id)
			duplicate_top
			generate_local (n)
			internal_generate_feature_access (string_implementation_id, string_make_feat_id, 1, False, True)
		end

	put_manifest_string (s: READABLE_STRING_GENERAL)
			-- Put `s' on IL stack.
		do
			create_object (string_implementation_id)
			duplicate_top
			put_system_string (s)
			internal_generate_feature_access (string_implementation_id, string_make_feat_id, 1, False, True)
		end

	put_immutable_manifest_string_8 (s: READABLE_STRING_GENERAL)
			-- Put `s' on IL stack.
		do
			create_object (immutable_string_8_implementation_id)
			duplicate_top
			put_system_string (s)
			internal_generate_feature_access (immutable_string_8_implementation_id, immutable_string_8_make_feat_id, 1, False, True)
		end

	put_manifest_string_32_from_system_string_local (n: INTEGER)
			-- Create a manifest string by using local at position `n' which
			-- should be of type SYSTEM_STRING.
		do
			create_object (string_32_implementation_id)
			duplicate_top
			generate_local (n)
			internal_generate_feature_access (string_32_implementation_id, string_32_make_feat_id, 1, False, True)
		end

	put_manifest_string_32 (s: READABLE_STRING_32)
			-- Put `s' on IL stack.
		do
			create_object (string_32_implementation_id)
			duplicate_top

			put_system_string_32 (s)
			internal_generate_feature_access (string_32_implementation_id, string_32_make_feat_id, 1, False, True)
		end

	put_immutable_manifest_string_32 (s: READABLE_STRING_32)
			-- Put `s' on IL stack.
		do
			create_object (immutable_string_32_implementation_id)
			duplicate_top

			put_system_string_32 (s)
			internal_generate_feature_access (immutable_string_32_implementation_id, immutable_string_32_make_feat_id, 1, False, True)
		end

	put_system_string (s: READABLE_STRING_GENERAL)
			-- Put `System.String' object corresponding to `s' on IL stack.
		do
			uni_string.set_string (s)
			method_body.put_string (md_emit.define_string (uni_string))
		end

	put_system_string_32 (s: READABLE_STRING_32)
			-- Put `System.String' object corresponding to `s' on IL stack.
		do
			uni_string.set_string (s)
			method_body.put_string (md_emit.define_string (uni_string))
		end

	put_numeric_integer_constant (type: TYPE_A; i: INTEGER)
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
	put_integer_32_constant (i: INTEGER)
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

	put_integer_64_constant (i: INTEGER_64)
			-- Put `i' as INTEGER_64 on IL stack
		do
			method_body.put_opcode_integer_64 ({MD_OPCODES}.Ldc_i8, i)
		end

	put_natural_8_constant,
	put_natural_16_constant,
	put_natural_32_constant (n: NATURAL_32)
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

	put_natural_64_constant (n: NATURAL_64)
			-- Put `n' as NATURAL_64 on IL stack.
		do
			method_body.put_opcode_natural_64 ({MD_OPCODES}.Ldc_i8, n)
		end

	put_real_32_constant (r: REAL)
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_real_32 ({MD_OPCODES}.Ldc_r4, r)
		end

	put_real_64_constant (d: DOUBLE)
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_real_64 ({MD_OPCODES}.Ldc_r8, d)
		end

	put_character_constant (c: CHARACTER)
			-- Put `c' on IL stack.
		do
			method_body.put_opcode_integer ({MD_OPCODES}.Ldc_i4, c.code)
		end

	put_boolean_constant (b: BOOLEAN)
			-- Put `b' on IL stack.
		do
			if b then
				method_body.put_opcode ({MD_OPCODES}.ldc_i4_1)
			else
				method_body.put_opcode ({MD_OPCODES}.ldc_i4_0)
			end
		end

feature -- Labels and branching

	branch_on_true (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Brtrue, label.id)
		end

	branch_on_false (label: IL_LABEL)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Brfalse, label.id)
		end

	branch_to (label: IL_LABEL)
			-- Generate a branch instruction to `label'.
		do
			method_body.put_opcode_label ({MD_OPCODES}.Br, label.id)
		end

	branch_on_condition (comparison: INTEGER_16; label: IL_LABEL)
			-- Generate a branch instruction to `label' if two top-level operands on
			-- IL stack when compared using conditional instruction `comparison' yield True.
		do
			method_body.put_opcode_label (comparison, label.id)
		end

	mark_label (label: IL_LABEL)
			-- Mark a portion of code with `label'.
		do
			method_body.mark_label (label.id)
		end

	create_label: IL_LABEL
			-- Create a new label
		do
			create Result.make (method_body.define_label)
		end

feature -- Switch instruction

	put_switch_start (count: INTEGER)
			-- Generate start of a switch instruction with `count' items.
		do
			method_body.put_opcode_integer ({MD_OPCODES}.switch, count)
			switch_count := count
		end

	put_switch_label (label: IL_LABEL)
			-- Generate a branch to `label' in switch instruction.
		do
			switch_count := switch_count - 1
				-- Labels of switch instruction are calculated relative to instruction end
			method_body.put_label (label.id, - switch_count * 4)
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER; is_unsigned: BOOLEAN)
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_eq then
				method_body.put_opcode ({MD_OPCODES}.Ceq)

			when il_ne then
				method_body.put_opcode ({MD_OPCODES}.Ceq)
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)

			when il_le then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.cgt_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Cgt)
				end
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)

			when il_lt then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.clt_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Clt)
				end

			when il_ge then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.clt_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Clt)
				end
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)

			when il_gt then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.cgt_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Cgt)
				end

			when il_star then
				method_body.put_opcode ({MD_OPCODES}.Mul)

			when il_power then
				method_body.put_static_call (current_module.power_method_token, 2, True)

			when il_plus then
				method_body.put_opcode ({MD_OPCODES}.Add)

			when il_mod then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.rem_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Rem)
				end

			when il_minus then
				method_body.put_opcode ({MD_OPCODES}.Sub)

			when il_div, il_slash then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.div_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Div)
				end

			when il_xor then
				method_body.put_opcode ({MD_OPCODES}.Xor_opcode)

			when il_or then
				method_body.put_opcode ({MD_OPCODES}.Or_opcode)

			when il_and then
				method_body.put_opcode ({MD_OPCODES}.And_opcode)

			when il_shl then
				method_body.put_opcode ({MD_OPCODES}.Shl)

			when il_shr then
				if is_unsigned then
					method_body.put_opcode ({MD_OPCODES}.shr_un)
				else
					method_body.put_opcode ({MD_OPCODES}.Shr)
				end
			end
		end

	generate_real_comparison_routine (a_code: INTEGER; is_real_32: BOOLEAN; a_return_type: TYPE_A)
			-- <Precursor>
		local
			l_routine_name: STRING
			l_return_type: STRING
		do
			inspect a_code
			when il_eq, il_ne then
				if is_real_32 then
					l_routine_name := once "is_equal_real_32"
				else
					l_routine_name := once "is_equal_real_64"
				end

			when il_le then
				if is_real_32 then
					l_routine_name := once "is_less_equal_real_32"
				else
					l_routine_name := once "is_less_equal_real_64"
				end

			when il_lt then
				if is_real_32 then
					l_routine_name := once "is_less_real_32"
				else
					l_routine_name := once "is_less_real_64"
				end

			when il_ge then
				if is_real_32 then
					l_routine_name := once "is_greater_equal_real_32"
				else
					l_routine_name := once "is_greater_equal_real_64"
				end

			when il_gt then
				if is_real_32 then
					l_routine_name := once "is_greater_real_32"
				else
					l_routine_name := once "is_greater_real_64"
				end

			when il_min then
				if is_real_32 then
					l_routine_name := once "min_real_32"
				else
					l_routine_name := once "min_real_64"
				end

			when il_max then
				if is_real_32 then
					l_routine_name := once "max_real_32"
				else
					l_routine_name := once "max_real_64"
				end

			when il_three_way_comparison then
				if is_real_32 then
					l_routine_name := once "three_way_comparison_real_32"
				else
					l_routine_name := once "three_way_comparison_real_64"
				end

			end

			if a_return_type.is_boolean then
				l_return_type := "System.Boolean"
			elseif attached {INTEGER_A} a_return_type as l_type then
				l_return_type := "System.Int"
				l_return_type.append_integer (l_type.size)
			elseif a_return_type.is_real_32 then
				l_return_type := "System.Single"
			elseif a_return_type.is_real_64 then
				l_return_type := "System.Double"
			end

			if is_real_32 then
				internal_generate_external_call (current_module.ise_runtime_token, current_module.ise_runtime_type_token,
					Void, l_routine_name, static_type, <<"System.Single", "System.Single">>, l_return_type, False)
			else
				internal_generate_external_call (current_module.ise_runtime_token, current_module.ise_runtime_type_token,
					Void, l_routine_name, static_type, <<"System.Double", "System.Double">>, l_return_type, False)
			end

			if a_code = il_ne then
				method_body.put_opcode ({MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode ({MD_OPCODES}.Ceq)
			end
		end

feature -- Unary operator generation

	generate_unary_operator (code: INTEGER)
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

	generate_upper_lower (is_upper: BOOLEAN)
			-- Generate upper if `is_upper', lower otherwise on CHARACTER.
		local
			l_rout_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Character_type, current_class_type)
			set_signature_type (l_sig, Character_type, current_class_type)

			if is_upper then
				uni_string.set_string ("ToUpper")
			else
				uni_string.set_string ("ToLower")
			end
			l_rout_token := md_emit.define_member_ref (uni_string,
				current_module.char_type_token, l_sig)

			method_body.put_static_call (l_rout_token, 1, True)
		end

	generate_is_query_on_character (query_name: STRING)
			-- Generate is_`query_name' on CHARACTER returning a boolean.
		local
			l_query_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Boolean_type, current_class_type)
			set_signature_type (l_sig, Character_type, current_class_type)

			uni_string.set_string (query_name)
			l_query_token := md_emit.define_member_ref (uni_string,
				current_module.char_type_token, l_sig)

			method_body.put_static_call (l_query_token, 1, True)
		end

	generate_is_query_on_real (is_real_32: BOOLEAN; query_name: STRING)
			-- Generate static call `query_name' on REAL_32 taking a REAL_32 as argument
			-- if `is_real_32', otherwise using REAL_64, and returning a boolean.
		local
			l_query_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, Boolean_type, current_class_type)
			if is_real_32 then
				set_signature_type (l_sig, Real_32_type, current_class_type)
			else
				set_signature_type (l_sig, Real_64_type, current_class_type)
			end

			uni_string.set_string (query_name)
			if is_real_32 then
				l_query_token := md_emit.define_member_ref (uni_string, current_module.real_32_type_token, l_sig)
			else
				l_query_token := md_emit.define_member_ref (uni_string, current_module.real_64_type_token, l_sig)
			end

			method_body.put_static_call (l_query_token, 1, True)
		end

	generate_math_one_argument (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type): type"
		local
			l_math_token: INTEGER
			l_sig: like method_sig
		do
			create l_sig.make
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, type, current_class_type)
			set_signature_type (l_sig, type, current_class_type)
			uni_string.set_string (a_name)
			l_math_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_static_call (l_math_token, 1, True)
		end

	generate_math_two_arguments (a_name: STRING; type: TYPE_A)
			-- Generate `a_name' feature call on basic types using a Math function where
			-- the signature is "(type, type): type"
		local
			l_math_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type, current_class_type)
			set_signature_type (l_sig, type, current_class_type)
			set_signature_type (l_sig, type, current_class_type)

			uni_string.set_string (a_name)
			l_math_token := md_emit.define_member_ref (uni_string, current_module.math_type_token,
				l_sig)

			method_body.put_static_call (l_math_token, 2, True)
		end

	generate_to_string
			-- Generate call on `ToString'.
		do
			method_body.put_call ({MD_OPCODES}.Callvirt,
				current_module.to_string_method_token, 0, True)
		end

	generate_hash_code
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
			convert_to_integer_32
			put_integer_32_constant (0x7FFFFFFF)
			method_body.put_opcode ({MD_OPCODES}.And_opcode)
		end

	generate_out (type: TYPE_A)
			-- Generate `out' on basic types.
		local
			local_number: INTEGER
		do
				-- Generate `out' representation in IL format
			generate_external_metamorphose (type)
			generate_to_string

				-- Store value
			byte_context.add_local (System_string_type)
			local_number := byte_context.local_list.count
			put_dummy_local_info (System_string_type, local_number)
			generate_local_assignment (local_number)

			put_manifest_string_from_system_string_local (local_number)

			if type.is_pointer or type.is_typed_pointer then
					-- Handling a POINTER type, we need to prepend `0x' to the output.
				duplicate_top
				put_manifest_string ("0x")
				internal_generate_feature_access (string_type_id, string_prepend_feat_id, 1, False, True)
			end
		end

feature -- Line info

	put_line_info (n: INTEGER)
			-- Generate debug information at line `n'.
		local
			l_pos: INTEGER
		do
			if
				is_debug_info_enabled and then
				not stop_breakpoints_generation
			then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (n + pragma_offset, l_pos)
				dbg_start_columns.force (0, l_pos)
				dbg_end_lines.force (n + pragma_offset, l_pos)
				dbg_end_columns.force (1000, l_pos)
				dbg_offsets_count := l_pos + 1

				Il_debug_info_recorder.record_line_info (current_class_type, Byte_context.current_feature, method_body.count, n)
				method_body.put_nop
			end
		end

	put_silent_line_info (n: INTEGER)
			-- Generate debug information at line `n'.
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
			if
				is_debug_info_enabled and then
				not stop_breakpoints_generation
			then
				Il_debug_info_recorder.ignore_next_debug_info
				put_line_info (n)
			end
		end

	put_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		local
			l_pos: INTEGER
		do
			if
				is_debug_info_enabled and then
				not stop_breakpoints_generation
			then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (location.line + pragma_offset, l_pos)
				dbg_start_columns.force (location.column, l_pos)
				dbg_end_lines.force (location.line + pragma_offset, l_pos)
				dbg_end_columns.force (location.final_column, l_pos)
				dbg_offsets_count := l_pos + 1

				Il_debug_info_recorder.record_line_info (current_class_type,
					Byte_context.current_feature, method_body.count, location.line)
				method_body.put_nop
			end
		end

	put_ghost_debug_infos (a_line_n:INTEGER; a_nb: INTEGER)
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal with the not generated debug clauses
			-- but displayed in eStudio during debugging
		do
			if is_debug_info_enabled then
				Il_debug_info_recorder.record_ghost_debug_infos (current_class_type, Byte_context.current_feature, method_body.count, a_line_n, a_nb)
			end
		end

	put_silent_debug_info (location: LOCATION_AS)
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
			-- But in case of dotnet debugger inside eStudio
			-- ignore those 'dummy' nope.
		do
			if
				is_debug_info_enabled and then
				not stop_breakpoints_generation
			then
				Il_debug_info_recorder.ignore_next_debug_info
				put_debug_info (location)
			end
		end

	flush_sequence_points (a_class_type: CLASS_TYPE)
			-- Flush all sequence points.
		local
			l_sequence_point_list: LINKED_LIST [like sequence_point]
			l_document: DBG_DOCUMENT_WRITER
		do
			if is_debug_info_enabled then
				if internal_document /= Void then
					l_document := current_module.dbg_pragma_documents (internal_document)
				else
					l_document := dbg_documents (a_class_type.associated_class.class_id)
				end
				dbg_writer.define_sequence_points (
					l_document,
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
				create dbg_offsets.make_filled (0, 0, 5)
				create dbg_start_lines.make_filled (0, 0, 5)
				create dbg_start_columns.make_filled (0, 0, 5)
				create dbg_end_lines.make_filled (0, 0, 5)
				create dbg_end_columns.make_filled (0, 0, 5)
				dbg_offsets_count := 0
			end
		end

	set_pragma_offset (a_offset: INTEGER)
			-- Set line pragma offset for debug info.
		do
			pragma_offset := a_offset
		ensure then
			pragma_offset_set: pragma_offset = a_offset
		end

	set_default_document
			-- Restore debug document to default.
		do
			internal_document := Void
		ensure then
			internal_document_void: internal_document = Void
		end

	set_stop_breakpoints_generation (a_bool: BOOLEAN)
			-- Should breakpoints not be generated?
		do
			stop_breakpoints_generation := a_bool
		ensure then
			set: stop_breakpoints_generation = a_bool
		end

	set_document (a_doc: STRING)
			-- Set debug document to `a_doc'.
		do
			internal_document := a_doc
		ensure then
			internal_document_set: internal_document = a_doc
		end

	internal_document: STRING
			-- Document used to generate debug info as stated by pragma declaration if any

	pragma_offset: INTEGER
			-- Offset in document used for debug info as stated by pragma declaration

	stop_breakpoints_generation: BOOLEAN
			-- Should breakpoints not be generated?

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation

feature -- Convenience

	generate_call_on_void_target_exception
			-- Generate call on void target exception.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				runtime_class_name,
				"generate_call_on_void_target_exception",
				static_type, <<>>, Void, False)
		end

feature -- Generic conformance

	generate_class_type_instance (cl_type: CL_TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		local
			l_rt_type_id: INTEGER
			l_cl_type_id: INTEGER
		do
			if cl_type.is_basic then
				l_rt_type_id := basic_type_id
				l_cl_type_id := cl_type.external_id (current_class_type.type)
			else
				l_rt_type_id := class_type_id
				l_cl_type_id := cl_type.implementation_id (current_class_type.type)
			end
			create_object (l_rt_type_id)
			duplicate_top
			put_type_token (l_cl_type_id)
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				class_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_generic_type_instance (n: INTEGER)
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		do
			create_object (generic_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_tuple_type_instance (n: INTEGER)
			-- Generate a RT_TUPLE_TYPE instance corresponding that will hold `n' items.
		do
			create_object (tuple_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_generic_type_settings (gen_type: TYPE_A)
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		do
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_generics", Normal_type, <<type_array_class_name>>, Void, True);

			duplicate_top
			put_type_token (gen_type.implementation_id (current_class_type.type))
			internal_generate_external_call (current_module.ise_runtime_token, 0,
				generic_type_class_name,
				"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_none_type_instance
			-- Generate a NONE_TYPE instance.
		do
			create_object (none_type_id)
		end

	generate_generating_type_instance (a_gen_type: TYPE_A)
			-- Generate an instance of the generic type `a_gen_type' where the type
			-- of the actual generic parameter is the type of the object on top
			-- of the stack.
			-- Useful to generate {ANY}.generating_type.
		local
			l_obj_var: INTEGER
		do
				-- First we store the top to a local variable.
			byte_context.add_local (any_type)
			l_obj_var := Byte_context.local_list.count
			put_dummy_local_info (any_type, l_obj_var)
			generate_local_assignment (l_obj_var)

				-- Create the RT_GENERIC_TYPE instance
			create_object (generic_type_id)
			duplicate_top
			put_integer_32_constant (1)
			generate_array_creation (runtime_type_id)
				-- Write the type of current object to the type array at position `0'.
			duplicate_top
			put_integer_32_constant (0)
			generate_local (l_obj_var)
			load_type
			generate_array_write ({IL_CONST}.il_ref, 0)

				-- Now set the RT_GENERIC_TYPE instance with the proper details
			generate_generic_type_settings (a_gen_type)

				-- Create the `gen_type' instance.
			create_generic_object (a_gen_type.implementation_id (current_class_type.type))
		end

feature {NONE} -- Implementation: generation

	generate_type_feature (a_type_feature: TYPE_FEATURE_I)
			-- Generate type description for `a_type_feature'.
		require
			a_type_feature_not_void: a_type_feature /= Void
		local
			l_cl_type: CL_TYPE_A
			l_gen_type: GEN_TYPE_A
			l_tuple_type: TUPLE_TYPE_A
			l_formal_type: FORMAL_A
			l_type_i: TYPE_A
			l_org_type_i: TYPE_A
			l_type_id, i, nb: INTEGER
		do
			l_type_i := a_type_feature.type

				-- We are now evaluation `l_type_i' in the context of current CLASS_TYPE
				-- generation.
			check
					-- If we have some formals, we are clearly in a generic class.
				is_generic_type: l_type_i.has_formal_generic implies current_class_type.is_generic
			end
			l_org_type_i := l_type_i
			l_type_i := l_type_i.adapted_in (current_class_type)
			if l_org_type_i.is_formal and then l_type_i.has_formal_generic then
					-- The case similar to "A [expanded B [G#1, G#2]]".
					-- Because no features are generated to resolve G#1 and G#2,
					-- the type is set to be a formal generic like for "A [G]"
				debug ("fixme")
					fixme ("Support the case of A [expanded B [G#1, G#2]]")
				end
				l_type_i := l_org_type_i
			end

			if attached {FORMAL_A} l_type_i as f then
				l_formal_type := f
				l_type_id := formal_type_id
			elseif l_type_i.is_none then
				l_type_id := none_type_id
			elseif attached {CL_TYPE_A} l_type_i as c then
				l_cl_type := c
				if l_cl_type.is_basic then
					l_type_id := basic_type_id
				elseif attached {GEN_TYPE_A} l_cl_type as g then
					l_gen_type := g
					if attached {TUPLE_TYPE_A} l_gen_type as t then
						l_tuple_type := t
						l_type_id := tuple_type_id
					else
						l_type_id := generic_type_id
					end
				else
					l_type_id := class_type_id
				end
			end

			start_new_body (feature_token (current_type_id, a_type_feature.feature_id))

				-- Set position of `result' local variable. Does not make sense to
				-- call `put_result_info' as we don't know its associated CL_TYPE_A.
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
				put_type_token (l_cl_type.implementation_id (current_class_type.type))
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					class_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			elseif l_type_id = basic_type_id then
				duplicate_top
					-- Make sure to use `external_id' like in `generate_class_type_instance'
					-- otherwise eweasel test#exec223 would fail.
				put_type_token (l_cl_type.external_id (current_class_type.type))
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					basic_type_class_name,
					"set_type", Normal_type, <<type_handle_class_name>>, Void, True)
			else
				duplicate_top

				put_integer_32_constant (l_gen_type.generics.count)
				generate_array_creation (runtime_type_id)

				from
					i := l_gen_type.generics.lower
					check
						i_start_at_one: i = 1
					end
					nb := l_gen_type.generics.upper
				until
					i > nb
				loop
					duplicate_top
					put_integer_32_constant (i - 1)
					l_gen_type.generics.i_th (i).generate_gen_type_il (Current, True)
					generate_array_write ({IL_CONST}.il_ref, 0)
					i := i + 1
				end

				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_generics", normal_type, <<type_array_class_name>>, Void, True)
				duplicate_top
				put_type_token (l_gen_type.implementation_id (current_class_type.type))
				internal_generate_external_call (current_module.ise_runtime_token, 0,
					generic_type_class_name,
					"set_type", normal_type, <<type_handle_class_name>>, Void, True)
			end
			generate_return (True)
			method_writer.write_current_body
		end

feature {CIL_CODE_GENERATOR} -- Implementation: convenience

	System_string_type: TYPE_A
			-- Type of string object
		once
			Result := System.system_string_class.compiled_class.types.first.type
		end

	System_object_type: TYPE_A
			-- Type of Object object
		once
			Result := System.system_object_class.compiled_class.types.first.type
		end

	string_type: TYPE_A
			-- Type of string object
		once
			Result := System.string_8_class.compiled_class.types.first.type
		end

	string_implementation_id: INTEGER
			-- Type ID of string implementation.
		once
			Result := string_type.implementation_id (Void)
		end

	string_type_id: INTEGER
			-- Type of string interface.
		once
			Result := string_type.static_type_id (Void)
		end

	string_prepend_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_8_class.compiled_class.
				feature_table.item ("prepend").feature_id
		ensure
			string_prepend_feat_id_positive: Result > 0
		end

	string_make_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_8_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		ensure
			string_make_feat_id_positive: Result > 0
		end

	string_32_type: TYPE_A
			-- Type of string object
		once
			Result := System.string_32_class.compiled_class.types.first.type
		end

	string_32_implementation_id: INTEGER
			-- Type ID of string implementation.
		once
			Result := string_32_type.implementation_id (Void)
		end

	string_32_type_id: INTEGER
			-- Type of string interface.
		once
			Result := string_32_type.static_type_id (Void)
		end

	string_32_prepend_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_32_class.compiled_class.
				feature_table.item ("prepend").feature_id
		ensure
			string_32_prepend_feat_id_positive: Result > 0
		end

	string_32_make_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.string_32_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		ensure
			string_32_make_feat_id_positive: Result > 0
		end

	immutable_string_8_type: TYPE_A
			-- Type of IMMUTABLE_STRING_8 object
		once
			Result := System.immutable_string_8_class.compiled_class.types.first.type
		end

	immutable_string_8_implementation_id: INTEGER
			-- Type ID of IMMUTABLE_STRING_8 implementation.
		once
			Result := immutable_string_8_type.implementation_id (Void)
		end

	immutable_string_8_type_id: INTEGER
			-- Type of IMMUTABLE_STRING_8 interface.
		once
			Result := immutable_string_8_type.static_type_id (Void)
		end

	immutable_string_8_make_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.immutable_string_8_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		ensure
			immutable_string_8_make_feat_id_positive: Result > 0
		end

	immutable_string_32_type: TYPE_A
			-- Type of IMMUTABLE_STRING_32 object
		once
			Result := System.immutable_string_32_class.compiled_class.types.first.type
		end

	immutable_string_32_implementation_id: INTEGER
			-- Type ID of IMMUTABLE_STRING_32 implementation.
		once
			Result := immutable_string_32_type.implementation_id (Void)
		end

	immutable_string_32_type_id: INTEGER
			-- Type of IMMUTABLE_STRING_32 interface.
		once
			Result := immutable_string_32_type.static_type_id (Void)
		end

	immutable_string_32_make_feat_id: INTEGER
			-- Feature ID of `make_from_cil' of STRING.
		once
			Result := System.immutable_string_32_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.make_from_cil_name_id).feature_id
		ensure
			immutable_string_32_make_feat_id_positive: Result > 0
		end

	any_type: CL_TYPE_A
			-- Type of ANY
		once
			Result := system.any_class.compiled_class.actual_type
		end

	any_type_id: INTEGER
			-- Type of ANY interface.
		once
			Result := any_type.static_type_id (Void)
		end

	is_equal_feat_id: INTEGER
			-- Feature ID of `is_equal' of ANY.
		once
			Result := System.any_class.compiled_class.feature_with_rout_id (is_equal_rout_id).feature_id
		ensure
			is_equal_feat_id_positive: Result > 0
		end

	is_equal_rout_id: INTEGER
			-- Routine ID of `is_equal' of ANY.
		once
			Result := System.any_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.is_equal_name_id).rout_id_set.first
		ensure
			is_equal_rout_id_positive: Result > 0
		end

	copy_feat_id: INTEGER
			-- Feature ID of `copy' of ANY.
		once
			Result := System.any_class.compiled_class.feature_with_rout_id (copy_rout_id).feature_id
		ensure
			copy_feat_id_positive: Result > 0
		end

	copy_rout_id: INTEGER
			-- Routine ID of `copy' of ANY.
		once
			Result := System.any_class.compiled_class.
				feature_table.item_id ({PREDEFINED_NAMES}.copy_name_id).rout_id_set.first
		ensure
			copy_rout_id_positive: Result > 0
		end

	equals_rout_id: INTEGER
			-- Routine ID of `equals' of SYSTEM_OBJECT.
		local
			c: CLASS_C
			f: FEATURE_I
		once
			c := System.system_object_class.compiled_class
			if c.feature_table.has_overloaded ({PREDEFINED_NAMES}.equals_name_id) then
				across
					c.feature_table.overloaded_items ({PREDEFINED_NAMES}.equals_name_id) as l
				from
					l.start
					f := l.item
					l.forth
				until
						-- "public virtual bool Equals (System.Object)"
					not f.is_class and then
					f.argument_count = 1 and then
					f.arguments.first.same_as (c.actual_type)
				loop
					f := l.item
				end
			else
				f := c.feature_table.item_id ({PREDEFINED_NAMES}.equals_name_id)
			end
			if f /= Void then
				Result := f.rout_id_set.first
			else
				check has_equals_rout_id: False then
					-- Raise an exception, as "equals" is required.
				end
			end
		ensure
			equals_rout_id_positive: Result > 0
		end

	finalize_rout_id: INTEGER
			-- Routine ID of `finalize' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
		ensure
			finalize_rout_id_positive: Result > 0
		end

	get_hash_code_rout_id: INTEGER
			-- Routine ID of `get_hash_code' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.get_hash_code_name_id).rout_id_set.first
		ensure
			get_hash_code_rout_id_positive: Result > 0
		end

	to_string_rout_id: INTEGER
			-- Routine ID of `to_string' of SYSTEM_OBJECT.
		once
			Result := System.system_object_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.to_string_name_id).rout_id_set.first
		ensure
			to_string_rout_id_positive: Result > 0
		end

	out_feat_id: INTEGER
			-- Feature ID of `out' of ANY.
		once
			Result := system.any_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.out_name_id).feature_id
		ensure
			out_feat_id_positive: Result > 0
		end

	to_cil_feat: TUPLE [static_type_id: INTEGER; feature_id: INTEGER]
			-- Feature ID of `to_cil' of STRING.
		local
			l_class: CLASS_C
		once
			l_class := system.string_8_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.to_cil_name_id).written_class

			Result := [l_class.types.first.static_type_id,
				l_class.feature_table.item_id ({PREDEFINED_NAMES}.to_cil_name_id).feature_id]
		ensure
			to_cil_feat_valid: Result /= Void and then (Result.static_type_id > 0 and
				Result.feature_id > 0)
		end

	hashable_class_id: INTEGER
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

	hashable_type: CL_TYPE_A
			-- Type `HASHABLE', Void otherwise.
		once
			if hashable_class_id > 0 then
				create Result.make (hashable_class_id)
			end
		end

	hash_code_rout_id: INTEGER
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

	hash_code_feat_id: INTEGER
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

	define_custom_attribute (token: INTEGER; ctor_token: INTEGER; data: MD_CUSTOM_ATTRIBUTE)
			-- Define a custom attribute on `token' using constructor `ctor_token' with
			-- arguments `data'.
			-- Same as `md_emit.define_custom_attribute' but we do not care about return type.
		do
			md_emit.define_custom_attribute (token, ctor_token, data).do_nothing
		end

feature {NONE} -- Once per type definition

	current_class_token: INTEGER
			-- Token of current class being generated.

feature -- Once per feature definition

	result_position: INTEGER
			-- Position of `Result' local variable.

feature -- Mapping between Eiffel compiler and generated tokens

	is_using_multi_assemblies: BOOLEAN
			-- Use multi-assemblies instead of multi-modules for workbench compilation.

	il_module_file_name (a_id: INTEGER): STRING
		do
			if is_using_multi_assemblies then
				Result := "assembly_"
				if a_id < 10 then
					Result.append_character ('0')
				end
			else
				Result := "module_"
			end
			Result.append (a_id.out)
			Result.append (".dll")
		end

	il_module_for_class (a_class: CLASS_C): IL_MODULE
			-- Perform lookup for module associated with `a_class'. If not
			-- found then create a module used for reference only.
		require
			a_class_not_void: a_class /= Void
		local
			l_type_id: INTEGER
			l_module_name: STRING
		do
			if is_single_module then
				l_type_id := 1
			else
				l_type_id := a_class.class_id // System.msil_classes_per_module + 1
			end
			Result := internal_il_modules.item (l_type_id)
			if Result = Void then
				l_module_name := il_module_file_name (l_type_id)
				create Result.make (
					l_module_name,
					location_path.extended (l_module_name).name,
					c_module_name,
					Void,
					Current,
					Void,
					l_type_id,
					is_debug_info_enabled,
					False,
					is_using_multi_assemblies)
				internal_il_modules.put (Result, l_type_id)
			end
		ensure
			module_not_void: Result /= Void
		end

	il_module (a_class_type: CLASS_TYPE): IL_MODULE
			-- Perform lookup for module associated with `a_class_type'. If not
			-- found then create a module used for reference only.
		require
			a_class_type_not_void: a_class_type /= Void
		do
			Result := il_module_for_class (a_class_type.associated_class)
		ensure
			module_not_void: Result /= Void
		end

	internal_il_modules: ARRAY [detachable IL_MODULE]
			-- Array of IL_MODULE indexed by CLASS_TYPE.packet_number

	external_class_mapping: HASH_TABLE [CL_TYPE_A, STRING]
			-- Quickly find a type given its external name.

	constructor_token (a_type_id: INTEGER): INTEGER
			-- Token identifier for default constructor of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.constructor_token (a_type_id)
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
			Result := current_module.inherited_constructor_token (a_type_id, a_feature_id)
		ensure
			feature_token_valid: Result /= 0
		end

	actual_class_type_token (a_type_id: INTEGER): INTEGER
			-- Given `a_type_id' returns its associated metadata token.
		require
			valid_type_id: a_type_id > 0
		do
			Result := current_module.actual_class_type_token (a_type_id)
		ensure
			class_token_valid: Result /= 0
		end

	mapped_class_type_token (a_type_id: INTEGER): INTEGER
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

	invariant_token (a_type_id: INTEGER): INTEGER
			-- Metadata token of invariant feature in class type `a_type_id'.
		require
			type_id_valid: a_type_id > 0
		do
			Result := current_module.invariant_token (a_type_id)
		ensure
			invariant_token_valid: Result /= 0
		end

	class_types: ARRAY [CLASS_TYPE]
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
		do
			Result := internal_class_types
			if Result = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					i := System.class_types.lower
					nb := System.class_types.upper
					create Result.make_filled (Void, 0, System.static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := System.class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
						Result.put (l_class_type, l_class_type.external_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
		ensure
			class_types_not_void: Result /= Void
			class_types_not_empty: Result.count > 0
		end

	feature_token (a_type_id, a_feature_id: INTEGER): INTEGER
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

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER
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

	signature (a_type_id, a_feature_id: INTEGER): TUPLE [class_type: CLASS_TYPE; routine_id: INTEGER]
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.signature (a_type_id, a_feature_id)
		ensure
			result_not_void: Result /= Void
		end

	implementation_signature (a_type_id, a_feature_id: INTEGER): like signature
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := current_module.implementation_signature (a_type_id, a_feature_id)
		ensure
			result_not_void: Result /= Void
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER
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

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER
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
			offset_count: 	INTEGER;			-- Offset count
			offsets:		ARRAY [INTEGER];	-- Offsets
			start_lines:	ARRAY [INTEGER];	-- Start lines
			start_columns:	ARRAY [INTEGER];	-- Start columns
			end_lines:		ARRAY [INTEGER];	-- End lines
			end_columns:	ARRAY [INTEGER];	-- End columns
			written_class_id:	INTEGER			-- Written in class ID
				]

			-- For type definition purpose.
		do
		end

	local_debug_info: TUPLE [INTEGER, INTEGER, INTEGER, like local_types]
			-- For type definition purpose.
		do
		end

	dbg_documents (a_class_id: INTEGER): DBG_DOCUMENT_WRITER
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

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_setter (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_implementation_feature (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_attribute (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_implementation_signature (a_signature: like signature; a_type_id, a_feature_id: INTEGER)

			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_implementation_signature (a_signature, a_type_id, a_feature_id)
		ensure
			inserted: implementation_signature (a_type_id, a_feature_id).is_equal (a_signature)
		end

	insert_signature (a_signature: like signature; a_type_id, a_feature_id: INTEGER)
			-- Insert `a_token' of `a_feature_id' in `a_type_id'.
		require
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			current_module.insert_signature (a_signature, a_type_id, a_feature_id)
		ensure
			inserted: signature (a_type_id, a_feature_id).is_equal (a_signature)
		end

feature {NONE} -- Implementation: Helpers

	same_signature (a_feat, a_other_feat: FEATURE_I; a_type, a_other_type: CLASS_TYPE): BOOLEAN
			-- Special treatement to know whether or not `a_other_feat' in `a_other_type' has the same signature
			-- as `a_feat' defined in `a_type'.
		require
			a_parent_feat_not_void: a_feat /= Void
			a_other_feat_not_void: a_other_feat /= Void
			a_type_not_void: a_type /= Void
			a_other_type_not_void: a_other_type /= Void
			compatible: a_feat.argument_count = a_other_feat.argument_count
		local
			i, nb: INTEGER_32
			l_type, l_other_type: TYPE_A
		do
				-- In this routine and wherever else we do a signature comparison to know whether or not
				-- a cast needs to be generated we use `is_safe_equivalent'. However as shown in eweasel
				-- test#incr078 sometime two types are not equivalent even if they are. The issue arises
				-- with an expanded class TEST2 which is used as `TEST2' and `expanded TEST2'. Because
				-- of the useless extra `expanded' mark the types are not equivalent. Currently, we avoid
				-- the problem by only doing the cast if the type is not expanded.
			l_type := result_type_in (a_feat, a_type).adapted_in (a_type)
			l_other_type := result_type_in (a_other_feat, a_other_type).adapted_in (a_other_type)
			Result := l_type.is_safe_equivalent (l_other_type)
			if Result then
				from
					nb := a_feat.argument_count
					i := 1
				until
					i > nb
				loop
					l_type := argument_actual_type_in (a_feat.arguments.i_th (i), a_type).adapted_in (a_type)
					l_other_type := argument_actual_type_in (a_other_feat.arguments.i_th (i), a_other_type).adapted_in (a_other_type)
					if not l_type.is_safe_equivalent (l_other_type) then
						Result := False
							-- Jump out of loop
						i := nb
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation: name mangling

	escape_type_name (n: STRING): STRING
			-- Escape type name `n' so that it can be used as a custom attribute value for Type argument.
		require
			n_attached: n /= Void
			n_not_empty: not n.is_empty
		local
			i: INTEGER
		do
			Result := n
			i := Result.count
			if Result.item (i) = '&' then
				from
				until
					i = 0 or else not (once "&[]").has (Result.item (i))
				loop
						-- Escape the character.
					Result.insert_character ('\', i)
					i := i - 1
				end
			end
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
		end

feature {NONE} -- Storage

	properties: LIST [INTEGER]
			-- Feature id's of features that have associated properties
			-- (valid for the current class only)
		once
			create {ARRAYED_LIST [INTEGER]} Result.make (0)
		ensure
			result_attached: Result /= Void
		end

	postponed_property_setters: LIST [PAIR [INTEGER, INTEGER]]
			-- Feature id's of features that have associated property setters
			-- that are not generated yet
		once
			create {ARRAYED_LIST [PAIR [INTEGER, INTEGER]]} Result.make (0)
		ensure
			result_attached: Result /= Void
		end

feature -- Inline agents

	generate_il_inline_agents (eif_cl: EIFFEL_CLASS_C; inline_agent_processor: PROCEDURE [FEATURE_I])

			-- Generate IL code for inline agents in `eif_cl'
		require
			eif_cl_not_void: eif_cl /= Void
			inline_agent_processor_attached: inline_agent_processor /= Void
		do
			if eif_cl.has_inline_agents then
					-- Generate.
				across
					eif_cl.inline_agent_table as a
				loop
					inline_agent_processor (a.item)
				end
			end
		end

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very long class",
		"CA093", "CA093: manifest array type mismatch"
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
