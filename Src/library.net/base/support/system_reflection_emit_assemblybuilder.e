indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.AssemblyBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER

inherit
	SYSTEM_REFLECTION_ASSEMBLY
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
	SYSTEM_SECURITY_IEVIDENCEFACTORY
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create {NONE}

feature -- Access

	get_location: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_Location"
		end

	get_code_base: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_CodeBase"
		end

	get_entry_point: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_EntryPoint"
		end

feature -- Basic Operations

	frozen define_unmanaged_resource (resource_file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_version_info_resource_string (product: STRING; product_version: STRING; company: STRING; copyright: STRING; trademark: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineVersionInfoResource"
		end

	frozen define_dynamic_module_string_string_boolean (name: STRING; file_name: STRING; emit_symbol_info: BOOLEAN): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen save (assembly_file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"Save"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_resource (name: STRING; description: STRING; file_name: STRING): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	get_manifest_resource_info (resource_name: STRING): SYSTEM_REFLECTION_MANIFESTRESOURCEINFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceInfo"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen set_entry_point_method_info_pefile_kinds (entry_method: SYSTEM_REFLECTION_METHODINFO; file_kind: SYSTEM_REFLECTION_EMIT_PEFILEKINDS) is
		external
			"IL signature (System.Reflection.MethodInfo, System.Reflection.Emit.PEFileKinds): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	get_manifest_resource_stream (name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	get_exported_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetExportedTypes"
		end

	frozen define_unmanaged_resource_array_byte (resource: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	get_file (name: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFile"
		end

	frozen define_resource_string_string_string_resource_attributes (name: STRING; description: STRING; file_name: STRING; attribute: SYSTEM_REFLECTION_RESOURCEATTRIBUTES): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	get_manifest_resource_names: ARRAY [STRING] is
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

	frozen add_resource_file (name: STRING; file_name: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	frozen set_entry_point (entry_method: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	get_manifest_resource_stream_type (type: SYSTEM_TYPE; name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	frozen define_dynamic_module (name: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen define_dynamic_module_string_string (name: STRING; file_name: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen add_resource_file_string_string_resource_attributes (name: STRING; file_name: STRING; attribute: SYSTEM_REFLECTION_RESOURCEATTRIBUTES) is
		external
			"IL signature (System.String, System.String, System.Reflection.ResourceAttributes): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	get_files_boolean (get_resource_modules: BOOLEAN): ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFiles"
		end

	frozen define_dynamic_module_string_boolean (name: STRING; emit_symbol_info: BOOLEAN): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen get_dynamic_module (name: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetDynamicModule"
		end

end -- class SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER
