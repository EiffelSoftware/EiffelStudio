indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ICustomTypeDescriptor"

deferred external class
	SYSTEM_COMPONENTMODEL_ICUSTOMTYPEDESCRIPTOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_events: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEvents"
		end

	get_component_name: STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetComponentName"
		end

	get_default_event: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.EventDescriptor use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetDefaultEvent"
		end

	get_default_property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetDefaultProperty"
		end

	get_events_array_attribute (attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEvents"
		end

	get_editor (editor_base_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Type): System.Object use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetEditor"
		end

	get_properties_array_attribute (attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetProperties"
		end

	get_converter: SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL deferred signature (): System.ComponentModel.TypeConverter use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetConverter"
		end

	get_attributes: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.AttributeCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetAttributes"
		end

	get_class_name: STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetClassName"
		end

	get_properties: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetProperties"
		end

	get_property_owner (pd: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): ANY is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.Object use System.ComponentModel.ICustomTypeDescriptor"
		alias
			"GetPropertyOwner"
		end

end -- class SYSTEM_COMPONENTMODEL_ICUSTOMTYPEDESCRIPTOR
