indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Binder"

deferred external class
	SYSTEM_REFLECTION_BINDER

feature -- Basic Operations

	bind_to_field (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; match: ARRAY [SYSTEM_REFLECTION_FIELDINFO]; value: ANY; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.FieldInfo[], System.Object, System.Globalization.CultureInfo): System.Reflection.FieldInfo use System.Reflection.Binder"
		alias
			"BindToField"
		end

	select_property (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; match: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO]; return_type: SYSTEM_TYPE; indexes: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.PropertyInfo[], System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Binder"
		alias
			"SelectProperty"
		end

	reorder_argument_array (args: ARRAY [ANY]; state: ANY) is
		external
			"IL deferred signature (System.Object[]&, System.Object): System.Void use System.Reflection.Binder"
		alias
			"ReorderArgumentArray"
		end

	select_method (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; match: ARRAY [SYSTEM_REFLECTION_METHODBASE]; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODBASE is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"SelectMethod"
		end

	change_type (value: ANY; type: SYSTEM_TYPE; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL deferred signature (System.Object, System.Type, System.Globalization.CultureInfo): System.Object use System.Reflection.Binder"
		alias
			"ChangeType"
		end

	bind_to_method (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; match: ARRAY [SYSTEM_REFLECTION_METHODBASE]; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; names: ARRAY [STRING]; state: ANY): SYSTEM_REFLECTION_METHODBASE is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.MethodBase[], System.Object[]&, System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[], System.Object&): System.Reflection.MethodBase use System.Reflection.Binder"
		alias
			"BindToMethod"
		end

end -- class SYSTEM_REFLECTION_BINDER
