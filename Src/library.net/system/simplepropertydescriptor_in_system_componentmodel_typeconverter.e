indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.TypeConverter+SimplePropertyDescriptor"

deferred external class
	SIMPLEPROPERTYDESCRIPTOR_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER

inherit
	SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR

feature -- Access

	get_property_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"get_PropertyType"
		end

	get_component_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"get_ComponentType"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	reset_value (component: ANY) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"ResetValue"
		end

	can_reset_value (component: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"CanResetValue"
		end

	should_serialize_value (component: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"ShouldSerializeValue"
		end

end -- class SIMPLEPROPERTYDESCRIPTOR_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER
