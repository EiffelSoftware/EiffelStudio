indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ICustomTypeDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICUSTOM_TYPE_DESCRIPTOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_events: SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEvents"
		end

	get_component_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetComponentName"
		end

	get_default_event: SYSTEM_DLL_EVENT_DESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.EventDescriptor use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetDefaultEvent"
		end

	get_default_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetDefaultProperty"
		end

	get_events_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEvents"
		end

	get_editor (editor_base_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type): System.Object use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEditor"
		end

	get_properties_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetProperties"
		end

	get_converter: SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL deferred signature (): System.ComponentModel.TypeConverter use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetConverter"
		end

	get_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.AttributeCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetAttributes"
		end

	get_class_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetClassName"
		end

	get_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetProperties"
		end

	get_property_owner (pd: SYSTEM_DLL_PROPERTY_DESCRIPTOR): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.Object use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetPropertyOwner"
		end

end -- class SYSTEM_DLL_ICUSTOM_TYPE_DESCRIPTOR
