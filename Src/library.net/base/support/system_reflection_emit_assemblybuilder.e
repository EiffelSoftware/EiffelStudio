indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.AssemblyBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER

inherit
	SYSTEM_REFLECTION_ASSEMBLY
		redefine
			get_location,
			get_manifest_resource_info,
			get_manifest_resource_names,
			get_files_with_resources,
			get_file,
			get_manifest_resource_stream,
			get_manifest_resource_stream_for_type,
			get_exported_types,
			get_entry_point,
			get_code_base
		end
	SYSTEM_SECURITY_IEVIDENCEFACTORY
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create {NONE}

feature -- Access

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

	get_location: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.AssemblyBuilder"
		alias
			"get_Location"
		end

feature -- Basic Operations

	frozen define_resource (name: STRING; description: STRING; fileName: STRING): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	frozen define_resource_with_attributes (name: STRING; description: STRING; fileName: STRING; attribute: INTEGER): SYSTEM_RESOURCES_IRESOURCEWRITER is
			-- Valid values for `attribute' are a combination of the following values:
			-- Public = 1
			-- Private = 2
		require
			valid_resource_attributes: (1 + 2) & attribute = 1 + 2
		external
			"IL signature (System.String, System.String, System.String, enum System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineResource"
		end

	frozen define_dynamic_module (name: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen define_dynamic_module_with_emit_symbol (name: STRING; emitSymbolInfo: BOOLEAN): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen define_dynamic_module_and_save_with_symbol (name: STRING; fileName: STRING; emitSymbolInfo: BOOLEAN): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	frozen define_dynamic_module_and_save (name: STRING; fileName: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String, System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineDynamicModule"
		end

	get_manifest_resource_stream_for_type (type: SYSTEM_TYPE; name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Type, System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	get_exported_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetExportedTypes"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryAttribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_version_info_resource is
		external
			"IL signature (): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineVersionInfoResource"
		end

	frozen define_version_info_resource_for (product: STRING; productVersion: STRING; company: STRING; copyright: STRING; trademark: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineVersionInfoResource"
		end

	get_file (name: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL signature (System.String): System.IO.FileStream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFile"
		end

	get_files_with_resources (getResourceModules: BOOLEAN): ARRAY [SYSTEM_IO_FILESTREAM] is
		external
			"IL signature (System.Boolean): System.IO.FileStream[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetFiles"
		end

	frozen set_entry_point_and_PE_type (entryMethod: SYSTEM_REFLECTION_METHODINFO; file_kind: INTEGER) is
			-- Valid values for `file_kind' are:
			-- Dll = 1
			-- ConsoleApplication = 2
			-- WindowApplication = 3
		require
			valid_pefile_kinds: file_kind = 1 or file_kind = 2 or file_kind = 3
		external
			"IL signature (System.Reflection.MethodInfo, enum System.Reflection.Emit.PEFileKinds): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	frozen set_entry_point (entryMethod: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetEntryPoint"
		end

	get_manifest_resource_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceNames"
		end

	frozen define_unmanaged_resource_for_file (resourceFileName: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_unmanaged_resource (resource: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen get_dynamic_module (name: STRING): SYSTEM_REFLECTION_EMIT_MODULEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.ModuleBuilder use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetDynamicModule"
		end

	get_manifest_resource_stream (name: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceStream"
		end

	frozen set_custom_attribute (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen add_resource_file (name: STRING; fileName: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	frozen add_resource_file_with_attributes (name: STRING; fileName: STRING; attribute: INTEGER) is
			-- Valid values for `attribute' are a combination of the following values:
			-- Public = 1
			-- Private = 2
		require
			valid_resource_attributes: (1 + 2) & attribute = 1 + 2
		external
			"IL signature (System.String, System.String, enum System.Reflection.ResourceAttributes): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"AddResourceFile"
		end

	get_manifest_resource_info (resourceName: STRING): SYSTEM_REFLECTION_MANIFESTRESOURCEINFO is
		external
			"IL signature (System.String): System.Reflection.ManifestResourceInfo use System.Reflection.Emit.AssemblyBuilder"
		alias
			"GetManifestResourceInfo"
		end

	frozen save (assemblyFileName: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.AssemblyBuilder"
		alias
			"Save"
		end

end -- class SYSTEM_REFLECTION_EMIT_ASSEMBLYBUILDER
