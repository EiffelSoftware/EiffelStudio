indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.PropertyDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_PROPERTY_DESCRIPTOR

inherit
	SYSTEM_DLL_MEMBER_DESCRIPTOR
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	frozen get_serialization_visibility: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY is
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

	get_property_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.PropertyDescriptor"
		alias
			"get_PropertyType"
		end

	get_component_type: TYPE is
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

	get_converter: SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter use System.ComponentModel.PropertyDescriptor"
		alias
			"get_Converter"
		end

feature -- Basic Operations

	can_reset_value (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"CanResetValue"
		end

	add_value_changed (component: SYSTEM_OBJECT; handler: EVENT_HANDLER) is
		external
			"IL signature (System.Object, System.EventHandler): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"AddValueChanged"
		end

	get_value (component: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"GetValue"
		end

	frozen get_child_properties_array_attribute (filter: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	set_value (component: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"SetValue"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"Equals"
		end

	get_child_properties_object_array_attribute (instance: SYSTEM_OBJECT; filter: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	reset_value (component: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"ResetValue"
		end

	frozen get_child_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	get_editor (editor_base_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"GetEditor"
		end

	frozen get_child_properties_object (instance: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.PropertyDescriptor"
		alias
			"GetChildProperties"
		end

	should_serialize_value (component: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.PropertyDescriptor"
		alias
			"ShouldSerializeValue"
		end

	remove_value_changed (component: SYSTEM_OBJECT; handler: EVENT_HANDLER) is
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

	frozen get_type_from_name (type_name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.ComponentModel.PropertyDescriptor"
		alias
			"GetTypeFromName"
		end

	on_value_changed (component: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.ComponentModel.PropertyDescriptor"
		alias
			"OnValueChanged"
		end

	frozen create_instance (type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.PropertyDescriptor"
		alias
			"CreateInstance"
		end

end -- class SYSTEM_DLL_PROPERTY_DESCRIPTOR
