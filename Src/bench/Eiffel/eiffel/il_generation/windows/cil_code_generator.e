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
			internal_duplicate_rout_id := System.any_class.compiled_class.feature_table.item_id (
				feature {PREDEFINED_NAMES}.Internal_duplicate_name_id).rout_id_set.first
			internal_finalize_rout_id := System.any_class.compiled_class.feature_table.item_id (
				feature {PREDEFINED_NAMES}.finalize_name_id).rout_id_set.first
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

feature {IL_CODE_GENERATOR} -- Access

	md_emit: MD_EMIT
			-- Metadata emitter.

	md_dispenser: MD_DISPENSER
			-- Object used to generate Metadata.

	method_writer: MD_METHOD_WRITER
			-- To store method bodys.

	method_body: MD_METHOD_BODY
			-- Body for currently generated routine.

	done_sig: MD_FIELD_SIGNATURE
			-- Precomputed signature of `done_token' so that we do not have
			-- to compute it too often.

	default_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a feature with no arguments and no return type.
			-- Used to define default constructors and other features with same signature.

	method_sig: MD_METHOD_SIGNATURE
			-- Permanent signature for features.

	field_sig: MD_FIELD_SIGNATURE
			-- Permanent signature for attributes.

	local_sig: MD_LOCAL_SIGNATURE
			-- Permanent signature for locals.
	
	local_start_offset, local_end_offset, local_count: INTEGER
			-- Number of locals for current feature.

	local_types: ARRAYED_LIST [PAIR [TYPE_I, STRING]]
			-- To store types of local variables.

	uni_string: UNI_STRING
			-- Buffer for all unicode string conversion.

	one_element_array: ARRAY [INTEGER]
			-- Array with one element.
			
	main_module_token: INTEGER
			-- ID of module being generated.

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
			
	any_type_id: INTEGER
			-- Type id of ANY class.

	c_module_name: UNI_STRING
			-- Name of C generated module containing all C externals.

feature {NONE} -- Debug info

	dbg_writer: DBG_WRITER
			-- PDB writer.

	dbg_offsets,
	dbg_start_lines,
	dbg_start_columns,
	dbg_end_lines,
	dbg_end_columns: ARRAY [INTEGER]
			-- Data holding debug information for current feature.

	dbg_offsets_count: INTEGER
			-- Number of meaningful elements in above arrays.

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
		local
			ass: MD_ASSEMBLY_INFO
		do
			create output_file_name.make_from_string (location)
			output_file_name.set_file_name (a_file_name)

				-- Create unicode string buffer.
			create uni_string.make_empty (1024)

				-- Initialize COM.
			(create {CLI_COM}).initialize_com
		
				-- Initialize metadata emitter.
			create md_dispenser.make
			md_emit := md_dispenser.emitter

			create method_writer.make
	
				-- Create signature for `done' in once computation.		
			create done_sig.make
			done_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			
				-- Create permanent signature for feature.
			create method_sig.make
			create field_sig.make
			create local_sig.make
			create local_types.make (5)

			create one_element_array.make (0, 1)

				-- Name of `dll' containing all C externals.
			create c_module_name.make ("lib" + assembly_name + ".dll")

			entry_point_token := 0
			last_override_token := 0
			create override_counter

			remap_external_token
			create ass.make
			uni_string.set_string (assembly_name)
			main_module_token := md_emit.define_assembly (uni_string, 0, ass)
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			check
				not_yet_implemented: False
			end
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
			-- In debug mode if `debug_mode' is true.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			is_debug_info_enabled := debug_mode

			if is_debug_info_enabled then
					-- Create PDB writer
				uni_string.set_string (output_file_name)
				create dbg_writer.make (md_emit, uni_string, True)
			end
			
			uni_string.set_string (name)
			md_emit.set_module_name (uni_string)
		end

	define_entry_point (creation_type_id, a_type_id: INTEGER; a_feature_id: INTEGER) is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_type_id'.
		require
			positive_creation_type_id: creation_type_id > 0
			positive_type_id: a_type_id > 0
			positive_feature_id: a_feature_id > 0
		local
			entry_type_token: INTEGER
			l_meth_token: INTEGER
			l_sig: like method_sig
		do
			entry_type_token := md_emit.define_type (
				create {UNI_STRING}.make ("MAIN"), feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
					feature {MD_TYPE_ATTRIBUTES}.Auto_layout | feature {MD_TYPE_ATTRIBUTES}.public,
				object_type_token, Void)
				
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			
			entry_point_token := md_emit.define_method (create {UNI_STRING}.make ("Main"),
				entry_type_token, feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Static, l_sig,
				feature {MD_METHOD_ATTRIBUTES}.Managed)
			
				-- Let's retrieve token associated to creation routine.
			l_meth_token := implementation_feature_token (a_type_id, a_feature_id)

			if is_debug_info_enabled then
				define_custom_attribute (entry_point_token, debugger_step_through_ctor_token,
					debugger_step_through_ca)
				define_custom_attribute (entry_point_token, debugger_hidden_ctor_token,
					debugger_hidden_ca)
				dbg_writer.set_user_entry_point (l_meth_token)
			end

			start_new_body (entry_point_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj,
				constructor_token.item (creation_type_id), 0, True)
			method_body.put_call (feature {MD_OPCODES}.Call,
				implementation_feature_token (a_type_id, a_feature_id), 0, False)
			method_body.put_opcode (feature {MD_OPCODES}.Ret)
			
			method_writer.write_current_body
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		do
			-- Do nothing
		end

	end_module_generation is
			-- Finish creation of current module.
		local
			l_pe_file: CLI_PE_FILE
			l_debug_info: MANAGED_POINTER
			l_dbg_directory: CLI_DEBUG_DIRECTORY
		do
			create l_pe_file.make (output_file_name, is_dll or else is_console_application, is_dll)
			if is_debug_info_enabled then
				create l_dbg_directory.make
				l_debug_info := dbg_writer.debug_info (l_dbg_directory)
				l_pe_file.set_debug_information (l_dbg_directory, l_debug_info)
				dbg_writer.close
			end
			l_pe_file.set_emitter (md_emit)
			l_pe_file.set_method_writer (method_writer)
			if entry_point_token /= 0 then
				l_pe_file.set_entry_point_token (entry_point_token)
			end
			l_pe_file.save	
		end

feature -- Generation type

	set_console_application is
			-- Current generated application is a CONSOLE application.
		do
			is_console_application := True
		end

	set_window_application is
			-- Current generated application is a WINDOW application.
		do
			is_console_application := False
		end

	set_dll is
			-- Current generated application is a DLL.
		do
			is_dll := True
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

	start_class_mappings (class_count: INTEGER) is
			-- Following calls to current will only be `generate_class_mappings'.
		do
			create class_mapping.make (0, class_count)
			create external_class_mapping.make (class_count)
			create external_token_mapping.make (class_count)
			create constructor_token.make (0, class_count)
			create internal_assemblies.make (0, class_count)
			create defined_assemblies.make (10)
			create internal_features.make (0, class_count)
			create internal_setters.make (0, class_count)
			create internal_attributes.make (0, class_count)
			create internal_implementation_features.make (0, class_count)
			create signatures_table.make (0, class_count)
			create implementation_signatures_table.make (0, class_count)

				-- Debug data structure.
			create dbg_documents.make (0, class_count)
			create method_sequence_points.make (1000)
			create local_info.make (1000)
		end

	clean_implementation_class_data is
			-- Clean current class implementation data.
		require
			current_type_id_set: current_type_id > 0
		do
			internal_features.put (Void, current_type_id)
		end

	generate_type_class_mappings is
			-- Create correspondance between `runtime_type_id' and ISE.Runtime.TYPE.
		require
			runtime_type_id_set: runtime_type_id > 0
		local
			l_sig: like method_sig
			l_meth_token: INTEGER
		do
			class_mapping.put (ise_type_token, runtime_type_id)
			class_mapping.put (ise_class_type_token, class_type_id)
			class_mapping.put (ise_basic_type_token, basic_type_id)
			class_mapping.put (ise_generic_type_token, generic_type_id)
			class_mapping.put (ise_formal_type_token, formal_type_id)
			class_mapping.put (ise_none_type_token, none_type_id)
			class_mapping.put (ise_eiffel_type_info_type_token, eiffel_type_info_type_id)
			class_mapping.put (ise_generic_conformance_token, generic_conformance_type_id)
			
			external_token_mapping.put (ise_type_token, Type_class_name)
			external_token_mapping.put (ise_class_type_token, Class_type_class_name)
			external_token_mapping.put (ise_basic_type_token, Basic_type_class_name)
			external_token_mapping.put (ise_generic_type_token, Generic_type_class_name)
			external_token_mapping.put (ise_formal_type_token, Formal_type_class_name)
			external_token_mapping.put (ise_none_type_token, None_type_class_name)
			external_token_mapping.put (ise_eiffel_type_info_type_token, Type_info_class_name)
			external_token_mapping.put (ise_generic_conformance_token,
				Generic_conformance_class_name)

			l_sig := default_sig
			uni_string.set_string (".ctor")

			l_meth_token := md_emit.define_member_ref (uni_string, ise_type_token, l_sig)
			constructor_token.put (l_meth_token, runtime_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_class_type_token, l_sig)
			constructor_token.put (l_meth_token, class_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_basic_type_token, l_sig)
			constructor_token.put (l_meth_token, basic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_generic_type_token, l_sig)
			constructor_token.put (l_meth_token, generic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_formal_type_token, l_sig)
			constructor_token.put (l_meth_token, formal_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_none_type_token, l_sig)
			constructor_token.put (l_meth_token, none_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string,
				ise_eiffel_type_info_type_token, l_sig)
			constructor_token.put (l_meth_token, eiffel_type_info_type_id)
		ensure
			inserted: class_mapping.item (runtime_type_id) = ise_type_token and
				class_mapping.item (class_type_id) = ise_class_type_token and
				class_mapping.item (basic_type_id) = ise_basic_type_token and
				class_mapping.item (generic_type_id) = ise_generic_type_token and
				class_mapping.item (formal_type_id) = ise_formal_type_token and
				class_mapping.item (none_type_id) = ise_none_type_token and
				class_mapping.item (eiffel_type_info_type_id) = ise_eiffel_type_info_type_token
		end

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Define all types, both external and eiffel one.
		require
			class_type_not_void: class_type /= Void
		local
			name, impl_name: STRING
			native_array: NATIVE_ARRAY_CLASS_TYPE
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_type: CL_TYPE_I
		do
			class_c := class_type.associated_class
			update_parents (class_type, class_c)

			native_array ?= class_type
			if native_array /= Void then
					-- Generate association with a NATIVE_ARRAY []
				uni_string.set_string (native_array.il_type_name)
				l_type_token := md_emit.define_type_ref (uni_string, assembly_token (class_c))
				class_mapping.put (l_type_token, class_type.static_type_id)
				external_class_mapping.put (class_type.type, native_array.il_type_name)
				external_token_mapping.put (l_type_token, native_array.il_type_name)
			else
				name := class_type.full_il_type_name
				if not class_c.is_external then
					impl_name := class_type.full_il_implementation_type_name
				end

				if class_c.is_external then
					uni_string.set_string (name)
					l_type_token := md_emit.define_type_ref (uni_string, assembly_token (class_c))
					class_mapping.put (l_type_token, class_type.static_type_id)

						-- Fix `class_type.type' as it only contains a valid
						-- class id, nothing else.
					l_type := class_type.type
					if l_type.base_class.is_basic then
						l_type := l_type.base_class.actual_type.type_i
					elseif l_type.base_class.is_expanded then
						l_type := clone (l_type)
						l_type.set_is_true_expanded (True)
					end
					external_class_mapping.put (l_type, name)
					external_token_mapping.put (l_type_token, name)
				else
						-- Let's define interface class.
					uni_string.set_string (name)
					l_attributes := feature {MD_TYPE_ATTRIBUTES}.Public |
						feature {MD_TYPE_ATTRIBUTES}.Auto_layout |
						feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
						feature {MD_TYPE_ATTRIBUTES}.Is_interface |
						feature {MD_TYPE_ATTRIBUTES}.Abstract
					if class_type.static_type_id = any_type_id then
							-- By default interface of ANY does not implement any other interfaces
							-- than EIFFEL_TYPE_INFO.
						l_type_token := md_emit.define_type (uni_string, l_attributes, 0,
							<< ise_eiffel_type_info_type_token >>)
					else
						l_type_token := md_emit.define_type (uni_string, l_attributes, 0,
							last_parents)
					end
					class_mapping.put (l_type_token, class_type.static_type_id)
					external_class_mapping.put (class_type.type, name)
					external_token_mapping.put (l_type_token, name)
					
						-- Let's define implementation class.
					l_attributes := feature {MD_TYPE_ATTRIBUTES}.Public |
						feature {MD_TYPE_ATTRIBUTES}.Auto_layout |
						feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
						feature {MD_TYPE_ATTRIBUTES}.Is_class

					if is_debug_info_enabled and dbg_documents.item (class_c.class_id) = Void then
						uni_string.set_string (class_c.file_name)
						dbg_documents.put (dbg_writer.define_document (uni_string, language_guid,
							vendor_guid, document_type_guid), class_c.class_id)
					end

					uni_string.set_string (impl_name)
					if class_c.is_deferred then
						l_attributes := l_attributes | feature {MD_TYPE_ATTRIBUTES}.Abstract
					end
					if class_c.is_frozen then
						l_attributes := l_attributes | feature {MD_TYPE_ATTRIBUTES}.Sealed
					end
					one_element_array.put (class_mapping.item (class_type.static_type_id), 0)
					l_type_token := md_emit.define_type (uni_string, l_attributes,
						object_type_token, one_element_array)
					class_mapping.put (l_type_token, class_type.implementation_id)
					external_class_mapping.put (class_type.type, impl_name)
					external_token_mapping.put (l_type_token, impl_name)
				end
			end
		end

	define_default_constructor (class_type: CLASS_TYPE) is
			-- Define default constructor for implementation of `class_type'
		require
			class_type_not_void: class_type /= Void
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := default_sig
			
			uni_string.set_string (".ctor")
			l_meth_token := md_emit.define_method (uni_string,
				class_mapping.item (class_type.implementation_id),
				feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Special_name |
				feature {MD_METHOD_ATTRIBUTES}.Rt_special_name,
				l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)
				
			start_new_body (l_meth_token)
			generate_current
			method_body.put_call (feature {MD_OPCODES}.Call, object_ctor_token, 0, False)
			generate_return
			method_writer.write_current_body
			
			constructor_token.put (l_meth_token, class_type.implementation_id)
		end

	define_runtime_features (class_type: CLASS_TYPE) is
			-- Define all features needed by ISE .NET runtime. It generates
			-- `____class_name', `$$____type', `____set_type' and `____type'.
		require
			class_type_not_void: class_type /= Void
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_field_sig: like field_sig
			l_type_token: INTEGER
			l_class_token: INTEGER
			l_name_ca: MD_CUSTOM_ATTRIBUTE
			l_class_name: STRING
		do
			l_class_token := class_mapping.item (class_type.implementation_id)
			l_class_name := class_type.associated_class.name_in_upper
			
			create l_name_ca.make
			l_name_ca.put_string (l_class_name)
			define_custom_attribute (l_class_token, ise_eiffel_class_name_attr_ctor_token,
				l_name_ca)
			
				-- Define `____class_name'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			uni_string.set_string ("____class_name")
			l_meth_token := md_emit.define_method (uni_string,
				l_class_token,
				feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Virtual |
				feature {MD_METHOD_ATTRIBUTES}.Final,
				l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)
			
			if is_cls_compliant then
				define_custom_attribute (l_meth_token, cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end

			start_new_body (l_meth_token)
			put_system_string (l_class_name)
			generate_return
			method_writer.write_current_body
			
				-- Define `$$____type'.
			l_field_sig := field_sig
			l_field_sig.reset
			l_field_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				ise_eiffel_derivation_type_token)
			uni_string.set_string ("$$____type")
			l_type_token := md_emit.define_field (uni_string, l_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Family, l_field_sig)

			if is_cls_compliant then
				define_custom_attribute (l_type_token, cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end
			
				-- Define `____set_type'.
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				ise_eiffel_derivation_type_token)
		
			uni_string.set_string ("____set_type")
			l_meth_token := md_emit.define_method (uni_string,
				l_class_token,
				feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Virtual |
				feature {MD_METHOD_ATTRIBUTES}.Final,
				l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

			if is_cls_compliant then
				define_custom_attribute (l_meth_token, cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end

			start_new_body (l_meth_token)
			generate_current
			generate_argument (1)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_type_token)
			generate_return
			method_writer.write_current_body
			
				-- Define `____type'.
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				ise_eiffel_derivation_type_token)
		
			uni_string.set_string ("____type")
			l_meth_token := md_emit.define_method (uni_string,
				l_class_token,
				feature {MD_METHOD_ATTRIBUTES}.Public |
				feature {MD_METHOD_ATTRIBUTES}.Virtual |
				feature {MD_METHOD_ATTRIBUTES}.Final,
				l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

			if is_cls_compliant then
				define_custom_attribute (l_meth_token, cls_compliant_ctor_token,
					not_cls_compliant_ca)
			end

			start_new_body (l_meth_token)
			generate_current
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_type_token)
			generate_return
			method_writer.write_current_body				
		end

	update_parents (class_type: CLASS_TYPE; class_c: CLASS_C) is
			-- Generate ancestors map of `class_c'.
			-- (export status {NONE})
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			cl_type: CLASS_TYPE
			l_list: SEARCH_TABLE [INTEGER]
			id: INTEGER
			pars: SEARCH_TABLE [CLASS_INTERFACE]
			class_interface: CLASS_INTERFACE
			i: INTEGER
			l_parents: ARRAY [INTEGER]
		do
			parents := class_c.parents
			create class_interface.make_from_context (class_c.class_interface, class_type)
			create pars.make (parents.count)
			from
				byte_context.set_class_type (class_type)
				create l_list.make (parents.count)
				parents.start
				create l_parents.make (0, parents.count)
			until
				parents.after
			loop
				parent_type ?= byte_context.real_type (parents.item.type_i)
				cl_type := parent_type.associated_class_type
				id := cl_type.static_type_id
				if not l_list.has (id) then
					l_list.force (id)
					if not cl_type.associated_class.is_external then
							-- Add parent interfaces only.
						l_parents.put (class_mapping.item (cl_type.static_type_id), i)
					end
					pars.force (parent_type.associated_class_type.class_interface)
					i := i + 1
				end
				parents.forth
			end
			class_interface.set_parents (pars)
			class_type.set_class_interface (class_interface)

				-- Element after last added should be 0.
			if i = 0 then
				last_parents := Void
			else
				l_parents.put (0, i)
				last_parents := l_parents
			end
		end

feature -- Features info

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
			set_current_class_type (class_type)
			set_current_class (class_c)
			set_current_type_id (class_type.static_type_id)
			current_class_token := class_mapping.item (current_type_id)
			
			define_default_constructor (class_type)

				-- Generate interface features on Eiffel classes
			if not class_c.is_external then
				inst_context.set_cluster (class_c.cluster)
				if not class_c.is_frozen then
					generate_interface_features (class_c, class_type)
				else
					generate_implementation_features (class_c, class_type)
				end
			end
		end

	generate_interface_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_feature (feat, True, False, False)
				features.forth
			end

				-- Generate type features for formal generic parameters.
			if class_c.generic_features /= Void then
				generate_type_features (class_c.generic_features, class_c.class_id)
			end

				-- Generate type features for feature used as anchor.
			if class_c.anchored_features /= Void then
				generate_type_features (class_c.anchored_features, class_c.class_id)
			end
		end

	generate_implementation_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_feature (feat, False, False, False)
				features.forth
			end
		end

	generate_feature (feat: FEATURE_I; in_interface, is_static, is_override: BOOLEAN) is
			-- Generate interface `feat' description.
		require
			feat_not_void: feat /= Void
		local
			l_meth_sig: like method_sig
			l_field_sig: like field_sig
			l_name: STRING
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
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
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				l_is_attribute := feat.is_attribute
				l_is_c_external := feat.is_c_external
				l_parameter_count := feat.argument_count

				create l_signature.make (0, l_parameter_count)
				l_signature.compare_references
			
				l_return_type := argument_actual_type (feat.type.actual_type.type_i)
				if not in_interface and is_static and l_is_attribute then
					l_field_sig := field_sig
					l_field_sig.reset
					set_signature_type (l_field_sig, l_return_type)
					l_signature.put (l_return_type.static_type_id, 0)
				else
					l_meth_sig := method_sig
					l_meth_sig.reset
					if is_static and not in_interface then
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
					else
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
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
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_type_token)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
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
							l_type_i := argument_actual_type (l_feat_arg.item.actual_type.type_i)
							set_signature_type (l_meth_sig, l_type_i)
							l_signature.put (l_type_i.static_type_id, i + 1)
							i := i + 1
							l_feat_arg.forth
						end
					end
				end
				
				if is_static then
					if l_is_c_external then
						l_name := encoder.feature_name (current_class_type.static_type_id,
							feat.body_index)
					else
						if l_is_attribute then
							l_name := "$$" + il_casing.camel_casing (feat.feature_name)
						else
							l_name := "$$" + il_casing.pascal_casing (feat.feature_name,
								feature {IL_CASING_CONVERSION}.lower_case)
						end
					end
				else
					l_name := il_casing.pascal_casing (feat.feature_name, 
						feature {IL_CASING_CONVERSION}.lower_case)
				end
				
				uni_string.set_string (l_name)

				if not in_interface and is_static and l_is_attribute then
					l_field_attr := feature {MD_FIELD_ATTRIBUTES}.Public
					
					l_meth_token := md_emit.define_field (uni_string, current_class_token,
						l_field_attr, l_field_sig)
					
					insert_attribute (l_meth_token, current_type_id, feat.feature_id)
				else
					l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public
					if in_interface then
						l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Virtual |
							feature {MD_METHOD_ATTRIBUTES}.Abstract
					else
						if is_static then
							l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Static
						else
							l_meth_attr := l_meth_attr | feature {MD_METHOD_ATTRIBUTES}.Virtual
							if feat.is_deferred and not is_override then
								l_meth_attr := l_meth_attr |
									feature {MD_METHOD_ATTRIBUTES}.Abstract				
							end
						end
					end
						
				
					if is_static and l_is_c_external then
							-- Let's define Pinvoke here.
						l_meth_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed |
							feature {MD_METHOD_ATTRIBUTES}.Preserve_sig)
						md_emit.define_pinvoke_map (l_meth_token,
							feature {MD_PINVOKE_CONSTANTS}.Charset_ansi |
							feature {MD_PINVOKE_CONSTANTS}.Cdecl, uni_string, c_module_token)
					else
							-- Normal method
						l_meth_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)
					end

					if is_cls_compliant and is_static or feat.is_type_feature then
						define_custom_attribute (l_meth_token, cls_compliant_ctor_token,
							not_cls_compliant_ca)
					end
					
					if not is_static and l_is_attribute and not is_override then
							-- Let's define attribute setter.
						if in_interface then
							l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
								feature {MD_METHOD_ATTRIBUTES}.Virtual |
								feature {MD_METHOD_ATTRIBUTES}.Abstract
						else
							l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Public |
								feature {MD_METHOD_ATTRIBUTES}.Virtual
						end

						l_meth_sig.reset
						l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
						l_meth_sig.set_parameter_count (1)
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
						set_signature_type (l_meth_sig, l_return_type)
						uni_string.set_string (setter_prefix + l_name)
						l_setter_token := md_emit.define_method (uni_string, current_class_token,
							l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

						insert_setter (l_setter_token, current_type_id, feat.feature_id)

						if is_cls_compliant then
							define_custom_attribute (l_setter_token, cls_compliant_ctor_token,
								not_cls_compliant_ca)
						end
					end

						-- Let's generate argument names now.	
					if is_static and not l_is_c_external then
						uni_string.set_string ("Current")
						l_param_token := md_emit.define_parameter (l_meth_token, uni_string, 1,
							feature {MD_PARAM_ATTRIBUTES}.In)
					end
					if l_has_arguments then
						from
							l_feat_arg := feat.arguments
							i := 1
							if is_static and not l_is_c_external then
									-- Offset for static features as we generate one more argument.
								j := 1
							end
						until
							i > l_parameter_count
						loop
							uni_string.set_string (l_feat_arg.item_name (i))
							l_param_token := md_emit.define_parameter (l_meth_token, uni_string,
								i + j, feature {MD_PARAM_ATTRIBUTES}.In)
							i := i + 1
						end
					end

					if not is_override then
						if is_static then
							insert_implementation_feature (l_meth_token, current_type_id,
								feat.feature_id)
							insert_implementation_signature (l_signature, current_type_id,
								feat.feature_id)
						else
							insert_feature (l_meth_token, current_type_id, feat.feature_id)
							insert_signature (l_signature, current_type_id, feat.feature_id)
						end
					else
						last_override_token := l_meth_token
					end
				end
			end
		end

	argument_actual_type (a_type: TYPE_I): TYPE_I is
			-- Compute real type of Current.
		require
			a_type_not_void: a_type /= Void
		do
			if not a_type.has_formal then
				if not a_type.is_none then
					Result := a_type
				end
			else
				Result := byte_context.real_type (a_type)
			end
		ensure
			valid_result: Result /= Void
		end

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_gen_type: GEN_TYPE_I
			l_type: TYPE_I
			l_ref: REFERENCE_I
		do
			if a_type.is_basic then
				a_sig.set_return_type (a_type.element_type, 0)
			else
				l_gen_type ?= a_type
				if l_gen_type /= Void and then l_gen_type.base_class.is_native_array then
					check
						l_gen_type_has_generics: l_gen_type.true_generics /= Void
						l_gen_type_valid_count: l_gen_type.true_generics.valid_index (1)
					end
					a_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					l_type := l_gen_type.meta_generic.item (1)
					l_ref ?= l_type
					if l_ref /= Void and then not l_type.is_true_expanded then
						a_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
					else
						set_signature_type (a_sig, l_gen_type.true_generics.item (1))
					end
				else
					a_sig.set_return_type (a_type.element_type,
						class_mapping.item (a_type.static_type_id))
				end
			end
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_gen_type: GEN_TYPE_I
			l_type: TYPE_I
			l_ref: REFERENCE_I
		do
			if a_type.is_basic then
				a_sig.set_type (a_type.element_type, 0)
			else
				l_gen_type ?= a_type
				if l_gen_type /= Void and then l_gen_type.base_class.is_native_array then
					check
						l_gen_type_has_generics: l_gen_type.true_generics /= Void
						l_gen_type_valid_count: l_gen_type.true_generics.valid_index (1)
					end
					a_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					l_type := l_gen_type.meta_generic.item (1)
					l_ref ?= l_type
					if l_ref /= Void and then not l_type.is_true_expanded then
						a_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
					else
						set_signature_type (a_sig, l_gen_type.true_generics.item (1))
					end
				else
					a_sig.set_type (a_type.element_type,
						class_mapping.item (a_type.static_type_id))
				end
			end
		end

	generate_type_features (feats: HASH_TABLE [TYPE_FEATURE_I, INTEGER]; class_id: INTEGER) is
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
				if l_type_feature.origin_class_id = class_id then
					generate_feature (l_type_feature, True, False, False)
				end
				feats.forth
			end
		end

feature -- Custom attribute

	add_ca (target_type_id: INTEGER; attribute_type_id: INTEGER; arg_count: INTEGER) is
			-- No description available.
			-- `target_type_id' [in].  
			-- `attribute_type_id' [in].  
			-- `arg_count' [in].  
		do
--			implementation.add_ca (target_type_id, attribute_type_id, arg_count)
		end

	generate_class_ca is
			-- No description available.
		do
--			implementation.generate_class_ca
		end

	generate_feature_ca (a_feature_id: INTEGER) is
			-- No description available.
			-- `a_feature_id' [in].  
		do
--			implementation.generate_feature_ca (a_feature_id)
		end

	add_cainteger_arg (a_value: INTEGER) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_cainteger_arg (a_value)
		end

	add_castring_arg (a_value: STRING) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_castring_arg (a_value)
		end

	add_careal_arg (a_value: REAL) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_careal_arg (a_value)
		end

	add_cadouble_arg (a_value: DOUBLE) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_cadouble_arg (a_value)
		end

	add_cacharacter_arg (a_value: CHARACTER) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_cacharacter_arg (a_value)
		end

	add_caboolean_arg (a_value: BOOLEAN) is
			-- No description available.
			-- `a_value' [in].  
		do
--			implementation.add_caboolean_arg (a_value)
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
		local
			l_token: INTEGER
			l_meth_token: INTEGER
			l_cur_sig: ARRAY [INTEGER]
			l_impl_sig: ARRAY [INTEGER]
			i, nb: INTEGER
			l_is_c_external: BOOLEAN
			l_sequence_point: like sequence_point
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)

			if feat.is_attribute then
				l_token := attribute_token (a_type_id, code_feature_id)
				start_new_body (l_meth_token)
				generate_current
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_token)
				method_body.put_opcode (feature {MD_OPCODES}.Ret)
				method_writer.write_current_body

				l_meth_token := setter_token (current_type_id, feat.feature_id)
				start_new_body (l_meth_token)
				generate_current
				generate_argument (1)
				generate_check_cast (Void, argument_actual_type (feat.type.actual_type.type_i))
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_token)
				method_body.put_opcode (feature {MD_OPCODES}.Ret)
				method_writer.write_current_body
			else
				l_token := implementation_feature_token (a_type_id, code_feature_id)
				l_cur_sig := signatures (current_type_id, feat.feature_id)
				l_impl_sig := implementation_signatures (a_type_id, code_feature_id)

				l_is_c_external := feat.is_c_external

				if not l_is_c_external and then l_cur_sig.is_equal (l_impl_sig) then
					if is_debug_info_enabled then
						dbg_writer.open_method (l_meth_token)
						l_sequence_point := method_sequence_points.item (l_token)
						dbg_offsets_count := l_sequence_point.integer_item (1)
						dbg_offsets ?= l_sequence_point.item (2)
						dbg_start_lines ?= l_sequence_point.item (3)
						dbg_start_columns ?= l_sequence_point.item (4)
						dbg_end_lines ?= l_sequence_point.item (5)
						dbg_end_columns ?= l_sequence_point.item (6)
						dbg_writer.define_sequence_points (
							dbg_documents.item (feat.written_in),
							dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
							dbg_end_lines, dbg_end_columns)
						generate_local_debug_info (l_token)
						dbg_writer.close_method
					end
					method_writer.write_duplicate_body (l_token, l_meth_token)
				else
					if is_debug_info_enabled then
							-- Enable debugger to go through stub definition.
						define_custom_attribute (l_meth_token, debugger_step_through_ctor_token,
							debugger_step_through_ca)
						define_custom_attribute (l_meth_token, debugger_hidden_ctor_token,
							debugger_hidden_ca)
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
						if l_cur_sig.item (i) /= l_impl_sig.item (i) then
							method_body.put_opcode_mdtoken (feature {MD_OPCODES}.castclass,
								class_mapping.item (l_impl_sig.item (i)))
						end
						i := i + 1
					end
					method_body.put_call (feature {MD_OPCODES}.Call, l_token,
						nb, feat.has_return_value)
					if feat.has_return_value then
						if l_cur_sig.item (0) /= l_impl_sig.item (0) then
							method_body.put_opcode_mdtoken (feature {MD_OPCODES}.castclass,
								class_mapping.item (l_cur_sig.item (0)))
						end
					end
					generate_return
					method_writer.write_current_body
				end
			end
		end

	generate_feature_code (feat: FEATURE_I) is
			-- Generate IL code for feature `feat'.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
		do
			if not feat.is_attribute and not feat.is_c_external then
				l_meth_token := implementation_feature_token (current_type_id, feat.feature_id)
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
						dbg_documents.item (current_class.class_id),
						dbg_offsets_count, dbg_offsets, dbg_start_lines, dbg_start_columns,
						dbg_end_lines, dbg_end_columns)
					dbg_writer.close_method
					method_sequence_points.put ([dbg_offsets_count, dbg_offsets, dbg_start_lines,
						dbg_start_columns, dbg_end_lines, dbg_end_columns], l_meth_token)
				end
			end
		end

	generate_feature_internal_duplicate (feat: FEATURE_I) is
			-- Generate IL code for feature `internal_duplicate' from ANY.
		require
			feat_not_void: feat /= Void
		local
			l_meth_token: INTEGER
		do
			l_meth_token := feature_token (current_type_id, feat.feature_id)
			start_new_body (l_meth_token)
			generate_current
			method_body.put_call (feature {MD_OPCODES}.Call, memberwise_clone_token, 0, True)
			generate_check_cast (Void, current_class_type.type)
			generate_return
			method_writer.write_current_body
		end

	generate_finalize_feature (feat: FEATURE_I) is
			-- Generate `Finalize' that calls `finalize' definition from ANY.
		require
			feat_not_void: feat /= Void
		local
			l_finalize_token: INTEGER
			l_dotnet_finalize_token: INTEGER
		do
			generate_feature (feat, False, True, False)
			generate_feature_code (feat)

			l_finalize_token := implementation_feature_token (current_type_id, feat.feature_id)

				-- Generate `Finalize' that calls `finalize'.
			uni_string.set_string ("Finalize")
			l_dotnet_finalize_token := md_emit.define_method (uni_string, current_class_token,
				feature {MD_METHOD_ATTRIBUTES}.Family | feature {MD_METHOD_ATTRIBUTES}.Virtual,
				default_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)
		
			start_new_body (l_dotnet_finalize_token)
			generate_current
			method_body.put_call (feature {MD_OPCODES}.Call, l_finalize_token, 0, False)
			method_body.put_opcode (feature {MD_OPCODES}.Ret)
			method_writer.write_current_body
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
		do
			l_parent_type_id := parent_type.static_type_id
			l_cur_sig := signatures (current_type_id, cur_feat.feature_id)
			l_inh_sig := signatures (l_parent_type_id, inh_feat.feature_id)

			l_same_signature := l_cur_sig.is_equal (l_inh_sig)
				
			if l_same_signature then
				md_emit.define_method_impl (current_class_token, feature_token (current_type_id,
					cur_feat.feature_id), feature_token (l_parent_type_id, inh_feat.feature_id))
					
				if cur_feat.is_attribute and then inh_feat.is_attribute then
					md_emit.define_method_impl (current_class_token, setter_token (current_type_id,
						cur_feat.feature_id), setter_token (l_parent_type_id, inh_feat.feature_id))
				end
			else
				l_name_id := inh_feat.feature_name_id
				l_name := inh_feat.feature_name
				inh_feat.set_feature_name (Override_prefix + l_name + override_counter.next.out)

					-- We have to generate body of `inh_feat' in context of
					-- `parent_type' in order to correctly evaluate its
					-- signature in current context.
				Byte_context.set_class_type (parent_type)
				generate_feature (inh_feat, False, False, True)
				l_return_type := argument_actual_type (inh_feat.type.actual_type.type_i)
				Byte_context.set_class_type (current_class_type)

				start_new_body (last_override_token)
				generate_current
				from
					i := 1
					nb := cur_feat.argument_count
				until
					i > nb
				loop
					generate_argument (i)
					if l_cur_sig.item (i) /= l_inh_sig.item (i) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.castclass,
							class_mapping.item (l_cur_sig.item (i)))
					end
					i := i + 1
				end
				method_body.put_call (feature {MD_OPCODES}.Callvirt, feature_token (current_type_id,
					cur_feat.feature_id), nb, cur_feat.has_return_value)
					
				if cur_feat.has_return_value then
					if l_cur_sig.item (0) /= l_inh_sig.item (0) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.castclass,
							class_mapping.item (l_inh_sig.item (0)))
					end
				end
				generate_return
				method_writer.write_current_body				

				md_emit.define_method_impl (current_class_token, last_override_token,
					feature_token (l_parent_type_id, inh_feat.feature_id))

				if cur_feat.is_attribute and then inh_feat.is_attribute then
					l_meth_attr := feature {MD_METHOD_ATTRIBUTES}.Virtual |
						feature {MD_METHOD_ATTRIBUTES}.Private

					l_meth_sig := method_sig
					l_meth_sig.reset
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
					l_meth_sig.set_parameter_count (1)
					l_meth_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

					set_signature_type (l_meth_sig, l_return_type)

					uni_string.set_string (Override_prefix + setter_prefix + l_name +
						override_counter.next.out)

					l_setter_token := md_emit.define_method (uni_string, current_class_token,
						l_meth_attr, l_meth_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

					start_new_body (l_setter_token)
					generate_current
					generate_argument (1)
					if l_cur_sig.item (0) /= l_inh_sig.item (0) then
						method_body.put_opcode_mdtoken (feature {MD_OPCODES}.castclass,
							class_mapping.item (l_cur_sig.item (0)))
					end
					method_body.put_call (feature {MD_OPCODES}.Callvirt,
						setter_token (current_type_id, cur_feat.feature_id),
						nb, cur_feat.has_return_value)

					generate_return
					method_writer.write_current_body				

					md_emit.define_method_impl (current_class_token, l_setter_token,
						setter_token (l_parent_type_id, inh_feat.feature_id))
				end
				inh_feat.set_feature_name_id (l_name_id)
			end
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
		local
			l_type_token: INTEGER
		do
			l_type_token := external_token_mapping.item (base_name)
			internal_generate_external_call (0, l_type_token, Void, name, ext_kind,
					Names_heap.convert_to_string_array (parameters_type),
					Names_heap.item (return_type), is_virtual)
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
			l_has_return_type: BOOLEAN
			l_type: TYPE_I
			l_real_type: STRING
			l_is_array: BOOLEAN
		do
 			if base_name /= Void then
 				uni_string.set_string (base_name)
 				l_class_token := md_emit.define_type_ref (uni_string, an_assembly_token)
 			else
				l_class_token := a_type_token
			end
			
			l_has_return_type := return_type /= Void
			if l_has_return_type then
				if return_type.item (return_type.count) = ']' then
					l_real_type := return_type.substring (1, return_type.count - 2)
					l_is_array := True
				else
					l_real_type := return_type
				end
				l_type := external_class_mapping.item (l_real_type)
			end
			
			inspect ext_kind
			when Field_type, Static_field_type, Set_field_type, Set_static_field_type then
				l_field_sig := field_sig
				l_field_sig.reset
				if l_is_array then
					l_field_sig.set_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
				end
				if l_type /= Void then
					set_signature_type (l_field_sig, l_type)
				else
					l_field_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
						external_token_mapping.item (return_type))
				end
				
				uni_string.set_string (member_name)
				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_field_sig)
				inspect ext_kind
				when Field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldfld, l_token)
				when Static_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, l_token)
				when Set_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stfld, l_token)
				when Set_static_field_type then
					method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, l_token)
				end
			else
				l_meth_sig := method_sig
				l_meth_sig.reset
				if ext_kind = static_type then
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				else
					l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
				end

				if parameters_string /= Void then
					nb := parameters_string.count
				end

				l_meth_sig.set_parameter_count (nb)

				if l_has_return_type then
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_method_return_type (l_meth_sig, l_type)
					else
						l_meth_sig.set_return_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							external_token_mapping.item (return_type))
					end
				else
					l_meth_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				end
	
				from
					i := 1
				until
					i > nb
				loop
					l_real_type := parameters_string.item (i)
					if l_real_type.item (l_real_type.count) = ']' then
						l_is_array := True
						l_real_type := l_real_type.substring (1, l_real_type.count - 2)
					else
						l_is_array := False
					end
					l_type := external_class_mapping.item (l_real_type)
					if l_is_array then
						l_meth_sig.set_type (
							feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					if l_type /= Void then
						set_signature_type (l_meth_sig, l_type)
					else
						l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
							external_token_mapping.item (l_real_type))
					end
					i := i + 1
				end
		
				if member_name = Void then
					uni_string.set_string (".ctor")
				else
					uni_string.set_string (member_name)
				end

				l_token := md_emit.define_member_ref (uni_string, l_class_token, l_meth_sig)
				
				inspect ext_kind
				when Creator_call_type, Static_type then
					method_body.put_call (feature {MD_OPCODES}.Call, l_token, nb, l_has_return_type)
				when Normal_type, Deferred_type then
					if is_virtual then
						method_body.put_call (
							feature {MD_OPCODES}.Callvirt, l_token, nb, l_has_return_type)
					else
						method_body.put_call (
							feature {MD_OPCODES}.Call, l_token, nb, l_has_return_type)
					end
				when Creator_type then
					method_body.put_call (
						feature {MD_OPCODES}.Newobj, l_token, nb, True)
				end
			end
		end

feature -- Local variable info generation

	set_local_count (a_count: INTEGER) is
			-- Set `local_count' to `a_count'.
		require
			valid_count: a_count >= 0
		do
			local_count := a_count
		ensure
			local_count_set: local_count = a_count
		end

	put_result_info (type_i: TYPE_I) is
			-- Specifies `type_i' of type of result.
		require
			type_i_not_void: type_i /= Void
		do
			if not once_generation then
				result_position := 0
				local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "Result"))
			end
		end

	put_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				Names_heap.item (name_id)))
		end

	put_nameless_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i, "_" + name_id.out))
		end

	put_dummy_local_info (type_i: TYPE_I; name_id: INTEGER) is
			-- Specifies `type_i' of type of local.
		require
			type_i_not_void: type_i /= Void
		do
			local_types.extend (create {PAIR [TYPE_I, STRING]}.make (type_i,
				"_dummy_" + name_id.out))
		end

feature {IL_CODE_GENERATOR} -- Local saving

	store_locals (a_meth_token: INTEGER) is
			-- Store `local_types' into `method_body' for routine `a_meth_token'.
		local
			l_sig: like local_sig
			l_locals: like local_types
			l_count: INTEGER
			l_loc_token: INTEGER
		do
			l_locals := local_types
			l_count := l_locals.count
			
			if l_count > 0 then
				l_sig := local_sig
				l_sig.reset
	
				l_sig.set_local_count (l_count)
				
				from
					l_locals.start
				until
					l_locals.after
				loop
					set_signature_type (l_sig, l_locals.item.first)
					l_locals.forth
				end
				
				if is_debug_info_enabled then
					if result_position /= -1 then
						local_count := local_count + 1
					end
					local_info.put ([local_start_offset, local_end_offset, local_count,
						local_types], a_meth_token)
					create local_types.make (5)
				else
					local_types.wipe_out
				end
				local_count := 0
				local_start_offset := 0
				local_end_offset := 0
				
				l_loc_token := md_emit.define_signature (l_sig)
				
				method_body.set_local_token (l_loc_token)
			end
		end

	generate_local_debug_info (a_method_token: INTEGER) is
			-- Generate local information about routine `method_token'.
		require
			debug_info_requested: is_debug_info_enabled	
			valid_method_token: a_method_token & 0xFF000000 = feature {MD_TOKEN_TYPES}.Method_def
		local
			l_locals: like local_types
			l_sig: MD_TYPE_SIGNATURE
			l_type: TYPE_I
			i: INTEGER
			nb: INTEGER
			l_start_offset, l_end_offset: INTEGER
			l_local_info: like local_debug_info
		do
			l_local_info := local_info.item (a_method_token)
			if l_local_info /= Void then
				from
					l_start_offset := l_local_info.integer_item (1)
					l_end_offset := l_local_info.integer_item (2)
					nb := l_local_info.integer_item (3)
					l_locals ?= l_local_info.item (4)
					dbg_writer.open_scope (l_start_offset)
					l_locals.start
					create l_sig.make
					i := 0
				until
					l_locals.after or i >= nb
				loop
					l_sig.reset
					l_type := l_locals.item.first
					if l_type.is_basic then
						l_sig.set_type (l_type.element_type, 0)
					else
						l_sig.set_type (l_type.element_type,
							class_mapping.item (l_type.static_type_id))
					end
					uni_string.set_string (l_locals.item.second)
					dbg_writer.define_local_variable (uni_string, i, l_sig)
					l_locals.forth
					i := i +1
				end
				dbg_writer.close_scope (l_end_offset)
			end
		end
		
feature -- Object creation

	create_object (a_type_id: INTEGER) is
			-- Create object of `a_type_id'.
		require
			valid_type_id: a_type_id > 0
		do
			method_body.put_call (feature {MD_OPCODES}.Newobj,
				constructor_token.item (a_type_id), 0, True)
		end

	create_like_object is
			-- Create object of same type as object on top of stack.
		do
			internal_generate_external_call (ise_runtime_token, 0, generic_conformance_class_name,
				"create_like_object", Static_type, <<type_info_class_name>>,
				type_info_class_name,
				False)			
		end

	load_type is
			-- Load on stack type of object on top of stack.
		do
			internal_generate_external_call (ise_runtime_token, 0, generic_conformance_class_name,
				"load_type_of_object", Static_type, <<type_info_class_name>>,
				type_class_name,
				False)			
		end
		
	create_type is
			-- Given info on stack, it will create a new instance of a generic formal
			-- parameter.
		do
			internal_generate_external_call (ise_runtime_token, 0, generic_conformance_class_name,
				"create_type", Static_type, <<type_class_name,
				type_info_class_name>>, type_info_class_name,
				False)			
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
			if once_generation then
				generate_once_result
			else
				generate_local (result_position)
			end
		end

	generate_attribute (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to attribute of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
				-- Attribute are accessed through their feature encapsulation.
			internal_generate_feature_access (type_i.static_type_id, a_feature_id, 0, True, True)
		end

	generate_feature_access (type_i: TYPE_I; a_feature_id: INTEGER; nb: INTEGER;
			is_function, is_virtual: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			internal_generate_feature_access (type_i.static_type_id, a_feature_id, nb,
				is_function, True)
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
				l_opcode := feature {MD_OPCODES}.Callvirt
			else
				l_opcode := feature {MD_OPCODES}.Call
			end

			method_body.put_call (l_opcode, feature_token (a_type_id, a_feature_id), nb,
				is_function)
		end

	generate_precursor_feature_access (type_i: TYPE_I; a_feature_id: INTEGER;
			nb: INTEGER; is_function: BOOLEAN)
		is
			-- Generate access to feature of `a_feature_id' in `type_i' with `nb' arguments.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_call (feature {MD_OPCODES}.Call,
				implementation_feature_token (type_i.implementation_id, a_feature_id),
				nb, is_function)
		end

	put_type_token (a_type_id: INTEGER) is
			-- Put token associated to `a_type_id' on stack.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken,
				class_mapping.item (a_type_id))
		end

	put_method_token (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate access to feature of `a_feature_id' in `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldtoken,
				feature_token (type_i.static_type_id, a_feature_id))
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		require
			valid_n: n >= 0
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
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_0)				
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Ldloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloc,
						l_pos.to_integer_16)
				end
			end
		end

	generate_metamorphose (type_i: TYPE_I) is
			-- Generate `metamorphose', ie boxing a basic type of `type_i' into its
			-- corresponding reference type.
		require
			type_i_not_void: type_i /= Void
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Box,
				class_mapping.item (type_i.static_type_id))
		end


	generate_unmetamorphose (type_i: TYPE_I) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_i'.
			-- Load content of address resulting from unbox operation.
		require
			type_i_not_void: type_i /= Void
		local
			l_type_id: INTEGER
		do
			l_type_id := type_i.static_type_id
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Unbox,
				class_mapping.item (l_type_id))
			generate_load_from_address (type_i)
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			if l_pos <= 255 then
				method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Ldloca_s, l_pos.to_integer_8)
			else
				method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Ldloca, l_pos.to_integer_16)
			end
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		require
			valid_n: n >= 0
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
			if once_generation then
				generate_once_result_address
			else
				generate_local_address (result_position)
			end
		end

	generate_routine_address (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate address of routine of `a_feature_id' in class `type_i'.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_opcode (feature {MD_OPCODES}.Dup)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldvirtftn,
				feature_token (type_i.static_type_id, a_feature_id))
		end

	generate_load_from_address (a_type: TYPE_I) is
			-- Load value of `a_type' type from address pushed on stack.
		require
			type_not_void: a_type /= Void
		do
			inspect a_type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_u8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i1)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i2)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_r4)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_r8)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				method_body.put_opcode (feature {MD_OPCODES}.Ldind_i)
			else
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldobj, class_mapping.item (a_type.static_type_id))
			end
		end

feature -- Assignments

	generate_is_instance_of (type_i: TYPE_I) is
			-- Generate `Isinst' byte code instruction.
		require
			type_i_not_void: type_i /= Void
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Isinst,
				class_mapping.item (type_i.static_type_id))
		end

	generate_check_cast (source_type, target_type: TYPE_I) is
			-- Generate `checkcast' byte code instruction.
		require
			target_type_not_void: target_type /= Void
		do
			if is_verifiable and not target_type.is_expanded then
				method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Castclass,
					class_mapping.item (target_type.static_type_id))
			end
		end

	generate_attribute_assignment (type_i: TYPE_I; a_feature_id: INTEGER) is
			-- Generate assignment to attribute of `a_feature_id' in current class.
		require
			type_i_not_void: type_i /= Void
			positive_feature_id: a_feature_id > 0
		do
			method_body.put_call (feature {MD_OPCODES}.Callvirt,
				setter_token (type_i.static_type_id, a_feature_id), 1, False) 
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		require
			valid_n: n >= 0
		local
			l_pos: INTEGER
		do
			l_pos := n + result_position
			inspect
				l_pos
			when 0 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_0)				
			when 1 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_1)
			when 2 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_2)
			when 3 then method_body.put_opcode (feature {MD_OPCODES}.Stloc_3)
			else
				if l_pos <= 255 then
					method_body.put_opcode_integer_8 (feature {MD_OPCODES}.Stloc_s,
						l_pos.to_integer_8)
				else
					method_body.put_opcode_integer_16 (feature {MD_OPCODES}.Stloc, 
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
		require
			type_not_void: type /= Void
			type_is_basic: type.is_basic
		do
			inspect
				type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then convert_to_boolean
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then convert_to_character
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then convert_to_real
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then convert_to_double
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then convert_to_native_int
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1
			then
				convert_to_integer_8
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2
			then
				convert_to_integer_16
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4
			then
				convert_to_integer_32
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8
			then
				convert_to_integer_64
				
			else
				check
					False
				end
			end
		end

	convert_to_native_int is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i)
		end
		
	convert_to_integer_8, convert_to_boolean is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i1)
		end
		
	convert_to_integer_16, convert_to_character is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i2)
		end
		
	convert_to_integer_32 is
			-- Convert top of stack into appropriate type.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Conv_i4)
		end

	convert_to_integer_64 is
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

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		do
				-- Push result on stack.
			generate_result
			generate_return
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
			done_token := md_emit.define_field (create {UNI_STRING}.make (name + "_done"),
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Public | feature {MD_FIELD_ATTRIBUTES}.Static,
				done_sig)
		end

	generate_once_result_info (name: STRING; type_i: TYPE_I) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_i'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			type_i: type_i /= Void
		local
			l_sig: like field_sig
		do
			l_sig := field_sig
			l_sig.reset
			set_signature_type (l_sig, type_i)	
				
			result_token := md_emit.define_field (create {UNI_STRING}.make (name + "_result"),
				current_class_token,
				feature {MD_FIELD_ATTRIBUTES}.Public | feature {MD_FIELD_ATTRIBUTES}.Static, l_sig)
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

	generate_array_creation (a_type_id: INTEGER) is
			-- Create a new NATIVE_ARRAY [A] where `a_type_id' corresponds
			-- to type id of `A'.
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Newarr,
				class_mapping.item (a_type_id))
		end

	generate_array_count is
			-- Get length of current NATIVE_ARRAY on stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldlen)
			convert_to_integer_32
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
				-- First we pop pushed array as it is not needed and
				-- then we push `0'.
			method_body.put_opcode (feature {MD_OPCODES}.Pop)
			method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
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
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_catch_position (method_body.count)
			method_body.exception_block.set_type_token (system_exception_token)
				-- We need to increment stack depth of 1 because CLI runtime automatically
				-- puts the exception object on top of stack and there is no automatic
				-- way to add it.
			method_body.increment_stack_depth (1)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_last_exception_token)			
		end

	generate_end_exception_block is
			-- Mark end of rescue clause.
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Leave, rescue_label)
			method_body.exception_block.set_end_position (method_body.count)
			method_body.mark_label (rescue_label)
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: IL_LABEL) is
			-- Check if assertions are already being checked,
			-- in that case we need to skip the assertion block.
		require
			end_of_assert_label_not_void: end_of_assert /= Void
		do
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, ise_in_assertion_token)
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, end_of_assert.id)
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
			put_boolean_constant (False)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_in_assertion_token)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
			-- Generate test after an assertion is being generated.
			-- If result of test is False, we raise an exception.
		local
			type_assert: STRING
			l_label: INTEGER
			l_str_token: INTEGER
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

			uni_string.set_string (type_assert + tag)
			l_str_token := md_emit.define_string (uni_string)

			l_label := method_body.define_label
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, l_label)
			generate_restore_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, exception_ctor_token, 1, True)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
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
			uni_string.set_string ("Precondition violation: " + tag)
			l_str_token := md_emit.define_string (uni_string)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldstr, l_str_token)
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Stsfld, ise_assertion_tag_token)
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, failure_block.id)
		end

	generate_precondition_violation is
			-- Generate a precondition violation.
			-- Has to be a specific one because preconditions can be weaken.
		do
			generate_restore_assertion_status
			method_body.put_opcode_mdtoken (feature {MD_OPCODES}.Ldsfld, ise_assertion_tag_token)
			method_body.put_call (feature {MD_OPCODES}.Newobj, exception_ctor_token, 1, True)
			method_body.put_opcode (feature {MD_OPCODES}.Throw)
		end

	generate_invariant_checking (type_i: TYPE_I) is
			-- Generate an invariant check after routine call
		require
			type_i_not_void: type_i /= Void
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Constants generation

	put_default_value (type: TYPE_I) is
			-- Put default value of `type' on IL stack.
		require
			type_not_void: type /= Void
		do
			inspect
				type.element_type
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean then
				put_boolean_constant (False)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then
				put_character_constant ('%U')
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r8 then
				put_double_constant (0.0)
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_i then
				put_integer_32_constant (0)
				convert_to_native_int
				
			when feature {MD_SIGNATURE_CONSTANTS}.Element_type_r4 then
				put_double_constant (0.0)
				convert_to_real
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i1,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u1
			then
				put_integer_8_constant (0)
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i2,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u2
			then
				put_integer_16_constant (0)
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i4,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u4
			then
				put_integer_32_constant (0)
				
			when
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_i8,
				feature {MD_SIGNATURE_CONSTANTS}.Element_type_u8
			then
				put_integer_64_constant (0)
				
			else
				put_void
			end
		end

	put_void is
			-- Add a Void element on stack.
		do
			method_body.put_opcode (feature {MD_OPCODES}.Ldnull)
		end
		
	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		require
			valid_s: s /= Void
		do
			create_object (String_implementation_id)
			duplicate_top
			put_system_string (s)
			internal_generate_feature_access (String_type_id, String_make_feat_id, 1, False, True)
		end

	put_system_string (s: STRING) is
			-- Put `System.String' object corresponding to `s' on IL stack.
		require
			valid_s: s /= Void
		local
			l_string_token: INTEGER
		do
			uni_string.set_string (s)
			l_string_token := md_emit.define_string (uni_string)
			method_body.put_string (l_string_token)
		end

	put_integer_constant (type: TYPE_I; i: INTEGER) is
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
			when 8 then put_integer_8_constant (i)
			when 16 then put_integer_16_constant (i)
			when 32 then put_integer_32_constant (i)
			when 64 then put_integer_64_constant (i)
			end
		end

	put_integer_8_constant,
	put_integer_16_constant,
	put_integer_32_constant (i: INTEGER) is
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
		
	put_integer_64_constant (i: INTEGER_64) is
			-- Put `i' as INTEGER_64 on IL stack
		do
			method_body.put_opcode_integer_64 (feature {MD_OPCODES}.Ldc_i8, i)
		end

	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
			method_body.put_opcode_double (feature {MD_OPCODES}.Ldc_r8, d)
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

	branch_on_true (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brtrue, label.id)
		end

	branch_on_false (label: IL_LABEL) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Brfalse, label.id)
		end

	branch_to (label: IL_LABEL) is
			-- Generate a branch instruction to `label'.
		require
			label_not_void: label /= Void
		do
			method_body.put_opcode_label (feature {MD_OPCODES}.Br, label.id)
		end

	mark_label (label: IL_LABEL) is
			-- Mark a portion of code with `label'.
		require
			label_not_void: label /= Void
		do
			method_body.mark_label (label.id)
		end

	create_label: IL_LABEL is
			-- Create a new label
		do
			create Result.make (method_body.define_label)
		end

feature -- Binary operator generation

	generate_binary_operator (code: INTEGER) is
			-- Generate a binary operator represented by `code'.
			-- Look in IL_CONST for `code' definition.
		do
			inspect
				code
			when il_le then
				method_body.put_opcode (feature {MD_OPCODES}.Cgt)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_lt then method_body.put_opcode (feature {MD_OPCODES}.Clt)
			when il_ge then
				method_body.put_opcode (feature {MD_OPCODES}.Clt)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_gt then method_body.put_opcode (feature {MD_OPCODES}.Cgt)
			when il_star then method_body.put_opcode (feature {MD_OPCODES}.Mul)
			when il_power then
				method_body.put_call (feature {MD_OPCODES}.Call, power_method_token, 2, True)
			when il_plus then method_body.put_opcode (feature {MD_OPCODES}.Add)
			when il_mod then method_body.put_opcode (feature {MD_OPCODES}.Rem)
			when il_minus then method_body.put_opcode (feature {MD_OPCODES}.Sub)
			when il_div, il_slash then method_body.put_opcode (feature {MD_OPCODES}.Div)
			when il_xor then method_body.put_opcode (feature {MD_OPCODES}.Xor_opcode)
			when il_or then method_body.put_opcode (feature {MD_OPCODES}.Or_opcode)
			when il_and then method_body.put_opcode (feature {MD_OPCODES}.And_opcode)
			when il_eq then method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_ne then
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_shl then method_body.put_opcode (feature {MD_OPCODES}.Shl)
			when il_shr then method_body.put_opcode (feature {MD_OPCODES}.Shr)
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
			when il_uminus then method_body.put_opcode (feature {MD_OPCODES}.Neg)
			when il_not then
				method_body.put_opcode (feature {MD_OPCODES}.Ldc_i4_0)
				method_body.put_opcode (feature {MD_OPCODES}.Ceq)
			when il_bitwise_not then method_body.put_opcode (feature {MD_OPCODES}.Not_opcode)
			end
		end

feature -- Basic feature

	generate_min (type: TYPE_I) is
			-- Generate `min' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_min_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset

			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			l_min_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Min"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_min_token, 2, True)
		end

	generate_max (type: TYPE_I) is
			-- Generate `max' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_max_token: INTEGER
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset
			
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			set_signature_type (l_sig, type)

			l_max_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Max"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_max_token, 2, True)
		end

	generate_abs (type: TYPE_I) is
			-- Generate `abs' on basic types.
		require
			type_not_void: type /= Void
			basic_type: type.is_basic
		local
			l_abs_token: INTEGER
			l_type_token: INTEGER
			l_sig: like method_sig
			l_type_id: INTEGER
		do
			l_type_id := type.static_type_id
			l_type_token := class_mapping.item (l_type_id)
			create l_sig.make
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			set_method_return_type (l_sig, type)
			set_signature_type (l_sig, type)
			l_abs_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("Abs"), math_type_token, l_sig)
				
			method_body.put_call (feature {MD_OPCODES}.Call, l_abs_token, 1, True)
		end

	generate_to_string is
			-- Generate call on `ToString'.
		do
			method_body.put_call (feature {MD_OPCODES}.Callvirt, to_string_method_token, 0, True)
		end
	
	generate_hash_code is
			-- Given an INTEGER on top of stack, put on stack
			-- a positive INTEGER.
		do
			convert_to_integer_32
			put_integer_32_constant (0x7FFFFFFF)
			method_body.put_opcode (feature {MD_OPCODES}.And_opcode)
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
			generate_to_string
			
				-- Store value
			byte_context.add_local (System_string_type)
			local_number := byte_context.local_list.count
			put_dummy_local_info (System_string_type, local_number)
			generate_local_assignment (local_number)
			
			create_object (string_implementation_id)
			duplicate_top
			generate_local (local_number)
			internal_generate_feature_access (string_type_id, string_make_feat_id, 0, False, True)
		end
		
feature -- Line info

	put_line_info (n: INTEGER) is
			-- Generate debug information at line `n'.
		require
			valid_n: n > 0
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
			end
		end

	put_debug_info (location: TOKEN_LOCATION) is
			-- Generate debug information for `location' to enable to
			-- find corresponding Eiffel class file in IL code.
		require
			location_not_void: location /= Void
		local
			l_pos: INTEGER
		do
			if is_debug_info_enabled then
				l_pos := dbg_offsets_count
				dbg_offsets.force (method_body.count, l_pos)
				dbg_start_lines.force (location.line_number, l_pos)
				dbg_start_columns.force (location.start_column_position, l_pos)
				dbg_end_lines.force (location.line_number, l_pos)
				dbg_end_columns.force (location.end_column_position, l_pos)
				dbg_offsets_count := l_pos + 1
			end
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
			create_object (l_type_id)
			duplicate_top
			put_type_token (cl_type.implementation_id)
			internal_generate_external_call (ise_runtime_token, 0, class_type_class_name, "set_type",
				Normal_type, <<type_handle_class_name>>, Void, True)
		end

	generate_generic_type_instance (n: INTEGER) is
			-- Generate a GENERIC_TYPE instance corresponding that will hold `n' items.
		require
			valid_n: n >= 0
		do
			create_object (generic_type_id)
			duplicate_top
			put_integer_32_constant (n)
			generate_array_creation (runtime_type_id)
		end

	generate_generic_type_settings (gen_type: GEN_TYPE_I) is
			-- Generate a CLASS_TYPE instance corresponding to `cl_type'.
		require
			gen_type_not_void: gen_type /= Void
		do
			internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_type_array",
				Normal_type, <<type_array_class_name>>, Void, True);

			duplicate_top
			put_type_token (gen_type.implementation_id)
			internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_type",
				Normal_type, <<type_handle_class_name>>, Void, True)

			duplicate_top
			put_integer_32_constant (gen_type.meta_generic.count)
			internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_nb_generics",
				Normal_type, <<integer_32_class_name>>, Void, True)
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
			generate_current
			internal_generate_external_call (ise_runtime_token, 0, generic_conformance_class_name, "compute_type",
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
			l_sig: like local_sig
			l_token: INTEGER
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

			start_new_body (feature_token (current_type_id, a_type_feature.feature_id))

				-- Set position of `result' local variable. Does not make sense to 
				-- call `put_result_info' as we don't know its associated CL_TYPE_I.
			result_position := 0

			l_sig := local_sig
			l_sig.reset
			
			l_sig.set_local_count (1)
			l_sig.add_local_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				class_mapping.item (l_type_id))
			l_token := md_emit.define_signature (l_sig)
			method_body.set_local_token (l_token)
			
			create_object (l_type_id)
			generate_result_assignment

			generate_result
			
			if l_type_id = formal_type_id then
				put_integer_32_constant (l_formal_type.position)
				internal_generate_external_call (ise_runtime_token, 0, formal_type_class_name,
					"set_position",
					Normal_type, <<integer_32_class_name>>, Void, True)
			elseif l_type_id = class_type_id then
					-- Non-generic class.
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (ise_runtime_token, 0, class_type_class_name, "set_type",
					Normal_type, <<type_handle_class_name>>, Void, True)
			elseif l_type_id = basic_type_id then
				put_type_token (l_cl_type.implementation_id)
				internal_generate_external_call (ise_runtime_token, 0, basic_type_class_name, "set_type",
					Normal_type, <<type_handle_class_name>>, Void, True)
			else
				duplicate_top

				put_integer_32_constant (l_gen_type.meta_generic.count)
				generate_array_creation (runtime_type_id)

				from
					i := l_gen_type.true_generics.lower
					check
						i_start_at_one: i = 1
					end
					up := l_gen_type.true_generics.upper
				until
					i > up
				loop
					duplicate_top
					put_integer_32_constant (i - 1)
					l_gen_type.true_generics.item (i).generate_gen_type_il (Current, True)
					generate_array_write (feature {IL_CONST}.il_ref)
					i := i + 1
				end

				internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_type_array",
					normal_type, <<type_array_class_name>>, Void, True)
				duplicate_top
				put_type_token (l_gen_type.implementation_id)
				internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_type",
					normal_type, <<type_handle_class_name>>, Void, True)
				duplicate_top
				put_integer_32_constant (l_gen_type.meta_generic.count)
				internal_generate_external_call (ise_runtime_token, 0, generic_type_class_name, "set_nb_generics",
					normal_type, <<integer_32_class_name>>, Void, True)
					
				pop
			end
			generate_return_value

			method_writer.write_current_body
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

feature {NONE} -- Predefine custom attributes

	define_custom_attribute (token: INTEGER; ctor_token: INTEGER; data: MD_CUSTOM_ATTRIBUTE) is
			-- Define a custom attribute on `token' using constructor `ctor_token' with
			-- arguments `data'.
			-- Same as `md_emit.define_custom_attribuyte' but we do not care about return type.
		local
			l_ca_token: INTEGER
		do
			l_ca_token := md_emit.define_custom_attribute (token, ctor_token, data)
			check
				l_ca_token_set: l_ca_token & 0xFF000000 = feature {MD_TOKEN_TYPES}.custom_attribute
			end
		end

	not_cls_compliant_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not CLS compliant attribute
		once
			create Result.make
			Result.put_integer_8 (0)
			Result.put_integer_16 (0)
		end

	debugger_step_through_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blobl for `System.Diagnostics.DebuggerStepThroughAttribute' attribute.
		once
			create Result.make
		end

	debugger_hidden_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blobl for `System.Diagnostics.DebuggerHiddenAttribute' attribute.
		once
			create Result.make
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
			compute_mscorlib_method_tokens
			compute_ise_runtime_tokens
			compute_c_module_token
		end

	entry_point_token: INTEGER
			-- Token for `Main' static feature in an assembly generated
			-- as an `exe'.

	c_module_token: INTEGER
			-- Token for C module containing all C externals.

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

	object_ctor_token: INTEGER
			-- Token for `System.Object' constructor feature in `mscorlib'.

	cls_compliant_ctor_token: INTEGER
			-- Token for `System.CLSCompliantAttribute' constructor.

	debugger_hidden_ctor_token, debugger_step_through_ctor_token: INTEGER
			-- Token for constructor of `System.Diagnostics.DebuggerHiddenAttribute' and
			-- `System.Diagnostics.DebuggerStepThroughAttribute'.

	exception_ctor_token: INTEGER
			-- Token for `System.Exception' constructor feature in `mscorlib'.

	memberwise_clone_token: INTEGER
			-- Token for `MemberwiseClone' of `System.Object'.

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

	ise_eiffel_type_info_type_token,
	ise_runtime_type_token,
	ise_type_token,
	ise_generic_conformance_token,
	ise_class_type_token,
	ise_generic_type_token,
	ise_formal_type_token,
	ise_none_type_token,
	ise_basic_type_token,
	ise_eiffel_derivation_type_token,
	ise_eiffel_class_name_attr_token,
	ise_eiffel_class_name_attr_ctor_token: INTEGER
			-- Token for run-time types used in code generation.

	compute_c_module_token is
			-- Compute `c_module_token'.
		do
			c_module_token := md_emit.define_module_ref (c_module_name)
		end

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
			l_sig: like method_sig
			l_cls_compliant_token: INTEGER
			l_debugger_step_through_token: INTEGER
			l_debugger_hidden_token: INTEGER
		do
			object_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Object"), mscorlib_token)
			math_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Math"), mscorlib_token)
			system_exception_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Exception"), mscorlib_token)
			l_cls_compliant_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.CLSCompliantAttribute"), mscorlib_token)
			l_debugger_step_through_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Diagnostics.DebuggerHiddenAttribute"),
				mscorlib_token)
			l_debugger_hidden_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Diagnostics.DebuggerStepThroughAttribute"),
				mscorlib_token)
			
			uni_string.set_string (".ctor")

				-- Define `.ctor' from `System.Exception'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			exception_ctor_token := md_emit.define_member_ref (uni_string,
				system_exception_token, l_sig)

				-- Define `.ctor' from `System.Object'.
			create default_sig.make
			default_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			default_sig.set_parameter_count (0)
			default_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			object_ctor_token := md_emit.define_member_ref (uni_string, object_type_token,
				default_sig)

				-- Define `.ctor' from `System.CLSCompliantAttribute'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			cls_compliant_ctor_token := md_emit.define_member_ref (uni_string,
				l_cls_compliant_token, l_sig)

			debugger_hidden_ctor_token := md_emit.define_member_ref (uni_string,
				l_debugger_hidden_token, l_sig)

			debugger_step_through_ctor_token := md_emit.define_member_ref (uni_string,
				l_debugger_step_through_token, l_sig)
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
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset
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

	compute_mscorlib_method_tokens is
			-- Compute `to_string_method_token'.
		local
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			to_string_method_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("ToString"), object_type_token, l_sig)

			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			memberwise_clone_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("MemberwiseClone"), object_type_token, l_sig)
		ensure
			to_string_method_token: to_string_method_token /= 0
		end

	compute_ise_runtime_tokens is
			-- Compute `ise_runtime_token'.
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN
			l_runtime_type_token, l_excep_man_token: INTEGER
			l_sig: like field_sig
			l_meth_sig: like method_sig
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

			l_sig := field_sig
			l_sig.reset
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class,
				system_exception_token)
			
			ise_last_exception_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("last_exception"), l_excep_man_token,
				l_sig)
				
				-- Define `ise_in_assertion_token'.
			l_runtime_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("ISE.Runtime.RUN_TIME"),
				ise_runtime_token)

			l_sig.reset
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			
			ise_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("in_assertion"), l_runtime_type_token, l_sig)
				
				-- Define `ise_assertion_tag_token'.
			l_sig.reset
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			ise_assertion_tag_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("assertion_tag"), l_runtime_type_token, l_sig)

				-- Define `ise_**_type_token'.
			ise_eiffel_type_info_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Type_info_class_name), ise_runtime_token)
			ise_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Type_class_name), ise_runtime_token)
			ise_class_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Class_type_class_name), ise_runtime_token)
			ise_generic_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (generic_type_class_name), ise_runtime_token)
			ise_formal_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Formal_type_class_name), ise_runtime_token)
			ise_none_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (None_type_class_name), ise_runtime_token)
			ise_basic_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (basic_type_class_name), ise_runtime_token)
			ise_eiffel_derivation_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("ISE.Runtime.EIFFEL_DERIVATION"), ise_runtime_token)
			ise_eiffel_class_name_attr_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("ISE.Runtime.EIFFEL_CLASS_NAME_ATTRIBUTE"),
				ise_runtime_token)
			ise_generic_conformance_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Generic_conformance_class_name), ise_runtime_token)

			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			
			uni_string.set_string (".ctor")
			ise_eiffel_class_name_attr_ctor_token := md_emit.define_member_ref (uni_string,
				ise_eiffel_class_name_attr_token, l_meth_sig)
		end
	
feature {NONE} -- Mapping between Eiffel compiler and generated tokens

	external_class_mapping: HASH_TABLE [TYPE_I, STRING]
			-- Quickly find a type given its external name.

	external_token_mapping: HASH_TABLE [INTEGER, STRING]
			-- Quickly find a type token given its external name.

	class_mapping: ARRAY [INTEGER]
			-- Array of type token indexed by their `type_id'.

	constructor_token: ARRAY [INTEGER]
			-- Array of ctor token indexed by their `type_id'.

	feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			internal_features_not_void: internal_features /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_features, a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token that sets it.
		require
			internal_setters_not_void: internal_setters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_setters, a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
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
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			internal_implementation_features_not_void: internal_implementation_features /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_implementation_features, a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			internal_attributes_not_void: internal_attributes /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_attributes, a_type_id, a_feature_id)
		ensure
			valid_result: Result /= 0
		end

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
		ensure
			valid_result: Result /= 0
		end

	internal_assemblies: ARRAY [INTEGER]
			-- Array indexed by class ID that contains assembly token.
			
	sequence_point: TUPLE [INTEGER, ARRAY [INTEGER], ARRAY [INTEGER], ARRAY [INTEGER],
			ARRAY [INTEGER], ARRAY [INTEGER]]
		is
			-- For type definition purpose.
		do
		end

	local_debug_info: TUPLE [INTEGER, INTEGER, INTEGER, like local_types] is
			-- For type definition purpose.
		do
		end

	local_info: HASH_TABLE [like local_debug_info, INTEGER]
			-- Table of `method_token' to local definition.

	method_sequence_points: HASH_TABLE [like sequence_point, INTEGER]
			-- Table of `method_token' to sequence points definition.

	dbg_documents: ARRAY [DBG_DOCUMENT_WRITER]
			-- Array indexed by class ID containing all DBG_DOCUMENTS.

	internal_implementation_features: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of features for implementation indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_features: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of features indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_setters: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of attributes setter indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_attributes: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of attributes indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	implementation_signatures_table, signatures_table: ARRAY [HASH_TABLE [ARRAY [INTEGER], INTEGER]]
			-- Array of signatures indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are an array of type id representation signature of
			-- feature `feature_id' in `type_id'.

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_features'.
		require
			internal_features_not_void: internal_features /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			insert_in_table (internal_features, a_token, a_type_id, a_feature_id)
		ensure
			inserted: feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_setter (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_setters'.
		require
			internal_setters_not_void: internal_setters /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			insert_in_table (internal_setters, a_token, a_type_id, a_feature_id)
		ensure
			inserted: setter_token (a_type_id, a_feature_id) = a_token
		end

	insert_implementation_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in
			-- `internal_implementation_features'.
		require
			internal_implementation_features_not_void: internal_implementation_features /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			insert_in_table (internal_implementation_features, a_token, a_type_id, a_feature_id)
		ensure
			inserted: implementation_feature_token (a_type_id, a_feature_id) = a_token
		end

	insert_attribute (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_features'.
		require
			internal_attributes_not_void: internal_attributes /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			insert_in_table (internal_attributes, a_token, a_type_id, a_feature_id)
		ensure
			inserted: attribute_token (a_type_id, a_feature_id) = a_token
		end

	insert_in_table (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_token, a_type_id, a_feature_id: INTEGER)
		is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_attributes'.
		require
			a_table_not_void: a_table /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
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
			inserted: implementation_signatures_table.item (a_type_id).item (a_feature_id) =
				a_signature
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
			inserted: signatures_table.item (a_type_id).item (a_feature_id) = a_signature
		end

	assembly_token (a_class: CLASS_C): INTEGER is
			-- Given `a_class' find its associated assembly token.
		require
			a_class_not_void: a_class /= Void
		do
			Result := internal_assemblies.item (a_class.class_id)
			if Result = 0 then
					-- Assembly token has not yet been computed.
				find_and_insert_assembly_token (a_class)
				Result := internal_assemblies.item (a_class.class_id)
			end
		end

	find_and_insert_assembly_token (a_class: CLASS_C) is
			-- Given `a_class' find out which assembly defines it and updates
			-- `internal_assemblies' accordingly. Create assembly reference
			-- as they are needed.
		require
			a_class_not_void: a_class /= Void
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_indexes: INDEXING_CLAUSE_AS
			l_info: ARRAY [STRING]
			l_name, l_key_string, l_version: STRING
			l_token: INTEGER
			l_key_token: MD_PUBLIC_KEY_TOKEN
			l_major, l_minor, l_build, l_revision: INTEGER
			l_pos, l_new_pos: INTEGER
			l_uni_string: UNI_STRING
		do
			if not a_class.is_external then
				internal_assemblies.put (main_module_token, a_class.class_id)
			else
				l_indexes := a_class.ast.top_indexes
				if l_indexes /= Void then
					l_info := l_indexes.assembly_name
					l_name := l_info.item (1)
					if defined_assemblies.has (l_name) then
						internal_assemblies.put (defined_assemblies.found_item, a_class.class_id)
					else
						if l_name.is_equal ("mscorlib") then
							internal_assemblies.put (mscorlib_token, a_class.class_id)
							defined_assemblies.put (mscorlib_token, l_name)
						elseif l_name.is_equal ("ise_runtime") then
							internal_assemblies.put (ise_runtime_token, a_class.class_id)
							defined_assemblies.put (ise_runtime_token, l_name)
						else
							create l_ass_info.make

							if l_info.valid_index (2) then
								l_version := l_info.item (2)

								l_pos := 1
								l_new_pos := l_version.index_of ('.', l_pos)
								l_major := l_version.substring (l_pos, l_new_pos - 1).to_integer

								l_pos := l_new_pos + 1
								l_new_pos := l_version.index_of ('.', l_pos)
								l_minor := l_version.substring (l_pos, l_new_pos - 1).to_integer

								l_pos := l_new_pos + 1
								l_new_pos := l_version.index_of ('.', l_pos)
								l_build := l_version.substring (l_pos, l_new_pos - 1).to_integer

								l_pos := l_new_pos + 1
								l_revision := l_version.substring (l_pos, l_version.count).to_integer

								l_ass_info.set_major_version (l_major.to_integer_16)
								l_ass_info.set_minor_version (l_minor.to_integer_16)
								l_ass_info.set_build_number (l_build.to_integer_16)
								l_ass_info.set_revision_number (l_revision.to_integer_16)
							end

							if l_info.valid_index (4) then
								l_key_string := l_info.item (4)
								if l_key_string /= Void then
									create l_key_token.make_from_string (l_key_string)
								end
							end
							
								-- NOTE: cannot use `uni_string' buffer as current feature can
								-- be used with other features that already uses it to define
								-- some metadata.
							create l_uni_string.make (l_name)
							
							l_token := md_emit.define_assembly_ref (l_uni_string, l_ass_info,
								l_key_token)
							internal_assemblies.put (l_token, a_class.class_id)						
							defined_assemblies.put (l_token, l_name)
						end
					end
				end
			end
		ensure
			updated: internal_assemblies.item (a_class.class_id) /= 0
		end
	
	defined_assemblies: HASH_TABLE [INTEGER, STRING]
			-- In order to avoid calling `define_assembly_ref' twice on same assemblies.

feature {NONE} -- Implementation

	buffer: GENERATION_BUFFER is
			-- Inherited feature from ASSERT_TYPE which is not used therefore hidden.
		do
			check
				not_callable: False
			end
		end
	
end -- class IL_CODE_GENERATOR
