indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.PropertyDescriptor"

deferred external class
	SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR

inherit
	SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR
		redefine
			get_hash_code,
			equals_object
		end

feature -- Access

	frozen get_serialization_visibility: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY is
		external
			"IL signature (): System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.PropertyDescriptor"
		alias
			"get_SerializationVisibility"
		end

	get_is_localizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"get_IsLocalizable"
		end

	get_property_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.PropertyDescriptor"
		alias
			"get_PropertyType"
		end

	get_component_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.PropertyDescriptor"
		alias
			"get_ComponentType"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"get_IsReadOnly"
		end

	get_converter: SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter use System.ComponentModel.PropertyDescriptor"
		alias
			"get_Converter"
		end

feature -- Basic Operations

	can_reset_value (component: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"CanResetValue"
		end

	add_value_changed (component: ANY; handler: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.Object, System.EventHandler): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"AddValueChanged"
		end

	get_value (component: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"GetValue"
		end

	frozen get_child_properties_object (instance: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	set_value (component: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"SetValue"
		end

	frozen get_child_properties_array_attribute (filter: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	get_child_properties_object_array_attribute (instance: ANY; filter: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	reset_value (component: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"ResetValue"
		end

	frozen get_child_properties: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"Equals"
		end

	get_editor (editor_base_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"GetEditor"
		end

	should_serialize_value (component: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"ShouldSerializeValue"
		end

	remove_value_changed (component: ANY; handler: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.Object, System.EventHandler): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"RemoveValueChanged"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyDescriptor"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen get_type_from_name (type_name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.ComponentModel.PropertyDescriptor"
		alias
			"GetTypeFromName"
		end

	on_value_changed (component: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"OnValueChanged"
		end

	frozen create_instance (type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"CreateInstance"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR
