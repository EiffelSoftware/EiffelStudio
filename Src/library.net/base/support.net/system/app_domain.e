indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AppDomain"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	APP_DOMAIN

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			initialize_lifetime_service,
			to_string
		end
	IEVIDENCE_FACTORY

create {NONE}

feature -- Access

	frozen get_relative_search_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_RelativeSearchPath"
		end

	frozen get_evidence: EVIDENCE is
		external
			"IL signature (): System.Security.Policy.Evidence use System.AppDomain"
		alias
			"get_Evidence"
		end

	frozen get_shadow_copy_files: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AppDomain"
		alias
			"get_ShadowCopyFiles"
		end

	frozen get_dynamic_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_DynamicDirectory"
		end

	frozen get_current_domain: APP_DOMAIN is
		external
			"IL static signature (): System.AppDomain use System.AppDomain"
		alias
			"get_CurrentDomain"
		end

	frozen get_setup_information: APP_DOMAIN_SETUP is
		external
			"IL signature (): System.AppDomainSetup use System.AppDomain"
		alias
			"get_SetupInformation"
		end

	frozen get_friendly_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_FriendlyName"
		end

	frozen get_base_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_BaseDirectory"
		end

feature -- Element Change

	frozen remove_process_exit (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_ProcessExit"
		end

	frozen remove_unhandled_exception (value: UNHANDLED_EXCEPTION_EVENT_HANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"remove_UnhandledException"
		end

	frozen add_process_exit (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_ProcessExit"
		end

	frozen add_domain_unload (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_DomainUnload"
		end

	frozen remove_assembly_load (value: ASSEMBLY_LOAD_EVENT_HANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyLoad"
		end

	frozen remove_assembly_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyResolve"
		end

	frozen remove_type_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_TypeResolve"
		end

	frozen add_assembly_load (value: ASSEMBLY_LOAD_EVENT_HANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyLoad"
		end

	frozen remove_domain_unload (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_DomainUnload"
		end

	frozen add_type_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_TypeResolve"
		end

	frozen add_unhandled_exception (value: UNHANDLED_EXCEPTION_EVENT_HANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"add_UnhandledException"
		end

	frozen add_resource_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_ResourceResolve"
		end

	frozen remove_resource_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_ResourceResolve"
		end

	frozen add_assembly_resolve (value: RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyResolve"
		end

feature -- Basic Operations

	frozen set_app_domain_policy (domain_policy: POLICY_LEVEL) is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Void use System.AppDomain"
		alias
			"SetAppDomainPolicy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"ToString"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence_permission_set_permission_set_permission_set (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; dir: SYSTEM_STRING; evidence: EVIDENCE; required_permissions: PERMISSION_SET; optional_permissions: PERMISSION_SET; refused_permissions: PERMISSION_SET): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_domain_string_evidence_string (friendly_name: SYSTEM_STRING; security_info: EVIDENCE; app_base_path: SYSTEM_STRING; app_relative_search_path: SYSTEM_STRING; shadow_copy_files: BOOLEAN): APP_DOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.String, System.String, System.Boolean): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen set_data (name: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.AppDomain"
		alias
			"SetData"
		end

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.AppDomain"
		alias
			"GetType"
		end

	frozen set_cache_path (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetCachePath"
		end

	frozen get_assemblies: NATIVE_ARRAY [ASSEMBLY] is
		external
			"IL signature (): System.Reflection.Assembly[] use System.AppDomain"
		alias
			"GetAssemblies"
		end

	frozen create_instance_string_string_boolean (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_attributes: EVIDENCE): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen load_array_byte_array_byte (raw_assembly: NATIVE_ARRAY [INTEGER_8]; raw_symbol_store: NATIVE_ARRAY [INTEGER_8]): ASSEMBLY is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_domain_string_evidence (friendly_name: SYSTEM_STRING; security_info: EVIDENCE): APP_DOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen load_array_byte_array_byte_evidence (raw_assembly: NATIVE_ARRAY [INTEGER_8]; raw_symbol_store: NATIVE_ARRAY [INTEGER_8]; security_evidence: EVIDENCE): ASSEMBLY is
		external
			"IL signature (System.Byte[], System.Byte[], System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen set_shadow_copy_files is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"SetShadowCopyFiles"
		end

	frozen set_thread_principal (principal: IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.AppDomain"
		alias
			"SetThreadPrincipal"
		end

	frozen create_instance_from_and_unwrap_string_string_array_object (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen create_instance_from (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen define_dynamic_assembly (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_permission_set (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; required_permissions: PERMISSION_SET; optional_permissions: PERMISSION_SET; refused_permissions: PERMISSION_SET): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_com_instance_from (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateComInstanceFrom"
		end

	frozen create_instance_and_unwrap_string_string_boolean (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_attributes: EVIDENCE): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen create_domain (friendly_name: SYSTEM_STRING): APP_DOMAIN is
		external
			"IL static signature (System.String): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_permission_set_permission_set_permission_set (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; dir: SYSTEM_STRING; required_permissions: PERMISSION_SET; optional_permissions: PERMISSION_SET; refused_permissions: PERMISSION_SET): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_evidence (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; evidence: EVIDENCE): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_instance (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; dir: SYSTEM_STRING): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen clear_shadow_copy_path is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"ClearShadowCopyPath"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; dir: SYSTEM_STRING; evidence: EVIDENCE): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen get_data (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.AppDomain"
		alias
			"GetData"
		end

	frozen create_instance_from_and_unwrap (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	initialize_lifetime_service: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.AppDomain"
		alias
			"InitializeLifetimeService"
		end

	frozen do_call_back (call_back_delegate: CROSS_APP_DOMAIN_DELEGATE) is
		external
			"IL signature (System.CrossAppDomainDelegate): System.Void use System.AppDomain"
		alias
			"DoCallBack"
		end

	frozen append_private_path (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"AppendPrivatePath"
		end

	frozen load_assembly_name_evidence (assembly_ref: ASSEMBLY_NAME; assembly_security: EVIDENCE): ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen is_finalizing_for_unload: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AppDomain"
		alias
			"IsFinalizingForUnload"
		end

	frozen get_current_thread_id: INTEGER is
		external
			"IL static signature (): System.Int32 use System.AppDomain"
		alias
			"GetCurrentThreadId"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence_permission_set_permission_set_permission_set_boolean (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; dir: SYSTEM_STRING; evidence: EVIDENCE; required_permissions: PERMISSION_SET; optional_permissions: PERMISSION_SET; refused_permissions: PERMISSION_SET; is_synchronized: BOOLEAN): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen load_array_byte (raw_assembly: NATIVE_ARRAY [INTEGER_8]): ASSEMBLY is
		external
			"IL signature (System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_string_string_array_object (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen load (assembly_ref: ASSEMBLY_NAME): ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen set_dynamic_base (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetDynamicBase"
		end

	frozen set_principal_policy (policy: PRINCIPAL_POLICY) is
		external
			"IL signature (System.Security.Principal.PrincipalPolicy): System.Void use System.AppDomain"
		alias
			"SetPrincipalPolicy"
		end

	frozen execute_assembly_string_evidence (assembly_file: SYSTEM_STRING; assembly_security: EVIDENCE): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen set_shadow_copy_path (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetShadowCopyPath"
		end

	frozen load_string_evidence (assembly_string: SYSTEM_STRING; assembly_security: EVIDENCE): ASSEMBLY is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_from_string_string_boolean (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_attributes: EVIDENCE): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_from_and_unwrap_string_string_boolean (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]; security_attributes: EVIDENCE): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen load_string (assembly_string: SYSTEM_STRING): ASSEMBLY is
		external
			"IL signature (System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_and_unwrap (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_evidence_permission_set_permission_set_permission_set (name: ASSEMBLY_NAME; access: ASSEMBLY_BUILDER_ACCESS; evidence: EVIDENCE; required_permissions: PERMISSION_SET; optional_permissions: PERMISSION_SET; refused_permissions: PERMISSION_SET): ASSEMBLY_BUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen clear_private_path is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"ClearPrivatePath"
		end

	frozen create_domain_string_evidence_app_domain_setup (friendly_name: SYSTEM_STRING; security_info: EVIDENCE; info: APP_DOMAIN_SETUP): APP_DOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.AppDomainSetup): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen execute_assembly_string_evidence_array_string (assembly_file: SYSTEM_STRING; assembly_security: EVIDENCE; args: NATIVE_ARRAY [SYSTEM_STRING]): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence, System.String[]): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen unload (domain: APP_DOMAIN) is
		external
			"IL static signature (System.AppDomain): System.Void use System.AppDomain"
		alias
			"Unload"
		end

	frozen create_instance_and_unwrap_string_string_array_object (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen create_instance_from_string_string_array_object (assembly_file: SYSTEM_STRING; type_name: SYSTEM_STRING; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): OBJECT_HANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen execute_assembly (assembly_file: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

end -- class APP_DOMAIN
