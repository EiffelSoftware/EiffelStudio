indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Module"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MODULE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE
	ICUSTOM_ATTRIBUTE_PROVIDER

create {NONE}

feature -- Access

	frozen get_scope_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_ScopeName"
		end

	frozen get_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Module"
		alias
			"get_Assembly"
		end

	frozen filter_type_name_ignore_case: TYPE_FILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeNameIgnoreCase"
		end

	get_fully_qualified_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_FullyQualifiedName"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"get_Name"
		end

	frozen filter_type_name: TYPE_FILTER is
		external
			"IL static_field signature :System.Reflection.TypeFilter use System.Reflection.Module"
		alias
			"FilterTypeName"
		end

feature -- Basic Operations

	frozen get_field (name: SYSTEM_STRING): FIELD_INFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Module"
		alias
			"Equals"
		end

	frozen get_methods: NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.Module"
		alias
			"GetMethods"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Module"
		alias
			"IsDefined"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
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

	get_type_string_boolean_boolean (class_name: SYSTEM_STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_string_boolean (class_name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_type_string (class_name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.Reflection.Module"
		alias
			"GetType"
		end

	get_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Module"
		alias
			"GetTypes"
		end

	frozen get_field_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Module"
		alias
			"GetField"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	frozen get_fields: NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Reflection.Module"
		alias
			"GetFields"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Module"
		alias
			"GetCustomAttributes"
		end

	frozen get_method_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

	frozen get_method (name: SYSTEM_STRING): METHOD_INFO is
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

	find_types (filter: TYPE_FILTER; filter_criteria: SYSTEM_OBJECT): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Reflection.Module"
		alias
			"FindTypes"
		end

	frozen get_signer_certificate: X509_CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Reflection.Module"
		alias
			"GetSignerCertificate"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Module"
		alias
			"ToString"
		end

	frozen get_method_string_array_type (name: SYSTEM_STRING; types: NATIVE_ARRAY [TYPE]): METHOD_INFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Reflection.Module"
		alias
			"GetMethod"
		end

feature {NONE} -- Implementation

	get_method_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
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

end -- class MODULE
