indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.MethodBase"

deferred external class
	SYSTEM_REFLECTION_METHODBASE

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen get_is_family_and_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamilyAndAssembly"
		end

	frozen get_is_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsAssembly"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsAbstract"
		end

	frozen get_is_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsPrivate"
		end

	frozen get_is_final: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFinal"
		end

	get_method_handle: SYSTEM_RUNTIMEMETHODHANDLE is
		external
			"IL deferred signature (): System.RuntimeMethodHandle use System.Reflection.MethodBase"
		alias
			"get_MethodHandle"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsPublic"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsSpecialName"
		end

	frozen get_is_constructor: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsConstructor"
		end

	frozen get_is_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamily"
		end

	get_attributes: SYSTEM_REFLECTION_METHODATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.MethodAttributes use System.Reflection.MethodBase"
		alias
			"get_Attributes"
		end

	frozen get_is_static: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsStatic"
		end

	get_calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS is
		external
			"IL signature (): System.Reflection.CallingConventions use System.Reflection.MethodBase"
		alias
			"get_CallingConvention"
		end

	frozen get_is_virtual: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsVirtual"
		end

	frozen get_is_hide_by_sig: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsHideBySig"
		end

	frozen get_is_family_or_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.MethodBase"
		alias
			"get_IsFamilyOrAssembly"
		end

feature -- Basic Operations

	invoke_object_binding_flags (obj: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; parameters: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL deferred signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.MethodBase"
		alias
			"Invoke"
		end

	get_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL deferred signature (): System.Reflection.ParameterInfo[] use System.Reflection.MethodBase"
		alias
			"GetParameters"
		end

	get_method_implementation_flags: SYSTEM_REFLECTION_METHODIMPLATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.MethodImplAttributes use System.Reflection.MethodBase"
		alias
			"GetMethodImplementationFlags"
		end

	frozen get_method_from_handle (handle: SYSTEM_RUNTIMEMETHODHANDLE): SYSTEM_REFLECTION_METHODBASE is
		external
			"IL static signature (System.RuntimeMethodHandle): System.Reflection.MethodBase use System.Reflection.MethodBase"
		alias
			"GetMethodFromHandle"
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

end -- class SYSTEM_REFLECTION_METHODBASE
