indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Assembly"

external class
	SYSTEM_REFLECTION_ASSEMBLY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_IEVIDENCEFACTORY
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_global_assembly_cache: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Assembly"
		alias
			"get_GlobalAssemblyCache"
		end

	get_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE is
		external
			"IL signature (): System.Security.Policy.Evidence use System.Reflection.Assembly"
		alias
			"get_Evidence"
		end

	get_code_base: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_CodeBase"
		end

	get_entry_point: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Assembly"
		alias
			"get_EntryPoint"
		end

	get_location: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_Location"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_FullName"
		end

feature -- Element Change

	frozen remove_module_resolve (value: SYSTEM_REFLECTION_MODULERESOLVEEVENTHANDLER) is
		external
			"IL signature (System.Reflection.ModuleResolveEventHandler): System.Void use System.Reflection.Assembly"
		alias
			"remove_ModuleResolve"
		end

	frozen add_module_resolve (value: SYSTEM_REFLECTION_MODULERESOLVEEVENTHANDLER) is
		external
			"IL signature (System.Reflection.ModuleResolveEventHandler): System.Void use System.Reflection.Assembly"
		alias
			"add_ModuleResolve"
		end

feature -- Basic Operations

	frozen get_referenced_assemblies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
		external
			"IL signature (): System.Reflection.AssemblyName[] use System.Reflection.Assembly"
		alias
			"GetReferencedAssemblies"
		end

	get_files_with_resources (getResourceModules: BOOLEAN): ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	get_files: ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	frozen get_executing_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetExecutingAssembly"
		end

	frozen load_from (assemblyFile: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	frozen load_from_with_security_evidence (assemblyFile: STRING; securityEvidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	get_manifest_resource_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Reflection.Assembly"
		alias
			"GetManifestResourceNames"
		end

	frozen load_from_caller_with_security_evidence (assemblyString: STRING; assemblySecurity: SYSTEM_SECURITY_POLICY_EVIDENCE; callerLocation: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_name_from_caller_with_security_evidence (assemblyRef: SYSTEM_REFLECTION_ASSEMBLYNAME; assemblySecurity: SYSTEM_SECURITY_POLICY_EVIDENCE; callerLocation: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_emitted_COFF_with_security_evidence (rawAssembly: ARRAY [INTEGER_8]; rawSymbolStore: ARRAY [INTEGER_8]; securityEvidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[], System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_name_with_security_evidence (assemblyString: STRING; assemblySecurity: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load (assemblyRef: SYSTEM_REFLECTION_ASSEMBLYNAME): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_name (assemblyString: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_COFF_with_security_evidence (assemblyRef: SYSTEM_REFLECTION_ASSEMBLYNAME; assemblySecurity: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_COFF (rawAssembly: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_emitted_COFF (rawAssembly: ARRAY [INTEGER_8]; rawSymbolStore: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_manifest_resource_stream (name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	get_manifest_resource_stream_for_type (type: SYSTEM_TYPE; name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	frozen load_module (moduleName: STRING; rawModule: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String, System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	frozen load_module_and_symbols (moduleName: STRING; rawModule: ARRAY [INTEGER_8]; rawSymbolStore: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String, System.Byte[], System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.Assembly"
		alias
			"GetObjectData"
		end

	frozen create_instance_with_options (typeName: STRING; ignoreCase: BOOLEAN; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activationAttributes: ARRAY [ANY]): ANY is
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
			"IL signature (System.String, System.Boolean, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	frozen create_instance (typeName: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	frozen create_instance_case_sensitive (typeName: STRING; ignoreCase: BOOLEAN): ANY is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	get_file (name: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Assembly"
		alias
			"GetFile"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Assembly"
		alias
			"GetHashCode"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Assembly"
		alias
			"IsDefined"
		end

	frozen create_qualified_name (assemblyName: STRING; typeName: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Reflection.Assembly"
		alias
			"CreateQualifiedName"
		end

	frozen get_calling_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetCallingAssembly"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Assembly"
		alias
			"Equals"
		end

	get_exported_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetExportedTypes"
		end

	frozen get_module (name: STRING): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"GetModule"
		end

	frozen get_loaded_modules: ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	frozen get_loaded_modules_with_resources (getResourceModules: BOOLEAN): ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	frozen get_modules: ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	frozen get_modules_with_resources (getResourceModules: BOOLEAN): ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	get_manifest_resource_info (resourceName: STRING): SYSTEM_REFLECTION_MANIFESTRESOURCEINFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Assembly"
		alias
			"GetManifestResourceInfo"
		end

	get_name_with_code_base (copiedName: BOOLEAN): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (System.Boolean): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	get_name: SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	frozen get_satellite_assembly (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	frozen get_satellite_assembly_for_culture (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; version: SYSTEM_VERSION): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo, System.Version): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	frozen get_assembly (type: SYSTEM_TYPE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Type): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetAssembly"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetTypes"
		end

	frozen get_type_case_and_exception_options (name: STRING; throwOnError: BOOLEAN; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	get_type_of (name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	get_type_excption_option (name: STRING; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	frozen get_entry_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetEntryAssembly"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.Assembly"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLY
