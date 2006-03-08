indexing
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

	SHARED_ERROR_HANDLER

	REFACTORING_HELPER

create {CIL_CODE_GENERATOR}
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
			value_type_id := system.system_value_type_class.compiled_class.types.first.static_type_id
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

	value_type_token: INTEGER
			-- Token for `System.ValueType' in `mscorlib'.

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

	cls_compliant_ctor_token: INTEGER
			-- Token for `System.CLSCompliantAttribute' constructor.

	com_visible_ctor_token: INTEGER
			-- Token for `System.Runtime.InteropServices.ComVisibleAttribute' constructor.

	debugger_hidden_ctor_token, debugger_step_through_ctor_token: INTEGER
			-- Token for constructor of `System.Diagnostics.DebuggerHiddenAttribute' and
			-- `System.Diagnostics.DebuggerStepThroughAttribute'.

	memberwise_clone_token: INTEGER
			-- Token for `MemberwiseClone' of `System.Object'.

	ise_runtime_token: INTEGER
			-- Token for `ise_runtime' assembly

	ise_eiffel_exception_ctor_token: INTEGER
			-- Token for `ISE.Runtime.EIFFEL_EXCEPTION.ctor (int, string)'.

	ise_eiffel_exception_chained_ctor_token: INTEGER
			-- Token for `ISE.Runtime.EIFFEL_EXCEPTION.ctor (int, string, Exception)'.

	ise_last_exception_token: INTEGER
			-- Token for `ISE.Runtime.last_exception' static field that holds
			-- exception object we got from `catch'.

	ise_in_assertion_token, ise_set_in_assertion_token: INTEGER
			-- Token for `ISE.Runtime.in_assertion' and `ISE.Runtime.set_in_assertion'
			-- static members that holds status of assertion checking.

	ise_assertion_tag_token: INTEGER
			-- Token for `ISE.Runtime.assertion_tag' static field that holds
			-- message for exception being thrown.

	ise_set_type_token: INTEGER
			-- Token for `ISE.Runtime.EIFFEL_TYPE_INFO.____set_type' feature that
			-- assign type information of a class.

	ise_check_invariant_token: INTEGER
			-- Token for `ISE.Runtime.ise_check_invariant' feature that
			-- checks a class invariant.

	ise_is_invariant_checked_for_token: INTEGER
			-- Token for `ISE.Runtime.is_invariant_checked_for' feature that
			-- tells if a class invariant has been checked or not for a given type.

	ise_eiffel_type_info_type_token,
	ise_runtime_type_token,
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
	type_handle_class_token,
	ise_assertion_level_enum_token: INTEGER
			-- Token for run-time types used in code generation.

feature {NONE} -- Custom attributes: access

	thread_static_attribute_ctor_token: INTEGER
			-- Token of ThreadStaticAttribute constructor

	is_thread_static_attribute_defined: BOOLEAN is
			-- Is token of ThreadStaticAttribute constructor defined?
		do
			Result := thread_static_attribute_ctor_token /= 0
		ensure
			definition: Result implies thread_static_attribute_ctor_token /= 0
		end

feature {CIL_CODE_GENERATOR} -- Custom attributes: modification

	define_thread_static_attribute (field_token: INTEGER) is
			-- Define a ThreadStaticAttribute attribute for field identified by `field_token'.
		require
			valid_token: field_token /= 0
				-- member_token is FieldDef
		local
			attribute_class_token: INTEGER
			l_method_sig: like method_sig
		do
			if not is_thread_static_attribute_defined then
				attribute_class_token := md_emit.define_type_ref (create {UNI_STRING}.make ("System.ThreadStaticAttribute"), mscorlib_token)
				l_method_sig := method_sig
				l_method_sig.reset
				l_method_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current | {MD_SIGNATURE_CONSTANTS}.default_sig)
				l_method_sig.set_parameter_count (0)
				l_method_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				thread_static_attribute_ctor_token := md_emit.define_member_ref (create {UNI_STRING}.make (".ctor"), attribute_class_token, l_method_sig)
			end
			md_emit.define_custom_attribute (field_token, thread_static_attribute_ctor_token, Void).do_nothing
		end

feature {CIL_CODE_GENERATOR} -- Synchronization tokens

	define_monitor_method_token (method_name: STRING): INTEGER is
			-- Define token for a procedure of type "System.Threading.Monitor" that takes one argument of type "System.Object"
		require
			method_name_not_void: method_name /= Void
			method_name_is_valid:
				method_name.is_equal ("Enter") or else method_name.is_equal ("Exit") or else
				method_name.is_equal ("Pulse") or else method_name.is_equal ("PulseAll")
		local
			monitor_token: INTEGER
			l_sig: like method_sig
		do
			monitor_token := md_emit.define_type_ref (create {UNI_STRING}.make ("System.Threading.Monitor"), mscorlib_token)
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.default_sig)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_object, 0)
			uni_string.set_string (method_name)
			Result := md_emit.define_member_ref (uni_string, monitor_token, l_sig)
		ensure
			defined: Result /= 0
		end

feature {CIL_CODE_GENERATOR} -- Once manifest strings: access

	once_string_field_token (is_cil_string: BOOLEAN): INTEGER is
			-- Token of a field that is used to store values of once manifest strings
			-- if CIL type "string" if `is_cil_string' is `true' or of Eiffel type "STRING" otherwise
		local
			once_string_field_name: UNI_STRING
			l_field_sig: like field_sig
		do
			if is_cil_string then
				Result := once_string_field_cil_token
				once_string_field_name := once_string_field_cil_name
			else
				Result := once_string_field_eiffel_token
				once_string_field_name := once_string_field_eiffel_name
			end
			if Result = 0 then
					-- Get token of the field that keeps once manifest strings.
					-- Define field signature.
				l_field_sig := field_sig
				l_field_sig.reset
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_szarray, 0)
				if is_cil_string then
					l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
				else
					l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_class,
						actual_class_type_token (system.string_class.compiled_class.types.first.type.static_type_id))
				end
					-- Define field token.
				Result := md_emit.define_member_ref (once_string_field_name, once_string_class_token, l_field_sig)
				if is_cil_string then
					once_string_field_cil_token := Result
				else
					once_string_field_eiffel_token := Result
				end
			end
		ensure
			valid_result: Result /= 0
			cil_token_defined: is_cil_string implies is_once_string_field_cil_defined
			eiffel_token_defined: not is_cil_string implies is_once_string_field_eiffel_defined
			consistent_cil_result: is_cil_string implies Result = once_string_field_cil_token
			consistent_eiffel_result: not is_cil_string implies Result = once_string_field_eiffel_token
			old_cil_token_preserved: (old is_once_string_field_cil_defined) implies once_string_field_cil_token = old once_string_field_cil_token
			old_eiffel_token_preserved: (old is_once_string_field_eiffel_defined) implies once_string_field_eiffel_token = old once_string_field_eiffel_token
		end

	once_string_allocation_routine_token: INTEGER is
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

	is_once_string_class_defined: BOOLEAN is
			-- Is token of a run-time helper class to manage once strings defined?
		do
			Result := once_string_class_token_value /= 0
		ensure
			definition: Result implies once_string_class_token_value /= 0
		end

	is_once_string_field_cil_defined: BOOLEAN is
			-- Is token of a field that is used to store values of CIL once manifest strings defined?
		do
			Result := once_string_field_cil_token /= 0
		ensure
			definition: Result implies once_string_field_cil_token /= 0
		end

	is_once_string_field_eiffel_defined: BOOLEAN is
			-- Is token of a field that is used to store values of Eiffel once manifest strings defined?
		do
			Result := once_string_field_eiffel_token /= 0
		ensure
			definition: Result implies once_string_field_eiffel_token /= 0
		end

	is_once_string_allocation_routine_defined: BOOLEAN is
			-- Is token of a routine that allocates array to store once manifest string values defined?
		do
			Result := once_string_allocation_routine_token_value /= 0
		ensure
			definition: Result implies once_string_allocation_routine_token_value /= 0
		end

feature {CIL_CODE_GENERATOR} -- Once manifest strings: management

	define_once_string_tokens is
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
				{MD_TYPE_ATTRIBUTES}.Auto_class | {MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.Public,
				object_type_token,
				Void)
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

				-- Emit field for Eiffel strings.
			l_field_sig.reset
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_field_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, actual_class_type_token (system.string_class.compiled_class.types.first.type.static_type_id))
			once_string_field_eiffel_token := md_emit.define_field (
				once_string_field_eiffel_name,
				helper_class_token,
				{MD_FIELD_ATTRIBUTES}.public | {MD_FIELD_ATTRIBUTES}.static,
				l_field_sig)
			define_thread_static_attribute (once_string_field_eiffel_token)

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
			once_string_allocation_routine_defined: is_once_string_allocation_routine_defined
		end

feature {NONE} -- Once manifest strings: names

	runtime_helper_class_name: UNI_STRING is
			-- Name of the helper run-time class.
		once
			create Result.make ("EiffelSoftware.Runtime.Data")
		end

	once_string_field_cil_name: UNI_STRING is
			-- Name of the once manifest string field to store CIL strings
		once
			create Result.make ("oms_cil")
		end

	once_string_field_eiffel_name: UNI_STRING is
			-- Name of the once manifest string field to store Eiffel strings
		once
			create Result.make ("oms_eiffel")
		end

	once_string_allocation_routine_name: UNI_STRING is
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

	once_string_allocation_routine_token_value: INTEGER
			-- Token of a routine that performs allocation of arrays for once manifest strings

	once_string_class_token_value: INTEGER
			-- Token of a run-time helper class that keeps values of once manifest strings

	once_string_class_token: INTEGER is
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
					once_string_resolution_token := 0
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

feature -- Access: types

	local_types: ARRAYED_LIST [PAIR [TYPE_I, STRING]] is
			-- To store types of local variables. For type definition only here.
		do
		end

	object_type_id, value_type_id, any_type_id: INTEGER
			-- Type id of SYSTEM_OBJECT, VALUE_TYPE and ANY class.

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
			is_dll := False
		ensure
			is_console_application_set: is_console_application
		end

	set_window_application is
			-- Current module is marked as being a WINDOW application.
		do
			is_console_application := False
			is_dll := False
		ensure
			is_console_application_set: not is_console_application
		end

	set_dll is
			-- Current module is a DLL.
		do
			is_console_application := True
			is_dll := True
		ensure
			is_dll_set: is_dll
		end

feature -- Settings

	set_resources (r: like resources) is
			-- Set `resources' with `r'.
		require
			r_not_void: r /= Void
		do
			resources := r
		ensure
			resources_set: resources = r
		end

feature -- Settings: signature

	set_method_return_type (a_sig: MD_METHOD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		do
			set_signature_type (a_sig, a_type)
		end

	set_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I) is
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_is_by_ref: BOOLEAN
			l_type: TYPE_I
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
			set_extended_signature_type (a_sig, l_type, l_is_by_ref)
		end

feature {NONE} -- Implementations: signatures

	set_extended_signature_type (a_sig: MD_SIGNATURE; a_type: TYPE_I; a_is_by_ref: BOOLEAN) is
			-- Set `a_type' to return type of `a_sig'.
		require
			is_generated: is_generated
			valid_sig: a_sig /= Void
			valid_type: a_type /= Void
		local
			l_native_array_type: NATIVE_ARRAY_TYPE_I
		do
			if a_is_by_ref then
				a_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_byref, 0)
			end
			if a_type.is_basic and not a_type.is_bit then
				a_sig.set_type (a_type.element_type, 0)
			else
				l_native_array_type ?= a_type
				if l_native_array_type /= Void then
					a_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
					set_signature_type (a_sig, l_native_array_type.true_generics.item (1))
				else
					if a_type.is_expanded then
						a_sig.set_type (a_type.element_type,
							actual_class_type_token (a_type.implementation_id))
					else
						a_sig.set_type (a_type.element_type,
							actual_class_type_token (a_type.static_type_id))
					end
				end
			end
		end

feature -- Cleanup

	cleanup is
			-- Clean up external data structures.
		do
			internal_dbg_documents := Void
			if dbg_writer /= Void and then not dbg_writer.is_closed then
				dbg_writer.close
			end
			dbg_writer := Void
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

			uni_string.set_string (module_name)

			if is_assembly_module then
				create ass.make
				create l_version
				if l_version.is_version_valid (assembly_info.version) then
					l_version.set_version (assembly_info.version)
					ass.set_major_version (l_version.major.to_natural_16)
					ass.set_minor_version (l_version.minor.to_natural_16)
					ass.set_build_number (l_version.build.to_natural_16)
					ass.set_revision_number (l_version.revision.to_natural_16)
				end

				if public_key /= Void then
					l_assembly_flags := {MD_ASSEMBLY_FLAGS}.public_key
				end
				associated_assembly_token :=
					md_emit.define_assembly (uni_string, l_assembly_flags, ass, public_key)
			end

			md_emit.set_module_name (uni_string)

			if is_debug_info_enabled then
				uni_string.set_string (module_file_name)
				create dbg_writer.make (md_emit, uni_string, True)
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
		is
			-- Define entry point for IL component from `a_feature_id' in
			-- class `a_class_type'.
		require
			is_generated: is_generated
			creation_type_not_void: creation_type /= Void
			a_class_type_not_void: a_class_type /= Void
			positive_feature_id: a_feature_id > 0
		local
			entry_type_token: INTEGER
			l_sig: like method_sig
			l_type_id: INTEGER
			l_nb_args: INTEGER
		do
			l_type_id := a_class_type.implementation_id

			entry_type_token := md_emit.define_type (
				create {UNI_STRING}.make ("MAIN"), {MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Auto_layout | {MD_TYPE_ATTRIBUTES}.public,
				object_type_token, Void)

			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			entry_point_token := md_emit.define_method (create {UNI_STRING}.make ("Main"),
				entry_type_token, {MD_METHOD_ATTRIBUTES}.Public |
				{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
				{MD_METHOD_ATTRIBUTES}.Static, l_sig,
				{MD_METHOD_ATTRIBUTES}.Managed)

			if is_debug_info_enabled then
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_step_through_ctor_token, Void)
				il_code_generator.define_custom_attribute (entry_point_token,
					debugger_hidden_ctor_token, Void)
			end

			il_code_generator.start_new_body (entry_point_token)

				-- Initialize assertions for runtime in workbench mode.
			if not System.in_final_mode then
				il_code_generator.put_type_token (l_type_id)
				il_code_generator.internal_generate_external_call (ise_runtime_token, 0,
					Runtime_class_name, "assertion_initialize",
					{SHARED_IL_CONSTANTS}.static_type, <<type_handle_class_name>>,
					Void, False)
			end

				-- Create root object and call creation procedure.
			il_code_generator.method_body.put_newobj (constructor_token (creation_type.implementation_id), 0)
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
		end

	save_to_disk (a_signing: MD_STRONG_NAME) is
			-- Save byte code and metadata to file `module_file_name'.
		require
			is_generated: is_generated
			a_signing_not_void: public_key /= Void implies a_signing /= Void
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
				l_pe_file.set_public_key (public_key, a_signing)
			end
			l_pe_file.set_emitter (md_emit)
			l_pe_file.set_method_writer (method_writer)
			if resources /= Void then
				l_pe_file.set_resources (resources)
			end
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

	generate_external_class_mapping (class_type: CLASS_TYPE) is
			-- Define reference to external type `class_type'.
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			not_external_class_type: class_type.is_external
		local
			class_c: CLASS_C
			l_native_array: NATIVE_ARRAY_CLASS_TYPE
			name: STRING
			l_type_token: INTEGER
			l_nested_parent_class: CLASS_C
			l_external_class: EXTERNAL_CLASS_C
			l_nested_parent_class_token: INTEGER
			l_uni_string: UNI_STRING
			l_sig: MD_TYPE_SIGNATURE
		do
			class_c := class_type.associated_class
			l_native_array ?= class_type

			if l_native_array /= Void or else is_by_ref_type (class_type.type) then
					-- Generate association with a NATIVE_ARRAY [] or TYPED_POINTER []
				create l_sig.make
				set_signature_type (l_sig, class_type.type)
				l_type_token := md_emit.define_type_spec (l_sig)
				name := class_type.full_il_type_name
				class_mapping.put (l_type_token, class_type.static_type_id)
				il_code_generator.external_class_mapping.put (class_type.type, name)
				internal_external_token_mapping.put (l_type_token, name)
			else
				name := class_type.full_il_type_name
				l_external_class ?= class_c
				if l_external_class /= Void and then l_external_class.is_nested then
					l_nested_parent_class := l_external_class.enclosing_class
					create l_uni_string.make (l_nested_parent_class.types.first.full_il_type_name)
					l_nested_parent_class_token := md_emit.define_type_ref (l_uni_string,
						assembly_token (l_nested_parent_class.types.first))
					l_uni_string.set_string (name.substring (
						name.index_of ('+', 1) + 1, name.count))
					l_type_token := md_emit.define_type_ref (l_uni_string,
						l_nested_parent_class_token)
				else
					create l_uni_string.make (name)
					l_type_token := md_emit.define_type_ref (l_uni_string,
						assembly_token (class_type))
				end
				class_mapping.put (l_type_token, class_type.static_type_id)

				il_code_generator.external_class_mapping.put (class_type.type, name)
				internal_external_token_mapping.put (l_type_token, name)
			end
		end

	generate_interface_class_mapping (class_type: CLASS_TYPE) is
			-- Define reference/definition of Eiffel type `class_type' used for
			-- interface purpose (i.e. interface class of an implementation class,
			-- or class itself if generated as a single class).
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
		local
			l_name: STRING
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_uni_string: UNI_STRING
		do
			class_c := class_type.associated_class
			l_name := class_type.full_il_type_name
			create l_uni_string.make (l_name)

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
					l_attributes := l_attributes | {MD_TYPE_ATTRIBUTES}.Is_class |
						{MD_TYPE_ATTRIBUTES}.Serializable
					if class_c.is_frozen or class_type.is_expanded then
						l_attributes := l_attributes | {MD_TYPE_ATTRIBUTES}.Sealed
					end

					single_parent_mapping.put (single_inheritance_parent_id,
						class_type.implementation_id)
				else
					l_attributes := l_attributes | {MD_TYPE_ATTRIBUTES}.Is_interface |
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
					l_uni_string.set_string (class_c.file_name)
					internal_dbg_documents.put (dbg_writer.define_document (l_uni_string,
						language_guid, vendor_guid, document_type_guid), class_c.class_id)
				end
			end

			class_mapping.put (l_type_token, class_type.static_type_id)
		end

	generate_implementation_class_mapping (class_type: CLASS_TYPE) is
			-- Define reference/definition of Eiffel type `class_type' used for
			-- implementation purpose.
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			not_generated_as_single_type: not class_type.is_generated_as_single_type
		local
			l_name: STRING
			class_c: CLASS_C
			l_type_token: INTEGER
			l_attributes: INTEGER
			l_uni_string: UNI_STRING
		do
			class_c := class_type.associated_class
			l_name := class_type.full_il_implementation_type_name
			create l_uni_string.make (l_name)

			if
				class_type.is_precompiled or
				il_code_generator.il_module (class_type) /= Current
			then
				l_type_token := md_emit.define_type_ref (l_uni_string, assembly_token (class_type))
			else
				l_attributes := {MD_TYPE_ATTRIBUTES}.Public |
					{MD_TYPE_ATTRIBUTES}.Auto_layout |
					{MD_TYPE_ATTRIBUTES}.Ansi_class |
					{MD_TYPE_ATTRIBUTES}.Is_class |
					{MD_TYPE_ATTRIBUTES}.Serializable

				if class_c.is_deferred then
					l_attributes := l_attributes | {MD_TYPE_ATTRIBUTES}.Abstract
				end

				if class_c.is_frozen or class_type.is_expanded then
					l_attributes := l_attributes | {MD_TYPE_ATTRIBUTES}.Sealed
				end

				update_parents (class_type, class_c, False)
				single_parent_mapping.put (single_inheritance_parent_id,
					class_type.implementation_id)
				l_type_token := md_emit.define_type (l_uni_string, l_attributes,
					single_inheritance_token, last_parents)

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
					l_uni_string.set_string (class_c.file_name)
					internal_dbg_documents.put (dbg_writer.define_document (l_uni_string,
						language_guid, vendor_guid, document_type_guid), class_c.class_id)
				end
			end

			class_mapping.put (l_type_token, class_type.implementation_id)
		end

	update_parents (class_type: CLASS_TYPE; class_c: CLASS_C; for_interface: BOOLEAN) is
			-- Generate ancestors map of `class_type' associated to `class_c' for context
			-- `for_interface'.
		require
			is_generated: is_generated
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			l_parent_type: CLASS_TYPE
			l_list: SEARCH_TABLE [INTEGER]
			id: INTEGER
			i: INTEGER
			l_parents: ARRAY [INTEGER]
			l_parent_class: CLASS_C
			l_single_inheritance_parent_id: like single_inheritance_parent_id
			l_has_an_eiffel_parent: BOOLEAN
			reference_type_a: CL_TYPE_A
			interface_class_type: CLASS_TYPE
		do
			parents := class_c.parents
			from
				create l_list.make (parents.count)
				parents.start
				create l_parents.make (0, parents.count)
				l_single_inheritance_parent_id := 0
			until
				parents.after
			loop
					-- We need to reset context at each iteration because calls to
					-- `xxx_class_type_token' might trigger a recursive call to `update_parents'
					-- thus changing the context.
				parent_type ?= byte_context.real_type_in (parents.item.type_i, class_type)
				l_parent_type := parent_type.associated_class_type
				l_has_an_eiffel_parent := l_has_an_eiffel_parent or else not l_parent_type.is_external
				id := l_parent_type.static_type_id
				if not l_list.has (id) then
					l_list.force (id)
					l_parent_class := l_parent_type.associated_class
					if
						not l_parent_class.is_single and
						(not l_parent_class.is_external or else l_parent_class.is_interface)
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
				parents.forth
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
							reference_type_a := class_type.type.type_a
							reference_type_a.set_reference_mark
							check
								has_reference_class_type: class_c.types.has_type (reference_type_a.type_i)
							end
							interface_class_type := class_c.types.search_item (reference_type_a.type_i)
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
					if for_interface then
						l_parents.force (actual_class_type_token (any_type_id), i)
					else
						l_parents.force (actual_class_type_token (class_type.static_type_id), i)
					end
					i := i + 1
				else
					if class_type.is_expanded then
							-- For expanded types we use interface of the reference counterpart.
						reference_type_a := class_type.type.type_a
						reference_type_a.set_reference_mark
						check
							has_reference_class_type: class_c.types.has_type (reference_type_a.type_i)
						end
						interface_class_type := class_c.types.search_item (reference_type_a.type_i)
						l_parents.force (actual_class_type_token (interface_class_type.static_type_id), i)
						i := i + 1
					elseif not for_interface then
						l_parents.force (actual_class_type_token (class_type.static_type_id), i)
						i := i + 1
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

	define_constructor (class_type: CLASS_TYPE; signature: like method_sig; is_reference: BOOLEAN; parent_token: INTEGER) is
			-- Define default constructor for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			signature_not_void: signature /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		local
			l_meth_token: INTEGER
			l_uni_string: like uni_string
			l_class: CLASS_C
			l_arg_count: INTEGER
			l_method_body: MD_METHOD_BODY
			i: INTEGER
		do
				-- Do not use `uni_string' as it might be used by `xxx_class_type_token'.
			create l_uni_string.make (".ctor")

			l_class := class_type.associated_class

			if
				is_reference or
				class_type.is_precompiled or class_type.is_external or
				il_code_generator.il_module (class_type) /= Current
			then
				l_meth_token := md_emit.define_member_ref (l_uni_string,
					actual_class_type_token (class_type.implementation_id), signature)
			else
				l_meth_token := md_emit.define_method (l_uni_string,
					actual_class_type_token (class_type.implementation_id),
					{MD_METHOD_ATTRIBUTES}.Public |
					{MD_METHOD_ATTRIBUTES}.Hide_by_signature |
					{MD_METHOD_ATTRIBUTES}.Special_name |
					{MD_METHOD_ATTRIBUTES}.Rt_special_name,
					signature, {MD_METHOD_ATTRIBUTES}.Managed)

				il_code_generator.start_new_body (l_meth_token)
				l_method_body := il_code_generator.method_body

				if not class_type.is_expanded then

						-- Call constructor from super-class for reference type
					il_code_generator.generate_current
					l_arg_count := signature.parameter_count
					from
						i := 1
					until
						i > l_arg_count
					loop
						inspect i
						when 0 then
							check
								already_defined: False
							end
						when 1 then
							l_method_body.put_opcode ({MD_OPCODES}.ldarg_1)
						when 2 then
							l_method_body.put_opcode ({MD_OPCODES}.ldarg_2)
						when 3 then
							l_method_body.put_opcode ({MD_OPCODES}.ldarg_3)
						else
							if i <= 255 then
								l_method_body.put_opcode_integer_8 ({MD_OPCODES}.ldarg_s, i.to_integer_8)
							else
								l_method_body.put_opcode_integer_16 ({MD_OPCODES}.ldarg, i.to_integer_16)
							end
						end
						i := i + 1
					end
					if parent_token = 0 then
						l_method_body.put_call ({MD_OPCODES}.Call,
							constructor_token (single_parent_mapping.item (class_type.implementation_id)) , l_arg_count, False)
					else
						l_method_body.put_call ({MD_OPCODES}.Call, parent_token, l_arg_count, False)
					end
				end

				if il_code_generator.is_initialization_required (class_type) then
					il_code_generator.generate_current
					il_code_generator.initialize_expanded_attributes (class_type)
					il_code_generator.pop
				end

				il_code_generator.generate_return (False)
				il_code_generator.store_locals (l_meth_token)
				method_writer.write_current_body

			end
			internal_constructor_token.put (l_meth_token, class_type.implementation_id)
		end

	define_default_constructor (class_type: CLASS_TYPE; is_reference: BOOLEAN) is
			-- Define default constructor for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		do
			define_constructor (class_type, default_sig, is_reference, 0)
		end

	define_constructors (class_type: CLASS_TYPE; is_reference: BOOLEAN) is
			-- Define constructors for implementation of `class_type'
		require
			is_generated: is_generated
			class_type_not_void: class_type /= Void
			class_type_can_be_created: not class_type.associated_class.is_interface
		local
			l_sig: like method_sig
			l_class: CLASS_C
			l_creators: ARRAY [STRING]
			l_creators_count: INTEGER
			l_feature: FEATURE_I
			l_external_feature: EXTERNAL_I
			l_il_extension: IL_EXTENSION_I
			l_define_default_ctor: BOOLEAN
			l_feat_arg: FEAT_ARG
			l_type_i: TYPE_I
			l_creators_table: HASH_TABLE [EXPORT_I, STRING]
			i: INTEGER
		do
			l_class := class_type.associated_class

			l_creators_table := l_class.creators
			if l_creators_table /= Void then
				l_creators := l_creators_table.current_keys
			end

			if l_creators /= Void and then not l_creators.is_empty then
				from
					i := l_creators.lower
					l_creators_count := l_creators.upper
				until
					i > l_creators_count
				loop
					l_feature := l_class.feature_named (l_creators[i])
					check
						l_feature_attached: l_feature /= Void
					end
					if l_feature.is_il_external then
						if l_feature.has_arguments then

							l_external_feature ?= l_feature
							check
								l_external_feature_attached: l_external_feature /= Void
							end
							l_il_extension ?= l_external_feature.extension
							check
								l_il_extension_attached: l_il_extension /= Void
							end

							create l_sig.make
							l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.has_current)
							l_sig.set_parameter_count (l_feature.argument_count)
							l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.element_type_void, 0)
							from
								l_feat_arg := l_feature.arguments
								l_feat_arg.start
							until
								l_feat_arg.after
							loop
								l_type_i := argument_actual_type (l_feat_arg.item.type_i)
								set_signature_type (l_sig, l_type_i)
								l_feat_arg.forth
							end
							define_constructor (class_type, l_sig, is_reference, l_il_extension.token)
						else
							l_define_default_ctor := True
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

	argument_actual_type (a_type: TYPE_I): TYPE_I is
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

	store_locals (a_local_types: like local_types; a_meth_token: INTEGER) is
			-- Store `local_types' into `il_code_generator.method_body' for routine `a_meth_token'.
		require
			is_generated: is_generated
			method_token_valid: a_meth_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
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
					set_signature_type (l_sig, a_local_types.item.first)
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
			method_token_valid: a_method_token & {MD_TOKEN_TYPES}.Md_mask =
				{MD_TOKEN_TYPES}.Md_method_def
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
					set_signature_type (l_sig, l_type)
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
				if a_type_name.item (a_type_name.count) = '&' then
					Result := external_token_mapping (a_type_name.substring (1, a_type_name.count - 1))
				else
					l_class_type := il_code_generator.external_class_mapping.item (a_type_name).
						associated_class_type
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
				define_default_constructor (class_types.item (a_type_id), True)
				Result := l_tokens.item (a_type_id)
			end
		ensure
			constructor_token_valid: Result /= 0
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
				l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
				l_sig.set_parameter_count (1)
				l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
				set_signature_type (l_sig, l_class_type.type)

				Result := md_emit.define_member_ref (create {UNI_STRING}.make ("$$_invariant"),
					actual_class_type_token (a_type_id), l_sig)
				internal_invariant_token.put (Result, a_type_id)
			end
		ensure
			invariant_token_valid: Result /= 0
		end

	internal_invariant_token: ARRAY [INTEGER]
			-- Array of invariant feature indexed by `type_id' of class in
			-- which they are defined.

	actual_class_type_token (a_type_id: INTEGER): INTEGER is
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
				l_class_type := class_types.item (a_type_id)
				if l_class_type.is_external then
					generate_external_class_mapping (l_class_type)
				elseif a_type_id = l_class_type.static_type_id then
					generate_interface_class_mapping (l_class_type)
				else
					generate_implementation_class_mapping (l_class_type)
				end
				Result := l_class_mapping.item (a_type_id)
			end
		ensure
			class_token_valid: Result /= 0
		end

	mapped_class_type_token (a_type_id: INTEGER): INTEGER is
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

	define_assembly_reference (a_name, a_version, a_culture, a_key: STRING): INTEGER is
			-- Define an assembly reference matching given parameters
		require
			a_name_not_void: a_name /= Void
		local
			l_ass_info: MD_ASSEMBLY_INFO
			l_version: VERSION
			l_major, l_minor, l_build, l_revision: INTEGER
			l_key_token: MD_PUBLIC_KEY_TOKEN
		do
			if defined_assemblies.has (a_name) then
				Result := defined_assemblies.found_item
			else
				if a_name.is_equal ("mscorlib") then
					Result := mscorlib_token
				elseif a_name.is_equal (runtime_namespace) then
					Result := ise_runtime_token
				else
					create l_ass_info.make

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

					if a_key /= Void then
						create l_key_token.make_from_string (a_key)
					end

						-- NOTE: cannot use `uni_string' buffer as current feature can
						-- be used with other features that already uses it to define
						-- some metadata.
					Result := md_emit.define_assembly_ref (create {UNI_STRING}.make (a_name), l_ass_info, l_key_token)
				end
				defined_assemblies.put (Result, a_name)
			end
		ensure
			is_token_defined: Result /= 0
			is_token_assembly_ref: Result & {MD_TOKEN_TYPES}.md_mask =  {MD_TOKEN_TYPES}.md_assembly_ref
		end

	class_data_token (class_c: CLASS_C): INTEGER is
			-- Token for class data  of `class_c'
		require
			class_c_not_void: class_c /= Void
			class_c_not_external: not class_c.is_external
		local
			class_id: INTEGER
			class_data_name: UNI_STRING
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
							{MD_TYPE_ATTRIBUTES}.auto_class | {MD_TYPE_ATTRIBUTES}.auto_layout |
							{MD_TYPE_ATTRIBUTES}.is_class | {MD_TYPE_ATTRIBUTES}.public |
							{MD_TYPE_ATTRIBUTES}.sealed,
							object_type_token,
							Void)
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

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		do
			if internal_class_types = Void then
				internal_class_types := il_code_generator.class_types
			end
			Result := internal_class_types
		ensure
			class_types_not_void: Result /= Void
			class_types_not_empty: Result.count > 0
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

	property_setter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
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
			setter_token_valid: Result /= 0 implies Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def
		end

	property_getter_token (a_type_id, a_feature_id: INTEGER): INTEGER is
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
			getter_token_valid: Result /= 0 implies Result & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_method_def
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

	internal_property_setters: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of property setter indexed by their `type_id'.
			-- For each type, there is an HASH_TABLE where keys are `feature_id'
			-- and elements are `token'.

	internal_property_getters: ARRAY [HASH_TABLE [INTEGER, INTEGER]]
			-- Array of property getter indexed by their `type_id'.
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

	insert_property_setter (a_token, a_type_id, a_feature_id: INTEGER) is
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

	insert_property_getter (a_token, a_type_id, a_feature_id: INTEGER) is
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

			l_hash.force (a_token, a_feature_id)
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

	module_reference_token (a_module: IL_MODULE): INTEGER is
			-- Given `a_module' from current assembly find its associated module token.
		require
			is_generated: is_generated
			a_module_not_void: a_module /= Void
			a_module_not_current: a_module /= Current
		local
			l_uni_string: UNI_STRING
		do
			Result := internal_module_references.item (a_module)
			if Result = 0 then
					-- ModuleRef token has not yet computed.
				create l_uni_string.make (a_module.module_name)
				Result := md_emit.define_module_ref (l_uni_string)
				internal_module_references.put (Result, a_module)
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
			l_indexes: INDEXING_CLAUSE_AS
			l_info: ARRAY [STRING]
			l_name, l_key_string, l_culture, l_version_string: STRING
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
					-- module.
				internal_assemblies.put (
					module_reference_token (il_code_generator.il_module (a_class_type)), a_class_type.implementation_id)
			else
				if
					not a_class_type.is_external and then
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
				internal_assemblies.put (
					define_assembly_reference (l_name, l_version_string, l_culture, l_key_string),
					a_class_type.implementation_id)
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
			create class_data_mapping.make (0, system.class_counter.count)
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
			create internal_property_setters.make (0, a_type_count)
			create internal_property_getters.make (0, a_type_count)
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
			uni_string.set_string (".ctor")

			l_meth_token := md_emit.define_member_ref (uni_string, ise_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.runtime_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_class_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.class_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_basic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.basic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_generic_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.generic_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_tuple_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.tuple_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_formal_type_token, l_sig)
			internal_constructor_token.put (l_meth_token, l_gen.formal_type_id)

			l_meth_token := md_emit.define_member_ref (uni_string, ise_none_type_token, l_sig)
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

	initialize_tokens is
			-- Recompute all tokens in context of newly created module.
		require
			is_generated: is_generated
		do
			mscorlib_token := 0
			object_type_token := 0
			value_type_token := 0
			math_type_token := 0
			system_exception_token := 0
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
			l_ass_info.set_major_version (l_version.major.to_natural_16)
			l_ass_info.set_minor_version (l_version.minor.to_natural_16)
			l_ass_info.set_build_number (l_version.build.to_natural_16)
			l_ass_info.set_revision_number (l_version.revision.to_natural_16)

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
			value_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make ("System.ValueType"), mscorlib_token)
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

				-- Define `.ctor' from `System.CLSCompliantAttribute' and
				-- `System.Runtime.InteropServices.ComVisibleAttribute'.
			l_sig := method_sig
			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (1)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			cls_compliant_ctor_token := md_emit.define_member_ref (uni_string,
				l_cls_compliant_token, l_sig)

			com_visible_ctor_token := md_emit.define_member_ref (uni_string,
				l_com_visible_token, l_sig)

			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)

			debugger_hidden_ctor_token := md_emit.define_member_ref (uni_string,
				l_debugger_hidden_token, l_sig)

			debugger_step_through_ctor_token := md_emit.define_member_ref (uni_string,
				l_debugger_step_through_token, l_sig)
		ensure
			object_type_token_set: object_type_token /= 0
			value_type_token_set: value_type_token /= 0
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
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_sig.set_parameter_count (2)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_r8, 0)
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
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			to_string_method_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("ToString"), object_type_token, l_sig)

			l_sig.reset
			l_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_sig.set_parameter_count (0)
			l_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
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
			l_token: INTEGER
			l_sig: like field_sig
			l_meth_sig: like method_sig
			l_ise_eiffel_name_attr_token: INTEGER
			l_ise_type_feature_attr_token: INTEGER
			l_ise_assertion_level_attr_token: INTEGER
			l_ise_interface_type_attr_token: INTEGER
			l_system_type_token: INTEGER
		do
				-- Define `ise_runtime_token'.
			create l_ass_info.make
			l_ass_info.set_major_version (5)
			l_ass_info.set_minor_version (7)
			l_ass_info.set_build_number (414)

			create l_pub_key.make_from_array (
				<<0xDE, 0xF2, 0x6F, 0x29, 0x6E, 0xFE, 0xF4, 0x69>>)

			ise_runtime_token := md_emit.define_assembly_ref (
				create {UNI_STRING}.make (runtime_namespace), l_ass_info, l_pub_key)

			ise_runtime_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (runtime_class_name), ise_runtime_token)

				-- Define `ise_last_exception_token'.
			l_sig := field_sig
			l_sig.reset
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				system_exception_token)

			ise_last_exception_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("last_exception"), ise_runtime_type_token,
				l_sig)

				-- Define `ise_in_assertion_token'.
			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (0)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("in_assertion"), ise_runtime_type_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)

			ise_set_in_assertion_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("set_in_assertion"), ise_runtime_type_token, l_meth_sig)

				-- Define `.ctor' from `ISE.Runtime.EIFFEL_EXCEPTION'.
			l_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (eiffel_exception_class_name),
				ise_runtime_token)

			l_meth_sig := method_sig
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_i4, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			ise_eiffel_exception_ctor_token := md_emit.define_member_ref (
				create {UNI_STRING}.make (".ctor"), l_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (3)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_i4, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class, system_exception_token)
			ise_eiffel_exception_chained_ctor_token := md_emit.define_member_ref (
				create {UNI_STRING}.make (".ctor"), l_token, l_meth_sig)

				-- Define `ise_assertion_tag_token'
			l_sig.reset
			l_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

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
			ise_tuple_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (tuple_type_class_name), ise_runtime_token)
			ise_formal_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Formal_type_class_name), ise_runtime_token)
			ise_none_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (None_type_class_name), ise_runtime_token)
			ise_basic_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (basic_type_class_name), ise_runtime_token)
			l_ise_eiffel_name_attr_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (eiffel_name_attribute), ise_runtime_token)
			l_ise_type_feature_attr_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (type_feature_attribute), ise_runtime_token)
			l_ise_assertion_level_attr_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (assertion_level_class_name_attribute), ise_runtime_token)
			l_ise_interface_type_attr_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (interface_type_class_name_attribute), ise_runtime_token)
			ise_generic_conformance_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Generic_conformance_class_name), ise_runtime_token)

				-- Define `ise_set_type_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				ise_generic_type_token)

			ise_set_type_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("____set_type"),
				ise_eiffel_type_info_type_token, l_meth_sig)

				-- Define `ise_check_invariant_token'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_object, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			ise_check_invariant_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("check_invariant"), ise_runtime_type_token, l_meth_sig)

				-- Define `ise_is_invariant_checked_for'.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Default_sig)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_boolean, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				runtime_type_handle_token)
			ise_is_invariant_checked_for_token := md_emit.define_member_ref (
				create {UNI_STRING}.make ("is_invariant_checked_for"),
				ise_runtime_type_token, l_meth_sig)

				-- Get token for `System.Type'
			l_system_type_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (system_type_class_name), mscorlib_token)

				-- Define constructors of custom attribute class that keeps Eiffel
				-- name classes in their Eiffel formatting. The first one is for non-generic
				-- classes, the second one for generic classes.
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)

			uni_string.set_string (".ctor")
			ise_eiffel_name_attr_ctor_token := md_emit.define_member_ref (uni_string,
				l_ise_eiffel_name_attr_token, l_meth_sig)

			ise_type_feature_attr_ctor_token := md_emit.define_member_ref (uni_string,
				l_ise_type_feature_attr_token, l_meth_sig)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_string, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_szarray, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)

			uni_string.set_string (".ctor")
			ise_eiffel_name_attr_generic_ctor_token := md_emit.define_member_ref (uni_string,
				l_ise_eiffel_name_attr_token, l_meth_sig)


				-- Definition of `.ctor' for ASSERTION_LEVEL_ATTRIBUTE
			ise_assertion_level_enum_token := md_emit.define_type_ref (
				create {UNI_STRING}.make (Assertion_level_enum_class_name), ise_runtime_token)

			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (2)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_valuetype,
				ise_assertion_level_enum_token)

			uni_string.set_string (".ctor")
			ise_assertion_level_attr_ctor_token := md_emit.define_member_ref (uni_string,
				l_ise_assertion_level_attr_token, l_meth_sig)

				-- Definition of `.ctor' for CREATION_TYPE_ATTRIBUTE
			l_meth_sig.reset
			l_meth_sig.set_method_type ({MD_SIGNATURE_CONSTANTS}.Has_current)
			l_meth_sig.set_parameter_count (1)
			l_meth_sig.set_return_type ({MD_SIGNATURE_CONSTANTS}.Element_type_void, 0)
			l_meth_sig.set_type ({MD_SIGNATURE_CONSTANTS}.Element_type_class,
				l_system_type_token)

			uni_string.set_string (".ctor")
			ise_interface_type_attr_ctor_token := md_emit.define_member_ref (uni_string,
				l_ise_interface_type_attr_token, l_meth_sig)
		end

feature {NONE} -- Implementation

	generate_argument_array is
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
				il_code_generator.implemented_type (l_root.origin_class_id, l_arg_type.type),
				l_root.origin_feature_id, 0, True, True)
		end

feature {NONE} -- Convenience

	is_by_ref_type (a_type: TYPE_I): BOOLEAN is
			-- Is `a_type' an out parameter type?
		require
			a_type_not_void: a_type /= Void
		local
			l_ptr_type: TYPED_POINTER_I
		do
			l_ptr_type ?= a_type
			Result := l_ptr_type /= Void
		end

	by_ref_type (a_type: TYPE_I): TYPE_I is
			-- True type represented by `a_type'.
		require
			a_type_not_void: a_type /= Void
			is_by_ref_type: is_by_ref_type (a_type)
		local
			l_typed_pointer: TYPED_POINTER_I
		do
			l_typed_pointer ?= a_type
			Result := l_typed_pointer.true_generics.item (1)
		ensure
			by_ref_type_not_void: Result /= Void
		end

	typed_pointer_class_id: INTEGER is
			-- Class id of TYPED_POINTER class.
		once
			Result := System.typed_pointer_class.compiled_class.class_id
		ensure
			typed_pointer_class_id_positive: Result > 0
		end

feature {NONE} -- Cleaning

	wipe_out is
			-- Free all used memory.
		do
			assembly_info := Void
			class_data_mapping := Void
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
			uni_string := Void
		end

invariant
	md_emit_not_void: is_generated implies md_emit /= Void
	module_file_name_not_void: module_file_name /= Void
	module_file_name_not_empty: not module_file_name.is_empty
	il_code_generator_not_void: il_code_generator /= Void
	dll_or_console_valid: not is_assembly_module implies (is_dll and is_console_application)

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

end -- class IL_MODULE
