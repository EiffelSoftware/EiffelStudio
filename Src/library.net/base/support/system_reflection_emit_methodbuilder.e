indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.MethodBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_METHODBUILDER

inherit
	SYSTEM_REFLECTION_METHODINFO
		redefine
			get_calling_convention,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReflectedType"
		end

	get_attributes: INTEGER is
		external
			"IL signature (): enum System.Reflection.MethodAttributes use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Attributes"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Name"
		end

	get_method_handle: SYSTEM_RUNTIMEMETHODHANDLE is
		external
			"IL signature (): System.RuntimeMethodHandle use System.Reflection.Emit.MethodBuilder"
		alias
			"get_MethodHandle"
		end

	frozen get_signature: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"get_Signature"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_DeclaringType"
		end

	get_return_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReturnType"
		end

	get_return_type_custom_attributes: SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER is
		external
			"IL signature (): System.Reflection.ICustomAttributeProvider use System.Reflection.Emit.MethodBuilder"
		alias
			"get_ReturnTypeCustomAttributes"
		end

	get_calling_convention: INTEGER is
		external
			"IL signature (): enum System.Reflection.CallingConventions use System.Reflection.Emit.MethodBuilder"
		alias
			"get_CallingConvention"
		end

	frozen get_init_locals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"get_InitLocals"
		end

feature -- Element Change

	frozen set_init_locals (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"set_InitLocals"
		end

feature -- Basic Operations

	get_Base_Definition: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.Emit.MethodBuilder"
		alias
			"GetBaseDefinition"
		end

	frozen create_method_body (il: ARRAY [INTEGER_8]; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"CreateMethodBody"
		end

	frozen set_custom_attribute_with_blob (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryAttribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetCustomAttribute"
		end

	get_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL signature (): System.Reflection.ParameterInfo[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetParameters"
		end

	get_method_implementation_Flags: INTEGER is
		external
			"IL signature (): enum System.Reflection.MethodImplAttributes use System.Reflection.Emit.MethodBuilder"
		alias
			"GetMethodImplementationFlags"
		end

	frozen add_declarative_security (action: INTEGER; pset: SYSTEM_SECURITY_PERMISSIONSET) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL signature (enum System.Security.Permissions.SecurityAction, System.Security.PermissionSet): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"AddDeclarativeSecurity"
		end

	frozen get_IL_generator_with_size (size: INTEGER): SYSTEM_REFLECTION_EMIT_ILGENERATOR is
		external
			"IL signature (System.Int32): System.Reflection.Emit.ILGenerator use System.Reflection.Emit.MethodBuilder"
		alias
			"GetILGenerator"
		end

	frozen get_token: SYSTEM_REFLECTION_EMIT_METHODTOKEN is
		external
			"IL signature (): System.Reflection.Emit.MethodToken use System.Reflection.Emit.MethodBuilder"
		alias
			"GetToken"
		end

	frozen set_marshal (unmanagedMarshal: SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetMarshal"
		end

	frozen get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.MethodBuilder"
		alias
			"GetModule"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"IsDefined"
		end

	frozen set_sym_custom_attribute (name2: STRING; data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetSymCustomAttribute"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetCustomAttributes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.MethodBuilder"
		alias
			"GetHashCode"
		end

	frozen set_custom_attribute (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen get_IL_generator: SYSTEM_REFLECTION_EMIT_ILGENERATOR is
		external
			"IL signature (): System.Reflection.Emit.ILGenerator use System.Reflection.Emit.MethodBuilder"
		alias
			"GetILGenerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.MethodBuilder"
		alias
			"ToString"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.MethodBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_implementation_flags (attributes2: INTEGER) is
			-- Valid values for `attributes2' are:
			-- CodeTypeMask = 3
			-- IL = 0
			-- Native = 1
			-- OPTIL = 2
			-- Runtime = 3
			-- ManagedMask = 4
			-- Unmanaged = 4
			-- Managed = 0
			-- ForwardRef = 16
			-- PreserveSig = 128
			-- InternalCall = 4096
			-- Synchronized = 32
			-- NoInlining = 8
			-- MaxMethodImplVal = 65535
		require
			valid_method_impl_attributes: attributes2 = 3 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 4 or attributes2 = 0 or attributes2 = 16 or attributes2 = 128 or attributes2 = 4096 or attributes2 = 32 or attributes2 = 8 or attributes2 = 65535
		external
			"IL signature (enum System.Reflection.MethodImplAttributes): System.Void use System.Reflection.Emit.MethodBuilder"
		alias
			"SetImplementationFlags"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.MethodBuilder"
		alias
			"Equals"
		end

	invoke_with_parameters (obj: ANY; invokeAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; parameters: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL signature (System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.Emit.MethodBuilder"
		alias
			"Invoke"
		end

	frozen define_parameter (position: INTEGER; attributes2: INTEGER; strParamName: STRING): SYSTEM_REFLECTION_EMIT_PARAMETERBUILDER is
			-- Valid values for `attributes2' are a combination of the following values:
			-- None = 0
			-- In = 1
			-- Out = 2
			-- Lcid = 4
			-- Retval = 8
			-- Optional = 16
			-- ReservedMask = 61440
			-- HasDefault = 4096
			-- HasFieldMarshal = 8192
			-- Reserved3 = 16384
			-- Reserved4 = 32768
		require
			valid_parameter_attributes: (0 + 1 + 2 + 4 + 8 + 16 + 61440 + 4096 + 8192 + 16384 + 32768) & attributes2 = 0 + 1 + 2 + 4 + 8 + 16 + 61440 + 4096 + 8192 + 16384 + 32768
		external
			"IL signature (System.Int32, enum System.Reflection.ParameterAttributes, System.String): System.Reflection.Emit.ParameterBuilder use System.Reflection.Emit.MethodBuilder"
		alias
			"DefineParameter"
		end

end -- class SYSTEM_REFLECTION_EMIT_METHODBUILDER
