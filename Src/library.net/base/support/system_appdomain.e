indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.AppDomain"

frozen external class
	SYSTEM_APPDOMAIN

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			initialize_lifetime_service,
			to_string
		end
	SYSTEM_SECURITY_IEVIDENCEFACTORY

create {NONE}

feature -- Access

	frozen get_relative_search_path: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_RelativeSearchPath"
		end

	frozen get_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE is
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

	frozen get_dynamic_directory: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_DynamicDirectory"
		end

	frozen get_current_domain: SYSTEM_APPDOMAIN is
		external
			"IL static signature (): System.AppDomain use System.AppDomain"
		alias
			"get_CurrentDomain"
		end

	frozen get_setup_information: SYSTEM_APPDOMAINSETUP is
		external
			"IL signature (): System.AppDomainSetup use System.AppDomain"
		alias
			"get_SetupInformation"
		end

	frozen get_friendly_name: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_FriendlyName"
		end

	frozen get_base_directory: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"get_BaseDirectory"
		end

feature -- Element Change

	frozen remove_process_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_ProcessExit"
		end

	frozen remove_unhandled_exception (value: SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"remove_UnhandledException"
		end

	frozen add_process_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_ProcessExit"
		end

	frozen add_domain_unload (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_DomainUnload"
		end

	frozen remove_assembly_load (value: SYSTEM_ASSEMBLYLOADEVENTHANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyLoad"
		end

	frozen remove_assembly_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyResolve"
		end

	frozen remove_type_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_TypeResolve"
		end

	frozen add_assembly_load (value: SYSTEM_ASSEMBLYLOADEVENTHANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyLoad"
		end

	frozen remove_domain_unload (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_DomainUnload"
		end

	frozen add_type_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_TypeResolve"
		end

	frozen add_unhandled_exception (value: SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"add_UnhandledException"
		end

	frozen add_resource_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_ResourceResolve"
		end

	frozen remove_resource_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_ResourceResolve"
		end

	frozen add_assembly_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyResolve"
		end

feature -- Basic Operations

	frozen set_app_domain_policy (domain_policy: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Void use System.AppDomain"
		alias
			"SetAppDomainPolicy"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"ToString"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence_permission_set_permission_set_permission_set (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; dir: STRING; evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refused_permissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_domain_string_evidence_string (friendly_name: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE; app_base_path: STRING; app_relative_search_path: STRING; shadow_copy_files: BOOLEAN): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.String, System.String, System.Boolean): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen set_data (name: STRING; data: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.AppDomain"
		alias
			"SetData"
		end

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.AppDomain"
		alias
			"GetType"
		end

	frozen unload (domain: SYSTEM_APPDOMAIN) is
		external
			"IL static signature (System.AppDomain): System.Void use System.AppDomain"
		alias
			"Unload"
		end

	frozen get_assemblies: ARRAY [SYSTEM_REFLECTION_ASSEMBLY] is
		external
			"IL signature (): System.Reflection.Assembly[] use System.AppDomain"
		alias
			"GetAssemblies"
		end

	frozen create_instance_string_string_boolean (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen load_array_byte_array_byte (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_domain_string_evidence (friendly_name: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen load_array_byte_array_byte_evidence (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]; security_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
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

	frozen set_thread_principal (principal: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.AppDomain"
		alias
			"SetThreadPrincipal"
		end

	frozen create_instance_from_and_unwrap_string_string_array_object (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen create_instance_from (assembly_file: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen define_dynamic_assembly (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_permission_set (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refused_permissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_com_instance_from (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateComInstanceFrom"
		end

	frozen create_instance_and_unwrap_string_string_boolean (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): ANY is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen create_domain (friendly_name: STRING): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen set_cache_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetCachePath"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_evidence (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen create_instance (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; dir: STRING): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
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

	frozen load_assembly_name (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; dir: STRING; evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen get_data (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.AppDomain"
		alias
			"GetData"
		end

	frozen create_instance_from_and_unwrap (assembly_name: STRING; type_name: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	initialize_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.AppDomain"
		alias
			"InitializeLifetimeService"
		end

	frozen do_call_back (call_back_delegate: SYSTEM_CROSSAPPDOMAINDELEGATE) is
		external
			"IL signature (System.CrossAppDomainDelegate): System.Void use System.AppDomain"
		alias
			"DoCallBack"
		end

	frozen append_private_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"AppendPrivatePath"
		end

	frozen load_assembly_name_evidence (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_assembly_name_evidence_string (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen get_current_thread_id: INTEGER is
		external
			"IL static signature (): System.Int32 use System.AppDomain"
		alias
			"GetCurrentThreadId"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_evidence_permission_set_permission_set_permission_set_boolean (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; dir: STRING; evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refused_permissions: SYSTEM_SECURITY_PERMISSIONSET; is_synchronized: BOOLEAN): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen load_array_byte (raw_assembly: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_string_string_array_object (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen load (assembly_string: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_and_unwrap_string_string_array_object (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen set_dynamic_base (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetDynamicBase"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_string_permission_set_permission_set_permission_set (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; dir: STRING; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refused_permissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
		external
			"IL signature (System.Reflection.AssemblyName, System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen set_principal_policy (policy: SYSTEM_SECURITY_PRINCIPAL_PRINCIPALPOLICY) is
		external
			"IL signature (System.Security.Principal.PrincipalPolicy): System.Void use System.AppDomain"
		alias
			"SetPrincipalPolicy"
		end

	frozen execute_assembly_string_evidence (assembly_file: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen set_shadow_copy_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetShadowCopyPath"
		end

	frozen load_string_evidence (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen create_instance_from_string_string_boolean (assembly_file: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen is_finalizing_for_unload: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AppDomain"
		alias
			"IsFinalizingForUnload"
		end

	frozen create_instance_from_and_unwrap_string_string_boolean (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): ANY is
		external
			"IL signature (System.String, System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen create_instance_and_unwrap (assembly_name: STRING; type_name: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen define_dynamic_assembly_assembly_name_assembly_builder_access_evidence_permission_set_permission_set_permission_set (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDERACCESS; evidence: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refused_permissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
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

	frozen load_string_evidence_string (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen execute_assembly_string_evidence_array_string (assembly_file: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; args: ARRAY [STRING]): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence, System.String[]): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen create_domain_string_evidence_app_domain_setup (friendly_name: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE; info: SYSTEM_APPDOMAINSETUP): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.AppDomainSetup): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_instance_from_string_string_array_object (assembly_file: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen execute_assembly (assembly_file: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

end -- class SYSTEM_APPDOMAIN
