indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IComNativeDescriptorHandler"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICOM_NATIVE_DESCRIPTOR_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_events (component: SYSTEM_OBJECT): SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Object): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEvents"
		end

	get_property_value (component: SYSTEM_OBJECT; property_name: SYSTEM_STRING; success: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.String, System.Boolean&): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetPropertyValue"
		end

	get_default_event (component: SYSTEM_OBJECT): SYSTEM_DLL_EVENT_DESCRIPTOR is
		external
			"IL deferred signature (System.Object): System.ComponentModel.EventDescriptor use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetDefaultEvent"
		end

	get_default_property (component: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL deferred signature (System.Object): System.ComponentModel.PropertyDescriptor use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetDefaultProperty"
		end

	get_name (component: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetName"
		end

	get_editor (component: SYSTEM_OBJECT; base_editor_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Type): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEditor"
		end

	get_events_object_array_attribute (component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEvents"
		end

	get_converter (component: SYSTEM_OBJECT): SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL deferred signature (System.Object): System.ComponentModel.TypeConverter use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetConverter"
		end

	get_attributes (component: SYSTEM_OBJECT): SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL deferred signature (System.Object): System.ComponentModel.AttributeCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetAttributes"
		end

	get_property_value_object_int32 (component: SYSTEM_OBJECT; dispid: INTEGER; success: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Int32, System.Boolean&): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetPropertyValue"
		end

	get_class_name (component: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetClassName"
		end

	get_properties (component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetProperties"
		end

end -- class SYSTEM_DLL_ICOM_NATIVE_DESCRIPTOR_HANDLER
