indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_SIMPLE_PROPERTY_DESCRIPTOR_IN_SYSTEM_DLL_TYPE_CONVERTER

inherit
	SYSTEM_DLL_PROPERTY_DESCRIPTOR

feature -- Access

	get_property_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"get_PropertyType"
		end

	get_component_type: TYPE is
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

	reset_value (component: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"ResetValue"
		end

	can_reset_value (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"CanResetValue"
		end

	should_serialize_value (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter+SimplePropertyDescriptor"
		alias
			"ShouldSerializeValue"
		end

end -- class SYSTEM_DLL_SIMPLE_PROPERTY_DESCRIPTOR_IN_SYSTEM_DLL_TYPE_CONVERTER
