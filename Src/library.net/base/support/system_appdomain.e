indexing
	Generator: "Eiffel Emitter 2.5b2"
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

feature -- Element Change

	frozen add_assembly_load (value: SYSTEM_ASSEMBLYLOADEVENTHANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyLoad"
		end

	frozen add_assembly_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_AssemblyResolve"
		end

	frozen remove_assembly_load (value: SYSTEM_ASSEMBLYLOADEVENTHANDLER) is
		external
			"IL signature (System.AssemblyLoadEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyLoad"
		end

	frozen remove_unhandled_exception (value: SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"remove_UnhandledException"
		end

	frozen add_type_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_TypeResolve"
		end

	frozen remove_type_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_TypeResolve"
		end

	frozen add_process_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_ProcessExit"
		end

	frozen add_unhandled_exception (value: SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER) is
		external
			"IL signature (System.UnhandledExceptionEventHandler): System.Void use System.AppDomain"
		alias
			"add_UnhandledException"
		end

	frozen remove_process_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_ProcessExit"
		end

	frozen remove_assembly_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_AssemblyResolve"
		end

	frozen add_resource_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"add_ResourceResolve"
		end

	frozen remove_domain_unload (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"remove_DomainUnload"
		end

	frozen remove_resource_resolve (value: SYSTEM_RESOLVEEVENTHANDLER) is
		external
			"IL signature (System.ResolveEventHandler): System.Void use System.AppDomain"
		alias
			"remove_ResourceResolve"
		end

	frozen add_domain_unload (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.AppDomain"
		alias
			"add_DomainUnload"
		end

feature -- Basic Operations

	frozen define_dynamic_assembly (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_evidence (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; evidence2: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_directory (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; dir: STRING): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.String): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_directory_and_evidence (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; dir: STRING; evidence2: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_permissions (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refusedPermissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_evidence_and_permissions (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; evidence2: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refusedPermissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_directory_and_permissions (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; dir: STRING; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refusedPermissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_with_directory_evidence_and_permissions (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; dir: STRING; evidence2: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refusedPermissions: SYSTEM_SECURITY_PERMISSIONSET): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen define_dynamic_assembly_synchronized_with_directory_evidence_and_permissions (name: SYSTEM_REFLECTION_ASSEMBLYNAME; access: INTEGER; dir: STRING; evidence2: SYSTEM_SECURITY_POLICY_EVIDENCE; required_permissions: SYSTEM_SECURITY_PERMISSIONSET; optional_permissions: SYSTEM_SECURITY_PERMISSIONSET; refusedPermissions: SYSTEM_SECURITY_PERMISSIONSET; isSynchronized: BOOLEAN): SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER is
			-- Valid values for `access' are:
			-- Run = 1
			-- Save = 2
			-- RunAndSave = 3
		require
			valid_assembly_builder_access: access = 1 or access = 2 or access = 3
		external
			"IL signature (System.Reflection.AssemblyName, enum System.Reflection.Emit.AssemblyBuilderAccess, System.String, System.Security.Policy.Evidence, System.Security.PermissionSet, System.Security.PermissionSet, System.Security.PermissionSet, System.Boolean): System.Reflection.Emit.AssemblyBuilder use System.AppDomain"
		alias
			"DefineDynamicAssembly"
		end

	frozen set_shadow_copy_files is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"SetShadowCopyFiles"
		end

	frozen get_assemblies: ARRAY [SYSTEM_REFLECTION_ASSEMBLY] is
		external
			"IL signature (): System.Reflection.Assembly[] use System.AppDomain"
		alias
			"GetAssemblies"
		end

	frozen do_call_back (call_back_delegate: SYSTEM_CROSSAPPDOMAINDELEGATE) is
		external
			"IL signature (System.CrossAppDomainDelegate): System.Void use System.AppDomain"
		alias
			"DoCallBack"
		end

	frozen load_with_name (assembly_string: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_with_evidence (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_emitted_assembly (raw_assembly: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_emitted_assembly_with_symbols (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_emitted_assembly_with_symbols_and_evidence (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]; security_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Byte[], System.Byte[], System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_with_name_evidence_and_caller (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_with_evidence_and_caller (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen load_with_name_andvidence (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.AppDomain"
		alias
			"Load"
		end

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.AppDomain"
		alias
			"GetType"
		end

	frozen get_data (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.AppDomain"
		alias
			"GetData"
		end

	frozen set_shadow_copy_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetShadowCopyPath"
		end

	frozen set_dynamic_base (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetDynamicBase"
		end

	frozen execute_assembly (assembly_file: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen execute_assembly_with_evidence (assembly_file: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen execute_assembly_with_evidence_and_entry_point (assembly_file: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; args: ARRAY [STRING]): INTEGER is
		external
			"IL signature (System.String, System.Security.Policy.Evidence, System.String[]): System.Int32 use System.AppDomain"
		alias
			"ExecuteAssembly"
		end

	frozen create_instance_and_unwrap (assembly_name: STRING; type_name: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen create_instance_and_unwrap_with_attributes (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen create_instance_and_unwrap_with_constraints (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): ANY is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceAndUnwrap"
		end

	frozen set_cache_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"SetCachePath"
		end

	frozen set_thread_principal (principal: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.AppDomain"
		alias
			"SetThreadPrincipal"
		end

	frozen create_domain (friendly_name2: STRING): SYSTEM_APPDOMAIN is
		external
			"IL signature (System.String): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_domain_with_name_and_evidence (friendly_name2: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_domain_with_name_evidence_directory_path_and_copy (friendly_name2: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE; appBasePath: STRING; appRelativeSearchPath: STRING; shadowCopyFiles2: BOOLEAN): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.String, System.String, System.Boolean): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_domain_with_evidence_and_setup (friendly_name2: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE; info: SYSTEM_APPDOMAINSETUP): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.AppDomainSetup): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_domain_with_evidence_and_properties (friendly_name2: STRING; security_info: SYSTEM_SECURITY_POLICY_EVIDENCE; properties: SYSTEM_COLLECTIONS_IDICTIONARY): SYSTEM_APPDOMAIN is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.Collections.IDictionary): System.AppDomain use System.AppDomain"
		alias
			"CreateDomain"
		end

	frozen create_instance_from_and_unwrap (assembly_name: STRING; type_name: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen create_instance_from_and_unwrap_with_attributes (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen create_instance_from_and_unwrap_with_constraints (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): ANY is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Object use System.AppDomain"
		alias
			"CreateInstanceFromAndUnwrap"
		end

	frozen unload (domain: SYSTEM_APPDOMAIN) is
		external
			"IL static signature (System.AppDomain): System.Void use System.AppDomain"
		alias
			"Unload"
		end

	frozen create_instance (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen create_instance_with_constraints (assembly_name: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	frozen create_instance_with_attributes (assembly_name: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstance"
		end

	initialize_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.AppDomain"
		alias
			"InitializeLifetimeService"
		end

	frozen set_principal_policy (policy: INTEGER) is
			-- Valid values for `policy' are:
			-- UnauthenticatedPrincipal = 0
			-- NoPrincipal = 1
			-- WindowsPrincipal = 2
		require
			valid_principal_policy: policy = 0 or policy = 1 or policy = 2
		external
			"IL signature (enum System.Security.Principal.PrincipalPolicy): System.Void use System.AppDomain"
		alias
			"SetPrincipalPolicy"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.AppDomain"
		alias
			"ToString"
		end

	frozen clear_private_path is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"ClearPrivatePath"
		end

	frozen set_app_domain_policy (domain_policy: SYSTEM_SECURITY_POLICY_POLICYLEVEL) is
		external
			"IL signature (System.Security.Policy.PolicyLevel): System.Void use System.AppDomain"
		alias
			"SetAppDomainPolicy"
		end

	frozen append_private_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"AppendPrivatePath"
		end

	frozen create_com_instance_from (assembly_name: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateComInstanceFrom"
		end

	frozen append_shadow_copy_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.AppDomain"
		alias
			"AppendShadowCopyPath"
		end

	frozen clear_shadow_copy_path is
		external
			"IL signature (): System.Void use System.AppDomain"
		alias
			"ClearShadowCopyPath"
		end

	frozen get_current_thread_id: INTEGER is
		external
			"IL static signature (): System.Int32 use System.AppDomain"
		alias
			"GetCurrentThreadId"
		end

	frozen create_instance_from_with_attributes (assembly_file: STRING; type_name: STRING; activation_attributes: ARRAY [ANY]): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String, System.Object[]): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_from_with_constraints (assembly_file: STRING; type_name: STRING; ignore_case: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]; security_attributes: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[], System.Security.Policy.Evidence): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen create_instance_from (assembly_file: STRING; type_name: STRING): SYSTEM_RUNTIME_REMOTING_OBJECTHANDLE is
		external
			"IL signature (System.String, System.String): System.Runtime.Remoting.ObjectHandle use System.AppDomain"
		alias
			"CreateInstanceFrom"
		end

	frozen is_finalizing_for_unload: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.AppDomain"
		alias
			"IsFinalizingForUnload"
		end

	frozen set_data (name: STRING; data: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.AppDomain"
		alias
			"SetData"
		end

end -- class SYSTEM_APPDOMAIN
