indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.ModuleBuilder"

external class
	SYSTEM_REFLECTION_EMIT_MODULEBUILDER

inherit
	SYSTEM_REFLECTION_MODULE
		redefine
			get_types,
			get_type_option_on_case_and_exception,
			get_type_case_sensitive,
			get_type_option_on_case
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Basic Operations

	frozen get_array_method_token (arrayClass: SYSTEM_TYPE; methodName: STRING; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.Type, System.String, enum System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethodToken"
		end

	frozen define_type (name2: STRING): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes (name2: STRING; attr: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes_and_parent (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes_parent_and_size (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; typesize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes_parent_and_packing_size (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; packsize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `packsize' are:
			-- Unspecified = 0
			-- Size1 = 1
			-- Size2 = 2
			-- Size4 = 4
			-- Size8 = 8
			-- Size16 = 16
		require
			valid_packing_size: packsize = 0 or packsize = 1 or packsize = 2 or packsize = 4 or packsize = 8 or packsize = 16
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, enum System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes_parent_size_and_packing_size (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; packing_size: INTEGER; typesize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `packing_size' are:
			-- Unspecified = 0
			-- Size1 = 1
			-- Size2 = 2
			-- Size4 = 4
			-- Size8 = 8
			-- Size16 = 16
		require
			valid_packing_size: packing_size = 0 or packing_size = 1 or packing_size = 2 or packing_size = 4 or packing_size = 8 or packing_size = 16
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, enum System.Reflection.Emit.PackingSize, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_type_with_attributes_parent_and_interfaces (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; interfaces: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineType"
		end

	frozen define_resource_with_attributes (name2: STRING; description: STRING; attribute: INTEGER): SYSTEM_RESOURCES_IRESOURCEWRITER is
			-- Valid values for `attribute' are a combination of the following values:
			-- Public = 1
			-- Private = 2
		require
			valid_resource_attributes: (1 + 2) & attribute = 1 + 2
		external
			"IL signature (System.String, System.String, enum System.Reflection.ResourceAttributes): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	frozen set_custom_attribute (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen is_transient: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.ModuleBuilder"
		alias
			"IsTransient"
		end

	frozen get_constructor_token (con: SYSTEM_REFLECTION_CONSTRUCTORINFO): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (System.Reflection.ConstructorInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetConstructorToken"
		end

	frozen set_sym_custom_attribute (name2: STRING; data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetSymCustomAttribute"
		end

	frozen get_array_method (arrayClass: SYSTEM_TYPE; methodName: STRING; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.Type, System.String, enum System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetArrayMethod"
		end

	frozen get_type_token (name2: STRING): SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	get_type_case_sensitive (className: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	frozen define_unmanaged_resource (resourceFileName: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen get_sym_writer: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLWRITER is
		external
			"IL signature (): System.Diagnostics.SymbolStore.ISymbolWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSymWriter"
		end

	frozen get_signature_token (sigHelper: SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER): SYSTEM_REFLECTION_EMIT_SIGNATURETOKEN is
		external
			"IL signature (System.Reflection.Emit.SignatureHelper): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	frozen define_uninitialized_data (name2: STRING; size: INTEGER; attributes: INTEGER): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
			-- Valid values for `attributes' are:
			-- FieldAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- InitOnly = 32
			-- Literal = 64
			-- NotSerialized = 128
			-- SpecialName = 512
			-- PinvokeImpl = 8192
			-- ReservedMask = 38144
			-- RTSpecialName = 1024
			-- HasFieldMarshal = 4096
			-- HasDefault = 32768
			-- HasFieldRVA = 256
		require
			valid_field_attributes: attributes = 7 or attributes = 0 or attributes = 1 or attributes = 2 or attributes = 3 or attributes = 4 or attributes = 5 or attributes = 6 or attributes = 16 or attributes = 32 or attributes = 64 or attributes = 128 or attributes = 512 or attributes = 8192 or attributes = 38144 or attributes = 1024 or attributes = 4096 or attributes = 32768 or attributes = 256
		external
			"IL signature (System.String, System.Int32, enum System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUninitializedData"
		end

	frozen get_method_token (method: SYSTEM_REFLECTION_METHODINFO): SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (System.Reflection.MethodInfo): System.Reflection.Emit.MethodToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetMethodToken"
		end

	frozen create_global_functions is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"CreateGlobalFunctions"
		end

	frozen define_document (url: STRING; language: SYSTEM_GUID; languageVendor: SYSTEM_GUID; documentType: SYSTEM_GUID): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER is
		external
			"IL signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocumentWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineDocument"
		end

	frozen get_type_token_for_type (type: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (System.Type): System.Reflection.Emit.TypeToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypeToken"
		end

	frozen get_field_token (field: SYSTEM_REFLECTION_FIELDINFO): SYSTEM_REFLECTION_EMIT_FIELDTOKEN is
		external
			"IL signature (System.Reflection.FieldInfo): System.Reflection.Emit.FieldToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetFieldToken"
		end

	frozen define_initialized_data (name2: STRING; data: ARRAY [INTEGER_8]; attributes: INTEGER): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
			-- Valid values for `attributes' are:
			-- FieldAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- InitOnly = 32
			-- Literal = 64
			-- NotSerialized = 128
			-- SpecialName = 512
			-- PinvokeImpl = 8192
			-- ReservedMask = 38144
			-- RTSpecialName = 1024
			-- HasFieldMarshal = 4096
			-- HasDefault = 32768
			-- HasFieldRVA = 256
		require
			valid_field_attributes: attributes = 7 or attributes = 0 or attributes = 1 or attributes = 2 or attributes = 3 or attributes = 4 or attributes = 5 or attributes = 6 or attributes = 16 or attributes = 32 or attributes = 64 or attributes = 128 or attributes = 512 or attributes = 8192 or attributes = 38144 or attributes = 1024 or attributes = 4096 or attributes = 32768 or attributes = 256
		external
			"IL signature (System.String, System.Byte[], enum System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineInitializedData"
		end

	frozen get_string_constant (str: STRING): SYSTEM_REFLECTION_EMIT_STRINGTOKEN is
		external
			"IL signature (System.String): System.Reflection.Emit.StringToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetStringConstant"
		end

	get_type_option_on_case_and_exception (className: STRING; throwOnError: BOOLEAN; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

	frozen get_signature_token_for_charachters (sigBytes: ARRAY [INTEGER_8]; sigLength: INTEGER): SYSTEM_REFLECTION_EMIT_SIGNATURETOKEN is
		external
			"IL signature (System.Byte[], System.Int32): System.Reflection.Emit.SignatureToken use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetSignatureToken"
		end

	frozen define_enum (name2: STRING; visibility: INTEGER; underlyingType: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_ENUMBUILDER is
			-- Valid values for `visibility' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & visibility = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.EnumBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineEnum"
		end

	frozen set_custom_attribute_with_blob (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryattribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_P_invoke_method (name2: STRING; dllName: STRING; attributes: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]; native_call_conv: INTEGER; native_char_set: INTEGER): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `native_char_set' are:
			-- None = 1
			-- Ansi = 2
			-- Unicode = 3
			-- Auto = 4
		require
			valid_char_set: native_char_set = 1 or native_char_set = 2 or native_char_set = 3 or native_char_set = 4
		external
			"IL signature (System.String, System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[], enum System.Runtime.InteropServices.CallingConvention, enum System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen define_p_invoke_with_entry_point (name2: STRING; dllName: STRING; entryName: STRING; attributes: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]; native_call_conv: INTEGER; native_char_set: INTEGER): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `native_char_set' are:
			-- None = 1
			-- Ansi = 2
			-- Unicode = 3
			-- Auto = 4
		require
			valid_char_set: native_char_set = 1 or native_char_set = 2 or native_char_set = 3 or native_char_set = 4
		external
			"IL signature (System.String, System.String, System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[], enum System.Runtime.InteropServices.CallingConvention, enum System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen define_unmanaged_resource_for_blob (resource: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineUnmanagedResource"
		end

	frozen define_resource (name2: STRING; description: STRING): SYSTEM_RESOURCES_IRESOURCEWRITER is
		external
			"IL signature (System.String, System.String): System.Resources.IResourceWriter use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineResource"
		end

	frozen set_user_entry_point (entryPoint: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ModuleBuilder"
		alias
			"SetUserEntryPoint"
		end

	frozen define_global_method_with_conventions (name2: STRING; attributes: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetTypes"
		end

	frozen define_global_method (name2: STRING; attributes: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `attributes' are:
			-- MemberAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- Final = 32
			-- Virtual = 64
			-- HideBySig = 128
			-- VtableLayoutMask = 256
			-- ReuseSlot = 0
			-- NewSlot = 256
			-- Abstract = 1024
			-- SpecialName = 2048
			-- PinvokeImpl = 8192
			-- UnmanagedExport = 8
			-- RTSpecialName = 4096
			-- ReservedMask = 53248
			-- HasSecurity = 16384
			-- RequireSecObject = 32768
		require
			valid_method_attributes: attributes = 7 or attributes = 0 or attributes = 1 or attributes = 2 or attributes = 3 or attributes = 4 or attributes = 5 or attributes = 6 or attributes = 16 or attributes = 32 or attributes = 64 or attributes = 128 or attributes = 256 or attributes = 0 or attributes = 256 or attributes = 1024 or attributes = 2048 or attributes = 8192 or attributes = 8 or attributes = 4096 or attributes = 53248 or attributes = 16384 or attributes = 32768
		external
			"IL signature (System.String, enum System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.ModuleBuilder"
		alias
			"DefineGlobalMethod"
		end

	get_type_option_on_case (className: STRING; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.ModuleBuilder"
		alias
			"GetType"
		end

end -- class SYSTEM_REFLECTION_EMIT_MODULEBUILDER
