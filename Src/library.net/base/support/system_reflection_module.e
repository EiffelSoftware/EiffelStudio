indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	frozen get_scope_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_ScopeName"
		end

	frozen get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Module"
		alias
			"get_Assembly"
		end

	frozen filter_type_name_ignore_case: SYSTEM_REFLECTION_TYPEFILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeNameIgnoreCase"
		end

	get_fully_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_FullyQualifiedName"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_Name"
		end

	frozen filter_type_name: SYSTEM_REFLECTION_TYPEFILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeName"
		end

feature -- Basic Operations

	frozen get_field (name: STRING): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Module"
		alias
			"Equals"
		end

	frozen get_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.Module"
		alias
			"GetMethods"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Module"
		alias
			"GetHashCode"
		end

	get_type_string_boolean_boolean (class_name: STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_string_boolean (class_name: STRING; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_string (class_name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Module"
		alias
			"GetTypes"
		end

	frozen get_field_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	frozen get_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Reflection.Module"
		alias
			"GetFields"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	frozen get_method_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen get_method (name: STRING): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen is_resource: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Module"
		alias
			"IsResource"
		end

	find_types (filter: SYSTEM_REFLECTION_TYPEFILTER; filter_criteria: ANY): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Reflection.Module"
		alias
			"FindTypes"
		end

	frozen get_signer_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Reflection.Module"
		alias
			"GetSignerCertificate"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"ToString"
		end

	frozen get_method_string_array_type (name: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

feature {NONE} -- Implementation

	get_method_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethodImpl"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.Module"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_MODULE
