indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	get_location: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_Location"
		end

	get_code_base: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_CodeBase"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_FullName"
		end

	get_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE is
		external
			"IL signature (): System.Security.Policy.Evidence use System.Reflection.Assembly"
		alias
			"get_Evidence"
		end

	get_entry_point: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Assembly"
		alias
			"get_EntryPoint"
		end

	frozen get_global_assembly_cache: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Assembly"
		alias
			"get_GlobalAssemblyCache"
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Assembly"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"ToString"
		end

	frozen load_from (assembly_file: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	frozen load_module_string_array_byte_array_byte (module_name: STRING; raw_module: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String, System.Byte[], System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	frozen get_referenced_assemblies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
		external
			"IL signature (): System.Reflection.AssemblyName[] use System.Reflection.Assembly"
		alias
			"GetReferencedAssemblies"
		end

	frozen load_module (module_name: STRING; raw_module: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String, System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	frozen load_array_byte_array_byte (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_modules: ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	frozen load_string (assembly_string: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_exported_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetExportedTypes"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.Assembly"
		alias
			"GetObjectData"
		end

	frozen get_loaded_modules_boolean (get_resource_modules: BOOLEAN): ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	get_manifest_resource_info (resource_name: STRING): SYSTEM_REFLECTION_MANIFESTRESOURCEINFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Assembly"
		alias
			"GetManifestResourceInfo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Assembly"
		alias
			"Equals"
		end

	get_type_string_boolean (name: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	frozen get_loaded_modules: ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	frozen create_instance (type_name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	get_files_boolean (get_resource_modules: BOOLEAN): ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	get_type_string (name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetTypes"
		end

	frozen get_module (name: STRING): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.String): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"GetModule"
		end

	get_manifest_resource_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Reflection.Assembly"
		alias
			"GetManifestResourceNames"
		end

	frozen load_assembly_name_evidence (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_name_boolean (copied_name: BOOLEAN): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (System.Boolean): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	get_file (name: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Assembly"
		alias
			"GetFile"
		end

	frozen get_calling_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetCallingAssembly"
		end

	frozen load_array_byte (raw_assembly: ARRAY [INTEGER_8]): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_entry_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetEntryAssembly"
		end

	frozen get_type_string_boolean_boolean (name: STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	frozen load_from_string_evidence (assembly_file: STRING; security_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	frozen get_modules_boolean (get_resource_modules: BOOLEAN): ARRAY [SYSTEM_REFLECTION_MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	get_name: SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	frozen get_executing_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetExecutingAssembly"
		end

	get_manifest_resource_stream (name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	frozen create_qualified_name (assembly_name: STRING; type_name: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Reflection.Assembly"
		alias
			"CreateQualifiedName"
		end

	frozen create_instance_string_boolean (type_name: STRING; ignore_case: BOOLEAN): ANY is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	get_files: ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	frozen load_string_evidence (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_satellite_assembly (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	frozen load_assembly_name_evidence_string (assembly_ref: SYSTEM_REFLECTION_ASSEMBLYNAME; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_manifest_resource_stream_type (type: SYSTEM_TYPE; name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	frozen get_assembly (type: SYSTEM_TYPE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Type): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetAssembly"
		end

	frozen get_satellite_assembly_culture_info_version (culture: SYSTEM_GLOBALIZATION_CULTUREINFO; version: SYSTEM_VERSION): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo, System.Version): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	frozen create_instance_string_boolean_binding_flags (type_name: STRING; ignore_case: BOOLEAN; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; activation_attributes: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Assembly"
		alias
			"IsDefined"
		end

	frozen load_array_byte_array_byte_evidence (raw_assembly: ARRAY [INTEGER_8]; raw_symbol_store: ARRAY [INTEGER_8]; security_evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[], System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load_string_evidence_string (assembly_string: STRING; assembly_security: SYSTEM_SECURITY_POLICY_EVIDENCE; caller_location: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence, System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.Assembly"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLY
