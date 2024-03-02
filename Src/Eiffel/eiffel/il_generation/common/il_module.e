note
	description: "[
		Entity that generates IL code into one module file. Stores only
		module specific data such as tokens. Delegate most of the work to
		IL_CODE_GENERATOR.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_MODULE

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
			{ANY} system, workbench
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	CLI_EMITTER_SERVICE
		export
			{NONE} all
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

	SHARED_IL_CONSTANTS
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

	SHARED_ERROR_HANDLER

	REFACTORING_HELPER

	INTERNAL_COMPILER_STRING_EXPORTER

create {CIL_CODE_GENERATOR}
	make

feature {NONE} -- Initialization

	make (
			a_module_name_with_extension: like module_name_with_extension;
			a_file_name: like module_file_name;
			a_c_module_name: like c_module_name;
			a_public_key: like public_key;
			a_il_code_generator: like il_code_generator;
			a_assembly_info: like assembly_info;
			a_module_id: INTEGER;
			a_is_debug_mode: BOOLEAN;
			a_is_main_module: BOOLEAN;
			a_is_using_multi_assembly: BOOLEAN)

			-- Create a new module of name `a_file_name' using metadata dispenser `a_dispenser'.
			-- If `a_is_main_module', current is an assembly manifest.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_module_name_not_void: a_module_name_with_extension /= Void
			a_module_name_not_empty: not a_module_name_with_extension.is_empty
			a_module_name_with_extension: a_module_name_with_extension.has ('.')
			a_il_code_generator_not_void: a_il_code_generator /= Void
			a_module_id_non_negative: a_module_id > 0
		local
			i: INTEGER
			f_ext, ext: READABLE_STRING_8
		do
			debug ("il_emitter_table")
				print ({STRING_32} "IL_MODULE: " + a_module_name_with_extension + "%N")
			end

			i := a_file_name.last_index_of ('.', a_file_name.count)
			if i > 0 then
				f_ext := a_file_name.substring (i + 1, a_file_name.count).to_string_8 -- Unicode extension string is not expected
			else
				check module_file_name_has_extension: False end
				f_ext := "dll" -- Default
			end

			i := a_module_name_with_extension.last_index_of ('.', a_module_name_with_extension.count)
			if i > 0 then
				ext := a_module_name_with_extension.substring (i + 1, a_module_name_with_extension.count).to_string_8 -- Unicode extension string is not expected
				if ext.is_case_insensitive_equal ("exe") or ext.is_case_insensitive_equal ("dll") then
					module_name_with_extension := a_module_name_with_extension
					module_name := a_module_name_with_extension.substring (1, i - 1)
				else
					check has_valid_extension: False end
					module_name := a_module_name_with_extension
					if f_ext /= Void then
						module_name_with_extension := a_module_name_with_extension + "." + f_ext
					else
						check has_extension: False end
						module_name_with_extension := a_module_name_with_extension
					end
				end
			else
				check has_extension: False end
				module_name := a_module_name_with_extension
				if f_ext /= Void then
					module_name_with_extension := a_module_name_with_extension + "." + f_ext
				else
					check has_extension: False end
					module_name_with_extension := a_module_name_with_extension
				end
			end
			module_file_name := a_file_name
			public_key := a_public_key
			il_code_generator := a_il_code_generator
			assembly_info := a_assembly_info
			module_id := a_module_id
			is_debug_info_enabled := a_is_debug_mode
			is_using_multi_assemblies := a_is_using_multi_assembly
			is_assembly_module := a_is_main_module
			if not is_assembly_module then
				is_dll := True
				is_console_application := True
			end
			c_module_name := a_c_module_name
			object_type_id := system.system_object_class.compiled_class.types.first.static_type_id
			value_type_id := system.system_value_type_class.compiled_class.types.first.static_type_id
			any_type_id := system.any_class.compiled_class.types.first.static_type_id
		ensure
			module_file_name_set: module_file_name = a_file_name
			module_name_set: module_name_with_extension = a_module_name_with_extension
			c_module_name_set: c_module_name = a_c_module_name
			public_key_set: public_key = a_public_key
			il_code_generator_set: il_code_generator = a_il_code_generator
			assembly_info_set: assembly_info = a_assembly_info
			is_debug_info_enabled_set: is_debug_info_enabled = a_is_debug_mode
			is_assembly_module_set: is_assembly_module = a_is_main_module
			thread_static_attribute_not_defined: not is_thread_static_attribute_defined
			helper_class_not_defined: not is_once_string_class_defined
			once_string_field_cil_not_defined: not is_once_string_field_cil_defined
			once_string_field_eiffel_not_defined: not is_once_string_field_eiffel_defined
			once_string_allocation_routine_not_defined: not is_once_string_allocation_routine_defined
		end

feature -- Access

	il_code_generator: CIL_CODE_GENERATOR
			-- To generate IL code.

	md_emit: MD_EMIT
			-- Metadata emitter.

	method_writer: MD_METHOD_WRITER
			-- Store byte code of features in memory.

	module_name: STRING
			-- Name of current module

	module_name_with_extension: STRING
			-- Name of current module with extension

	module_file_name: READABLE_STRING_32
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

	resources: CLI_RESOURCES
			-- List of resources used by this module.

feature -- Status report

	is_generated: BOOLEAN
			-- Is current used for reference purpose only, or for actual code generation.

	is_saved: BOOLEAN
			-- Was current already saved to disk?

	is_debug_info_enabled: BOOLEAN
			-- Is debug information generated along with Current?

	is_assembly_module: BOOLEAN
			-- Does current represent an assembly manifest?
			-- I.e. an assembly is made of modules/assemblies and of one assembly manifest which
			-- is a module with `Assembly' table metadata.

	is_using_multi_assemblies: BOOLEAN
			-- Using multi-assemblies instead of multi-modules.

	is_dll, is_console_application: BOOLEAN
			-- Nature of generated module.

	is_32bits: BOOLEAN
			-- Should assembly be generated as a 32bit assembly

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
			-- NOTE: it may also be System.Runtime assembly...

	runtime_type_handle_token: INTEGER
			-- Token for `System.RuntimeTypeHandle' in `mscorlib'.

	object_type_token: INTEGER
			-- Token for `System.Object' in `mscorlib'.

	value_type_token: INTEGER
			-- Token for `System.ValueType' in `mscorlib'.

	math_type_token: INTEGER
			-- Token for `System.Math' type in `mscorlib'.

	real_32_type_token: INTEGER
			-- Token for `System.Single' type in `mscorlib'.

	real_64_type_token: INTEGER
			-- Token for `System.Double' type in `mscorlib'.

	char_type_token: INTEGER
			-- Token for `System.Char' type in `mscorlib'.

	string_type_token: INTEGER
			-- Token for `System.String' type in `mscorlib'.

	system_exception_token: INTEGER
			-- Token for `System.Exception' type in `mscorlib'.

	to_string_method_token: INTEGER
			-- Token for `System.Object.ToString' feature in `mscorlib'.

	power_method_token: INTEGER
			-- Token for `System.Math.Power' feature in `mscorlib'.

	cls_compliant_ctor_token: INTEGER
			-- Token for `System.CLSCompliantAttribute' constructor.

	com_visible_ctor_token: INTEGER
			-- Token for `System.Runtime.InteropServices.ComVisibleAttribute' constructor.

	debuggable_ctor_token: INTEGER
			-- Token for constructor of `System.Diagnostics.DebuggableAttribute'.

	debugger_hidden_ctor_token, debugger_step_through_ctor_token: INTEGER
			-- Token for constructor of `System.Diagnostics.DebuggerHiddenAttribute' and
			-- `System.Diagnostics.DebuggerStepThroughAttribute'.

	memberwise_clone_token: INTEGER
			-- Token for `MemberwiseClone' of `System.Object'.

	ise_runtime_token: INTEGER
			-- Token for `ise_runtime' assembly

	ise_set_last_exception_token: INTEGER
			-- Token for `ISE.Runtime.set_last_exception' that passes excepton object
			-- we got from `catch' to exception manager.

	ise_get_last_exception_token: INTEGER
			-- Token for `ISE.Runtime.get_last_exception' that returns excepton object
			-- from exception manager.

	ise_restore_last_exception_token: INTEGER
			-- Token for `ISE.Runtime.restore_last_exception' that restore `last_exception'
			-- at the end of a rescue clause.

	ise_raise_code_token: INTEGER
			-- Token for `ISE.Runtime.raise_code' that raises exception of a given code.

	ise_rethrow_token: INTEGER
			-- Token for `ISE.Runtime.rethrow' that raises exception at the end of rescue clause.

	ise_raise_old_token: INTEGER
			-- Token for `ISE.Runtime.raise_old' that raise old violation when there was exception
			-- during old expression evaluation

	ise_enter_rescue_token: INTEGER
			-- Token for `ISE.Runtime.enter_rescue' that increase rescue level when entering rescue.

	ise_get_rescue_level_token, ise_set_rescue_level_token: INTEGER
			-- Tokens for `ISE.Runtime.get_rescue_level' and `ISE.Runtime.set_rescue_level'
			-- static members that holds rescue level.

	ise_in_assertion_token, ise_set_in_assertion_token: INTEGER
			-- Token for `ISE.Runtime.in_assertion' and `ISE.Runtime.set_in_assertion'
			-- static members that holds status of assertion checking.

	ise_in_precondition_token, ise_set_in_precondition_token: INTEGER
			-- Token for `ISE.Runtime.in_precondition' and `ISE.Runtime.set_in_precondition'
			-- static members that holds status of precondition checking.

	ise_caller_supplier_precondition_token: INTEGER
			-- Token for `ISE.Runtime.caller_supplier_precondition'

	ise_assertion_tag_token: INTEGER
			-- Token for `ISE.Runtime.assertion_tag' static field that holds
			-- message for exception being thrown.

	ise_get_type_token: INTEGER
			-- Token for `ISE.Runtime.EIFFEL_TYPE_INFO.____type' feature that
			-- returns generic type information of a class.

	ise_check_invariant_token: INTEGER
			-- Token for `ISE.Runtime.ise_check_invariant' feature that
			-- checks a class invariant.

	ise_is_invariant_checked_for_token: INTEGER
			-- Token for `ISE.Runtime.is_invariant_checked_for' feature that
			-- tells if a class invariant has been checked or not for a given type.

	ise_eiffel_type_info_type_token,
	ise_runtime_type_token,
	ise_exception_manager_type_token,
	ise_rt_extension_type_token,
	ise_type_token,
	ise_generic_conformance_token,
	ise_class_type_token,
	ise_generic_type_token,
	ise_tuple_type_token,
	ise_formal_type_token,
	ise_none_type_token,
	ise_basic_type_token,
	ise_type_feature_attr_ctor_token,
	ise_eiffel_name_attr_ctor_token,
	ise_eiffel_name_attr_generic_ctor_token,
	ise_assertion_level_attr_ctor_token,
	ise_interface_type_attr_ctor_token,
	ise_eiffel_consumable_attr_ctor_token,
	ise_eiffel_class_type_mark_attr_ctor_token,
	type_handle_class_token,
	ise_assertion_level_enum_token,
	ise_class_type_mark_enum_token,
	dotnet_non_serialized_attr_ctor_token,
	ise_eiffel_version_attr_ctor_token: INTEGER
			-- Token for run-time types used in code generation.

feature {NONE} -- Custom attributes: access

	thread_static_attribute_ctor_token: INTEGER
			-- Token of ThreadStaticAttribute constructor

	is_thread_static_attribute_defined: BOOLEAN
			-- Is token of ThreadStaticAttribute constructor defined?
		do
			Result := thread_static_attribute_ctor_token /= 0
		ensure
			definition: Result implies thread_static_attribute_ctor_token /= 0
		end

feature {CIL_CODE_GENERATOR} -- Custom attributes: modification

	define_thread_static_attribute (field_token: INTEGER)
			-- Define a ThreadStaticAttribute attribute for field identified by `field_token'.
		require
			valid_token: field_token /= 0
				-- member_token is FieldDef
		local
			attribute_class_token: INTEGER
			l_method_sig: like method_sig
		do
			if not is_thread_static_attribute_defined then
				attribute_class_token := md_emit.define_type_ref (uni_string ("System.ThreadStaticAttribute"), mscorlib_token)
				l_method_sig := method_sig
				l_method_sig.reset
				l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current | {MD_SIGNATURE_CONSTANTS}.default_sig)
				l_method_sig.set_parameter_count (0)
				l_method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				thread_static_attribute_ctor_token := md_emit.define_member_ref (dot_ctor_uni_string, attribute_class_token, l_method_sig)
			end
			md_emit.define_custom_attribute (field_token, thread_static_attribute_ctor_token, empty_ca).do_nothing
		end

feature {CIL_CODE_GENERATOR} -- Synchronization tokens

	define_monitor_method_token (method_name: STRING): INTEGER
			-- Define token for a procedure of type "System.Threading.Monitor" that takes one argument of type "System.Object"
		require
			method_name_not_void: method_name /= Void
			method_name_is_valid:
				method_name.is_equal ("Enter") or else method_name.is_equal ("Exit") or else
				method_name.is_equal ("Pulse") or else method_name.is_equal ("PulseAll")
		local
			monitor_token: INTEGER
			l_mscorlib_token: INTEGER
			l_sig: like method_sig
			l_version: VERSION
			l_ass_info: MD_ASSEMBLY_INFO
			l_system_threading: ASSEMBLY_I
		do
			l_mscorlib_token := mscorlib_token
			if system.is_il_netcore then
				l_system_threading := if attached system.system_threading_monitor_class.public_assembly as l_assembly then l_assembly else system.system_threading_monitor_class.assembly end
				create l_version
				check
					version_valid: l_version.is_version_valid (l_system_threading.assembly_version)
				end

				l_version.set_version (l_system_threading.assembly_version)
				l_ass_info := md_factory.assembly_info
				l_ass_info.set_major_version (l_version.major.to_natural_16)
				l_ass_info.set_minor_version (l_version.minor.to_natural_16)
				l_ass_info.set_build_number (l_version.build.to_natural_16)
				l_ass_info.set_revision_number (l_version.revision.to_natural_16)


				l_mscorlib_token := define_assembly_reference ("System.Threading", l_ass_info.string, "", l_system_threading.assembly_public_key_token)
			end


			monitor_token := md_emit.define_type_ref (uni_string ("System.Threading.Monitor"), l_mscorlib_token)
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_object, 0)
			Result := md_emit.define_member_ref (uni_string (method_name), monitor_token, l_sig)
		ensure
			defined: Result /= 0
		end

feature {CIL_CODE_GENERATOR} -- Once manifest strings: access

	once_string_field_token (a_type: INTEGER): INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- `a_type': string_type_cil, string_type_string, string_type_string_32
		local
			once_string_field_name: CLI_STRING
			l_field_sig: like field_sig
		do
			if a_type = string_type_cil then
				Result := once_string_field_cil_token
				once_string_field_name := once_string_field_cil_name
			elseif a_type = string_type_string then
				Result := once_string_field_eiffel_token
				once_string_field_name := once_string_field_eiffel_name
			elseif a_type = string_type_immutable_string_8 then
				Result := once_immutable_string_8_field_eiffel_token
				once_string_field_name := once_immutable_string_8_field_eiffel_name
			elseif a_type = string_type_immutable_string_32 then
				Result := once_immutable_string_32_field_eiffel_token
				once_string_field_name := once_immutable_string_32_field_eiffel_name
			else
				Result := once_string_32_field_eiffel_token
				once_string_field_name := once_string_32_field_eiffel_name
			end
			if Result = 0 then
					-- Get token of the field that keeps once manifest strings.
					-- Define field signature.
				l_field_sig := field_sig
				l_field_sig.reset
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				if a_type = string_type_cil then
					l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
				else
					if a_type = string_type_string then
						l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class,
							actual_class_type_token (system.string_8_class.compiled_class.types.first.static_type_id))
					elseif a_type = string_type_immutable_string_8 then
						l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class,
							actual_class_type_token (system.immutable_string_8_class.compiled_class.types.first.static_type_id))
					elseif a_type = string_type_immutable_string_32 then
						l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class,
							actual_class_type_token (system.immutable_string_32_class.compiled_class.types.first.static_type_id))
					else
						l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class,
							actual_class_type_token (system.string_32_class.compiled_class.types.first.static_type_id))
					end
				end
					-- Define field token.
				Result := md_emit.define_member_ref (once_string_field_name, once_string_class_token, l_field_sig)
				if a_type = string_type_cil then
					once_string_field_cil_token := Result
				elseif a_type = string_type_string then
					once_string_field_eiffel_token := Result
				elseif a_type = string_type_immutable_string_8 then
					once_immutable_string_8_field_eiffel_token := Result
				elseif a_type = string_type_immutable_string_32 then
					once_immutable_string_32_field_eiffel_token := Result
				else
					once_string_32_field_eiffel_token := Result
				end
			end
		ensure
			valid_result: Result /= 0
			cil_token_defined: (a_type = string_type_cil) implies is_once_string_field_cil_defined
			string_eiffel_token_defined: (a_type = string_type_string) implies is_once_string_field_eiffel_defined
			string_32_eiffel_token_defined: (a_type = string_type_string_32) implies is_once_string_32_field_eiffel_defined
			consistent_cil_result: (a_type = string_type_cil) implies Result = once_string_field_cil_token
			consistent_eiffel_string_result: (a_type = string_type_string) implies Result = once_string_field_eiffel_token
			consistent_eiffel_string_32_result: (a_type = string_type_string_32) implies Result = once_string_32_field_eiffel_token
			old_cil_token_preserved: (old is_once_string_field_cil_defined) implies once_string_field_cil_token = old once_string_field_cil_token
			old_eiffel_string_token_preserved: (old is_once_string_field_eiffel_defined) implies once_string_field_eiffel_token = old once_string_field_eiffel_token
			old_eiffel_string_32_token_preserved: (old is_once_string_32_field_eiffel_defined) implies once_string_32_field_eiffel_token = old once_string_32_field_eiffel_token
		end

	once_string_allocation_routine_token: INTEGER
			-- Token of a routine that allocates array to store once manifest string values
		local
			l_method_sig: like method_sig
		do
			Result := once_string_allocation_routine_token_value
			if Result = 0 then
					-- Get token of the routine that allocates arrays for once manifest strings.
					-- Define method signature.
				l_method_sig := method_sig
				l_method_sig.reset
				l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
				l_method_sig.set_parameter_count (2)
				l_method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
				l_method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
				l_method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
					-- Define method token.
				Result := md_emit.define_member_ref (once_string_allocation_routine_name, once_string_class_token, l_method_sig)
				once_string_allocation_routine_token_value := Result
			end
		ensure
			valid_result: Result /= 0
			token_defined: is_once_string_allocation_routine_defined
			consistent_result: Result = once_string_allocation_routine_token_value
			old_token_preserved: (old is_once_string_allocation_routine_defined) implies Result = old once_string_allocation_routine_token_value
		end

feature {CIL_CODE_GENERATOR} -- Once manifest strings: status report

	is_once_string_class_defined: BOOLEAN
			-- Is token of a run-time helper class to manage once strings defined?
		do
			Result := once_string_class_token_value /= 0
		ensure
			definition: Result implies once_string_class_token_value /= 0
		end

	is_once_string_field_cil_defined: BOOLEAN
			-- Is token of a field that is used to store values of CIL once manifest strings defined?
		do
			Result := once_string_field_cil_token /= 0
		ensure
			definition: Result implies once_string_field_cil_token /= 0
		end

	is_once_string_field_eiffel_defined: BOOLEAN
			-- Is token of a field that is used to store values of Eiffel once manifest strings defined?
		do
			Result := once_string_field_eiffel_token /= 0
		ensure
			definition: Result implies once_string_field_eiffel_token /= 0
		end

	is_once_string_32_field_eiffel_defined: BOOLEAN
			-- Is token of a field that is used to store values of Eiffel once manifest strings (STRING_32) defined?
		do
			Result := once_string_32_field_eiffel_token /= 0
		ensure
			definition: Result implies once_string_32_field_eiffel_token /= 0
		end

	is_once_immutable_string_8_field_eiffel_defined: BOOLEAN
			-- Is token of a field that is used to store values of Eiffel once manifest strings (IMMUTABLE_STRING_8) defined?
		do
			Result := once_immutable_string_8_field_eiffel_token /= 0
		ensure
			definition: Result implies once_immutable_string_8_field_eiffel_token /= 0
		end

	is_once_immutable_string_32_field_eiffel_defined: BOOLEAN
			-- Is token of a field that is used to store values of Eiffel once manifest strings (IMMUTABLE_STRING_32) defined?
		do
			Result := once_immutable_string_32_field_eiffel_token /= 0
		ensure
			definition: Result implies once_immutable_string_32_field_eiffel_token /= 0
		end

	is_once_string_allocation_routine_defined: BOOLEAN
			-- Is token of a routine that allocates array to store once manifest string values defined?
		do
			Result := once_string_allocation_routine_token_value /= 0
		ensure
			definition: Result implies once_string_allocation_routine_token_value /= 0
		end

feature {CIL_CODE_GENERATOR} -- Once manifest strings: management

	define_once_string_tokens
			-- Define tokens to work with once manifest strings:
			--    helper class
			--    field for CIL strings array
			--    field for Eiffel strings array
			--    method to allocate array
		require
			helper_class_not_defined: not is_once_string_class_defined
			once_string_field_cil_not_defined: not is_once_string_field_cil_defined
			once_string_field_eiffel_not_defined: not is_once_string_field_eiffel_defined
			once_string_allocation_routine_not_defined: not is_once_string_allocation_routine_defined
		local
			helper_class_token: like once_string_class_token_value
			l_field_sig: like field_sig
			l_method_sig: like method_sig
		do
				-- Define helper class.
			helper_class_token := md_emit.define_type (
					runtime_helper_class_name,
					{MD_TYPE_ATTRIBUTES}.Auto_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Public,
					object_type_token,
					Void
				)
			once_string_class_token_value := helper_class_token

				-- Emit field for CIL strings.
			l_field_sig := field_sig
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			once_string_field_cil_token := md_emit.define_field (
				once_string_field_cil_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_string_field_cil_token)

				-- Emit field for Eiffel strings (STRING_8).
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, actual_class_type_token (system.string_8_class.compiled_class.types.first.static_type_id))
			once_string_field_eiffel_token := md_emit.define_field (
				once_string_field_eiffel_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_string_field_eiffel_token)

				-- Emit field for Eiffel strings (STRING_32).
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, actual_class_type_token (system.string_32_class.compiled_class.types.first.static_type_id))
			once_string_32_field_eiffel_token := md_emit.define_field (
				once_string_32_field_eiffel_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_string_32_field_eiffel_token)

				-- Emit field for Eiffel strings (IMMUTABLE_STRING_8).
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, actual_class_type_token (system.immutable_string_8_class.compiled_class.types.first.static_type_id))
			once_immutable_string_8_field_eiffel_token := md_emit.define_field (
				once_immutable_string_8_field_eiffel_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_immutable_string_8_field_eiffel_token)

				-- Emit field for Eiffel strings (IMMUTABLE_STRING_32).
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, actual_class_type_token (system.immutable_string_32_class.compiled_class.types.first.static_type_id))
			once_immutable_string_32_field_eiffel_token := md_emit.define_field (
				once_immutable_string_32_field_eiffel_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_immutable_string_32_field_eiffel_token)


				-- Emit method to allocate storage for strings.
			l_method_sig := method_sig
			l_method_sig.reset
			l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
			l_method_sig.set_parameter_count (2)
			l_method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
			l_method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
			l_method_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_i4, 0)
			once_string_allocation_routine_token_value := md_emit.define_method (
				once_string_allocation_routine_name,
				helper_class_token,
				{MD_METHOD_ATTRIBUTES}.public |
				{MD_METHOD_ATTRIBUTES}.static |
				{MD_METHOD_ATTRIBUTES}.hide_by_signature,
				l_method_sig,
				{MD_METHOD_ATTRIBUTES}.il | {MD_METHOD_ATTRIBUTES}.managed)
		ensure
			helper_class_defined: is_once_string_class_defined
			once_string_field_cil_defined: is_once_string_field_cil_defined
			once_string_field_eiffel_defined: is_once_string_field_eiffel_defined
			once_string_32_field_eiffel_defined: is_once_string_32_field_eiffel_defined
			once_immutable_string_32_field_eiffel_defined: is_once_immutable_string_32_field_eiffel_defined
			once_immutable_string_8_field_eiffel_defined: is_once_immutable_string_8_field_eiffel_defined
			once_string_allocation_routine_defined: is_once_string_allocation_routine_defined
		end

feature {NONE} -- Once manifest strings: names

	runtime_helper_class_name: CLI_STRING
			-- Name of the helper run-time class.
		once
			create Result.make ("EiffelSoftware.Runtime.Data")
		end

	once_string_field_cil_name: CLI_STRING
			-- Name of the once manifest string field to store CIL strings
		once
			create Result.make ("oms_cil")
		end

	once_string_field_eiffel_name: CLI_STRING
			-- Name of the once manifest string field to store Eiffel strings
		once
			create Result.make ("oms_eiffel")
		end

	once_string_32_field_eiffel_name: CLI_STRING
			-- Name of the once manifest string field to store Eiffel strings (STRING_32)
		once
			create Result.make ("oms32_eiffel")
		end

	once_immutable_string_8_field_eiffel_name: CLI_STRING
			-- Name of the once manifest string field to store Eiffel strings
		once
			create Result.make ("omis8_eiffel")
		end

	once_immutable_string_32_field_eiffel_name: CLI_STRING
			-- Name of the once manifest string field to store Eiffel strings (STRING_32)
		once
			create Result.make ("omis32_eiffel")
		end

	once_string_allocation_routine_name: CLI_STRING
			-- Name of the routine that allocates storage for once manifest strings
		once
			create Result.make ("allocate_oms")
		end

feature {NONE} -- Once manifest strings: tokens

	once_string_field_cil_token: INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- of CIL type "string" or 0 if it is not computed yet

	once_string_field_eiffel_token: INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- of Eiffel type "STRING" or 0 if it is not computed yet

	once_string_32_field_eiffel_token: INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- of Eiffel type "STRING_32" or 0 if it is not computed yet

	once_immutable_string_8_field_eiffel_token: INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- of Eiffel type "IMMUTABLE_STRING_8" or 0 if it is not computed yet

	once_immutable_string_32_field_eiffel_token: INTEGER
			-- Token of a field that is used to store values of once manifest strings
			-- of Eiffel type "IMMUTABLE_STRING_32" or 0 if it is not computed yet

	once_string_allocation_routine_token_value: INTEGER
			-- Token of a routine that performs allocation of arrays for once manifest strings

	once_string_class_token_value: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings

	once_string_32_class_token_value: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings (STRING_32)

	once_immutable_string_8_class_token_value: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings (IMMUTABLE_STRING_8)

	once_immutable_string_32_class_token_value: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings (IMMUTABLE_STRING_32)

	main_assembly_ref_token_value: INTEGER
			-- Assembly ref token of main assembly.

	once_string_class_token: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings
		local
			once_string_resolution_token: INTEGER
			anchor_class_type: CLASS_TYPE
		do
			Result := once_string_class_token_value
			if Result = 0 then
					-- Define type reference.
					-- This code is a hack, because it assumes that the run-time
					-- class is generated in the assembly with class ANY.
				anchor_class_type := system.any_class.compiled_class.types.first
				if anchor_class_type.is_precompiled then
						-- Take token of precompiled assembly.
					once_string_resolution_token := assembly_token (anchor_class_type)
				elseif is_assembly_module then
						-- Take token of current module.
					once_string_resolution_token := 1
				else
						-- Take token of main (assembly) module.
					if is_using_multi_assemblies then
						once_string_resolution_token := main_assembly_ref_token
					else
						once_string_resolution_token := 0 -- It seems that using `0` means current assembly...
					end
				end
				Result := md_emit.define_type_ref (runtime_helper_class_name, once_string_resolution_token)
				once_string_class_token_value := Result
			end
		ensure
			valid_result: Result /= 0
			token_defined: is_once_string_class_defined
			consistent_result: Result = once_string_class_token_value
			old_token_preserved: (old is_once_string_class_defined) implies once_string_class_token_value = old once_string_class_token_value
		end

	main_assembly_ref_token: INTEGER
			-- Assembly ref token of the main assembly.
		do
			Result := main_assembly_ref_token_value

			if Result = 0 then
				Result := module_reference_token (il_code_generator.main_module)
				main_assembly_ref_token_value := Result
			end
		ensure
			valid_result: Result /= 0
		end

feature -- Access: types

	local_types: ARRAYED_LIST [PAIR [TYPE_A, STRING]]
			-- To store types of local variables. For type definition only here.
		do
		end

	object_type_id, value_type_id, any_type_id: INTEGER
			-- Type id of SYSTEM_OBJECT, VALUE_TYPE and ANY class.

feature {NONE} -- Access: code generation

	dot_ctor_uni_string: CLI_STRING
		do
			Result := internal_dot_ctor_uni_string
			if Result = Void then
				create Result.make (".ctor")
				internal_dot_ctor_uni_string := Result
			end
		end

	uni_string (s: READABLE_STRING_GENERAL): CLI_STRING
			-- Buffer for all Unicode string conversion.
			-- Do no keep a reference on that result value.
		do
			Result := internal_uni_string
			if Result = Void then
					-- Note: this means, there is no buffer for all unicode string conversion !
					-- `initialize_uni_string` needs to be called for that.
				create Result.make (s)
			else
					-- Reuse CLI_STRING object for performance.
				Result.set_string (s)
			end
		ensure
			expected_string: Result.string_32.same_string_general (s)
		end

	initialize_uni_string (nb: INTEGER)
		do
			if
				attached {EXECUTION_ENVIRONMENT}.item ("ISE_OPTS") as l_opts and then
				l_opts.has_substring ("disable_uni_string_buffer")
			then
					-- Disable uni_string reusable buffer.
				internal_uni_string := Void
			else
				create internal_uni_string.make_empty (1_024)
			end
		end

	reset_uni_string
		do
			internal_uni_string := Void
		end

	internal_uni_string: detachable like uni_string
	internal_dot_ctor_uni_string: detachable like uni_string

feature {NONE} -- Access: metadata generation

	last_parents: ARRAY [INTEGER]
			-- List of parents tokens last described after call to `update_parents'.

	single_inheritance_parent_id: INTEGER
			-- Implementation ID of parent when no interface is being generated:
			-- either if `is_single_inheritance_implementation' or if class `is_single'.

	single_inheritance_token: INTEGER
			-- Token of parent class when no interface is being generated:
			-- either if `is_single_inheritance_implementation' or if class `is_single'.

	is_single_inheritance_implementation: BOOLEAN
			-- Is current generation of type SINGLE_IL_CODE_GENERATOR?
		do
			Result := il_code_generator.is_single_inheritance_implementation
		end

feature -- Access: signatures

	default_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a feature with no arguments and no return type.
			-- Used to define default constructors and other features with same signature.

	generic_ctor_sig: MD_METHOD_SIGNATURE
			-- Precomputed signature of a constructor of generic type.

	method_sig: MD_METHOD_SIGNATURE
			-- Permanent signature for features.

	field_sig: MD_FIELD_SIGNATURE
			-- Permanent signature for attributes.

	local_sig: MD_LOCAL_SIGNATURE
			-- Permanent signature for locals.

feature -- Settings: Generation type

	set_console_application
			-- Current module is marked as being a CONSOLE application.
		do
			is_console_application := True
			is_dll := False
		ensure
			is_console_application_set: is_console_application
		end

	set_window_application
			-- Current module is marked as being a WINDOW application.
		do
			is_console_application := False
			is_dll := False
		ensure
			is_console_application_set: not is_console_application
		end

	set_dll
			-- Current module is a DLL.
		do
			is_console_application := True
			is_dll := True
		ensure
			is_dll_set: is_dll
		end

	set_32bits
			-- Current module is a 32bit module?
		do
			is_32bits := True
		ensure
			is_32bits_set: is_32bits
		end

feature -- Settings

	set_resources (r: like resources)
			-- Set `resources' with `r'.
		require
			r_not_void: r /= Void
		do
			resources := r
		ensure
			resources_set: resources = r
		end

feature -- Settings: signature

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_A; a_context_type: CLASS_TYPE)
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		do
			set_signature_type (a_sig, a_type, a_context_type)
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_A; a_context_type: CLASS_TYPE)
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			l_is_by_ref: BOOLEAN
			l_type: TYPE_A
		do
				-- If it is an instance of TYPED_POINTER then it corresponds to
				-- an out type. We need to extract the real type represented by
				-- TYPED_POINTER.
			l_is_by_ref := is_by_ref_type (a_type)
			if l_is_by_ref then
				l_type := by_ref_type (a_type)
			else
				l_type := a_type
			end
			set_extended_signature_type (a_sig, l_type, l_is_by_ref, a_context_type)
		end

feature {NONE} -- Implementations: signatures

	set_extended_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_A; a_is_by_ref: BOOLEAN; a_context_type: CLASS_TYPE)
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			l_exp_type: CL_TYPE_A
			l_type, l_other_type: TYPE_A
		do
			if a_is_by_ref then
				a_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_byref, 0)
			end
				-- Simply take `actual_type' to resolve directly anchors if any.
			l_type := a_type.actual_type
			if l_type.is_basic or l_type.is_none then
				a_sig.set_type (l_type.element_type, 0)
			elseif l_type.is_formal and then attached {FORMAL_A} l_type as l_formal then
				l_other_type := a_context_type.type.generics.i_th (l_formal.position)
				if l_other_type.is_formal then
					a_sig.set_type (l_type.element_type, 0)
				else
					set_signature_type (a_sig, l_other_type, a_context_type)
				end
			elseif l_type.is_expanded then
					-- Correctly process classes mapped to built-in .NET types.
				l_exp_type := {CL_TYPE_A} / l_type
				if
					l_exp_type /= Void and then
					il_code_generator.il_module (l_exp_type.associated_class_type (a_context_type.type)) /= Current and then
					assembly_token (l_exp_type.associated_class_type (a_context_type.type)) = mscorlib_token and then
					il_code_generator.external_class_mapping.has (l_exp_type.base_class.external_class_name)
				then
					l_exp_type := il_code_generator.external_class_mapping.item (l_exp_type.base_class.external_class_name)
				end
				if l_exp_type /= Void and then l_exp_type.is_basic then
					a_sig.set_type (l_exp_type.element_type, 0)
				else
					a_sig.set_type (l_type.element_type,
						actual_class_type_token (l_type.implementation_id (a_context_type.type)))
				end
			elseif attached {NATIVE_ARRAY_TYPE_A} l_type as l_native_array_type then
				a_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
				set_signature_type (a_sig, l_native_array_type.generics.first, a_context_type)
			else
				a_sig.set_type (l_type.element_type,
					actual_class_type_token (l_type.static_type_id (a_context_type.type)))
			end
		end

feature -- Cleanup

	cleanup
			-- Clean up external data structures.
		do
			internal_dbg_documents := Void
			internal_dbg_pragma_documents := Void
			if attached dbg_writer as l_dbg_writer and then not dbg_writer.is_closed then
				dbg_writer.close (Void)
			end
			dbg_writer := Void
		end

feature -- Code generation

	prepare (a_dispenser: MD_DISPENSER; a_count: INTEGER)
			-- Prepare Current to start metadata and code generation.
		require
			a_dispenser_not_void: a_dispenser /= Void
			a_count_positive: a_count > 0
			not_is_generated: not is_generated
		local
			ass: MD_ASSEMBLY_INFO
			l_assembly_flags: INTEGER
			target_framework_attr_type_token: INTEGER
			l_version: VERSION
			ca: MD_CUSTOM_ATTRIBUTE
			attribute_ctor: INTEGER
			sig: MD_METHOD_SIGNATURE
			ca_token: INTEGER
			i: INTEGER
			rt_v: STRING_32
			l_mod_name_string: CLI_STRING
			md_ui: MD_UI
		do
				-- Mark Current has being generated.
			is_generated := True

			create md_ui.make_with_action (agent (m: detachable READABLE_STRING_GENERAL)
					do
						degree_output.flush_output
					end)

			md_ui.checkpoint (generator + ".prepare")

			md_emit := a_dispenser.emitter (md_ui)
			create method_writer.make

				-- Create Unicode string buffer.
			initialize_uni_string (1024)

				-- Module name
			create l_mod_name_string.make (module_name)
			md_emit.set_module_name (l_mod_name_string)

				-- Create default signature.
			create default_sig.make
			default_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			default_sig.set_parameter_count (0)
			default_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

				-- Create permanent signature for feature.
			create method_sig.make
			create field_sig.make
			create local_sig.make

			entry_point_token := 0

			initialize_mapping (a_count)
			initialize_tokens
			initialize_runtime_type_class_mappings

				-- Create signature of constructor of generic type.
			create generic_ctor_sig.make
			generic_ctor_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			generic_ctor_sig.set_parameter_count (1)
			generic_ctor_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			generic_ctor_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_generic_type_token)

			if is_assembly_module or is_using_multi_assemblies then
				ass := md_factory.assembly_info
				create l_version
				if
					attached assembly_info as l_assembly_info and then
					l_version.is_version_valid (l_assembly_info.version)
				then
					l_version.set_version (l_assembly_info.version)
					ass.set_major_version (l_version.major.to_natural_16)
					ass.set_minor_version (l_version.minor.to_natural_16)
					ass.set_build_number (l_version.build.to_natural_16)
					ass.set_revision_number (l_version.revision.to_natural_16)
				elseif attached system.msil_version as l_system_version then

					check is_using_multi_assemblies end
					l_version.set_version (l_system_version)
					ass.set_major_version (l_version.major.to_natural_16)
					ass.set_minor_version (l_version.minor.to_natural_16)
					ass.set_build_number (l_version.build.to_natural_16)
					ass.set_revision_number (l_version.revision.to_natural_16)
				end

				if public_key /= Void then
					l_assembly_flags := {MD_ASSEMBLY_FLAGS}.public_key
				end
				associated_assembly_token :=
					md_emit.define_assembly (l_mod_name_string, l_assembly_flags, ass, public_key)

				if is_debug_info_enabled then
					md_emit.define_custom_attribute (associated_assembly_token,
						debuggable_ctor_token, enabled_debuggable_ca).do_nothing
				end

				if system.is_il_netcore then
						-- TODO: check if this custom attribute should be for any module, or just for the main one. [2023-05-26]
					target_framework_attr_type_token := md_emit.define_type_ref (
							uni_string ("System.Runtime.Versioning.TargetFrameworkAttribute"),
							mscorlib_token
						)

						-- [assembly: TargetFramework(".NETCoreApp,Version=v6.0", FrameworkDisplayName = "")]
					create sig.make
					sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
					sig.set_parameter_count (1)
					sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
					sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, string_type_token)

					attribute_ctor := md_emit.define_member_ref (
							dot_ctor_uni_string,
							target_framework_attr_type_token,
							sig
						)
					rt_v := system.clr_runtime_version
					if
						rt_v /= Void  and then
						rt_v.starts_with_general ("net")
					then
						i := rt_v.index_of ('/', 1)
						if i > 0 then
							rt_v := rt_v.head (i - 1)
						end
						rt_v := rt_v.substring (4, rt_v.count) -- Remove the "net"
					else
						debug ("refactor_fixme")
							fixme ("Check if this is acceptable default version number ! [2023-09-18")
						end
						rt_v := "6.0" -- Hardcoded value!!!
					end
					create ca.make
					ca.put_string (".NETCoreApp,Version=v" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (rt_v))
					ca.put_integer_16 (0)

-- The "FrameworkDisplayName" is not required
--						-- Number of named arguments
--					ca.put_integer_16 (1)
--						-- We mark it's a property
--					ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_property)
--						-- Fill `FieldOrPropType' in `ca'
--					ca.put_integer_8 ({MD_SIGNATURE_CONSTANTS}.element_type_string)
--						-- Put the name of the property
--					ca.put_string ("FrameworkDisplayName")
--						-- Put the value
--					ca.put_string ("NET 6.0")
--					ca.put_integer_16 (0)
					ca_token := md_emit.define_custom_attribute (associated_assembly_token, attribute_ctor, ca)
				end
			end

			if is_debug_info_enabled then
				dbg_writer := md_factory.dbg_writer (md_emit, uni_string (module_file_name), True)
				if not dbg_writer.is_successful then
					Error_handler.insert_error (create {VIGE}.make_pdb_in_use (module_file_name))
					error_handler.raise_error
				end
			end
		ensure
			is_generated_set: is_generated
		end

	define_entry_point
			(creation_type: CLASS_TYPE; a_class_type: CLASS_TYPE; a_feature_id: INTEGER;
			a_has_arguments: BOOLEAN)

			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_class_type'.
		require
			is_generated: is_generated
			creation_type_not_void: creation_type /= Void
			a_class_type_not_void: a_class_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			l_entry_type_token: INTEGER
			l_root_creator_token: INTEGER
			l_set_exception_manager_token: INTEGER
			l_rt_extension_object_token: INTEGER
			l_sig: like method_sig
			l_field_sig: like field_sig
			l_meth_sig: like method_sig
			l_type_id: INTEGER
			l_nb_args: INTEGER
		do
			l_type_id := a_class_type.implementation_id

			l_entry_type_token := md_emit.define_type (
					uni_string ("MAIN"),
					{MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.public,
					object_type_token, Void
				)

				-- First we create a static function which takes one argument: In our case an instance of class ANY.
				-- This function then creates the root object and calls the creation feature.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_eiffel_type_info_type_token)

			l_root_creator_token := md_emit.define_method (uni_string ("create_and_call_root_object"),
					l_entry_type_token,
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Static, l_sig,
					{MD_METHOD_ATTRIBUTES}.Managed
				)

			if is_debug_info_enabled then
				il_code_generator.define_custom_attribute (l_root_creator_token,
					debugger_step_through_ctor_token, empty_ca)
				il_code_generator.define_custom_attribute (l_root_creator_token,
					debugger_hidden_ctor_token, empty_ca)
			end

			il_code_generator.start_new_body (l_root_creator_token)

				-- Initialize assertions for runtime in workbench mode.
			if not System.in_final_mode or else System.keep_assertions then
				il_code_generator.put_type_token (l_type_id)
				il_code_generator.internal_generate_external_call (ise_runtime_token, 0,
					Runtime_class_name, "assertion_initialize",
					{SHARED_IL_CONSTANTS}.static_type, <<type_handle_class_name>>,
					Void, False, Void)
			end

				-- Create ISE_EXCEPTION_MANAGER object and assign it to ISE_RUNTIME.
			il_code_generator.create_object (ise_exception_manager_type_id)
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_exception_manager_type_token)
			l_set_exception_manager_token := md_emit.define_member_ref (
				uni_string ("set_exception_manager"), ise_runtime_type_token, l_meth_sig)
			il_code_generator.method_body.put_static_call (l_set_exception_manager_token, 1, False)

			if
				not System.in_final_mode and then
				system.rt_extension_class /= Void and then system.rt_extension_class.is_compiled
			then
					-- Create RT_EXTENSION object and assign it to ISE_RUNTIME.
				il_code_generator.create_object (rt_extension_type_implementation_id)
				l_field_sig := field_sig
				l_field_sig.reset
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
					ise_rt_extension_type_token)
				l_rt_extension_object_token := md_emit.define_member_ref (
					uni_string ("rt_extension_object"),
					ise_runtime_type_token,
					l_field_sig)
				il_code_generator.method_body.put_opcode_mdtoken ({MD_OPCODES}.stsfld, l_rt_extension_object_token)
			end

				-- Create root object and call creation procedure.
			;(create {CREATE_TYPE}.make (system.root_type)).generate_il
			if creation_type.is_expanded then
					-- Box expanded object.
				il_code_generator.generate_metamorphose (creation_type.type)
				il_code_generator.generate_load_address (creation_type.type)
			end

			if a_has_arguments then
					-- Generate conversion from the command line arguments
					-- from .NET to an Eiffel array.
				generate_argument_array
				l_nb_args := 1
			end

			if creation_type.is_expanded then
				il_code_generator.method_body.put_call ({MD_OPCODES}.Call,
					feature_token (creation_type.implementation_id,
						creation_type.associated_class.feature_of_rout_id
						(a_class_type.associated_class.feature_of_feature_id (a_feature_id).rout_id_set.first).feature_id),
					l_nb_args, False)
			elseif a_class_type.is_generated_as_single_type then
				il_code_generator.method_body.put_call ({MD_OPCODES}.Callvirt,
					feature_token (l_type_id, a_feature_id), l_nb_args, False)
			else
				il_code_generator.method_body.put_call ({MD_OPCODES}.Call,
					implementation_feature_token (l_type_id, a_feature_id), l_nb_args, False)
			end
			il_code_generator.generate_return (False)
			method_writer.write_current_body

				-- Now create the actual static main routine.
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			entry_point_token := md_emit.define_method (uni_string ("Main"),
				l_entry_type_token, {MD_METHOD_ATTRIBUTES}.Public |
				{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
				{MD_METHOD_ATTRIBUTES}.Static, l_sig,
				{MD_METHOD_ATTRIBUTES}.Managed)

			if is_debug_info_enabled then
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_step_through_ctor_token, empty_ca)
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_hidden_ctor_token, empty_ca)
			end

			il_code_generator.start_new_body (entry_point_token)

				-- Initialize assertions for runtime in workbench mode.
			if not System.in_final_mode or else System.keep_assertions then
				il_code_generator.put_type_token (l_type_id)
				il_code_generator.internal_generate_external_call (ise_runtime_token, 0,
					Runtime_class_name, "assertion_initialize",
					{SHARED_IL_CONSTANTS}.static_type, <<type_handle_class_name>>,
					Void, False, Void)
			end

				-- Dummy ANY object for context in case `system.root_type' is generic.
			(create {CREATE_TYPE}.make (system.any_class.compiled_class.types.first.type)).generate_il

				-- Call the routine which creates and calls creation feature on root object.
			il_code_generator.method_body.put_static_call (	l_root_creator_token, 1, False)

			il_code_generator.generate_return (False)
			method_writer.write_current_body
		end

	save_to_disk (a_signing: MD_STRONG_NAME)
			-- Save byte code and metadata to file `module_file_name'.
		require
			is_generated: is_generated
			a_signing_not_void: public_key /= Void implies a_signing /= Void
		local
			l_pe_file: CLI_PE_FILE
			ept: like entry_point_token
			loc: PATH
			l_codeview_debug_info,
			l_checksum_debug_info: MANAGED_POINTER
			l_checksum_dbg_directory,
			l_reproducible_dbg_directory: CLI_DEBUG_DIRECTORY
		do
			l_pe_file := md_factory.pe_file (module_file_name, is_dll or is_console_application, is_dll, is_32bits, md_emit)
			if is_debug_info_enabled then
				if attached md_factory.codeview_debug_directory as l_codeview_dbg_directory then
					l_codeview_debug_info := dbg_writer.codeview_debug_info (l_codeview_dbg_directory)
					l_pe_file.set_codeview_debug_information (l_codeview_dbg_directory, l_codeview_debug_info)

					l_checksum_dbg_directory := md_factory.pdbchecksum_debug_directory
					if l_checksum_dbg_directory /= Void then
						l_checksum_debug_info := dbg_writer.checksum_debug_info (l_checksum_dbg_directory)
						l_pe_file.set_checksum_debug_information (l_checksum_dbg_directory, l_checksum_debug_info)
					end

					l_reproducible_dbg_directory := md_factory.reproducible_debug_directory
					if l_reproducible_dbg_directory /= Void then
						l_pe_file.set_reproducible_debug_information (l_reproducible_dbg_directory)
					end

					dbg_writer.close (l_pe_file)
				else
					check implemented: False end
				end
			end
			if attached public_key as l_pub_key and then a_signing /= Void then
				l_pe_file.set_public_key (l_pub_key, a_signing)
			end
			l_pe_file.set_method_writer (method_writer)
			if attached resources as l_res then
				l_pe_file.set_resources (l_res)
			end
			ept := entry_point_token
			if ept /= 0 then
				l_pe_file.set_entry_point_token (ept)
			end
			l_pe_file.save

			if is_using_multi_assemblies then
				-- FIXME: also save associated .deps.json file!
				create loc.make_from_string (module_file_name)
				if attached loc.parent as l_parent then
					-- FIXME
					-- It seems deps.json file per file is not needed.
					-- still under testing, if we are sure we need
					-- to remove the feature deploy_netcore_deps_json_file
					-- deploy_netcore_deps_json_file (defined_assemblies, system, l_parent, module_name + ".deps.json")
				end
			end

			wipe_out
			is_generated := False
			is_saved := True
			debug ("il_emitter_table")
				print ({STRING_32} "IL_MODULE: " + module_name_with_extension + " SAVED%N")
			end
		ensure
			is_generated_set: not is_generated
			is_saved: is_saved
		end

feature -- Netcore deployment

	deploy_netcore_deps_json_file (a_assemblie: like defined_assemblies;
				a_system: SYSTEM_I; a_target_directory: PATH; a_target_filename: READABLE_STRING_GENERAL)
		local
			f: PLAIN_TEXT_FILE
			vars: CIL_PROJECT_INFO
			s, libs_tpl, libs: STRING
			l_versioned_name: STRING_32
			l_name: READABLE_STRING_GENERAL
			l_version: READABLE_STRING_GENERAL
		do
			create vars.make_from_system (system)

			s := "[
{
  "runtimeTarget": {
    "name": "${CLR_RUNTIME}",
    "signature": ""
  },
  "targets": {
    "${CLR_RUNTIME}": {
      "${LIB_NAME_VERSION}": {
        "runtime": {
          "${LIB_NAME}.${LIB_TYPE}": {}
        }
      }
    }
  },
  "libraries": {
    "${LIB_NAME_VERSION}": {
      "type": "project",
      "serviceable": false,
      "sha512": ""
    }${LIBRARIES}
  }
}
			]"
			s.replace_substring_all ("${CLR_RUNTIME}", {CIL_GENERATOR}.to_json_string (vars.clr_runtime))
			create l_versioned_name.make_from_string_general (module_name)
			if attached assembly_info as l_ass_info then
				l_version := l_ass_info.version
			else
				l_version := vars.system_version
			end
			if l_version /= Void then
				l_versioned_name.append_character ('/')
				l_versioned_name.append (l_version)
			end
			s.replace_substring_all ("${LIB_NAME_VERSION}", {CIL_GENERATOR}.to_json_string (l_versioned_name))
			s.replace_substring_all ("${LIB_NAME}", {CIL_GENERATOR}.to_json_string (module_name))
			s.replace_substring_all ("${LIB_TYPE}", "dll")


			-- FIXME: use the list of .Net assemblies, and generated assemblies to get versions and related information.
			if a_assemblie /= Void and then not a_assemblie.is_empty then
				create libs.make_empty
libs_tpl := "[

    "${LIB_NAME_VERSION}": { "type": "reference", "serviceable": false, "sha512": "" }
]"

				across
					a_assemblie as ic
				loop
					l_name := ic.key
					l_version := ic.item.version

					libs.append (",%N")
					libs.append (libs_tpl)
					-- FIXME: maybe use proper JSON encoding, eventually the JSON library.
					create l_versioned_name.make_from_string_general (l_name)
					if l_version /= Void then
						l_versioned_name.append_character ('/')
						l_versioned_name.append (l_version)
					end
					libs.replace_substring_all ("${LIB_NAME_VERSION}", {CIL_GENERATOR}.to_json_string (l_versioned_name))
				end
			end

			s.replace_substring_all ("${LIBRARIES}", libs)

			create f.make_with_path (a_target_directory.extended (a_target_filename))
			f.open_write
			f.put_string (s)
			f.close
		end

feature -- Metadata description

	generate_external_class_mapping (class_type: CLASS_TYPE)
			-- Define reference to external type `class_type'.
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			external_class_type: class_type.is_external or else class_type.is_basic
		local
			class_c: CLASS_C
			name: STRING
			l_type_token, tok: INTEGER
			l_nested_parent_class: CLASS_C
			l_nested_parent_class_token: INTEGER
			l_sig: MD_TYPE_SIGNATURE
		do
			class_c := class_type.associated_class
			if
				attached {NATIVE_ARRAY_CLASS_TYPE} class_type
				or else is_by_ref_type (class_type.type)
			then
					-- Generate association with a NATIVE_ARRAY [] or TYPED_POINTER []
				create l_sig.make
				set_signature_type (l_sig, class_type.type, class_type)
				l_type_token := md_emit.define_type_spec (l_sig)
				name := class_type.associated_class.external_class_name.twin
				class_mapping.put (l_type_token, class_type.external_id)
				il_code_generator.external_class_mapping.put (class_type.type, name)
				internal_external_token_mapping.put (l_type_token, name)
			else
				name := class_type.associated_class.external_class_name.twin
				if attached {EXTERNAL_CLASS_C} class_c as l_external_class and then l_external_class.is_nested then
					l_nested_parent_class := l_external_class.enclosing_class
					l_nested_parent_class_token := md_emit.define_type_ref (uni_string (l_nested_parent_class.types.first.full_il_type_name),
						external_assembly_token (l_nested_parent_class.types.first))
					l_type_token := md_emit.define_type_ref (uni_string (name.substring (
						name.index_of ('+', 1) + 1, name.count)),
						l_nested_parent_class_token)
				else
					tok := external_assembly_token (class_type)
					l_type_token := md_emit.define_type_ref (uni_string (name), tok)
				end
				class_mapping.put (l_type_token, class_type.external_id)

				il_code_generator.external_class_mapping.put (class_type.type, name)
				internal_external_token_mapping.put (l_type_token, name)
			end
		end

	generate_interface_class_mapping (class_type: CLASS_TYPE)
			-- Define reference/definition of Eiffel type `class_type' used for
			-- interface purpose (i.e. interface class of an implementation class,
			-- or class itself if generated as a single class).
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
		local
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_uni_string: CLI_STRING
		do
			if class_mapping.item (class_type.static_type_id) = 0 then

				class_c := class_type.associated_class
				create l_uni_string.make (class_type.full_il_type_name)

				if
					class_type.is_precompiled or
					il_code_generator.il_module (class_type) /= Current
				then
					l_type_token := md_emit.define_type_ref (l_uni_string, assembly_token (class_type))
				else
					update_parents (class_type, class_c, True)

					l_attributes := {MD_TYPE_ATTRIBUTES}.Public |
									{MD_TYPE_ATTRIBUTES}.Auto_layout |
									{MD_TYPE_ATTRIBUTES}.Ansi_class

					if class_type.is_generated_as_single_type then
						l_attributes := l_attributes |
							{MD_TYPE_ATTRIBUTES}.Is_class |
							{MD_TYPE_ATTRIBUTES}.Serializable |
							({MD_TYPE_ATTRIBUTES}.abstract & (- class_c.is_deferred.to_integer.to_integer_16)) |
							({MD_TYPE_ATTRIBUTES}.Sealed & (- (class_c.is_optimized_as_frozen or class_type.is_expanded).to_integer.to_integer_16))
						single_parent_mapping.put (single_inheritance_parent_id, class_type.implementation_id)
					else
						l_attributes := l_attributes |
							{MD_TYPE_ATTRIBUTES}.Is_interface |
							{MD_TYPE_ATTRIBUTES}.Abstract
					end

					l_type_token := md_emit.define_type (l_uni_string, l_attributes,
						single_inheritance_token, last_parents)

					if not il_code_generator.is_single_module then
						class_type.set_last_type_token (l_type_token)
					end

					if
						is_debug_info_enabled and then
						internal_dbg_documents.item (class_c.class_id) = Void
					then
						internal_dbg_documents.put (dbg_writer.define_document (uni_string (class_c.file_name),
							language_guid, vendor_guid, document_type_guid), class_c.class_id)
					end
				end

				class_mapping.put (l_type_token, class_type.static_type_id)
			end
		end

	generate_implementation_class_mapping (class_type: CLASS_TYPE)
			-- Define reference/definition of Eiffel type `class_type' used for
			-- implementation purpose.
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			not_generated_as_single_type: not class_type.is_generated_as_single_type
		local
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_uni_string: CLI_STRING
		do
			class_c := class_type.associated_class
			create l_uni_string.make (class_type.full_il_implementation_type_name)

			if
				class_type.is_precompiled or
				il_code_generator.il_module (class_type) /= Current
			then
				l_type_token := md_emit.define_type_ref (l_uni_string, assembly_token (class_type))
			else
				l_attributes :=
					{MD_TYPE_ATTRIBUTES}.Public |
					{MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Is_class |
					{MD_TYPE_ATTRIBUTES}.Serializable |
					({MD_TYPE_ATTRIBUTES}.Abstract & (- class_c.is_deferred.to_integer.to_integer_16)) |
					({MD_TYPE_ATTRIBUTES}.Sealed & (- (class_c.is_optimized_as_frozen or class_type.is_expanded).to_integer.to_integer_16))

				update_parents (class_type, class_c, False)
				single_parent_mapping.put (single_inheritance_parent_id,
					class_type.implementation_id)
				l_type_token := md_emit.define_type (l_uni_string, l_attributes,
					single_inheritance_token, last_parents)

				if not class_type.is_generated_as_single_type then
					md_emit.define_custom_attribute (l_type_token, ise_eiffel_consumable_attr_ctor_token, eiffel_non_consumable_ca).do_nothing
				end
				if not il_code_generator.is_single_module then
					if not class_type.is_generated_as_single_type then
						class_type.set_last_implementation_type_token (l_type_token)
					else
						class_type.set_last_type_token (l_type_token)
					end
				end

				if
					is_debug_info_enabled and then
					internal_dbg_documents.item (class_c.class_id) = Void
				then
					internal_dbg_documents.put (dbg_writer.define_document (uni_string (class_c.file_name),
						language_guid, vendor_guid, document_type_guid), class_c.class_id)
				end
			end

			class_mapping.put (l_type_token, class_type.implementation_id)
		end

	update_parents (class_type: CLASS_TYPE; class_c: CLASS_C; for_interface: BOOLEAN)
			-- Generate ancestors map of `class_type` associated to `class_c` for context
			-- `for_interface`, updating `last_parents` accordingly.
		require
			is_generated: is_generated
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			parents: like {CLASS_C}.parents
			l_parent_type: CLASS_TYPE
			l_list: SEARCH_TABLE [INTEGER]
			id: INTEGER
			i: INTEGER
			l_parents: ARRAY [INTEGER]
			parent_count: CELL [INTEGER]
			l_parent_class: CLASS_C
			l_single_inheritance_parent_id: like single_inheritance_parent_id
			l_has_an_eiffel_parent: BOOLEAN
			interface_class_type: CLASS_TYPE
		do
			parents :=
					-- TODO: support mutliple .override directives for methods inherited from non-conforming parents.
					-- (See `{CIL_CODE_GENERATOR}.generate_method_impl`. It should be applied to every non-conformig parent
					-- again to allow using only conforming parents when generating interfaces.)
--				if for_interface then
--					class_c.conforming_parents
--				else
					class_c.parents
--				end
			create l_list.make (parents.count)
			create l_parents.make_filled (0, 0, parents.count)
			l_single_inheritance_parent_id := 0
			across
				parents as p
			loop
					-- We need to reset context at each iteration because calls to
					-- `xxx_class_type_token' might trigger a recursive call to `update_parents'
					-- thus changing the context.
				l_parent_type := p.item.associated_class_type (class_type.type)
				l_has_an_eiffel_parent := l_has_an_eiffel_parent or else not l_parent_type.is_external
				id := l_parent_type.static_type_id
				if not l_list.has (id) then
					l_list.force (id)
					l_parent_class := l_parent_type.associated_class
					if
						l_parent_class.is_interface or else
						not l_parent_type.is_generated_as_single_type and then
						not l_parent_type.is_external
					then
							-- Add parent interfaces only.
						l_parents.put (actual_class_type_token (l_parent_type.static_type_id), i)
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
							l_single_inheritance_parent_id := l_parent_type.implementation_id
						end
					elseif l_parent_type.is_generated_as_single_type then
						check
							single_inheritance_parent_id_not_set: l_single_inheritance_parent_id = 0
						end
						l_single_inheritance_parent_id := l_parent_type.implementation_id
							-- Note: We do not add into `pars' as we only store there the
							-- parents than can be included as interfaces.
					end
				end
			end

				-- Element after last added should be 0.
			if i = 0 then
					-- Let's add the necessary interfaces so that we have a proper Eiffel type.
				if l_single_inheritance_parent_id = 0 then
					if for_interface then
							-- We must handle ANY here, thus we simply add EIFFEL_TYPE_INFO
							-- as parent.
						last_parents := << ise_eiffel_type_info_type_token, 0 >>
					else
							-- We are in the implementation, therefore we simply for
							-- the associated interface.
						if class_type.is_expanded then
								-- For expanded types we use interface of the reference counterpart.
							check
								has_reference_class_type: class_c.types.has_type (Void, class_type.type.reference_type)
							end
							interface_class_type := class_c.types.search_item (Void, class_type.type.reference_type)
						else
								-- For reference types the corresponding interface is used.
							interface_class_type := class_type
						end
						last_parents := << actual_class_type_token (interface_class_type.static_type_id), 0 >>
					end
				else
						-- We inherit from a .NET class or an Eiffel single class.
						-- If the parent is an Eiffel class then nothing to be done,
						-- if not, we need to add the ANY interface to ensure that
						-- the run-time knows we are handling an Eiffel type.
					if not l_has_an_eiffel_parent then
						last_parents := << actual_class_type_token (any_type_id), 0 >>
					else
						last_parents := Void
					end
				end
			else
				if not l_has_an_eiffel_parent then
						-- We do not explicitely inherit from an Eiffel type, thus we
						-- need inheritance to ANY to let the runtime know that we are
						-- an Eiffel type on the interface, and the implementation should
						-- inherit the associated interface type which inherits from ANY.
					l_parents.force (actual_class_type_token (if for_interface then any_type_id else class_type.static_type_id end), i)
					i := i + 1
				else
					if class_type.is_expanded then
							-- For expanded types we use interface of the reference counterpart.
						check
							has_reference_class_type: class_c.types.has_type (Void, class_type.type.reference_type)
						end
						interface_class_type := class_c.types.search_item (Void, class_type.type.reference_type)
						l_parents.force (actual_class_type_token (interface_class_type.static_type_id), i)
						i := i + 1
						if class_c.is_generic and then attached {GEN_TYPE_A} interface_class_type.type as gen_type then
							create parent_count.put (i)
							gen_type.enumerate_interfaces (
								agent (c: CLASS_TYPE; p: ARRAY [INTEGER]; k: CELL [INTEGER])
									local
										j: INTEGER
									do
										j := k.item
										k.put (j + 1)
										p.force (actual_class_type_token (c.static_type_id), j)
									end
								(?, l_parents, parent_count)
							)
							i := parent_count.item
						end
					else
						interface_class_type := class_c.types.search_item (Void, class_type.type)
						if not for_interface then
							l_parents.force (actual_class_type_token (class_type.static_type_id), i)
							i := i + 1
						elseif class_c.is_generic and then attached {GEN_TYPE_A} interface_class_type.type as gen_type then
							create parent_count.put (i)
							gen_type.enumerate_interfaces (
								agent (c: CLASS_TYPE; p: ARRAY [INTEGER]; k: CELL [INTEGER])
									local
										j: INTEGER
									do
										j := k.item
										k.put (j + 1)
										p.force (actual_class_type_token (c.static_type_id), j)
									end
								(?, l_parents, parent_count)
							)
							i := parent_count.item
						end
					end
				end
				l_parents.force (0, i)
				last_parents := l_parents
			end

				-- Single inheritance parent should be set after all calls to `actual_class_type_token'
				-- because the latter can recursively call `update_parents' and change the attributes.
			if l_single_inheritance_parent_id = 0 then
				if class_type.is_expanded then
						-- If we are expanded, we need to explicitely inherit
						-- from System.ValueType
					single_inheritance_parent_id := value_type_id
					single_inheritance_token := value_type_token
				elseif for_interface then
					single_inheritance_parent_id := 0
					single_inheritance_token := 0
				else
						-- We are not a single class.
						-- We are not expanded, simply inherit from System.Object
					single_inheritance_parent_id := object_type_id
					single_inheritance_token := object_type_token
				end
			else
				single_inheritance_token := actual_class_type_token (l_single_inheritance_parent_id)
				single_inheritance_parent_id := l_single_inheritance_parent_id
			end
		end

	define_constructor (class_type: CLASS_TYPE; a_signature: like method_sig; is_reference: BOOLEAN; external_token, eiffel_token: INTEGER; feature_id: INTEGER)
			-- Define constructor for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			signature_not_void: a_signature /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		local
			l_meth_token: INTEGER
			l_uni_string: like uni_string
			l_class: CLASS_C
			l_arg_count: INTEGER
			l_method_body: MD_METHOD_BODY
			l_tokens: HASH_TABLE [INTEGER, INTEGER]
			l_field_sig: like field_sig
			l_parent_type_id: INTEGER
			l_class_type: CLASS_TYPE
		do
				-- Do not use `uni_string' as it might be used by `xxx_class_type_token'.
			l_uni_string := dot_ctor_uni_string

			l_class := class_type.associated_class

			if
				is_reference or
				class_type.is_precompiled or class_type.is_external or
				il_code_generator.il_module (class_type) /= Current
			then
				l_meth_token := md_emit.define_member_ref (l_uni_string,
					actual_class_type_token (class_type.implementation_id), a_signature)
			else
				l_meth_token := md_emit.define_method (l_uni_string,
					actual_class_type_token (class_type.implementation_id),
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					a_signature, {MD_METHOD_ATTRIBUTES}.Managed)

				il_code_generator.start_new_body (l_meth_token)
				l_method_body := il_code_generator.method_body
				l_arg_count := a_signature.parameter_count

				il_code_generator.generate_current
				if class_type.is_expanded then
						-- Zero out all the data.
					l_method_body.put_opcode_mdtoken ({MD_OPCODES}.initobj, actual_class_type_token (class_type.implementation_id))
				else
						-- Call constructor from super-class for reference type
					if external_token = 0 then
						l_parent_type_id := single_parent_mapping.item (class_type.implementation_id)
						if il_code_generator.class_types.item (l_parent_type_id).is_generic then
								-- Pass an argument that keeps Eiffel run-time type information
								-- to the parent constructor.
							il_code_generator.generate_argument (l_arg_count + 1)
							l_method_body.put_call ({MD_OPCODES}.Call, constructor_token (l_parent_type_id), 1, False)
						else
							l_method_body.put_call ({MD_OPCODES}.Call, constructor_token (l_parent_type_id), 0, False)
						end
					else
						if l_class.is_generic then
								-- Avoid passing an argument that keeps Eiffel run-time type information
								-- to an external constructor.
							put_args_on_stack (l_arg_count - 1)
							l_method_body.put_call ({MD_OPCODES}.Call, external_token, l_arg_count - 1, False)
						else
							put_args_on_stack (l_arg_count)
							l_method_body.put_call ({MD_OPCODES}.Call, external_token, l_arg_count, False)
						end
					end
					if eiffel_token /= 0 then
						il_code_generator.generate_current
						if l_class.is_generic and then not l_class.parents_classes.first.is_generic then
								-- Avoid passing an argument that keeps Eiffel run-time type information
								-- to a non-generic parent constructor.
							put_args_on_stack (l_arg_count - 1)
							l_method_body.put_call ({MD_OPCODES}.Callvirt, eiffel_token, l_arg_count - 1, False)
						else
							put_args_on_stack (l_arg_count)
							l_method_body.put_call ({MD_OPCODES}.Callvirt, eiffel_token, l_arg_count, False)
						end
					end
				end

					-- Record type information if required.
				if class_type.is_generic then
					il_code_generator.generate_current
					il_code_generator.generate_argument (l_arg_count)
						-- Set signature of `$$____type' field.
					l_field_sig := field_sig
					l_field_sig.reset
					l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
						ise_generic_type_token)
						-- Find class type that declares `$$____type' field.
					l_class_type := class_type
					if not l_class_type.is_expanded and then l_class_type.associated_class.is_single then
						from
						until
							l_class_type.associated_class.has_external_main_parent
						loop
							l_class_type := il_code_generator.class_types.item (single_parent_mapping.item (l_class_type.implementation_id))
						end
					end
						-- Do not use `uni_string' as it might be used by `xxx_class_type_token'.
					l_method_body.put_opcode_mdtoken ({MD_OPCODES}.Stfld,
						md_emit.define_member_ref (uni_string ("$$____type"),
						actual_class_type_token (l_class_type.implementation_id), l_field_sig))
				end

				if il_code_generator.is_initialization_required (class_type) then
					il_code_generator.generate_current
					il_code_generator.initialize_expanded_attributes (class_type)
					il_code_generator.pop
				end

				il_code_generator.generate_return (False)
				il_code_generator.store_locals (l_meth_token, class_type)
				method_writer.write_current_body

			end
			if a_signature = default_sig or else a_signature = generic_ctor_sig then
				internal_constructor_token.put (l_meth_token, class_type.implementation_id)
			end
			if feature_id /= 0 then
				l_tokens := internal_constructors [class_type.implementation_id]
				if l_tokens = Void then
					create l_tokens.make (1)
					internal_constructors [class_type.implementation_id] := l_tokens
				end
				l_tokens [feature_id] := l_meth_token
			end
		end

	put_args_on_stack (a_count: INTEGER)
			-- Put arguments on stack
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				il_code_generator.generate_argument (i)
				i := i + 1
			end
		end

	define_default_constructor (class_type: CLASS_TYPE; is_reference: BOOLEAN)
			-- Define default constructor for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		do
			if class_type.is_generic then
				define_constructor (class_type, generic_ctor_sig, is_reference, 0, 0, 0)
			else
				define_constructor (class_type, default_sig, is_reference, 0, 0, 0)
			end
		end

	define_constructors (class_type: CLASS_TYPE; is_reference: BOOLEAN)
			-- Define constructors for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		local
			l_sig: like method_sig
			l_class: CLASS_C
			l_feature: FEATURE_I
			l_define_default_ctor: BOOLEAN
			i: INTEGER
			l_constructors: LIST [STRING]
			l_eiffel_constructor: BOOLEAN
			l_is_generic: BOOLEAN
		do
			l_class := class_type.associated_class

			if
				attached l_class.creators as cs and then
				not cs.is_empty and then
				attached cs.current_keys as ns
			then
				if l_class.ast.top_indexes /= Void then
					l_constructors := l_class.ast.top_indexes.dotnet_constructors
				end
				l_is_generic := l_class.is_generic
				across
					ns as n
				loop
					l_feature := l_class.feature_of_name_id (n.item)
					check
						l_feature_attached: l_feature /= Void
					end
					l_eiffel_constructor := l_constructors /= Void and then l_constructors.has (l_feature.feature_name)
					if l_feature.is_il_external or else l_eiffel_constructor then
						if l_feature.has_arguments then
							create l_sig.make
							l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
							l_sig.set_parameter_count (l_feature.argument_count + l_is_generic.to_integer)
							l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
							across
								l_feature.arguments as a
							loop
								set_signature_type (l_sig, argument_actual_type (a.item), class_type)
							end
							if l_is_generic then
								l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_generic_type_token)
							end
						elseif l_is_generic then
							l_sig := generic_ctor_sig
						else
							l_sig := default_sig
						end
						if l_feature.is_il_external and then attached {IL_EXTENSION_I} l_feature.extension as l_il_extension then
							if l_eiffel_constructor then
								define_constructor (class_type, l_sig, is_reference, l_il_extension.token, feature_token (class_type.static_type_id, l_feature.feature_id), l_feature.feature_id)
							else
								define_constructor (class_type, l_sig, is_reference, l_il_extension.token, 0, l_feature.feature_id)
							end
						else
							define_constructor (class_type, l_sig, is_reference, 0, feature_token (class_type.static_type_id, l_feature.feature_id), l_feature.feature_id)
						end
					else
						l_define_default_ctor := True
					end
					i := i + 1
				end
			else
				l_define_default_ctor := True
			end

			if l_define_default_ctor then
				define_default_constructor (class_type, is_reference)
			end
		end

	argument_actual_type (a_type: TYPE_A): TYPE_A
			-- Compute real type of Current in current generated class.
		require
			a_type_not_void: a_type /= Void
		do
			if a_type.is_none then
				Result := system.any_class.compiled_class.types.first.type
			else
				Result := byte_context.real_type (a_type)
			end
		ensure
			valid_result: Result /= Void
		end

feature -- Local saving

	store_locals (a_local_types: like local_types; a_meth_token: INTEGER; a_context_type: CLASS_TYPE)
			-- Store `local_types' into `il_code_generator.method_body' for routine `a_meth_token'.
		require
			is_generated: is_generated
			method_token_valid: a_meth_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
			a_context_type_not_void: a_context_type /= Void
		local
			l_sig: like local_sig
			l_count: INTEGER
		do
			l_count := a_local_types.count
			if l_count > 0 then
				l_sig := local_sig
				l_sig.reset
				l_sig.set_local_count (l_count)
				across
					a_local_types as t
				loop
					set_signature_type (l_sig, t.item.first, a_context_type)
				end
				il_code_generator.method_body.set_local_token (md_emit.define_signature (l_sig))
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

	generate_local_debug_info (a_method_token: INTEGER; a_context_type: CLASS_TYPE)
			-- Generate local information about routine `method_token'.
		require
			is_generated: is_generated
			debug_info_requested: is_debug_info_enabled
			method_token_valid: a_method_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
			a_context_type_not_void: a_context_type /= Void
		local
			l_locals: like local_types
			l_sig: MD_TYPE_SIGNATURE
			i: INTEGER
			nb: INTEGER
			l_start_offset, l_end_offset: INTEGER
		do
			if attached local_info.item (a_method_token) as l_local_info then
				from
					l_start_offset := l_local_info.start_offset
					l_end_offset := l_local_info.end_offset
					nb := l_local_info.nb
					l_locals := l_local_info.locals
					dbg_writer.open_scope (l_start_offset)
					l_locals.start
					create l_sig.make
					i := 0
				until
					l_locals.after or i >= nb
				loop
					l_sig.reset
					set_signature_type (l_sig, l_locals.item.first, a_context_type)
					dbg_writer.define_local_variable (uni_string (l_locals.item.second), i, l_sig)
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

	external_token_mapping (a_type_name: STRING): INTEGER
			-- Quickly find a type token given its external_name.
		require
			a_type_name_not_void: a_type_name /= Void
			a_type_name_not_empty: not a_type_name.is_empty
		local
			l_class_type: CLASS_TYPE
		do
			Result := internal_external_token_mapping.item (a_type_name)
			if Result = 0 then
				if a_type_name.item (a_type_name.count) = '&' then
					Result := external_token_mapping (a_type_name.substring (1, a_type_name.count - 1))
				else
					l_class_type := il_code_generator.external_class_mapping.item (a_type_name).
						associated_class_type (Void)
					generate_external_class_mapping (l_class_type)
					Result := internal_external_token_mapping.item (a_type_name)
				end
			end
		ensure
			external_token_mapping_valid:
				Result & {MD_TOKEN_TYPES}.Md_mask = {MD_TOKEN_TYPES}.Md_type_ref
		end

	internal_external_token_mapping: HASH_TABLE [INTEGER, STRING]
			-- Quickly find a type token given its external name.

	class_data_mapping: ARRAY [INTEGER]
			-- Array of class tokens indexed by their `class_id'.

	class_mapping: ARRAY [INTEGER]
			-- Array of type tokens indexed by their `type_id'.

	single_parent_mapping: ARRAY [INTEGER]
			-- Array of type tokens showing single inheritance parent for a given `type_id'.

	internal_constructor_token: ARRAY [INTEGER]
			-- Array of ctor token indexed by their `type_id'.

	internal_constructors: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of ctor tokens indexed by their `type_id' and parent ctor tokens.

	constructor_token (a_type_id: INTEGER): INTEGER
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
				define_default_constructor (il_code_generator.class_types.item (a_type_id), True)
				Result := l_tokens.item (a_type_id)
			end
		ensure
			constructor_token_valid: Result /= 0
		end

	inherited_constructor_token (a_type_id: INTEGER; a_feature_id: INTEGER): INTEGER
			-- Token identifier for constructor of `a_type_id' generated for
			-- a feature identified by `a_feature_id'.
		require
			is_generated: is_generated
			internal_constructors_not_void: internal_constructors /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_tokens: HASH_TABLE [INTEGER, INTEGER]
			l_class_type: CLASS_TYPE
			l_feature: FEATURE_I
			l_meth_sig: MD_METHOD_SIGNATURE
			l_argument_count: INTEGER
			l_type_i: TYPE_A
		do
			l_tokens := internal_constructors [a_type_id]
			if l_tokens /= Void then
				Result := l_tokens [a_feature_id]
			end
			if Result = 0 then
				l_class_type := il_code_generator.class_types.item (a_type_id)
				l_feature := l_class_type.associated_class.feature_of_feature_id (a_feature_id)
				l_argument_count := l_feature.argument_count
				create l_meth_sig.make
				l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
				if l_class_type.is_generic and then not l_class_type.is_external then
					l_meth_sig.set_parameter_count (l_argument_count + 1)
				else
					l_meth_sig.set_parameter_count (l_argument_count)
				end
				l_meth_sig.set_return_type (
					{MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				if l_argument_count > 0 then
					across
						l_feature.arguments as a
					loop
						l_type_i := il_code_generator.argument_actual_type_in (a.item, l_class_type)
						il_code_generator.set_signature_type (l_meth_sig, l_type_i, l_class_type)
					end
				end
				if l_class_type.is_generic and then not l_class_type.is_external then
					l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, ise_generic_type_token)
				end
				define_constructor (l_class_type, l_meth_sig, True, 0, 0, a_feature_id)
				l_tokens := internal_constructors [a_type_id]
				if l_tokens /= Void then
					Result := l_tokens [a_feature_id]
				end
			end
		end

	invariant_token (a_type_id: INTEGER): INTEGER
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
 				l_class_type := il_code_generator.class_types.item (a_type_id)

					-- Generate reference to invariant defined in a different assembly.
				l_sig := method_sig
				l_sig.reset
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				set_signature_type (l_sig, l_class_type.type, l_class_type)

				Result := md_emit.define_member_ref (uni_string ("$$_invariant"),
					actual_class_type_token (a_type_id), l_sig)
				internal_invariant_token.put (Result, a_type_id)
			end
		ensure
			invariant_token_valid: Result /= 0
		end

	internal_invariant_token: ARRAY [INTEGER]
			-- Array of invariant feature indexed by `type_id' of class in
			-- which they are defined.

	actual_class_type_token (a_type_id: INTEGER): INTEGER
			-- Given `a_type_id' returns its associated metadata token
		require
			is_generated: is_generated
			valid_type_id: a_type_id > 0
		local
			l_class_mapping: like class_mapping
			l_class_type: CLASS_TYPE
		do
			l_class_mapping := class_mapping
			Result := l_class_mapping.item (a_type_id)
			if Result = 0 then
					-- Although we do not require `is_generated' for `actual_class_type_token'
					-- we need it in the case it was not yet generated.
				check
					is_generated: is_generated
				end
				l_class_type := il_code_generator.class_types.item (a_type_id)
				if l_class_type.is_external then
					generate_external_class_mapping (l_class_type)
				elseif a_type_id = l_class_type.static_type_id then
					generate_interface_class_mapping (l_class_type)
				elseif a_type_id = l_class_type.implementation_id then
					generate_implementation_class_mapping (l_class_type)
				else
					check
						a_type_id = l_class_type.external_id
					end
					generate_external_class_mapping (l_class_type)
				end
				Result := l_class_mapping.item (a_type_id)
			end
		ensure
			class_token_valid: Result /= 0
		end

	mapped_class_type_token (a_type_id: INTEGER): INTEGER
			-- Given `a_type_id' returns its associated metadata token
			-- to be used in signatures and code generation token where
			-- ANY needs to be mapped into System.Object.
		require
			is_generated: is_generated
			valid_type_id: a_type_id > 0
		do
				-- We only map the interface of ANY into System.object
				-- for code generation.
			if a_type_id = any_type_id then
				Result := actual_class_type_token (object_type_id)
			else
				Result := actual_class_type_token (a_type_id)
			end
		ensure
			class_token_valid: Result /= 0
		end

	define_assembly_reference (a_name, a_version, a_culture: READABLE_STRING_32; a_key: detachable READABLE_STRING_32): INTEGER
			-- Define an assembly reference matching given parameters
		require
			a_name_not_void: a_name /= Void
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_version: VERSION
			l_major, l_minor, l_build, l_revision: INTEGER
			l_key_token: MD_PUBLIC_KEY_TOKEN
		do
			if defined_assemblies.has_key (a_name) then
				Result := defined_assemblies.found_item.token
			else
				if a_name.same_string_general ("mscorlib") and mscorlib_token > 0 then
					Result := mscorlib_token
				elseif a_name.same_string_general (runtime_namespace) and ise_runtime_token > 0 then
					Result := ise_runtime_token
				else
					l_ass_info := md_factory.assembly_info

					create l_version
					if l_version.is_version_valid (a_version) then
						l_version.set_version (a_version)
						l_major := l_version.major
						l_minor := l_version.minor
						l_build := l_version.build
						l_revision := l_version.revision

						l_ass_info.set_major_version (l_major.to_natural_16)
						l_ass_info.set_minor_version (l_minor.to_natural_16)
						l_ass_info.set_build_number (l_build.to_natural_16)
						l_ass_info.set_revision_number (l_revision.to_natural_16)
					end

					if
						a_key /= Void and then
						not a_key.is_whitespace and then
						not a_key.same_string_general ("null")
					then
						create l_key_token.make_from_string (a_key)
					end

						-- NOTE: cannot use `uni_string' buffer as current feature can
						-- be used with other features that already uses it to define
						-- some metadata.
					Result := md_emit.define_assembly_ref (uni_string (a_name), l_ass_info, l_key_token)
				end
				defined_assemblies.put ([Result, a_version], a_name)
			end
		ensure
			is_token_defined: Result /= 0
			is_token_assembly_ref: Result & {MD_TOKEN_TYPES}.md_mask =  {MD_TOKEN_TYPES}.md_assembly_ref
		end

	class_data_token (class_c: CLASS_C): INTEGER
			-- Token for class data  of `class_c'
		require
			class_c_not_void: class_c /= Void
			class_c_not_external: not class_c.is_external
		local
			class_id: INTEGER
			class_data_name: CLI_STRING
			class_assembly_info: ASSEMBLY_INFO
			class_module: IL_MODULE
		do
			class_id := class_c.class_id
			Result := class_data_mapping.item (class_id)
			if Result = 0 then
				create class_data_name.make (class_c.il_data_name)
				if class_c.is_precompiled then
					class_assembly_info := class_c.assembly_info
					Result := md_emit.define_type_ref (
						class_data_name,
						define_assembly_reference (
							class_assembly_info.assembly_name,
							class_assembly_info.version,
							class_assembly_info.culture,
							class_assembly_info.public_key_token))
				else
					class_module := il_code_generator.il_module_for_class (class_c)
					if class_module = Current then
						Result := md_emit.define_type (
								class_data_name,
								{MD_TYPE_ATTRIBUTES}.auto_class |
								{MD_TYPE_ATTRIBUTES}.auto_layout |
								{MD_TYPE_ATTRIBUTES}.is_class |
								{MD_TYPE_ATTRIBUTES}.public |
								{MD_TYPE_ATTRIBUTES}.sealed,
								object_type_token,
								Void
							)
					else
						Result := md_emit.define_type_ref (class_data_name, module_reference_token (class_module))
					end
				end
				class_data_mapping.put (Result, class_id)
			end
		ensure
			is_token_defined: Result /= 0
			is_type_token:
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_def or else
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_ref or else
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_spec
		end

	feature_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given a `a_feature_id' in `a_type_id' return associated
			-- token
		require
			is_generated: is_generated
			internal_features_not_void: internal_features /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			if a_type_id = 651 and a_Feature_id = 31 then
				do_nothing
			end
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

	setter_token (a_type_id, a_feature_id: INTEGER): INTEGER
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

	defined_property_setter_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token of a property setter (if any) without attempting to define it.
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_setters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_property_setters, a_type_id, a_feature_id)
		ensure
			setter_token_valid: Result /= 0 implies
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def or
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_member_ref
		end

	property_setter_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token of a property setter (if any).
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_setters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_property_setters, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, False, False)
				Result := table_token (internal_property_setters, a_type_id, a_feature_id)
			end
		ensure
			setter_token_valid: Result /= 0 implies
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def or
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_member_ref
		end

	defined_property_getter_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token of a property getter (if any) without attempting to define it.
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_getters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_property_getters, a_type_id, a_feature_id)
		ensure
			getter_token_valid: Result /= 0 implies
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def or
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_member_ref
		end

	property_getter_token (a_type_id, a_feature_id: INTEGER): INTEGER
			-- Given an attribute `a_feature_id' in `a_type_id' return associated
			-- token of a property getter (if any).
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_getters /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		do
			Result := table_token (internal_property_getters, a_type_id, a_feature_id)
			if Result = 0 then
					-- Most likely a feature from a precompiled library, False because
					-- not in interface, not a static and not an override.
				il_code_generator.define_feature_reference (a_type_id, a_feature_id,
					False, False, False)
				Result := table_token (internal_property_getters, a_type_id, a_feature_id)
			end
		ensure
			getter_token_valid: Result /= 0 implies
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def or
				Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_member_ref
		end

	implementation_feature_token (a_type_id, a_feature_id: INTEGER): INTEGER
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

	attribute_token (a_type_id, a_feature_id: INTEGER): INTEGER
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
				if Result = 0 then
					Result := table_token (internal_features, a_type_id, a_feature_id)
				end
			end
		ensure
			valid_result: Result /= 0
		end

	signature (a_type_id, a_feature_id: INTEGER): TUPLE [class_type: CLASS_TYPE; routine_id: INTEGER]
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated signature.
		require
			is_generated: is_generated
			internal_signatures_not_void: internal_signatures /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [like signature, INTEGER]
		do
			l_feats := internal_signatures.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
			if Result = Void then
				il_code_generator.define_feature_reference (a_type_id, a_feature_id, False, False, False)
				Result := internal_signatures.item (a_type_id).item (a_feature_id)
			end
		ensure
			result_not_void: Result /= Void
		end

	implementation_signature (a_type_id, a_feature_id: INTEGER): like signature
			-- Given a `a_feature_id' in `a_type_id' retrieves its associated
			-- signature.
		require
			is_generated: is_generated
			internal_implementation_signatures_not_void: internal_implementation_signatures /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_feats: HASH_TABLE [like signature, INTEGER]
		do
			l_feats := internal_implementation_signatures.item (a_type_id)
			if l_feats /= Void then
				Result := l_feats.item (a_feature_id)
			end
			if Result = Void then
				il_code_generator.define_feature_reference (a_type_id, a_feature_id, False, False, False)
				Result := internal_implementation_signatures.item (a_type_id).item (a_feature_id)
			end
		ensure
			result_not_void: Result /= Void
		end

	table_token (a_table: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]];
			a_type_id, a_feature_id: INTEGER): INTEGER

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
			offset_count: 	INTEGER;			-- Offset count
			offsets: 		ARRAY [INTEGER];	-- Offsets
			start_lines:	ARRAY [INTEGER];	-- Start lines
			start_columns:	ARRAY [INTEGER];	-- Start columns
			end_lines:		ARRAY [INTEGER];	-- End lines
			end_columns:	ARRAY [INTEGER];	-- End columns
			written_class_id: INTEGER			-- Written in class ID
			]

			-- For type definition purpose.
		do
		end

	local_debug_info: TUPLE [start_offset: INTEGER; end_offset: INTEGER; nb: INTEGER; locals: like local_types]
			-- For type definition purpose.
		require
			False
		do
		end

	local_info: HASH_TABLE [like local_debug_info, INTEGER]
			-- Table of `method_token' to local definition.

	method_sequence_points: HASH_TABLE [LINKED_LIST [like sequence_point], INTEGER]
			-- Table of `method_token' to sequence points definition.

	dbg_documents (a_class_id: INTEGER): DBG_DOCUMENT_WRITER
			-- Associated document to `a_class_id'.
		require
			is_generated: is_generated
			in_debug_mode: is_debug_info_enabled
		do
			Result := internal_dbg_documents.item (a_class_id)
			if
				Result = Void and then
				attached system.class_of_id (a_class_id) as l_class
			then
				Result := dbg_writer.define_document (uni_string (l_class.file_name), language_guid,
					vendor_guid, document_type_guid)
				internal_dbg_documents.put (Result, a_class_id)
			end
		ensure
			dbg_documents_not_void: Result /= Void
		end

	dbg_pragma_documents (a_path: STRING): DBG_DOCUMENT_WRITER
			-- Associated document to `a_path'.
		require
			attached_path: a_path /= Void
			is_generated: is_generated
			in_debug_mode: is_debug_info_enabled
		do
			Result := internal_dbg_pragma_documents.item (a_path)
			if Result = Void then
				Result := dbg_writer.define_document (uni_string (a_path), language_guid,
					vendor_guid, document_type_guid)
				internal_dbg_pragma_documents.put (Result, a_path)
			end
		ensure
			dbg_pragma_documents_not_void: Result /= Void
		end

	internal_dbg_documents: ARRAY [detachable DBG_DOCUMENT_WRITER]
			-- Array indexed by class ID containing all DBG_DOCUMENTS.

	internal_dbg_pragma_documents: HASH_TABLE [DBG_DOCUMENT_WRITER, STRING]
			-- Item: Document writer used for pragma debug generation
			-- Key: Path to document defined by pragma clause

	internal_implementation_features: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of features for implementation indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_features: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of features indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_setters: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of attributes setter indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_property_setters: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of property setter indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_property_getters: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of property getter indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_attributes: ARRAY [detachable HASH_TABLE [INTEGER, INTEGER]]
			-- Array of attributes indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_signatures, internal_implementation_signatures: ARRAY [detachable HASH_TABLE [like signature, INTEGER]]
			-- Array of signatures indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are an array of type id representation signature of
			-- feature `feature_id' in `type_id'.

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

	clean_implementation_class_data (a_type_id: INTEGER)
			-- Clean current class implementation data.
		require
			is_generated: is_generated
			a_type_id_valid: a_type_id > 0
		do
			internal_features.put (Void, a_type_id)
		end

	insert_feature (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_setter (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_property_setter (a_token, a_type_id, a_feature_id: INTEGER)
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_property_setters'.
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_setters /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
			not_inserted: table_token (internal_property_setters, a_type_id, a_feature_id) = 0
		do
			insert_in_table (internal_property_setters, a_token, a_type_id, a_feature_id)
		ensure
			inserted: property_setter_token (a_type_id, a_feature_id) = a_token
		end

	insert_property_getter (a_token, a_type_id, a_feature_id: INTEGER)
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_property_getters'.
		require
			is_generated: is_generated
			internal_setters_not_void: internal_property_getters /= Void
			valid_token: a_token /= 0
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
			not_inserted: table_token (internal_property_getters, a_type_id, a_feature_id) = 0
		do
			insert_in_table (internal_property_getters, a_token, a_type_id, a_feature_id)
		ensure
			inserted: property_getter_token (a_type_id, a_feature_id) = a_token
		end

	insert_implementation_feature (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_attribute (a_token, a_type_id, a_feature_id: INTEGER)
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

	insert_signature (a_signature: like signature; a_type_id, a_feature_id: INTEGER)
			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `signatures_table'.
		require
			is_generated: is_generated
			internal_signatures_not_void: internal_signatures /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [like signature, INTEGER]
		do
			if a_type_id = 601 and a_feature_id = 3 then
				do_nothing
			end
			l_hash := internal_signatures.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				internal_signatures.put (l_hash, a_type_id)
			end
			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: signature (a_type_id, a_feature_id).is_equal (a_signature)
		end

	insert_implementation_signature (a_signature: like signature; a_type_id, a_feature_id: INTEGER)

			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `implementation_signatures_table'.
		require
			is_generated: is_generated
			internal_implementation_signatures_not_void: internal_implementation_signatures /= Void
			a_signature_not_void: a_signature /= Void
			valid_type_id: a_type_id > 0
			valid_feature_id: a_feature_id > 0
		local
			l_hash: HASH_TABLE [like signature, INTEGER]
		do
			l_hash := internal_implementation_signatures.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				internal_implementation_signatures.put (l_hash, a_type_id)
			end
			l_hash.put (a_signature, a_feature_id)
		ensure
			inserted: implementation_signature (a_type_id, a_feature_id).is_equal (a_signature)
		end


	insert_in_table (a_table: ARRAY [HASH_TABLE [INTEGER, INTEGER]];
			a_token, a_type_id, a_feature_id: INTEGER)

			-- Insert `a_token' of `a_feature_id' in `a_type_id' in `internal_attributes'.
		require
			is_generated: is_generated
			a_table_not_void: a_table /= Void
			token_valid: a_token /= 0
			type_id_valid: a_type_id > 0
			feature_id_valid: a_feature_id > 0
			not_inserted:
				attached a_table.item (a_type_id) as feature_table and then feature_table.has (a_feature_id) implies
				feature_table.item (a_feature_id) & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_member_ref and then
				a_token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def
		local
			l_hash: HASH_TABLE [INTEGER, INTEGER]
		do
			l_hash := a_table.item (a_type_id)
			if l_hash = Void then
				create l_hash.make (10)
				a_table.put (l_hash, a_type_id)
			end

			l_hash.force (a_token, a_feature_id)
		ensure
			inserted: a_table.item (a_type_id).item (a_feature_id) = a_token
		end

	assembly_token (a_class_type: CLASS_TYPE): INTEGER
			-- Given `a_class_type' find its associated assembly token.
		require
			is_generated: is_generated
			a_class_type_not_void: a_class_type /= Void
		do
			Result := internal_assemblies.item (a_class_type.implementation_id)
			if Result = 0 then
					-- Assembly token has not yet been computed.
				find_and_insert_assembly_token (a_class_type, False)
				Result := internal_assemblies.item (a_class_type.implementation_id)
			end
		end

	external_assembly_token (a_class_type: CLASS_TYPE): INTEGER
			-- Given `a_class_type' find its associated assembly token
			-- using an external type counterpart (if any).
		require
			is_generated: is_generated
			a_class_type_not_void: a_class_type /= Void
		do
			Result := internal_assemblies.item (a_class_type.external_id)
			if Result = 0 then
					-- Assembly token has not yet been computed.
				find_and_insert_assembly_token (a_class_type, True)
				Result := internal_assemblies.item (a_class_type.external_id)
			end
		end

	module_reference_token (a_module: IL_MODULE): INTEGER
			-- Given `a_module' from current assembly find its associated module token.
		require
			is_generated: is_generated
			a_module_not_void: a_module /= Void
			a_module_not_current: a_module /= Current
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_version: VERSION
		do
			Result := internal_module_references.item (a_module)
			if Result = 0 then
				if is_using_multi_assemblies then
						-- AssemblyRef token has not yet been computed.
					create l_version
					if attached system.msil_version as l_msil_version then
						l_version.set_version (l_msil_version)
					else
						l_version.set_version ("1.0.0.0") -- Default version.
					end
					l_ass_info := md_factory.assembly_info
					l_ass_info.set_major_version (l_version.major.to_natural_16)
					l_ass_info.set_minor_version (l_version.minor.to_natural_16)
					l_ass_info.set_build_number (l_version.build.to_natural_16)
					l_ass_info.set_revision_number (l_version.revision.to_natural_16)
					Result := define_assembly_reference (a_module.module_name, system.msil_version, "", Void)
					internal_module_references.put (Result, a_module)
				else
						-- ModuleRef token has not yet been computed.
					Result := md_emit.define_module_ref (uni_string (a_module.module_name_with_extension))
					internal_module_references.put (Result, a_module)
				end
			end
		end

	find_and_insert_assembly_token (a_class_type: CLASS_TYPE; is_used_as_external: BOOLEAN)
			-- Given `a_class_type' find out which assembly defines it and updates
			-- `internal_assemblies' accordingly. Create assembly reference
			-- as they are needed.
		require
			is_generated: is_generated
			a_class_not_void: a_class_type /= Void
			not_inserted: (is_used_as_external or else internal_assemblies.item (a_class_type.implementation_id) = 0) and
				(is_used_as_external implies internal_assemblies.item (a_class_type.external_id) = 0)
		local
			l_token: INTEGER
			l_id: INTEGER
			l_name, l_key_string, l_culture, l_version_string: READABLE_STRING_32
			l_assembly: ASSEMBLY_I
			l_precompiled_assembly: ASSEMBLY_INFO
		do
			if attached {NATIVE_ARRAY_CLASS_TYPE} a_class_type as l_native_array then
				l_token := assembly_token (l_native_array.deep_il_element_type.associated_class_type (Void))
			elseif a_class_type.is_generated and then not is_used_as_external then
					-- We need to find in which module it is being defined. If no `module_ref'
					-- token is found for this module, we need to create one for Current module.
					--FIXME: I'm not sure what to do when `a_class_type' is defined in current
					-- module.
				l_token := module_reference_token (il_code_generator.il_module (a_class_type))
			else
				if
					not a_class_type.is_external and then
					not is_used_as_external and then
					a_class_type.is_precompiled
				then
					l_precompiled_assembly := a_class_type.assembly_info
					l_name := l_precompiled_assembly.assembly_name
					l_version_string := l_precompiled_assembly.version
					l_culture := l_precompiled_assembly.culture
					l_key_string := l_precompiled_assembly.public_key_token
				else
					if attached {EXTERNAL_CLASS_C} a_class_type.associated_class as l_external_class then
							-- When it is an XML represented external class.
						l_assembly := if attached l_external_class.lace_class.public_assembly as l_public_assembly then l_public_assembly else l_external_class.lace_class.assembly end
						l_name := l_assembly.assembly_name
						l_version_string := l_assembly.assembly_version
						l_culture := l_assembly.assembly_culture
						l_key_string := l_assembly.assembly_public_key_token
					elseif
						attached a_class_type.associated_class.ast.top_indexes as l_indexes and then
						attached l_indexes.assembly_name as l_info
					then
							-- When it is an actual Eiffel class encapsulating
							-- an external class.
						l_name := l_info [1]
						if l_info.valid_index (2) then
							l_version_string := l_info [2]
						end
						if l_info.valid_index (4) then
							l_key_string := l_info [4]
						end
					end
				end
				if attached l_name then
					l_token := define_assembly_reference (l_name, l_version_string, l_culture, l_key_string)
				end
			end
			l_id :=
				if is_used_as_external then
					a_class_type.external_id
				else
					a_class_type.implementation_id
				end
			if l_token /= 0 then
				internal_assemblies.put (l_token, l_id)
			end
		ensure
			updated:  (is_used_as_external or else internal_assemblies.item (a_class_type.implementation_id) /= 0) and
				(is_used_as_external implies internal_assemblies.item (a_class_type.external_id) /= 0)
		end

	defined_assemblies: STRING_TABLE [TUPLE [token: INTEGER; version: READABLE_STRING_GENERAL]]
			-- In order to avoid calling `define_assembly_ref' twice on same assemblies.

feature {NONE} -- Once per modules being generated.

	initialize_mapping (a_type_count: INTEGER)
			-- Following calls to current will only be `generate_class_mappings'.
		require
			is_generated: is_generated
			a_type_count_positive: a_type_count > 0
		do
			create class_data_mapping.make_filled (0, 0, system.class_counter.count)
			create class_mapping.make_filled (0, 0, a_type_count)
			create single_parent_mapping.make_filled (0, 0, a_type_count)
			create internal_external_token_mapping.make (a_type_count)
			create internal_invariant_token.make_filled (0, 0, a_type_count)
			create internal_constructor_token.make_filled (0, 0, a_type_count)
			create internal_constructors.make_filled (Void, 0, a_type_count)
			create internal_assemblies.make_filled (0, 0, a_type_count)
			create internal_module_references.make (10)
			create defined_assemblies.make (10)
			create internal_features.make_filled (Void, 0, a_type_count)
			create internal_setters.make_filled (Void, 0, a_type_count)
			create internal_property_setters.make_filled (Void, 0, a_type_count)
			create internal_property_getters.make_filled (Void, 0, a_type_count)
			create internal_attributes.make_filled (Void, 0, a_type_count)
			create internal_implementation_features.make_filled (Void, 0, a_type_count)
			create internal_signatures.make_filled (Void, 0, a_type_count)
			create internal_implementation_signatures.make_filled (Void, 0, a_type_count)

				-- Debug data structure.
			create internal_dbg_documents.make_filled (Void, 0, a_type_count)
			create internal_dbg_pragma_documents.make (a_type_count)
			create method_sequence_points.make (1000)
			create local_info.make (1000)
			internal_class_types := Void
		end

	initialize_runtime_type_class_mappings
			-- Initializes correspondance between .NET runtime types and Eiffel types.
		require
			is_generated: is_generated
		local
			l_sig: like method_sig
			l_meth_token: INTEGER
			l_gen: like il_code_generator
			l_dot_ctor_uni_string: like uni_string
		do
			l_gen := il_code_generator
			class_mapping.put (ise_type_token, l_gen.runtime_type_id)
			class_mapping.put (ise_class_type_token, l_gen.class_type_id)
			class_mapping.put (ise_basic_type_token, l_gen.basic_type_id)
			class_mapping.put (ise_generic_type_token, l_gen.generic_type_id)
			class_mapping.put (ise_tuple_type_token, l_gen.tuple_type_id)
			class_mapping.put (ise_formal_type_token, l_gen.formal_type_id)
			class_mapping.put (ise_none_type_token, l_gen.none_type_id)
			class_mapping.put (ise_eiffel_type_info_type_token, l_gen.eiffel_type_info_type_id)
			class_mapping.put (ise_generic_conformance_token, l_gen.generic_conformance_type_id)
			class_mapping.put (ise_assertion_level_enum_token, l_gen.assertion_level_enum_type_id)

			internal_external_token_mapping.put (ise_type_token, Type_class_name)
			internal_external_token_mapping.put (ise_class_type_token, Class_type_class_name)
			internal_external_token_mapping.put (ise_basic_type_token, Basic_type_class_name)
			internal_external_token_mapping.put (ise_generic_type_token, Generic_type_class_name)
			internal_external_token_mapping.put (ise_tuple_type_token, tuple_type_class_name)
			internal_external_token_mapping.put (ise_formal_type_token, Formal_type_class_name)
			internal_external_token_mapping.put (ise_none_type_token, None_type_class_name)
			internal_external_token_mapping.put (ise_eiffel_type_info_type_token,
				Type_info_class_name)
			internal_external_token_mapping.put (ise_generic_conformance_token,
				Generic_conformance_class_name)
			internal_external_token_mapping.put (type_handle_class_token,
				Type_handle_class_name)
			internal_external_token_mapping.put (ise_assertion_level_enum_token,
				Assertion_level_enum_class_name)

			l_sig := default_sig

			l_dot_ctor_uni_string := dot_ctor_uni_string

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.runtime_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_class_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.class_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_basic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.basic_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_generic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.generic_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_tuple_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.tuple_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_formal_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.formal_type_id)

			l_meth_token := md_emit.define_member_ref (l_dot_ctor_uni_string, ise_none_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.none_type_id)
		ensure
			inserted:
				actual_class_type_token (il_code_generator.runtime_type_id) = ise_type_token and
				actual_class_type_token (il_code_generator.class_type_id) = ise_class_type_token and
				actual_class_type_token (il_code_generator.basic_type_id) = ise_basic_type_token and
				actual_class_type_token (il_code_generator.generic_type_id) = ise_generic_type_token and
				actual_class_type_token (il_code_generator.tuple_type_id) = ise_tuple_type_token and
				actual_class_type_token (il_code_generator.formal_type_id) = ise_formal_type_token and
				actual_class_type_token (il_code_generator.none_type_id) = ise_none_type_token and
				actual_class_type_token (il_code_generator.eiffel_type_info_type_id) = ise_eiffel_type_info_type_token
		end

	initialize_tokens
			-- Recompute all tokens in context of newly created module.
		require
			is_generated: is_generated
		do
			mscorlib_token := 0
			object_type_token := 0
			value_type_token := 0
			math_type_token := 0
			system_exception_token := 0
			ise_exception_manager_type_token := 0
			ise_rt_extension_type_token := 0
			compute_mscorlib_token
			compute_mscorlib_type_tokens
			compute_power_method_token
			compute_mscorlib_method_tokens
			compute_ise_runtime_tokens
			compute_c_module_token
				-- Clear custom attribute tokens.
			thread_static_attribute_ctor_token := 0
				-- Clear once string tokens.
			once_string_field_cil_token := 0
			once_string_field_eiffel_token := 0
			once_string_allocation_routine_token_value := 0
			once_string_class_token_value := 0
		ensure
			thread_static_attribute_not_defined: not is_thread_static_attribute_defined
			helper_class_not_defined: not is_once_string_class_defined
			once_string_field_cil_not_defined: not is_once_string_field_cil_defined
			once_string_field_eiffel_not_defined: not is_once_string_field_eiffel_defined
			once_string_allocation_routine_not_defined: not is_once_string_allocation_routine_defined
		end

	compute_c_module_token
			-- Compute `c_module_token'.
		require
			is_generated: is_generated
		do
			c_module_token := md_emit.define_module_ref (uni_string (c_module_name))
		end

	compute_mscorlib_token
			-- Compute `mscorlib_token'.
		require
			is_generated: is_generated
			has_system_object: System.system_object_class /= Void
			system_object_compiled: System.system_object_class.is_compiled
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_system_runtime: ASSEMBLY_I
			l_version: VERSION
		do
				-- WORKAROUND:
				-- To compute it, we simply take the data from `System.Object'. That way our
				-- code is automatically using the version of `mscorlib' that was specified
				-- in the Ace file.

				-- TODO extract code.
			l_system_runtime := if attached system.system_object_class.public_assembly as l_assembly then l_assembly else system.system_object_class.assembly end
			if l_system_runtime = Void then
					-- TODO: get assembly using "System.Runtime"
			end

			create l_version
			check
				version_valid: l_version.is_version_valid (l_system_runtime.assembly_version)
			end

			l_version.set_version (l_system_runtime.assembly_version)
			l_ass_info := md_factory.assembly_info
			l_ass_info.set_major_version (l_version.major.to_natural_16)
			l_ass_info.set_minor_version (l_version.minor.to_natural_16)
			l_ass_info.set_build_number (l_version.build.to_natural_16)
			l_ass_info.set_revision_number (l_version.revision.to_natural_16)

			mscorlib_token := define_assembly_reference (l_system_runtime.name, l_ass_info.string, "", l_system_runtime.assembly_public_key_token)

			type_handle_class_token := md_emit.define_type_ref (uni_string (Type_handle_class_name), mscorlib_token)
		end

	compute_mscorlib_type_tokens
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
			l_debuggable_token: INTEGER
			l_com_visible_token: INTEGER
			l_debugger_step_through_token: INTEGER
			l_debugger_hidden_token: INTEGER
			l_non_serialized_attribute_token: INTEGER
			l_dot_ctor_uni_string: like uni_string
		do
			object_type_token := md_emit.define_type_ref (uni_string ("System.Object"), mscorlib_token)
			value_type_token := md_emit.define_type_ref (uni_string ("System.ValueType"), mscorlib_token)
			runtime_type_handle_token := md_emit.define_type_ref (uni_string (type_handle_class_name), mscorlib_token)
			math_type_token := md_emit.define_type_ref (uni_string ("System.Math"), mscorlib_token)
			real_32_type_token := md_emit.define_type_ref (uni_string ("System.Single"), mscorlib_token)
			real_64_type_token := md_emit.define_type_ref (uni_string ("System.Double"), mscorlib_token)
			char_type_token := md_emit.define_type_ref (uni_string ("System.Char"), mscorlib_token)
			string_type_token := md_emit.define_type_ref (uni_string ("System.String"), mscorlib_token)
			system_exception_token := md_emit.define_type_ref (uni_string ("System.Exception"), mscorlib_token)
			l_debuggable_token := md_emit.define_type_ref (uni_string ("System.Diagnostics.DebuggableAttribute"), mscorlib_token)
			l_cls_compliant_token := md_emit.define_type_ref (uni_string ("System.CLSCompliantAttribute"), mscorlib_token)
			l_debugger_step_through_token := md_emit.define_type_ref (uni_string ("System.Diagnostics.DebuggerHiddenAttribute"),
				mscorlib_token)
			l_debugger_hidden_token := md_emit.define_type_ref (uni_string ("System.Diagnostics.DebuggerStepThroughAttribute"),
				mscorlib_token)
			l_com_visible_token := md_emit.define_type_ref (uni_string ("System.Runtime.InteropServices.ComVisibleAttribute"),
				mscorlib_token)
			l_non_serialized_attribute_token := md_emit.define_type_ref (uni_string (non_serialized_attribute_class_name),
				mscorlib_token)


				-- Define `.ctor' from `System.CLSCompliantAttribute' and
				-- `System.Runtime.InteropServices.ComVisibleAttribute'.

			l_dot_ctor_uni_string := dot_ctor_uni_string

			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			cls_compliant_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_cls_compliant_token, l_sig)

			com_visible_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_com_visible_token, l_sig)

				-- Define `.ctor' from `System.Diagnostics.DebuggableAttribute'.
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			debuggable_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_debuggable_token, l_sig)

			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			debugger_hidden_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_debugger_hidden_token, l_sig)

			debugger_step_through_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_debugger_step_through_token, l_sig)

				-- Get token for the .ctor of `System.NonSerializedAttribute'
			dotnet_non_serialized_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_non_serialized_attribute_token, l_sig)
		ensure
			object_type_token_set: object_type_token /= 0
			value_type_token_set: value_type_token /= 0
			math_type_token_set: math_type_token /= 0
			system_exception_token_set: system_exception_token /= 0
		end

	compute_power_method_token
			-- Compute `power_method_token'.
		require
			is_generated: is_generated
			valid_math_type_token: math_type_token /= 0
		local
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)

			power_method_token := md_emit.define_member_ref (uni_string ("Pow"), math_type_token, l_sig)
		ensure
			power_method_token_set: power_method_token /= 0
		end

	compute_mscorlib_method_tokens
			-- Compute `to_string_method_token'.
		require
			is_generated: is_generated
		local
			l_sig: like method_sig
		do
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			to_string_method_token := md_emit.define_member_ref (uni_string ("ToString"), object_type_token, l_sig)

			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			memberwise_clone_token := md_emit.define_member_ref (uni_string ("MemberwiseClone"), object_type_token, l_sig)
		ensure
			to_string_method_token: to_string_method_token /= 0
		end

	compute_ise_runtime_tokens
			-- Compute `ise_runtime_token'.
		require
			is_generated: is_generated
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_sig: like field_sig
			l_meth_sig: like method_sig
			l_ise_eiffel_name_attr_token: INTEGER
			l_ise_type_feature_attr_token: INTEGER
			l_ise_assertion_level_attr_token: INTEGER
			l_ise_interface_type_attr_token: INTEGER
			l_ise_eiffel_consumable_attr_token: INTEGER
			l_ise_eiffel_version_attr_token: INTEGER
			l_system_type_token: INTEGER
			l_dot_ctor_uni_string: like uni_string
		do
				-- Define `ise_runtime_token'.
			l_ass_info := md_factory.assembly_info
			if system.is_il_netcore then
				l_ass_info.major_version 	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_netcore_info.major_version
				l_ass_info.minor_version	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_netcore_info.minor_version
				l_ass_info.build_number		:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_netcore_info.build_number
				l_ass_info.revision_number	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_netcore_info.revision_number
			else
				l_ass_info.major_version 	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_framework_info.major_version
				l_ass_info.minor_version 	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_framework_info.minor_version
				l_ass_info.build_number 	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_framework_info.build_number
				l_ass_info.revision_number 	:= {IL_PREDEFINED_CONSTANTS}.eiffel_runtime_framework_info.revision_number
			end

			ise_runtime_token := define_assembly_reference (
					runtime_namespace, l_ass_info.string, "",
					{IL_PREDEFINED_CONSTANTS}.eiffel_runtime_public_key_string
				)

			ise_runtime_type_token := md_emit.define_type_ref (
					uni_string (runtime_class_name),
					ise_runtime_token
				)

			ise_exception_manager_type_token := md_emit.define_type_ref (
					uni_string (exception_manager_interface_name),
					ise_runtime_token
				)

			ise_rt_extension_type_token := md_emit.define_type_ref (
					uni_string (rt_extension_interface_name),
					ise_runtime_token
				)

				-- Define `ise_set_last_exception_token'.
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, system_exception_token)

			ise_set_last_exception_token := md_emit.define_member_ref (
				uni_string ("set_last_exception"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_get_last_exception_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, system_exception_token)

			ise_get_last_exception_token := md_emit.define_member_ref (
				uni_string ("get_last_exception"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_restore_last_exception_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, system_exception_token)

			ise_restore_last_exception_token := md_emit.define_member_ref (
				uni_string ("restore_last_exception"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_raise_code_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_i4, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)

			ise_raise_code_token := md_emit.define_member_ref (
				uni_string ("raise_code"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_raise_old_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, system_exception_token)

			ise_raise_old_token := md_emit.define_member_ref (
				uni_string ("raise_old"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_enter_rescue_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			ise_enter_rescue_token := md_emit.define_member_ref (
				uni_string ("enter_rescue"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_set_rescue_level_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_i4, 0)

			ise_set_rescue_level_token := md_emit.define_member_ref (
				uni_string ("set_rescue_level"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_get_rescue_level_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_i4, 0)

			ise_get_rescue_level_token := md_emit.define_member_ref (
				uni_string ("get_rescue_level"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_rethrow_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_rethrow_token := md_emit.define_member_ref (
				uni_string ("rethrow"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_in_assertion_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_in_assertion_token := md_emit.define_member_ref (
				uni_string ("in_assertion"), ise_runtime_type_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_set_in_assertion_token := md_emit.define_member_ref (
				uni_string ("set_in_assertion"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_in_precondition_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_in_precondition_token := md_emit.define_member_ref (
				uni_string ("in_precondition"), ise_runtime_type_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_set_in_precondition_token := md_emit.define_member_ref (
				uni_string ("set_in_precondition"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_assertion_tag_token'
			l_sig := field_sig
			l_sig.reset
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			ise_assertion_tag_token := md_emit.define_member_ref (
				uni_string ("assertion_tag"), ise_runtime_type_token, l_sig)

				-- Define `ise_**_type_token'.
			ise_eiffel_type_info_type_token := md_emit.define_type_ref (
				uni_string (Type_info_class_name), ise_runtime_token)
			ise_type_token := md_emit.define_type_ref (
				uni_string (Type_class_name), ise_runtime_token)
			ise_class_type_token := md_emit.define_type_ref (
				uni_string (Class_type_class_name), ise_runtime_token)
			ise_generic_type_token := md_emit.define_type_ref (
				uni_string (generic_type_class_name), ise_runtime_token)
			ise_tuple_type_token := md_emit.define_type_ref (
				uni_string (tuple_type_class_name), ise_runtime_token)
			ise_formal_type_token := md_emit.define_type_ref (
				uni_string (Formal_type_class_name), ise_runtime_token)
			ise_none_type_token := md_emit.define_type_ref (
				uni_string (None_type_class_name), ise_runtime_token)
			ise_basic_type_token := md_emit.define_type_ref (
				uni_string (basic_type_class_name), ise_runtime_token)
			l_ise_eiffel_name_attr_token := md_emit.define_type_ref (
				uni_string (eiffel_name_attribute), ise_runtime_token)
			l_ise_eiffel_version_attr_token := md_emit.define_type_ref (
				uni_string (eiffel_version_attribute), ise_runtime_token)
			l_ise_type_feature_attr_token := md_emit.define_type_ref (
				uni_string (type_feature_attribute), ise_runtime_token)
			l_ise_assertion_level_attr_token := md_emit.define_type_ref (
				uni_string (assertion_level_class_name_attribute), ise_runtime_token)
			l_ise_interface_type_attr_token := md_emit.define_type_ref (
				uni_string (interface_type_class_name_attribute), ise_runtime_token)
			l_ise_eiffel_consumable_attr_token := md_emit.define_type_ref (
				uni_string (eiffel_consumable_attribute), ise_runtime_token)
			ise_generic_conformance_token := md_emit.define_type_ref (
				uni_string (Generic_conformance_class_name), ise_runtime_token)

				-- Define `ise_get_type_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				ise_generic_type_token)

			ise_get_type_token := md_emit.define_member_ref (
				uni_string ("____type"),
				ise_eiffel_type_info_type_token, l_meth_sig)

				-- Define `ise_check_invariant_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_check_invariant_token := md_emit.define_member_ref (
				uni_string ("check_invariant"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_is_invariant_checked_for'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				runtime_type_handle_token)
			ise_is_invariant_checked_for_token := md_emit.define_member_ref (
				uni_string ("is_invariant_checked_for"),
				ise_runtime_type_token, l_meth_sig)

				-- Get token for `System.Type'
			l_system_type_token := md_emit.define_type_ref (
				uni_string (system_type_class_name), mscorlib_token)

				-- Define constructors of custom attribute class that keeps Eiffel
				-- name classes in their Eiffel formatting. The first one is for non-generic
				-- classes, the second one for generic classes.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			l_dot_ctor_uni_string := dot_ctor_uni_string

			ise_eiffel_name_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_eiffel_name_attr_token, l_meth_sig)

			ise_type_feature_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_type_feature_attr_token, l_meth_sig)

			ise_eiffel_version_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_eiffel_version_attr_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)

			ise_eiffel_name_attr_generic_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_eiffel_name_attr_token, l_meth_sig)

				-- Definition of `.ctor' for CLASS_TYPE_MARK_ATTRIBUTE
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				md_emit.define_type_ref
					(uni_string (Class_type_mark_enum_class_name), ise_runtime_token))

			ise_eiffel_class_type_mark_attr_ctor_token := md_emit.define_member_ref
				(l_dot_ctor_uni_string, md_emit.define_type_ref
					(uni_string (class_type_mark_attribute_name), ise_runtime_token), l_meth_sig)

				-- Definition of `.ctor' for ASSERTION_LEVEL_ATTRIBUTE
			ise_assertion_level_enum_token := md_emit.define_type_ref (
				uni_string (Assertion_level_enum_class_name), ise_runtime_token)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				ise_assertion_level_enum_token)

			l_dot_ctor_uni_string := dot_ctor_uni_string

			ise_assertion_level_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_assertion_level_attr_token, l_meth_sig)

				-- Definition of `.ctor' for CREATION_TYPE_ATTRIBUTE
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)

			ise_interface_type_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_interface_type_attr_token, l_meth_sig)

				-- Definition of `.ctor' for EIFFEL_CONSUMABLE_ATTRIBUTE
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_eiffel_consumable_attr_ctor_token := md_emit.define_member_ref (l_dot_ctor_uni_string,
				l_ise_eiffel_consumable_attr_token, l_meth_sig)

		end

feature {NONE} -- Implementation

	generate_argument_array
			-- Generate a new argument array for system procedure creation that takes
			-- an ARRAY [STRING] as argument.
			-- Note: Maybe we do not need to rely on ARGUMENTS being in the system
			-- but for the moment it is much easier to call a library function than
			-- emitting the IL in Eiffel code.
		require
			has_arguments_class: system.arguments_class /= Void
			has_arguments_class_in_system: system.arguments_class.is_compiled
		local
			l_arg_type: CLASS_TYPE
			l_root: FEATURE_I
		do
			l_arg_type := system.arguments_class.compiled_class.types.first
			l_root := system.arguments_class.compiled_class.feature_table.
				item_id ({PREDEFINED_NAMES}.internal_argument_array_name_id)

			check
				has_routine: l_root /= Void
			end

			il_code_generator.create_object (l_arg_type.implementation_id)
			il_code_generator.generate_feature_access (
				l_arg_type.type.implemented_type (l_root.origin_class_id),
				l_root.origin_feature_id, 0, True, True)
		end

feature {NONE} -- Convenience

	is_by_ref_type (a_type: TYPE_A): BOOLEAN
			-- Is `a_type' an out parameter type?
		require
			a_type_not_void: a_type /= Void
		do
			Result := attached {TYPED_POINTER_A} a_type
		end

	by_ref_type (a_type: TYPE_A): TYPE_A
			-- True type represented by `a_type'.
		require
			a_type_not_void: a_type /= Void
			is_by_ref_type: is_by_ref_type (a_type)
		do
			if attached {TYPED_POINTER_A} a_type as l_typed_pointer then
				Result := l_typed_pointer.generics.first
			else
				check is_by_ref_type: False end
			end
		ensure
			by_ref_type_not_void: Result /= Void
		end

	typed_pointer_class_id: INTEGER
			-- Class id of TYPED_POINTER class.
		once
			Result := System.typed_pointer_class.compiled_class.class_id
		ensure
			typed_pointer_class_id_positive: Result > 0
		end

	ise_exception_manager_type_id: INTEGER
			-- Type id of ISE_EXCEPTION_MANAGER
		once
			Result := system.ise_exception_manager_class.compiled_class.types.first.implementation_id
		end

	rt_extension_type_implementation_id: INTEGER
			-- Type id of RT_EXTENSION class.
		require
			present: system.rt_extension_class /= Void
			compiled: system.rt_extension_class.is_compiled
		once
			Result := system.rt_extension_class.compiled_class.types.first.implementation_id
		end

feature {NONE} -- Cleaning

	wipe_out
			-- Free all used memory.
		do
			assembly_info := Void
			class_data_mapping := Void
			class_mapping := Void
			dbg_writer := Void
			default_sig := Void
			generic_ctor_sig := Void
			defined_assemblies.wipe_out
			defined_assemblies := Void
			field_sig := Void
			internal_assemblies := Void
			internal_attributes := Void
			internal_class_types := Void
			internal_constructor_token := Void
			internal_constructors := Void
			internal_dbg_documents := Void
			internal_dbg_pragma_documents := Void
			internal_external_token_mapping := Void
			internal_features := Void
			internal_implementation_features := Void
			internal_invariant_token := Void
			internal_module_references := Void
			internal_setters := Void
			internal_property_setters := Void
			internal_property_getters := Void
			last_parents := Void
			local_info := Void
			local_sig := Void
			md_emit := Void
			method_sequence_points := Void
			method_sig := Void
			method_writer := Void
			public_key := Void
			single_parent_mapping := Void
			reset_uni_string
		end

invariant
	md_emit_not_void: is_generated implies md_emit /= Void
	module_file_name_not_void: module_file_name /= Void
	module_file_name_not_empty: not module_file_name.is_empty
	il_code_generator_not_void: il_code_generator /= Void
	dll_or_console_valid: not is_assembly_module implies (is_dll and is_console_application)

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
