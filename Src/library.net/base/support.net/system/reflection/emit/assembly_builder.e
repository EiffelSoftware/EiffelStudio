indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.AssemblyBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_BUILDER

inherit
	ASSEMBLY
		redefine
			get_location,
			get_manifest_resource_info,
			get_manifest_resource_names,
			get_files_boolean,
			get_file,
			get_manifest_resource_stream,
			get_manifest_resource_stream_type,
			get_exported_types,
			get_entry_point,
			get_code_base
		end
	IEVIDENCE_FACTORY
	ICUSTOM_ATTRIBUTE_PROVIDER
	ISERIALIZABLE

create {NONE}

feature -- Access

	get_location: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_Location"
		end

	get_code_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_CodeBase"
		end

	get_entry_point: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_EntryPoint"
		end

feature -- Basic Operations

	frozen define_unmanaged_resource (resource_file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_version_info_resource_string (product: SYSTEM_STRING; product_version: SYSTEM_STRING; company: SYSTEM_STRING; copyright: SYSTEM_STRING; trademark: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineVersionInfoResource"
		end

	frozen define_dynamic_module_string_string_boolean (name: SYSTEM_STRING; file_name: SYSTEM_STRING; emit_symbol_info: BOOLEAN): MODULE_BUILDER is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen save (assembly_file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"Save"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_resource (name: SYSTEM_STRING; description: SYSTEM_STRING; file_name: SYSTEM_STRING): IRESOURCE_WRITER is
		external
			"IL signature (System.String, System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	get_manifest_resource_info (resource_name: SYSTEM_STRING): MANIFEST_RESOURCE_INFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceInfo"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen set_entry_point_method_info_pefile_kinds (entry_method: METHOD_INFO; file_kind: PEFILE_KINDS) is
		external
			"IL signature (System.Reflection.MethodInfo, System.Reflection.Emit.PEFileKinds): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	get_manifest_resource_stream (name: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	get_exported_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetExportedTypes"
		end

	frozen define_unmanaged_resource_array_byte (resource: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	get_file (name: SYSTEM_STRING): FILE_STREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFile"
		end

	frozen define_resource_string_string_string_resource_attributes (name: SYSTEM_STRING; description: SYSTEM_STRING; file_name: SYSTEM_STRING; attribute: RESOURCE_ATTRIBUTES): IRESOURCE_WRITER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	get_manifest_resource_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceNames"
		end

	frozen define_version_info_resource is
		external
			"IL signature (): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineVersionInfoResource"
		end

	frozen add_resource_file (name: SYSTEM_STRING; file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	frozen set_entry_point (entry_method: METHOD_INFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	get_manifest_resource_stream_type (type: TYPE; name: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	frozen define_dynamic_module (name: SYSTEM_STRING): MODULE_BUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen define_dynamic_module_string_string (name: SYSTEM_STRING; file_name: SYSTEM_STRING): MODULE_BUILDER is
		external
			"IL signature (System.String, System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen add_resource_file_string_string_resource_attributes (name: SYSTEM_STRING; file_name: SYSTEM_STRING; attribute: RESOURCE_ATTRIBUTES) is
		external
			"IL signature (System.String, System.String, System.Reflection.ResourceAttributes): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	get_files_boolean (get_resource_modules: BOOLEAN): NATIVE_ARRAY [FILE_STREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFiles"
		end

	frozen define_dynamic_module_string_boolean (name: SYSTEM_STRING; emit_symbol_info: BOOLEAN): MODULE_BUILDER is
		external
			"IL signature (System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen get_dynamic_module (name: SYSTEM_STRING): MODULE_BUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetDynamicModule"
		end

end -- class ASSEMBLY_BUILDER
