indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Module"

external class
	SYSTEM_REFLECTION_MODULE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	frozen get_fully_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_FullyQualifiedName"
		end

	frozen filter_type_name_ignore_case: SYSTEM_REFLECTION_TYPEFILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeNameIgnoreCase"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_Name"
		end

	frozen get_scope_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_ScopeName"
		end

	frozen filter_type_name: SYSTEM_REFLECTION_TYPEFILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeName"
		end

	frozen get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Module"
		alias
			"get_Assembly"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Module"
		alias
			"Equals"
		end

	get_type_case_sensitive (className: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_option_on_case (className: STRING; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_option_on_case_and_exception (className: STRING; throwOnError: BOOLEAN; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	frozen get_field (name2: STRING): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	frozen get_field_with_attributes (name2: STRING; binding_attr: INTEGER): SYSTEM_REFLECTION_FIELDINFO is
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
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	frozen get_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Reflection.Module"
		alias
			"GetFields"
		end

	frozen get_method_with_types (name2: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen get_method (name2: STRING): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen get_method_with_binder_convention_types_and_modifiers (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen get_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.Module"
		alias
			"GetMethods"
		end

	frozen get_signer_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Reflection.Module"
		alias
			"GetSignerCertificate"
		end

	frozen is_resource: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Module"
		alias
			"IsResource"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Module"
		alias
			"IsDefined"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.Module"
		alias
			"GetObjectData"
		end

	find_types (filter: SYSTEM_REFLECTION_TYPEFILTER; filterCriteria: ANY): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Reflection.Module"
		alias
			"FindTypes"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Module"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"ToString"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Module"
		alias
			"GetTypes"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.Module"
		alias
			"Finalize"
		end

	get_method_impl (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethodImpl"
		end

end -- class SYSTEM_REFLECTION_MODULE
