indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Assembly"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASSEMBLY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IEVIDENCE_FACTORY
	ICUSTOM_ATTRIBUTE_PROVIDER
	ISERIALIZABLE

create {NONE}

feature -- Access

	get_location: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_Location"
		end

	get_escaped_code_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_EscapedCodeBase"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_FullName"
		end

	get_evidence: EVIDENCE is
		external
			"IL signature (): System.Security.Policy.Evidence use System.Reflection.Assembly"
		alias
			"get_Evidence"
		end

	get_entry_point: METHOD_INFO is
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

	get_code_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"get_CodeBase"
		end

feature -- Element Change

	frozen remove_module_resolve (value: MODULE_RESOLVE_EVENT_HANDLER) is
		external
			"IL signature (System.Reflection.ModuleResolveEventHandler): System.Void use System.Reflection.Assembly"
		alias
			"remove_ModuleResolve"
		end

	frozen add_module_resolve (value: MODULE_RESOLVE_EVENT_HANDLER) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Assembly"
		alias
			"ToString"
		end

	frozen load_from (assembly_file: SYSTEM_STRING): ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	frozen load_module_string_array_byte_array_byte (module_name: SYSTEM_STRING; raw_module: NATIVE_ARRAY [INTEGER_8]; raw_symbol_store: NATIVE_ARRAY [INTEGER_8]): MODULE is
		external
			"IL signature (System.String, System.Byte[], System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	frozen get_referenced_assemblies: NATIVE_ARRAY [ASSEMBLY_NAME] is
		external
			"IL signature (): System.Reflection.AssemblyName[] use System.Reflection.Assembly"
		alias
			"GetReferencedAssemblies"
		end

	frozen load_module (module_name: SYSTEM_STRING; raw_module: NATIVE_ARRAY [INTEGER_8]): MODULE is
		external
			"IL signature (System.String, System.Byte[]): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"LoadModule"
		end

	frozen load_array_byte_array_byte (raw_assembly: NATIVE_ARRAY [INTEGER_8]; raw_symbol_store: NATIVE_ARRAY [INTEGER_8]): ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_modules: NATIVE_ARRAY [MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	frozen load_string (assembly_string: SYSTEM_STRING): ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_exported_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetExportedTypes"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.Assembly"
		alias
			"GetObjectData"
		end

	frozen get_loaded_modules_boolean (get_resource_modules: BOOLEAN): NATIVE_ARRAY [MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	get_manifest_resource_info (resource_name: SYSTEM_STRING): MANIFEST_RESOURCE_INFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Assembly"
		alias
			"GetManifestResourceInfo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Assembly"
		alias
			"Equals"
		end

	get_type_string_boolean (name: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	frozen get_loaded_modules: NATIVE_ARRAY [MODULE] is
		external
			"IL signature (): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetLoadedModules"
		end

	frozen create_instance (type_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	get_files_boolean (get_resource_modules: BOOLEAN): NATIVE_ARRAY [FILE_STREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	get_type_string (name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	get_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Assembly"
		alias
			"GetTypes"
		end

	frozen get_module (name: SYSTEM_STRING): MODULE is
		external
			"IL signature (System.String): System.Reflection.Module use System.Reflection.Assembly"
		alias
			"GetModule"
		end

	get_manifest_resource_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Reflection.Assembly"
		alias
			"GetManifestResourceNames"
		end

	frozen load_assembly_name_evidence (assembly_ref: ASSEMBLY_NAME; assembly_security: EVIDENCE): ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	get_name_boolean (copied_name: BOOLEAN): ASSEMBLY_NAME is
		external
			"IL signature (System.Boolean): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	get_file (name: SYSTEM_STRING): FILE_STREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Assembly"
		alias
			"GetFile"
		end

	frozen get_calling_assembly: ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetCallingAssembly"
		end

	frozen load_array_byte (raw_assembly: NATIVE_ARRAY [INTEGER_8]): ASSEMBLY is
		external
			"IL static signature (System.Byte[]): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen load (assembly_ref: ASSEMBLY_NAME): ASSEMBLY is
		external
			"IL static signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_entry_assembly: ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetEntryAssembly"
		end

	frozen load_with_partial_name (partial_name: SYSTEM_STRING): ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadWithPartialName"
		end

	frozen get_type_string_boolean_boolean (name: SYSTEM_STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Assembly"
		alias
			"GetType"
		end

	frozen load_from_string_evidence (assembly_file: SYSTEM_STRING; security_evidence: EVIDENCE): ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadFrom"
		end

	frozen get_modules_boolean (get_resource_modules: BOOLEAN): NATIVE_ARRAY [MODULE] is
		external
			"IL signature (System.Boolean): System.Reflection.Module[] use System.Reflection.Assembly"
		alias
			"GetModules"
		end

	get_name: ASSEMBLY_NAME is
		external
			"IL signature (): System.Reflection.AssemblyName use System.Reflection.Assembly"
		alias
			"GetName"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Assembly"
		alias
			"GetCustomAttributes"
		end

	frozen get_executing_assembly: ASSEMBLY is
		external
			"IL static signature (): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetExecutingAssembly"
		end

	get_manifest_resource_stream (name: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	frozen create_qualified_name (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Reflection.Assembly"
		alias
			"CreateQualifiedName"
		end

	frozen create_instance_string_boolean (type_name: SYSTEM_STRING; ignore_case: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	get_files: NATIVE_ARRAY [FILE_STREAM] is
		external
			"IL signature (): System.IO.FileStream[] use System.Reflection.Assembly"
		alias
			"GetFiles"
		end

	frozen load_string_evidence (assembly_string: SYSTEM_STRING; assembly_security: EVIDENCE): ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"Load"
		end

	frozen get_satellite_assembly (culture: CULTURE_INFO): ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	get_manifest_resource_stream_type (type: TYPE; name: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Assembly"
		alias
			"GetManifestResourceStream"
		end

	frozen get_assembly (type: TYPE): ASSEMBLY is
		external
			"IL static signature (System.Type): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetAssembly"
		end

	frozen get_satellite_assembly_culture_info_version (culture: CULTURE_INFO; version: VERSION): ASSEMBLY is
		external
			"IL signature (System.Globalization.CultureInfo, System.Version): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"GetSatelliteAssembly"
		end

	frozen create_instance_string_boolean_binding_flags (type_name: SYSTEM_STRING; ignore_case: BOOLEAN; binding_attr: BINDING_FLAGS; binder: BINDER; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO; activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Boolean, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo, System.Object[]): System.Object use System.Reflection.Assembly"
		alias
			"CreateInstance"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Assembly"
		alias
			"IsDefined"
		end

	frozen load_with_partial_name_string_evidence (partial_name: SYSTEM_STRING; security_evidence: EVIDENCE): ASSEMBLY is
		external
			"IL static signature (System.String, System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
		alias
			"LoadWithPartialName"
		end

	frozen load_array_byte_array_byte_evidence (raw_assembly: NATIVE_ARRAY [INTEGER_8]; raw_symbol_store: NATIVE_ARRAY [INTEGER_8]; security_evidence: EVIDENCE): ASSEMBLY is
		external
			"IL static signature (System.Byte[], System.Byte[], System.Security.Policy.Evidence): System.Reflection.Assembly use System.Reflection.Assembly"
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

end -- class ASSEMBLY
