indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.MethodBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	METHOD_BUILDER

inherit
	METHOD_INFO
		redefine
			get_calling_convention,
			get_hash_code,
			equals,
			to_string
		end
	ICUSTOM_ATTRIBUTE_PROVIDER

create {NONE}

feature -- Access

	frozen get_signature: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Signature"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Name"
		end

	frozen get_init_locals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"get_InitLocals"
		end

	get_reflected_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReflectedType"
		end

	get_return_type_custom_attributes: ICUSTOM_ATTRIBUTE_PROVIDER is
		external
			"IL signature (): System.Reflection.ICustomAttributeProvider use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReturnTypeCustomAttributes"
		end

	get_calling_convention: CALLING_CONVENTIONS is
		external
			"IL signature (): System.Reflection.CallingConventions use System.Reflection.Emit.MethodBuilder"
		alias
			"get_CallingConvention"
		end

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_DeclaringType"
		end

	get_return_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReturnType"
		end

	get_method_handle: RUNTIME_METHOD_HANDLE is
		external
			"IL signature (): System.RuntimeMethodHandle use System.Reflection.Emit.MethodBuilder"
		alias
			"get_MethodHandle"
		end

	get_attributes: METHOD_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.MethodAttributes use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_init_locals (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"set_InitLocals"
		end

feature -- Basic Operations

	frozen get_ilgenerator_int32 (size: INTEGER): ILGENERATOR is
		external
			"IL signature (System.Int32): System.Reflection.Emit.ILGenerator use System.Reflection.Emit.MethodBuilder"
		alias
			"GetILGenerator"
		end

	frozen set_marshal (unmanaged_marshal: UNMANAGED_MARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetMarshal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"Equals"
		end

	frozen add_declarative_security (action: SECURITY_ACTION; pset: PERMISSION_SET) is
		external
			"IL signature (System.Security.Permissions.SecurityAction, System.Security.PermissionSet): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"AddDeclarativeSecurity"
		end

	frozen set_sym_custom_attribute (name: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetSymCustomAttribute"
		end

	invoke_object_binding_flags (obj: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; parameters: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.Emit.MethodBuilder"
		alias
			"Invoke"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.MethodBuilder"
		alias
			"GetHashCode"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_parameter (position: INTEGER; attributes: PARAMETER_ATTRIBUTES; str_param_name: SYSTEM_STRING): PARAMETER_BUILDER is
		external
			"IL signature (System.Int32, System.Reflection.ParameterAttributes, System.String): System.Reflection.Emit.ParameterBuilder use System.Reflection.Emit.MethodBuilder"
		alias
			"DefineParameter"
		end

	get_method_implementation_flags: METHOD_IMPL_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.MethodImplAttributes use System.Reflection.Emit.MethodBuilder"
		alias
			"GetMethodImplementationFlags"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetCustomAttribute"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetCustomAttributes"
		end

	get_base_definition: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Emit.MethodBuilder"
		alias
			"GetBaseDefinition"
		end

	get_parameters: NATIVE_ARRAY [PARAMETER_INFO] is
		external
			"IL signature (): System.Reflection.ParameterInfo[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetParameters"
		end

	frozen get_module: MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.MethodBuilder"
		alias
			"GetModule"
		end

	frozen get_token: METHOD_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.MethodToken use System.Reflection.Emit.MethodBuilder"
		alias
			"GetToken"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"ToString"
		end

	frozen set_implementation_flags (attributes: METHOD_IMPL_ATTRIBUTES) is
		external
			"IL signature (System.Reflection.MethodImplAttributes): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetImplementationFlags"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"IsDefined"
		end

	frozen create_method_body (il: NATIVE_ARRAY [INTEGER_8]; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"CreateMethodBody"
		end

	frozen get_ilgenerator: ILGENERATOR is
		external
			"IL signature (): System.Reflection.Emit.ILGenerator use System.Reflection.Emit.MethodBuilder"
		alias
			"GetILGenerator"
		end

end -- class METHOD_BUILDER
