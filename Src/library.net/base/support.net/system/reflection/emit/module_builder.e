indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.ModuleBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MODULE_BUILDER

inherit
	MODULE
		redefine
			get_types,
			get_fully_qualified_name,
			get_type_string_boolean_boolean,
			get_type_string,
			get_type_string_boolean
		end
	ISERIALIZABLE
	ICUSTOM_ATTRIBUTE_PROVIDER

create {NONE}

feature -- Access

	get_fully_qualified_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.ModuleBuilder"
		alias
			"get_FullyQualifiedName"
		end

feature -- Basic Operations

	frozen get_type_token_type (type: TYPE): TYPE_TOKEN is
		external
			"IL signature (System.Type): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	frozen define_type_string_type_attributes_type_packing_size (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; packsize: PACKING_SIZE): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_document (url: SYSTEM_STRING; language: GUID; language_vendor: GUID; document_type: GUID): ISYMBOL_DOCUMENT_WRITER is
		external
			"IL signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocumentWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineDocument"
		end

	frozen get_string_constant (str: SYSTEM_STRING): STRING_TOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.StringToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetStringConstant"
		end

	frozen define_type_string_type_attributes_type (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_string_type_attributes_type_int32 (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; typesize: INTEGER): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_enum (name: SYSTEM_STRING; visibility: TYPE_ATTRIBUTES; underlying_type: TYPE): ENUM_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.EnumBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineEnum"
		end

	frozen set_user_entry_point (entry_point: METHOD_INFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetUserEntryPoint"
		end

	frozen define_global_method (name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_BUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	frozen get_signature_token (sig_helper: SIGNATURE_HELPER): SIGNATURE_TOKEN is
		external
			"IL signature (System.Reflection.Emit.SignatureHelper): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	frozen set_sym_custom_attribute (name: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetSymCustomAttribute"
		end

	frozen define_resource (name: SYSTEM_STRING; description: SYSTEM_STRING): IRESOURCE_WRITER is
		external
			"IL signature (System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_resource_string_string_resource_attributes (name: SYSTEM_STRING; description: SYSTEM_STRING; attribute: RESOURCE_ATTRIBUTES): IRESOURCE_WRITER is
		external
			"IL signature (System.String, System.String, System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	get_type_string (class_name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	get_type_string_boolean (class_name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
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

	frozen define_type (name: SYSTEM_STRING): TYPE_BUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen get_array_method (array_class: TYPE; method_name: SYSTEM_STRING; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_INFO is
		external
			"IL signature (System.Type, System.String, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethod"
		end

	frozen get_field_token (field: FIELD_INFO): FIELD_TOKEN is
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

	frozen get_type_token (name: SYSTEM_STRING): TYPE_TOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	frozen get_sym_writer: ISYMBOL_WRITER is
		external
			"IL signature (): System.Diagnostics.SymbolStore.ISymbolWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSymWriter"
		end

	frozen define_uninitialized_data (name: SYSTEM_STRING; size: INTEGER; attributes: FIELD_ATTRIBUTES): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Int32, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUninitializedData"
		end

	frozen define_type_string_type_attributes (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_initialized_data (name: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]; attributes: FIELD_ATTRIBUTES): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Byte[], System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineInitializedData"
		end

	frozen define_unmanaged_resource (resource_file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen get_method_token (method: METHOD_INFO): METHOD_TOKEN is
		external
			"IL signature (System.Reflection.MethodInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetMethodToken"
		end

	frozen define_type_string_type_attributes_type_array_type (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; interfaces: NATIVE_ARRAY [TYPE]): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen get_signature_token_array_byte (sig_bytes: NATIVE_ARRAY [INTEGER_8]; sig_length: INTEGER): SIGNATURE_TOKEN is
		external
			"IL signature (System.Byte[], System.Int32): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	get_type_string_boolean_boolean (class_name: SYSTEM_STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	frozen define_unmanaged_resource_array_byte (resource: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_type_string_type_attributes_type_packing_size_int32 (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; packing_size: PACKING_SIZE; typesize: INTEGER): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_global_method_string_method_attributes_calling_conventions (name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_BUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	frozen define_pinvoke_method_string_string_string (name: SYSTEM_STRING; dll_name: SYSTEM_STRING; entry_name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]; native_call_conv: CALLING_CONVENTION; native_char_set: CHAR_SET): METHOD_BUILDER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen get_constructor_token (con: CONSTRUCTOR_INFO): METHOD_TOKEN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetConstructorToken"
		end

	frozen get_array_method_token (array_class: TYPE; method_name: SYSTEM_STRING; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_TOKEN is
		external
			"IL signature (System.Type, System.String, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethodToken"
		end

	get_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypes"
		end

	frozen define_pinvoke_method (name: SYSTEM_STRING; dll_name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]; native_call_conv: CALLING_CONVENTION; native_char_set: CHAR_SET): METHOD_BUILDER is
		external
			"IL signature (System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

end -- class MODULE_BUILDER
