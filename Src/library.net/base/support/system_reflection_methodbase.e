indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.MethodBase"

deferred external class
	SYSTEM_REFLECTION_METHODBASE

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen get_is_virtual: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsVirtual"
		end

	frozen get_is_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsPrivate"
		end

	frozen get_is_family_and_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamilyAndAssembly"
		end

	get_method_handle: SYSTEM_RUNTIMEMETHODHANDLE is
		external
			"IL deferred signature (): System.RuntimeMethodHandle use System.Reflection.MethodBase"
		alias
			"get_MethodHandle"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsAbstract"
		end

	frozen get_is_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsAssembly"
		end

	frozen get_is_family_or_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamilyOrAssembly"
		end

	frozen get_is_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamily"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsSpecialName"
		end

	get_attributes: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.MethodAttributes use System.Reflection.MethodBase"
		alias
			"get_Attributes"
		ensure
			valid_method_attributes: Result = 7 or Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 0 or Result = 256 or Result = 1024 or Result = 2048 or Result = 8192 or Result = 8 or Result = 4096 or Result = 53248 or Result = 16384 or Result = 32768
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsPublic"
		end

	frozen get_is_constructor: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsConstructor"
		end

	get_calling_convention: INTEGER is
		external
			"IL signature (): enum System.Reflection.CallingConventions use System.Reflection.MethodBase"
		alias
			"get_CallingConvention"
		ensure
			valid_calling_conventions: Result = 1 or Result = 2 or Result = 3 or Result = 32 or Result = 64
		end

	frozen get_is_static: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsStatic"
		end

	frozen get_is_hide_by_sig: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsHideBySig"
		end

	frozen get_is_final: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFinal"
		end

feature -- Basic Operations

	get_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL deferred signature (): System.Reflection.ParameterInfo[] use System.Reflection.MethodBase"
		alias
			"GetParameters"
		end

	frozen get_method_from_handle (handle: SYSTEM_RUNTIMEMETHODHANDLE): SYSTEM_REFLECTION_METHODBASE is
		external
			"IL static signature (System.RuntimeMethodHandle): System.Reflection.MethodBase use System.Reflection.MethodBase"
		alias
			"GetMethodFromHandle"
		end

	get_method_implementation_flags: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.MethodImplAttributes use System.Reflection.MethodBase"
		alias
			"GetMethodImplementationFlags"
		ensure
			valid_method_impl_attributes: Result = 3 or Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 4 or Result = 0 or Result = 16 or Result = 128 or Result = 4096 or Result = 32 or Result = 8 or Result = 65535
		end

	frozen get_current_method: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL static signature (): System.Reflection.MethodBase use System.Reflection.MethodBase"
		alias
			"GetCurrentMethod"
		end

	frozen invoke (obj: ANY; parameters: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.MethodBase"
		alias
			"Invoke"
		end

	invoke_with_parameters (obj: ANY; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; parameters: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
			-- Valid values for `invoke_attr' are a combination of the following values:
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
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.MethodBase"
		alias
			"Invoke"
		end

end -- class SYSTEM_REFLECTION_METHODBASE
