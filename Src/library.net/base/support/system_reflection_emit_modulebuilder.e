indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.ModuleBuilder"

external class
	SYSTEM_REFLECTION_EMIT_MODULEBUILDER

inherit
	SYSTEM_REFLECTION_MODULE
		redefine
			get_types,
			get_fully_qualified_name,
			get_type_string_boolean_boolean,
			get_type_string,
			get_type_string_boolean
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	get_fully_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.ModuleBuilder"
		alias
			"get_FullyQualifiedName"
		end

feature -- Basic Operations

	frozen get_type_token_type (type: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (System.Type): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	frozen define_type_string_type_attributes_type_packing_size (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; packsize: SYSTEM_REFLECTION_EMIT_PACKINGSIZE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_document (url: STRING; language: SYSTEM_GUID; language_vendor: SYSTEM_GUID; document_type: SYSTEM_GUID): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER is
		external
			"IL signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocumentWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineDocument"
		end

	frozen get_string_constant (str: STRING): SYSTEM_REFLECTION_EMIT_STRINGTOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.StringToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetStringConstant"
		end

	frozen define_type_string_type_attributes_type (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_string_type_attributes_type_int32 (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; typesize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_enum (name: STRING; visibility: SYSTEM_REFLECTION_TYPEATTRIBUTES; underlying_type: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_ENUMBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.EnumBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineEnum"
		end

	frozen set_user_entry_point (entry_point: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetUserEntryPoint"
		end

	frozen define_global_method (name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	frozen get_signature_token (sig_helper: SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER): SYSTEM_REFLECTION_EMIT_SIGNATURETOKEN is
		external
			"IL signature (System.Reflection.Emit.SignatureHelper): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	frozen set_sym_custom_attribute (name: STRING; data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetSymCustomAttribute"
		end

	frozen define_resource (name: STRING; description: STRING): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_resource_string_string_resource_attributes (name: STRING; description: STRING; attribute: SYSTEM_REFLECTION_RESOURCEATTRIBUTES): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String, System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	get_type_string (class_name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	get_type_string_boolean (class_name: STRING; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	frozen is_transient: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.ModuleBuilder"
		alias
			"IsTransient"
		end

	frozen define_type (name: STRING): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen get_array_method (array_class: SYSTEM_TYPE; method_name: STRING; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.Type, System.String, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethod"
		end

	frozen get_field_token (field: SYSTEM_REFLECTION_FIELDINFO): SYSTEM_REFLECTION_EMIT_FIELDTOKEN is
		external
			"IL signature (System.Reflection.FieldInfo): System.Reflection.Emit.FieldToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetFieldToken"
		end

	frozen create_global_functions is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"CreateGlobalFunctions"
		end

	frozen get_type_token (name: STRING): SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	frozen get_sym_writer: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLWRITER is
		external
			"IL signature (): System.Diagnostics.SymbolStore.ISymbolWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSymWriter"
		end

	frozen define_uninitialized_data (name: STRING; size: INTEGER; attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
		external
			"IL signature (System.String, System.Int32, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUninitializedData"
		end

	frozen define_type_string_type_attributes (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_initialized_data (name: STRING; data: ARRAY [INTEGER_8]; attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
		external
			"IL signature (System.String, System.Byte[], System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineInitializedData"
		end

	frozen define_unmanaged_resource (resource_file_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen get_method_token (method: SYSTEM_REFLECTION_METHODINFO): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (System.Reflection.MethodInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetMethodToken"
		end

	frozen define_type_string_type_attributes_type_array_type (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; interfaces: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen get_signature_token_array_byte (sig_bytes: ARRAY [INTEGER_8]; sig_length: INTEGER): SYSTEM_REFLECTION_EMIT_SIGNATURETOKEN is
		external
			"IL signature (System.Byte[], System.Int32): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	get_type_string_boolean_boolean (class_name: STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	frozen define_unmanaged_resource_array_byte (resource: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_type_string_type_attributes_type_packing_size_int32 (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; packing_size: SYSTEM_REFLECTION_EMIT_PACKINGSIZE; typesize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_global_method_string_method_attributes_calling_conventions (name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	frozen define_pinvoke_method_string_string_string (name: STRING; dll_name: STRING; entry_name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]; native_call_conv: SYSTEM_RUNTIME_INTEROPSERVICES_CALLINGCONVENTION; native_char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen get_constructor_token (con: SYSTEM_REFLECTION_CONSTRUCTORINFO): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetConstructorToken"
		end

	frozen get_array_method_token (array_class: SYSTEM_TYPE; method_name: STRING; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (System.Type, System.String, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethodToken"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypes"
		end

	frozen define_pinvoke_method (name: STRING; dll_name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]; native_call_conv: SYSTEM_RUNTIME_INTEROPSERVICES_CALLINGCONVENTION; native_char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

end -- class SYSTEM_REFLECTION_EMIT_MODULEBUILDER
