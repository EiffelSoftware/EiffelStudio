indexing
	description: "[
		Entity that generates IL code into one module file. Stores only
		module specific data such as tokens. Delegate most of the work to
		IL_CODE_GENERATOR.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_MODULE

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
			{ANY} System
		end
	
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		end

	IL_GUIDS
		export
			{NONE} all
		end

	IL_PREDEFINED_CUSTOM_ATTRIBUTES
		export
			{NONE} all
		end

	IL_PREDEFINED_STRINGS
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	HASHABLE
		rename
			hash_code as module_id
		end

create {IL_CODE_GENERATOR}
	make
	
feature {NONE} -- Initialization

	make (
			a_module_name: like module_name;
			a_file_name: like module_file_name;
			a_c_module_name: like c_module_name;
			a_public_key: like public_key;
			a_il_code_generator: like il_code_generator;
			a_assembly_info: like assembly_info;
			a_module_id: INTEGER;
			a_is_debug_mode: BOOLEAN;
			a_is_main_module: BOOLEAN)
		is
			-- Create a new module of name `a_file_name' using metadata dispenser `a_dispenser'.
			-- If `a_is_main_module', current is an assembly manifest.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_module_name_not_void: a_module_name /= Void
			a_module_name_not_empty: not a_module_name.is_empty
			a_il_code_generator_not_void: a_il_code_generator /= Void
			a_module_id_non_negative: a_module_id > 0
		do
			module_name := a_module_name
			module_file_name := a_file_name
			public_key := a_public_key
			il_code_generator := a_il_code_generator
			assembly_info := a_assembly_info
			module_id := a_module_id
			is_debug_info_enabled := a_is_debug_mode
			is_assembly_module := a_is_main_module
			if not is_assembly_module then
				is_dll := True
				is_console_application := True
			end
			c_module_name := a_c_module_name
			object_type_id := system.system_object_class.compiled_class.types.first.static_type_id
			any_type_id := system.any_class.compiled_class.types.first.static_type_id
		ensure
			module_file_name_set: module_file_name = a_file_name
			module_name_set: module_name = a_module_name
			c_module_name_set: c_module_name = a_c_module_name
			public_key_set: public_key = a_public_key
			il_code_generator_set: il_code_generator = a_il_code_generator
			assembly_info_set: assembly_info = a_assembly_info
			is_debug_info_enabled_set: is_debug_info_enabled = a_is_debug_mode
			is_assembly_module_set: is_assembly_module = a_is_main_module
		end

feature -- Access

	il_code_generator: IL_CODE_GENERATOR
			-- To generate IL code.

	md_emit: MD_EMIT
			-- Metadata emitter.
			
	method_writer: MD_METHOD_WRITER
			-- Store byte code of features in memory.

	module_name: STRING
			-- Name of current module

	module_file_name: STRING
			-- Location where current will be generated.

	module_id: INTEGER
			-- Identifier for current module in current system.

	c_module_name: STRING
			-- Name of DLL where C externals used by Current module are stored.
			
	assembly_info: ASSEMBLY_INFO
			-- Assembly information if current is an assembly manifest.
		--require
		--	is_assembly_module: is_assembly_module

	public_key: MD_PUBLIC_KEY
			-- Public key if used and if current is an assembly manifest.
		--require
		--	is_assembly_module: is_assembly_module

feature -- Status report

	is_generated: BOOLEAN
			-- Is current used for reference purpose only, or for actual code generation.

	is_saved: BOOLEAN
			-- Was current already saved to disk?

	is_debug_info_enabled: BOOLEAN
			-- Is debug information generated along with Current?
			
	is_assembly_module: BOOLEAN
			-- Does current represent an assembly manifest?
			-- I.e. an assembly is made of modules and of one assembly manifest which
			-- is a module with `Assembly' table metadata.
			
	is_dll, is_console_application: BOOLEAN
			-- Nature of generated module.

feature -- Access: tokens

	entry_point_token: INTEGER
			-- Token for `Main' static feature in an assembly generated
			-- as an `exe'.

	associated_assembly_token: INTEGER
			-- Token for current assembly
		--require
		--	is_assembly_module: is_assembly_module

	c_module_token: INTEGER
			-- Token for C module containing all C externals.

	mscorlib_token: INTEGER
			-- Token for `mscorlib' assembly.

	runtime_type_handle_token: INTEGER
			-- Token for `System.RuntimeTypeHandle' in `mscorlib'.

	object_type_token: INTEGER
			-- Token for `System.Object' in `mscorlib'.

	math_type_token: INTEGER
			-- Token for `System.Math' type in `mscorlib'.

	char_type_token: INTEGER
			-- Token for `System.Char' type in `mscorlib'.

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

	com_visible_ctor_token: INTEGER
			-- Token for `System.Runtime.InteropServices.ComVisibleAttribute' constructor.

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

	ise_in_assertion_token, ise_set_in_assertion_token: INTEGER
			-- Token for `ISE.RUNTIME.in_assertion' and `ISE.RUNTIME.set_in_assertion'
			-- static members that holds status of assertion checking.

	ise_assertion_tag_token: INTEGER
			-- Token for `ISE.RUNTIME.assertion_tag' static field that holds
			-- message for exception being thrown.

	ise_set_type_token: INTEGER
			-- Token for `ISE.Runtime.EIFFEL_TYPE_INFO.____set_type' feature that
			-- assign type information of a class.

	ise_check_invariant_token: INTEGER
			-- Token for `ISE.Runtime.ise_check_invariant' feature that
			-- checks a class invariant.

	ise_is_invariant_checked_for_token: INTEGER
			-- Token for `ISE.RUNTIME.is_invariant_checked_for' feature that
			-- tells if a class invariant has been checked or not for a given type.

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
	ise_eiffel_class_name_attr_ctor_token,
	type_handle_class_token: INTEGER
			-- Token for run-time types used in code generation.

feature -- Access: types

	local_types: ARRAYED_LIST [PAIR [TYPE_I, STRING]] is
			-- To store types of local variables. For type definition only here.
		do
		end

	object_type_id, any_type_id: INTEGER
			-- Type id of SYSTEM_OBJECT and ANY class.

feature {NONE} -- Access: code generation

	uni_string: UNI_STRING
			-- Buffer for all unicode string conversion.

feature {NONE} -- Access: metadata generation

	last_parents: ARRAY [INTEGER]
			-- List of parents tokens last described after call to `update_parents'.

	single_inheritance_parent_id: INTEGER
			-- Implementation ID of parent when no interface is being generated:
			-- either if `is_single_inheritance_implementation' or if class `is_single'.

	single_inheritance_token: INTEGER
			-- Token of parent class when no interface is being generated:
			-- either if `is_single_inheritance_implementation' or if class `is_single'.
			
	is_single_inheritance_implementation: BOOLEAN is
			-- Is current generation of type SINGLE_IL_CODE_GENERATOR?
		do
			Result := il_code_generator.is_single_inheritance_implementation
		end

feature -- Access: signatures

	default_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a feature with no arguments and no return type.
			-- Used to define default constructors and other features with same signature.

	method_sig: MD_METHOD_SIGNATURE
			-- Permanent signature for features.

	field_sig: MD_FIELD_SIGNATURE
			-- Permanent signature for attributes.

	local_sig: MD_LOCAL_SIGNATURE
			-- Permanent signature for locals.

feature -- Settings: Generation type

	set_console_application is
			-- Current module is marked as being a CONSOLE application.
		do
			is_console_application := True
		ensure
			is_console_application_set: is_console_application
		end

	set_window_application is
			-- Current module is marked as being a WINDOW application.
		do
			is_console_application := False
		ensure
			is_console_application_set: not is_console_application
		end

	set_dll is
			-- Current module is a DLL.
		do
			is_dll := True
		ensure
			is_dll_set: is_dll
		end

feature -- Settings: signature

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_gen_type: NATIVE_ARRAY_TYPE_I
		do
			if a_type.is_basic then
				a_sig.set_return_type (a_type.element_type, 0)
			else
				l_gen_type ?= a_type
				if l_gen_type /= Void then
					a_sig.set_return_type (
						feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					set_signature_type (a_sig, l_gen_type.true_generics.item (1))
				else
					a_sig.set_return_type (a_type.element_type,
						class_type_token (a_type.static_type_id))
				end
			end
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_gen_type: NATIVE_ARRAY_TYPE_I
		do
			if a_type.is_basic then
				a_sig.set_type (a_type.element_type, 0)
			else
				l_gen_type ?= a_type
				if l_gen_type /= Void then
					if a_type.is_out then
						a_sig.set_byref_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					else
						a_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					end
					set_signature_type (a_sig, l_gen_type.true_generics.item (1))
				else
					if a_type.is_out then
						a_sig.set_byref_type (a_type.element_type,
							class_type_token (a_type.static_type_id))
					else
						a_sig.set_type (a_type.element_type,
							class_type_token (a_type.static_type_id))
					end
				end
			end
		end

feature -- Code generation

	prepare (a_dispenser: MD_DISPENSER; a_count: INTEGER) is
			-- Prepare Current to start metadata and code generation.
		require
			a_dispenser_not_void: a_dispenser /= Void
			a_count_positive: a_count > 0
			not_is_generated: not is_generated
		local
			ass: MD_ASSEMBLY_INFO
			l_assembly_flags: INTEGER
			l_version: VERSION
		do
				-- Mark Current has being generated.
			is_generated := True
			
			md_emit := a_dispenser.emitter
			create method_writer.make
			
				-- Create unicode string buffer.
			create uni_string.make_empty (1024)

				-- Create default signature.
			create default_sig.make
			default_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			default_sig.set_parameter_count (0)
			default_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Create permanent signature for feature.
			create method_sig.make
			create field_sig.make
			create local_sig.make

			entry_point_token := 0

			initialize_mapping (a_count)
			initialize_tokens
			initialize_runtime_type_class_mappings

			uni_string.set_string (module_name)

			if is_assembly_module then
				create ass.make
				create l_version
				if l_version.is_version_valid (assembly_info.version) then
					l_version.set_version (assembly_info.version)
					ass.set_major_version (l_version.major.to_integer_16)
					ass.set_minor_version (l_version.minor.to_integer_16)
					ass.set_build_number (l_version.build.to_integer_16)
					ass.set_revision_number (l_version.revision.to_integer_16)
				end
				
				if public_key /= Void then
					l_assembly_flags := feature {MD_ASSEMBLY_FLAGS}.public_key
				end
				associated_assembly_token :=
					md_emit.define_assembly (uni_string, l_assembly_flags, ass, public_key)
				il_code_generator.define_custom_attribute (associated_assembly_token,
					com_visible_ctor_token, not_com_visible_ca)
			end

			md_emit.set_module_name (uni_string)

			if is_debug_info_enabled then
				uni_string.set_string (module_file_name)
				create dbg_writer.make (md_emit, uni_string, True)
			end
		ensure
			is_generated_set: is_generated
		end

	define_entry_point
			(creation_type_id: INTEGER; a_class_type: CLASS_TYPE; a_feature_id: INTEGER)
		is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_class_type'.
		require
			is_generated: is_generated
			positive_creation_type_id: creation_type_id > 0
			a_class_type_not_void: a_class_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			entry_type_token: INTEGER
			l_sig: like method_sig
			l_type_id: INTEGER
		do
			l_type_id := a_class_type.static_type_id

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
				feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
				feature {MD_METHOD_ATTRIBUTES}.Static, l_sig,
				feature {MD_METHOD_ATTRIBUTES}.Managed)

			if is_debug_info_enabled then
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_step_through_ctor_token, debugger_step_through_ca)
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_hidden_ctor_token, debugger_hidden_ca)
			end

			il_code_generator.start_new_body (entry_point_token)
			il_code_generator.method_body.put_call (feature {MD_OPCODES}.Newobj,
				constructor_token (creation_type_id), 0, True)
			il_code_generator.method_body.put_call (feature {MD_OPCODES}.Callvirt,
				feature_token (l_type_id, a_feature_id), 0, False)
			il_code_generator.method_body.put_opcode (feature {MD_OPCODES}.Ret)

			method_writer.write_current_body
		end

	save_to_disk is
			-- Save byte code and metadata to file `module_file_name'.
		require
			is_generated: is_generated
		local
			l_pe_file: CLI_PE_FILE
			l_debug_info: MANAGED_POINTER
			l_dbg_directory: CLI_DEBUG_DIRECTORY
		do
			create l_pe_file.make (module_file_name, is_dll or is_console_application, is_dll)
			if is_debug_info_enabled then
				create l_dbg_directory.make
				l_debug_info := dbg_writer.debug_info (l_dbg_directory)
				l_pe_file.set_debug_information (l_dbg_directory, l_debug_info)
				dbg_writer.close
			end
			if public_key /= Void then
				l_pe_file.set_public_key (public_key)
			end
			l_pe_file.set_emitter (md_emit)
			l_pe_file.set_method_writer (method_writer)
			if entry_point_token /= 0 then
				l_pe_file.set_entry_point_token (entry_point_token)
			end
			l_pe_file.save

			wipe_out
			is_generated := False
			is_saved := True
		ensure
			is_generated_set: not is_generated
			is_saved: is_saved
		end

feature -- Metadata description

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Define all types, both external and eiffel one.
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
		local
			name, impl_name: STRING
			native_array: NATIVE_ARRAY_CLASS_TYPE
			l_external_class: EXTERNAL_CLASS_C
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_type: CL_TYPE_I
			l_nested_parent_class: CLASS_C
			l_nested_parent_class_token: INTEGER
			l_one_element_array: ARRAY [INTEGER]
		do
			class_c := class_type.associated_class

			native_array ?= class_type
			if native_array /= Void then
					-- Generate association with a NATIVE_ARRAY []
				name := native_array.il_type_name
				uni_string.set_string (name)
				l_type_token := md_emit.define_type_ref (uni_string, assembly_token (class_type))
				class_mapping.put (l_type_token, class_type.static_type_id)
				il_code_generator.external_class_mapping.put (class_type.type, name)
				internal_external_token_mapping.put (l_type_token, name)
			else
				name := class_type.full_il_type_name
				if not class_c.is_external then
					impl_name := class_type.full_il_implementation_type_name
				end

				if class_c.is_external then
					l_external_class ?= class_c
					if l_external_class /= Void and then l_external_class.is_nested then
						l_nested_parent_class := l_external_class.enclosing_class
						uni_string.set_string (l_nested_parent_class.types.first.full_il_type_name)
						l_nested_parent_class_token := md_emit.define_type_ref (uni_string,
							assembly_token (l_nested_parent_class.types.first))
						uni_string.set_string (name.substring (
							name.index_of ('+', 1) + 1, name.count))
						l_type_token := md_emit.define_type_ref (uni_string,
							l_nested_parent_class_token)
					else
						uni_string.set_string (name)
						l_type_token := md_emit.define_type_ref (uni_string,
							assembly_token (class_type))
					end
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
					il_code_generator.external_class_mapping.put (l_type, name)
					internal_external_token_mapping.put (l_type_token, name)
				else
					update_parents (class_type, class_c)
					if not (class_c.is_frozen or class_c.is_single) then
							-- Let's define interface class.
						uni_string.set_string (name)
						l_attributes := feature {MD_TYPE_ATTRIBUTES}.Public |
							feature {MD_TYPE_ATTRIBUTES}.Auto_layout |
							feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
							feature {MD_TYPE_ATTRIBUTES}.Is_interface |
							feature {MD_TYPE_ATTRIBUTES}.Abstract
						if
							class_type.is_precompiled or
							il_code_generator.il_modules (class_type) /= Current
						then
							l_type_token := md_emit.define_type_ref (uni_string,
								assembly_token (class_type))
						else
							if class_type.static_type_id = any_type_id then
									-- By default interface of ANY does not implement any other
									-- interfaces than EIFFEL_TYPE_INFO.
								l_type_token := md_emit.define_type (uni_string, l_attributes, 0,
									<< ise_eiffel_type_info_type_token >>)
							else
								l_type_token := md_emit.define_type (uni_string, l_attributes, 0,
									last_parents)
							end
							class_type.set_last_type_token (l_type_token)
						end
						class_mapping.put (l_type_token, class_type.static_type_id)
						il_code_generator.external_class_mapping.put (class_type.type, name)
						internal_external_token_mapping.put (l_type_token, name)
						uni_string.set_string (impl_name)
					else
						uni_string.set_string (name)
					end

						-- Let's define implementation class.
					l_attributes := feature {MD_TYPE_ATTRIBUTES}.Public |
						feature {MD_TYPE_ATTRIBUTES}.Auto_layout |
						feature {MD_TYPE_ATTRIBUTES}.Ansi_class |
						feature {MD_TYPE_ATTRIBUTES}.Is_class |
						feature {MD_TYPE_ATTRIBUTES}.Serializable

					if class_c.is_deferred then
						l_attributes := l_attributes | feature {MD_TYPE_ATTRIBUTES}.Abstract
					end

					if
						class_type.is_precompiled or
						il_code_generator.il_modules (class_type) /= Current
					then
						l_type_token := md_emit.define_type_ref (uni_string,
							assembly_token (class_type))
					else
						if class_c.is_frozen then
							l_attributes := l_attributes | feature {MD_TYPE_ATTRIBUTES}.Sealed
						elseif not class_c.is_single then
							create l_one_element_array.make (0, 1)
							l_one_element_array.put (class_type_token (class_type.static_type_id),
								0)
							last_parents := l_one_element_array
						end
						single_parent_mapping.put (single_inheritance_parent_id,
							class_type.implementation_id)
						l_type_token := md_emit.define_type (uni_string, l_attributes,
							single_inheritance_token, last_parents)

						if not (class_c.is_frozen or class_c.is_single) then
							class_type.set_last_implementation_type_token (l_type_token)
						else
							class_type.set_last_type_token (l_type_token)
						end
						
						if
							is_debug_info_enabled and then
							internal_dbg_documents.item (class_c.class_id) = Void
						then
							uni_string.set_string (class_c.file_name)
							internal_dbg_documents.put (dbg_writer.define_document (uni_string,
								language_guid, vendor_guid, document_type_guid), class_c.class_id)
						end

					end

					class_mapping.put (l_type_token, class_type.implementation_id)
					if class_c.is_frozen or class_c.is_single then
						class_mapping.put (l_type_token, class_type.static_type_id)
					end
					il_code_generator.external_class_mapping.put (class_type.type, impl_name)
					internal_external_token_mapping.put (l_type_token, impl_name)

					if
						not class_type.is_precompiled and then
						il_code_generator.il_modules (class_type) = Current
					then
						define_default_constructor (class_type)
					end
				end
			end
		end

	update_parents (class_type: CLASS_TYPE; class_c: CLASS_C) is
			-- Generate ancestors map of `class_c'.
			-- (export status {NONE})
		require
			is_generated: is_generated
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			cl_type: CLASS_TYPE
			l_list: SEARCH_TABLE [INTEGER]
			id: INTEGER
			i: INTEGER
			l_parents: ARRAY [INTEGER]
			l_parent_class: CLASS_C
			l_class_type: CLASS_TYPE
			l_single_inheritance_parent_id: like single_inheritance_parent_id
		do
			l_class_type := byte_context.class_type
			parents := class_c.parents
			from
				create l_list.make (parents.count)
				parents.start
				create l_parents.make (0, parents.count)
				l_single_inheritance_parent_id := 0
			until
				parents.after
			loop
				byte_context.set_class_type (class_type)
				parent_type ?= byte_context.real_type (parents.item.type_i)
				cl_type := parent_type.associated_class_type
				id := cl_type.static_type_id
				if not l_list.has (id) then
					l_list.force (id)
					l_parent_class := cl_type.associated_class
					if
						not l_parent_class.is_single and
						(not l_parent_class.is_external or else l_parent_class.is_interface)
					then
							-- Add parent interfaces only.
						l_parents.put (class_type_token (cl_type.static_type_id), i)
						i := i + 1
						if
							is_single_inheritance_implementation and then
							not class_c.is_single and then not l_parent_class.is_interface and then
							l_single_inheritance_parent_id = 0 and then
							l_parent_class = class_c.main_parent
						then
								-- We arbitrary take the first parent as principal parent if
								-- it does not inherit already from an external class, in which
								-- case it goes through a different line of code.
								-- FIXME: Manu 4/15/2002: To optimize we should take the one
								-- with the most features
							l_single_inheritance_parent_id := cl_type.implementation_id
						end
					elseif l_parent_class.is_external or else l_parent_class.is_single then
						check
							single_inheritance_parent_id_not_set: l_single_inheritance_parent_id = 0
						end
						l_single_inheritance_parent_id := cl_type.implementation_id
							-- Note: We do not add into `pars' as we only store there the
							-- parents than can be included as interfaces.
					end
				end
				parents.forth
			end

			if l_single_inheritance_parent_id = 0 then
				single_inheritance_parent_id := object_type_id
				single_inheritance_token := object_type_token
			else
				single_inheritance_token := class_type_token (l_single_inheritance_parent_id)
				single_inheritance_parent_id := l_single_inheritance_parent_id
			end

				-- Element after last added should be 0.
			if i = 0 then
				last_parents := Void
			else
				l_parents.put (0, i)
				last_parents := l_parents
			end

				-- Restore byte context if any.
			if l_class_type /= Void then
				byte_context.set_class_type (l_class_type)
			end
		end

	define_default_constructor (class_type: CLASS_TYPE) is
			-- Define default constructor for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		local
			l_meth_token: INTEGER
			l_sig: like method_sig
			l_ctor_token: INTEGER
			l_uni_string: like uni_string
		do
				-- Do not use `uni_string' as it might be used by `class_type_token'.
			create l_uni_string.make (".ctor")
			l_sig := default_sig

			if
				class_type.is_precompiled or class_type.associated_class.is_external or
				il_code_generator.il_modules (class_type) /= Current
			then
				l_meth_token := md_emit.define_member_ref (l_uni_string,
					class_type_token (class_type.implementation_id), l_sig)
			else
				l_meth_token := md_emit.define_method (l_uni_string,
					class_type_token (class_type.implementation_id),
					feature {MD_METHOD_ATTRIBUTES}.Public |
					feature {MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					feature {MD_METHOD_ATTRIBUTES}.Special_name |
					feature {MD_METHOD_ATTRIBUTES}.Rt_special_name,
					l_sig, feature {MD_METHOD_ATTRIBUTES}.Managed)

				l_ctor_token := constructor_token (single_parent_mapping.item (
						class_type.implementation_id))

				il_code_generator.start_new_body (l_meth_token)
				il_code_generator.generate_current
				il_code_generator.method_body.put_call (feature {MD_OPCODES}.Call, l_ctor_token,
					0, False)
				il_code_generator.generate_return
				method_writer.write_current_body

			end
			internal_constructor_token.put (l_meth_token, class_type.implementation_id)
		end

feature -- Local saving

	store_locals (a_local_types: like local_types; a_meth_token: INTEGER) is
			-- Store `local_types' into `il_code_generator.method_body' for routine `a_meth_token'.
		require
			is_generated: is_generated
			method_token_valid: a_meth_token & feature {MD_TOKEN_TYPES}.Md_mask =
				feature {MD_TOKEN_TYPES}.Md_method_def
		local
			l_sig: like local_sig
			l_count: INTEGER
			l_loc_token: INTEGER
		do
			l_count := a_local_types.count

			if l_count > 0 then
				l_sig := local_sig
				l_sig.reset

				l_sig.set_local_count (l_count)

				from
					a_local_types.start
				until
					a_local_types.after
				loop
					set_signature_type (l_sig,
						il_code_generator.argument_actual_type (a_local_types.item.first))
					a_local_types.forth
				end

				l_loc_token := md_emit.define_signature (l_sig)
				il_code_generator.method_body.set_local_token (l_loc_token)
			end

			if is_debug_info_enabled then
				l_count := il_code_generator.local_count
				if il_code_generator.result_position /= -1 then
					l_count := l_count + 1
				end
				local_info.put ([
					il_code_generator.local_start_offset,
					il_code_generator.local_end_offset, l_count,
					a_local_types], a_meth_token)
				il_code_generator.reset_local_types
			else
				a_local_types.wipe_out
			end
		end

	generate_local_debug_info (a_method_token: INTEGER) is
			-- Generate local information about routine `method_token'.
		require
			is_generated: is_generated
			debug_info_requested: is_debug_info_enabled
			method_token_valid: a_method_token & feature {MD_TOKEN_TYPES}.Md_mask =
				feature {MD_TOKEN_TYPES}.Md_method_def
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
							class_type_token (l_type.static_type_id))
					end
					uni_string.set_string (l_locals.item.second)
					dbg_writer.define_local_variable (uni_string, i, l_sig)
					l_locals.forth
					i := i +1
				end
				dbg_writer.close_scope (l_end_offset)
			end
		end

feature -- Debug info

	dbg_writer: DBG_WRITER
			-- PDB writer.

feature -- Mapping between Eiffel compiler and generated tokens

	external_token_mapping (a_type_name: STRING): INTEGER is
			-- Quickly find a type token given its external_name.
		require
			a_type_name_not_void: a_type_name /= Void
			a_type_name_not_empty: not a_type_name.is_empty
		local
			l_class_type: CLASS_TYPE
		do
			Result := internal_external_token_mapping.item (a_type_name)
			if Result = 0 then
				l_class_type := il_code_generator.external_class_mapping.item (a_type_name).
					associated_class_type
				generate_class_mappings (l_class_type)
				Result := internal_external_token_mapping.item (a_type_name)
			end
		ensure
			external_token_mapping_valid:
				Result & feature {MD_TOKEN_TYPES}.Md_mask = feature {MD_TOKEN_TYPES}.Md_type_ref
		end

	internal_external_token_mapping: HASH_TABLE [INTEGER, STRING]
			-- Quickly find a type token given its external name.

	class_mapping: ARRAY [INTEGER]
			-- Array of type token indexed by their `type_id'.

	single_parent_mapping: ARRAY [INTEGER]
			-- Array of type token showing single inheritance parent for a given `type_id'.

	internal_constructor_token: ARRAY [INTEGER]
			-- Array of ctor token indexed by their `type_id'.

	constructor_token (a_type_id: INTEGER): INTEGER is
			-- Token identifier for default constructor of `a_type_id'.
		require
			is_generated: is_generated
			valid_type_id: a_type_id > 0
		local
			l_tokens: like internal_constructor_token
		do
			l_tokens := internal_constructor_token
			Result := l_tokens.item (a_type_id)
			if Result = 0 then
				define_default_constructor (class_types.item (a_type_id))
				Result := l_tokens.item (a_type_id)
			end
		ensure
			constructor_token_valid: Result /= Void
		end

	invariant_token (a_type_id: INTEGER): INTEGER is
			-- Metadata token of invariant feature in class type `a_type_id'.
		require
			is_generated: is_generated
			type_id_valid: a_type_id > 0
		local
			l_sig: like method_sig
			l_class_type: CLASS_TYPE
		do
			Result := internal_invariant_token.item (a_type_id)
			if Result = 0 then
 				l_class_type := class_types.item (a_type_id)

					-- Generate reference to invariant defined in a different assembly.
				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				set_signature_type (l_sig, l_class_type.type)

				Result := md_emit.define_member_ref (create {UNI_STRING}.make ("$$_invariant"),
					class_type_token (a_type_id), l_sig)
				internal_invariant_token.put (Result, a_type_id)
			end
		ensure
			invariant_token_valid: Result /= 0
		end
	
	internal_invariant_token: ARRAY [INTEGER]
			-- Array of invariant feature indexed by `type_id' of class in
			-- which they are defined.

	class_type_token (a_type_id: INTEGER): INTEGER is
			-- Given `a_type_id' returns its associated metadata token.
		require
			is_generated: is_generated
			valid_type_id: a_type_id > 0
		local
			l_class_mapping: like class_mapping
			l_class_types: like class_types
		do
			l_class_mapping := class_mapping
			Result := l_class_mapping.item (a_type_id)
			if Result = 0 then
					-- Although we do not require `is_generated' for `class_type_token'
					-- we need it in the case it was not yet generated.
				check
					is_generated: is_generated
				end
				l_class_types := class_types
				generate_class_mappings (l_class_types.item (a_type_id))
				Result := l_class_mapping.item (a_type_id)
			end
		ensure
			class_token_valid: Result /= 0
		end

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		do
			if internal_class_types = Void then
				internal_class_types := il_code_generator.class_types
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
			is_generated: is_generated
			internal_features_not_void: internal_features /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_features, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, False, False)
				Result := table_token (internal_features, a_type_id, a_feature_id)
			end
		ensure
			feature_token_valid: Result /= 0
		end

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token that sets it.
		require
			is_generated: is_generated
			internal_setters_not_void: internal_setters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_setters, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, False, False)
				Result := table_token (internal_setters, a_type_id, a_feature_id)
			end
		ensure
			setter_token_valid: Result /= 0
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			is_generated: is_generated
			internal_implementation_features_not_void: internal_implementation_features /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_implementation_features, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, True, False)
				Result := table_token (internal_implementation_features, a_type_id, a_feature_id)
			end
		ensure
			valid_result: Result /= 0
		end

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			is_generated: is_generated
			internal_attributes_not_void: internal_attributes /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_attributes, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, False, False)
				Result := table_token (internal_attributes, a_type_id, a_feature_id)
			end
		ensure
			valid_result: Result /= 0
		end

	table_token (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_type_id, a_feature_id: INTEGER): INTEGER
		is
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			is_generated: is_generated
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

	internal_assemblies: ARRAY [INTEGER]
			-- Array indexed by type ID that contains assembly token.

	internal_module_references: HASH_TABLE [INTEGER, IL_MODULE]
			-- Array of ModuleRef token indexed by their associated module

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

	local_info: HASH_TABLE [like local_debug_info, INTEGER]
			-- Table of `method_token' to local definition.

	method_sequence_points: HASH_TABLE [LINKED_LIST [like sequence_point], INTEGER]
			-- Table of `method_token' to sequence points definition.

	dbg_documents (a_class_id: INTEGER): DBG_DOCUMENT_WRITER is
			-- Associated document to `a_class_id'.
		require
			is_generated: is_generated
			in_debug_mode: is_debug_info_enabled
		local
			l_string: UNI_STRING
			l_class: CLASS_C
		do
			Result := internal_dbg_documents.item (a_class_id)
			if Result = Void then
				l_class := System.class_of_id (a_class_id)
				create l_string.make (l_class.file_name)
				Result := dbg_writer.define_document (l_string, language_guid,
					vendor_guid, document_type_guid)
				internal_dbg_documents.put (Result, a_class_id)
			end
		ensure
			dbg_documents_not_void: Result /= Void
		end

	internal_dbg_documents: ARRAY [DBG_DOCUMENT_WRITER]
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

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

	clean_implementation_class_data (a_type_id: INTEGER) is
			-- Clean current class implementation data.
		require
			is_generated: is_generated
			a_type_id_valid: a_type_id > 0
		do
			internal_features.put (Void, a_type_id)
		end

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER) is
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_features'.
		require
			is_generated: is_generated
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
			is_generated: is_generated
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
			is_generated: is_generated
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
			is_generated: is_generated
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
			is_generated: is_generated
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

	assembly_token (a_class_type: CLASS_TYPE): INTEGER is
			-- Given `a_class_type' find its associated assembly token.
		require
			is_generated: is_generated
			a_class_type_not_void: a_class_type /= Void
		do
			Result := internal_assemblies.item (a_class_type.implementation_id)
			if Result = 0 then
					-- Assembly token has not yet been computed.
				find_and_insert_assembly_token (a_class_type)
				Result := internal_assemblies.item (a_class_type.implementation_id)
			end
		end

	module_reference_token (a_class_type: CLASS_TYPE): INTEGER is
			-- Given `a_class_type' from current assembly find its associated module token.
		require
			is_generated: is_generated
			a_class_type_not_void: a_class_type /= Void
			a_class_type_is_generated: a_class_type.is_generated
		local
			l_module: IL_MODULE
			l_uni_string: UNI_STRING
		do
			l_module := il_code_generator.il_modules (a_class_type)
			check
					-- Cannot be current since we are looking for a reference to another
					-- module.
				l_module_not_current: l_module /= Current
			end
			Result := internal_module_references.item (l_module)
			if Result = 0 then
					-- ModuleRef token has not yet computed.
				create l_uni_string.make (l_module.module_name)
				Result := md_emit.define_module_ref (l_uni_string)
				internal_module_references.put (Result, l_module)
			end
		end

	find_and_insert_assembly_token (a_class_type: CLASS_TYPE) is
			-- Given `a_class_type' find out which assembly defines it and updates
			-- `internal_assemblies' accordingly. Create assembly reference
			-- as they are needed.
		require
			is_generated: is_generated
			a_class_not_void: a_class_type /= Void
			not_inserted: internal_assemblies.item (a_class_type.implementation_id) = 0
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_indexes: INDEXING_CLAUSE_AS
			l_info: ARRAY [STRING]
			l_name, l_key_string, l_culture, l_version_string: STRING
			l_version: VERSION
			l_token: INTEGER
			l_key_token: MD_PUBLIC_KEY_TOKEN
			l_major, l_minor, l_build, l_revision: INTEGER
			l_uni_string: UNI_STRING
			l_external_class: EXTERNAL_CLASS_C
			l_assembly: ASSEMBLY_I
			l_precompiled_assembly: ASSEMBLY_INFO
			l_native_array: NATIVE_ARRAY_CLASS_TYPE
		do
			l_native_array ?= a_class_type
			if l_native_array /= Void then
				internal_assemblies.put (
					assembly_token (l_native_array.deep_il_element_type.associated_class_type),
					a_class_type.implementation_id)
			elseif a_class_type.is_generated then
					-- We need to find in which module it is being defined. If no `module_ref'
					-- token is found for this module, we need to create one for Current module.
					--FIXME: I'm not sure what to do when `a_class_type' is defined in current
					-- moudle.
				internal_assemblies.put (
					module_reference_token (a_class_type), a_class_type.implementation_id)
			else
				if
					not a_class_type.associated_class.is_external and then
					a_class_type.is_precompiled
				then
					l_precompiled_assembly := a_class_type.assembly_info
					l_name := l_precompiled_assembly.assembly_name
					l_version_string := l_precompiled_assembly.version
					l_culture := l_precompiled_assembly.culture
					l_key_string := l_precompiled_assembly.public_key_token
				else
					l_external_class ?= a_class_type.associated_class
					if l_external_class /= Void then
							-- When it is an XML represented external class.
						l_assembly := l_external_class.lace_class.assembly
						l_name := l_assembly.assembly_name
						l_version_string := l_assembly.version
						l_culture := l_assembly.culture
						l_key_string := l_assembly.public_key_token
					else
							-- When it is an actual Eiffel class encapsulating
							-- an external class.
						l_indexes := a_class_type.associated_class.ast.top_indexes
						check
							l_indexes_not_void: l_indexes /= Void
						end
						l_info := l_indexes.assembly_name
						l_name := l_info.item (1)
						if l_info.valid_index (2) then
							l_version_string := l_info.item (2)
						end
						if l_info.valid_index (4) then
							l_key_string := l_info.item (4)
						end
					end
				end
				if defined_assemblies.has (l_name) then
					internal_assemblies.put (defined_assemblies.found_item,
						a_class_type.implementation_id)
				else
					if l_name.is_equal ("mscorlib") then
						internal_assemblies.put (mscorlib_token, a_class_type.implementation_id)
						defined_assemblies.put (mscorlib_token, l_name)
					elseif l_name.is_equal ("ISE.Runtime") then
						internal_assemblies.put (ise_runtime_token, a_class_type.implementation_id)
						defined_assemblies.put (ise_runtime_token, l_name)
					else
						create l_ass_info.make

						create l_version
						if l_version.is_version_valid (l_version_string) then
							l_version.set_version (l_version_string)
							l_major := l_version.major
							l_minor := l_version.minor
							l_build := l_version.build
							l_revision := l_version.revision

							l_ass_info.set_major_version (l_major.to_integer_16)
							l_ass_info.set_minor_version (l_minor.to_integer_16)
							l_ass_info.set_build_number (l_build.to_integer_16)
							l_ass_info.set_revision_number (l_revision.to_integer_16)
						end

						if l_key_string /= Void then
							create l_key_token.make_from_string (l_key_string)
						end

							-- NOTE: cannot use `uni_string' buffer as current feature can
							-- be used with other features that already uses it to define
							-- some metadata.
						create l_uni_string.make (l_name)

						l_token := md_emit.define_assembly_ref (l_uni_string, l_ass_info,
							l_key_token)
						internal_assemblies.put (l_token, a_class_type.implementation_id)
						defined_assemblies.put (l_token, l_name)
					end
				end
			end
		ensure
			updated: internal_assemblies.item (a_class_type.implementation_id) /= 0
		end

	defined_assemblies: HASH_TABLE [INTEGER, STRING]
			-- In order to avoid calling `define_assembly_ref' twice on same assemblies.

feature {NONE} -- Once per modules being generated.

	initialize_mapping (a_type_count: INTEGER) is
			-- Following calls to current will only be `generate_class_mappings'.
		require
			is_generated: is_generated
			a_type_count_positive: a_type_count > 0
		do
			create class_mapping.make (0, a_type_count)
			create single_parent_mapping.make (0, a_type_count)
			create internal_external_token_mapping.make (a_type_count)
			create internal_invariant_token.make (0, a_type_count)
			create internal_constructor_token.make (0, a_type_count)
			create internal_assemblies.make (0, a_type_count)
			create internal_module_references.make (10)
			create defined_assemblies.make (10)
			create internal_features.make (0, a_type_count)
			create internal_setters.make (0, a_type_count)
			create internal_attributes.make (0, a_type_count)
			create internal_implementation_features.make (0, a_type_count)

				-- Debug data structure.
			create internal_dbg_documents.make (0, a_type_count)
			create method_sequence_points.make (1000)
			create local_info.make (1000)
			internal_class_types := Void
		end

	initialize_runtime_type_class_mappings is
			-- Initializes correspondance between .NET runtime types and Eiffel types.
		require
			is_generated: is_generated
		local
			l_sig: like method_sig
			l_meth_token: INTEGER
			l_gen: like il_code_generator
		do
			l_gen := il_code_generator
			class_mapping.put (ise_type_token, l_gen.runtime_type_id)
			class_mapping.put (ise_class_type_token, l_gen.class_type_id)
			class_mapping.put (ise_basic_type_token, l_gen.basic_type_id)
			class_mapping.put (ise_generic_type_token, l_gen.generic_type_id)
			class_mapping.put (ise_formal_type_token, l_gen.formal_type_id)
			class_mapping.put (ise_none_type_token, l_gen.none_type_id)
			class_mapping.put (ise_eiffel_type_info_type_token, l_gen.eiffel_type_info_type_id)
			class_mapping.put (ise_generic_conformance_token, l_gen.generic_conformance_type_id)

			internal_external_token_mapping.put (ise_type_token, Type_class_name)
			internal_external_token_mapping.put (ise_class_type_token, Class_type_class_name)
			internal_external_token_mapping.put (ise_basic_type_token, Basic_type_class_name)
			internal_external_token_mapping.put (ise_generic_type_token, Generic_type_class_name)
			internal_external_token_mapping.put (ise_formal_type_token, Formal_type_class_name)
			internal_external_token_mapping.put (ise_none_type_token, None_type_class_name)
			internal_external_token_mapping.put (ise_eiffel_type_info_type_token,
				Type_info_class_name)
			internal_external_token_mapping.put (ise_generic_conformance_token,
				Generic_conformance_class_name)
			internal_external_token_mapping.put (type_handle_class_token,
				Type_handle_class_name)

			l_sig := default_sig
			uni_string.set_string (".ctor")

			l_meth_token := md_emit.define_member_ref (uni_string, ise_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.runtime_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_class_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.class_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_basic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.basic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_generic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.generic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_formal_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.formal_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_none_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.none_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string,
				ise_eiffel_type_info_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.eiffel_type_info_type_id)
		ensure
			inserted:
				class_type_token (il_code_generator.runtime_type_id) = ise_type_token and
				class_type_token (il_code_generator.class_type_id) = ise_class_type_token and
				class_type_token (il_code_generator.basic_type_id) = ise_basic_type_token and
				class_type_token (il_code_generator.generic_type_id) = ise_generic_type_token and
				class_type_token (il_code_generator.formal_type_id) = ise_formal_type_token and
				class_type_token (il_code_generator.none_type_id) = ise_none_type_token and
				class_type_token (il_code_generator.eiffel_type_info_type_id) = ise_eiffel_type_info_type_token
		end
	
	initialize_tokens is
			-- Recompute all tokens in context of newly created module.
		require
			is_generated: is_generated
		do
			mscorlib_token := 0
			object_type_token := 0
			math_type_token := 0
			system_exception_token := 0
			compute_mscorlib_token
			compute_mscorlib_type_tokens
			compute_power_method_token
			compute_mscorlib_method_tokens
			compute_ise_runtime_tokens
			compute_c_module_token
		end

	compute_c_module_token is
			-- Compute `c_module_token'.
		require
			is_generated: is_generated
		local
			l_uni_string: UNI_STRING
		do
			create l_uni_string.make (c_module_name)
			c_module_token := md_emit.define_module_ref (l_uni_string)
		end

	compute_mscorlib_token is
			-- Compute `mscorlib_token'.
		require
			is_generated: is_generated
			has_system_object: System.system_object_class /= Void
			system_object_compiled: System.system_object_class.is_compiled
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN
			l_system_object: EXTERNAL_CLASS_I
			l_mscorlib: ASSEMBLY_I
			l_version: VERSION
		do
				-- To compute it, we simply take the data from `System.Object'. That way our
				-- code is automatically using the version of `mscorlib' that was specified
				-- in the Ace file.
			l_system_object := System.system_object_class
			l_mscorlib := l_system_object.assembly
			
			create l_version
			check
				version_valid: l_version.is_version_valid (l_mscorlib.version)
			end
			
			l_version.set_version (l_mscorlib.version)
			create l_ass_info.make
			l_ass_info.set_major_version (l_version.major.to_integer_16)
			l_ass_info.set_minor_version (l_version.minor.to_integer_16)
			l_ass_info.set_build_number (l_version.build.to_integer_16)
			l_ass_info.set_revision_number (l_version.revision.to_integer_16)

			create l_pub_key.make_from_string (l_mscorlib.public_key_token)

			mscorlib_token := md_emit.define_assembly_ref (
				create {UNI_STRING}.make (l_mscorlib.assembly_name), l_ass_info, l_pub_key)

			type_handle_class_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Type_handle_class_name), mscorlib_token)
		end

	compute_mscorlib_type_tokens is
			-- Compute `double_type_token', `math_type_token'.
		require
			is_generated: is_generated
			valid_mscorlib_token: mscorlib_token /= 0
			object_type_token_not_set: object_type_token = 0
			math_type_token_not_set: math_type_token = 0
			system_exception_token_not_set: system_exception_token = 0
		local
			l_sig: like method_sig
			l_cls_compliant_token: INTEGER
			l_com_visible_token: INTEGER
			l_debugger_step_through_token: INTEGER
			l_debugger_hidden_token: INTEGER
		do
			object_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Object"), mscorlib_token)
			runtime_type_handle_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (type_handle_class_name), mscorlib_token)
			math_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Math"), mscorlib_token)
			char_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Char"), mscorlib_token)
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
			l_com_visible_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.Runtime.InteropServices.ComVisibleAttribute"),
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
			object_ctor_token := md_emit.define_member_ref (uni_string, object_type_token,
				default_sig)

				-- Define `.ctor' from `System.CLSCompliantAttribute' and
				-- `System.Runtime.InteropServices.ComVisibleAttribute'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			cls_compliant_ctor_token := md_emit.define_member_ref (uni_string,
				l_cls_compliant_token, l_sig)

			com_visible_ctor_token := md_emit.define_member_ref (uni_string,
				l_com_visible_token, l_sig)

			l_sig.reset
			l_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

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
			is_generated: is_generated
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
			uni_string.set_string ("Pow")
			power_method_token := md_emit.define_member_ref (uni_string, math_type_token, l_sig)
		ensure
			power_method_token_set: power_method_token /= 0
		end

	compute_mscorlib_method_tokens is
			-- Compute `to_string_method_token'.
		require
			is_generated: is_generated
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
		require
			is_generated: is_generated
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_pub_key: MD_PUBLIC_KEY_TOKEN
			l_excep_man_token: INTEGER
			l_sig: like field_sig
			l_meth_sig: like method_sig
		do
				-- Define `ise_runtime_token'.
			create l_ass_info.make
			l_ass_info.set_major_version (5)
			l_ass_info.set_minor_version (3)

			create l_pub_key.make_from_array (
				<<0xDE, 0xF2, 0x6F, 0x29, 0x6E, 0xFE, 0xF4, 0x69>>)

			ise_runtime_token := md_emit.define_assembly_ref (
				create {UNI_STRING}.make ("ISE.Runtime"), l_ass_info, l_pub_key)

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
			ise_runtime_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (runtime_class_name), ise_runtime_token)

			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("in_assertion"), ise_runtime_type_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0) 

			ise_set_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("set_in_assertion"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_assertion_tag_token'.
			l_sig.reset
			l_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			ise_assertion_tag_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("assertion_tag"), ise_runtime_type_token, l_sig)

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

				-- Define `ise_set_type_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_class, 
				ise_eiffel_derivation_type_token)

			ise_set_type_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("____set_type"),
				ise_eiffel_type_info_type_token, l_meth_sig)

				-- Define `ise_check_invariant_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_object, 0) 
			ise_check_invariant_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("check_invariant"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_is_invariant_checked_for'.
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				runtime_type_handle_token) 
			ise_is_invariant_checked_for_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("is_invariant_checked_for"),
				ise_runtime_type_token, l_meth_sig)

				-- Define constructor of custom attribute class that keeps Eiffel
				-- name classes in their Eiffel formatting.
			l_meth_sig.reset
			l_meth_sig.set_method_type (feature {MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type (feature {MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			uni_string.set_string (".ctor")
			ise_eiffel_class_name_attr_ctor_token := md_emit.define_member_ref (uni_string,
				ise_eiffel_class_name_attr_token, l_meth_sig)
		end

feature {NONE} -- Cleaning

	wipe_out is
			-- Free all used memory.
		do
			assembly_info := Void
			class_mapping := Void
			dbg_writer := Void
			default_sig := Void
			defined_assemblies.wipe_out
			defined_assemblies := Void
			field_sig := Void
			internal_assemblies := Void
			internal_attributes := Void
			internal_class_types := Void
			internal_constructor_token := Void
			internal_dbg_documents := Void
			internal_external_token_mapping := Void
			internal_features := Void
			internal_implementation_features := Void
			internal_invariant_token := Void
			internal_module_references := Void
			internal_setters := Void
			last_parents := Void
			local_info := Void
			local_sig := Void
			md_emit := Void
			method_sequence_points := Void
			method_sig := Void
			method_writer := Void
			public_key := Void
			single_parent_mapping := Void
			uni_string := Void
		end

invariant
	md_emit_not_void: is_generated implies md_emit /= Void
	module_file_name_not_void: module_file_name /= Void
	module_file_name_not_empty: not module_file_name.is_empty
	il_code_generator_not_void: il_code_generator /= Void
	dll_or_console_valid: not is_assembly_module implies (is_dll and is_console_application)

end -- class IL_MODULE
