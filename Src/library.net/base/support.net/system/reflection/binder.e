indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Binder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	BINDER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	bind_to_field (binding_attr: BINDING_FLAGS; match: NATIVE_ARRAY [FIELD_INFO]; value: SYSTEM_OBJECT; culture: CULTURE_INFO): FIELD_INFO is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.FieldInfo[], System.Object, System.Globalization.CultureInfo): System.Reflection.FieldInfo use System.Reflection.Binder"
		alias
			"BindToField"
		end

	select_property (binding_attr: BINDING_FLAGS; match: NATIVE_ARRAY [PROPERTY_INFO]; return_type: TYPE; indexes: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.PropertyInfo[], System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Binder"
		alias
			"SelectProperty"
		end

	reorder_argument_array (args: NATIVE_ARRAY [SYSTEM_OBJECT]; state: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object[]&, System.Object): System.Void use System.Reflection.Binder"
		alias
			"ReorderArgumentArray"
		end

	select_method (binding_attr: BINDING_FLAGS; match: NATIVE_ARRAY [METHOD_BASE]; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_BASE is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"SelectMethod"
		end

	change_type (value: SYSTEM_OBJECT; type: TYPE; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Type, System.Globalization.CultureInfo): System.Object use System.Reflection.Binder"
		alias
			"ChangeType"
		end

	bind_to_method (binding_attr: BINDING_FLAGS; match: NATIVE_ARRAY [METHOD_BASE]; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; names: NATIVE_ARRAY [SYSTEM_STRING]; state: SYSTEM_OBJECT): METHOD_BASE is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Object[]&, System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[], System.Object&): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"BindToMethod"
		end

end -- class BINDER
