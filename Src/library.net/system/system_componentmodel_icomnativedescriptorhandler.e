indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IComNativeDescriptorHandler"

deferred external class
	SYSTEM_COMPONENTMODEL_ICOMNATIVEDESCRIPTORHANDLER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_events (component: ANY): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Object): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEvents"
		end

	get_property_value (component: ANY; property_name: STRING; success: BOOLEAN): ANY is
		external
			"IL deferred signature (System.Object, System.String, System.Boolean&): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetPropertyValue"
		end

	get_default_event (component: ANY): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL deferred signature (System.Object): System.ComponentModel.EventDescriptor use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetDefaultEvent"
		end

	get_default_property (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL deferred signature (System.Object): System.ComponentModel.PropertyDescriptor use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetDefaultProperty"
		end

	get_name (component: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetName"
		end

	get_editor (component: ANY; base_editor_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Object, System.Type): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEditor"
		end

	get_events_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetEvents"
		end

	get_converter (component: ANY): SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL deferred signature (System.Object): System.ComponentModel.TypeConverter use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetConverter"
		end

	get_attributes (component: ANY): SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL deferred signature (System.Object): System.ComponentModel.AttributeCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetAttributes"
		end

	get_property_value_object_int32 (component: ANY; dispid: INTEGER; success: BOOLEAN): ANY is
		external
			"IL deferred signature (System.Object, System.Int32, System.Boolean&): System.Object use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetPropertyValue"
		end

	get_class_name (component: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetClassName"
		end

	get_properties (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.IComNativeDescriptorHandler"
		alias
			"GetProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_ICOMNATIVEDESCRIPTORHANDLER
