indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.TypeDescriptor"

frozen external class
	SYSTEM_COMPONENTMODEL_TYPEDESCRIPTOR

create {NONE}

feature -- Access

	frozen get_com_native_descriptor_handler: SYSTEM_COMPONENTMODEL_ICOMNATIVEDESCRIPTORHANDLER is
		external
			"IL static signature (): System.ComponentModel.IComNativeDescriptorHandler use System.ComponentModel.TypeDescriptor"
		alias
			"get_ComNativeDescriptorHandler"
		end

feature -- Element Change

	frozen remove_refreshed (value: SYSTEM_COMPONENTMODEL_REFRESHEVENTHANDLER) is
		external
			"IL static signature (System.ComponentModel.RefreshEventHandler): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"remove_Refreshed"
		end

	frozen add_refreshed (value: SYSTEM_COMPONENTMODEL_REFRESHEVENTHANDLER) is
		external
			"IL static signature (System.ComponentModel.RefreshEventHandler): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"add_Refreshed"
		end

	frozen set_com_native_descriptor_handler (value: SYSTEM_COMPONENTMODEL_ICOMNATIVEDESCRIPTORHANDLER) is
		external
			"IL static signature (System.ComponentModel.IComNativeDescriptorHandler): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"set_ComNativeDescriptorHandler"
		end

feature -- Basic Operations

	frozen get_default_event_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.EventDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultEvent"
		end

	frozen get_default_event (component: ANY): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL static signature (System.Object): System.ComponentModel.EventDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultEvent"
		end

	frozen get_properties_type_array_attribute (component_type: SYSTEM_TYPE; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Type, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen refresh_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL static signature (System.Reflection.Assembly): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"Refresh"
		end

	frozen sort_descriptor_array (infos: SYSTEM_COLLECTIONS_ILIST) is
		external
			"IL static signature (System.Collections.IList): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"SortDescriptorArray"
		end

	frozen get_class_name (component: ANY): STRING is
		external
			"IL static signature (System.Object): System.String use System.ComponentModel.TypeDescriptor"
		alias
			"GetClassName"
		end

	frozen get_events_object_array_attribute_boolean (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Attribute[], System.Boolean): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen get_events_type (component_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Type): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen get_events (component: ANY): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen get_properties_type (component_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Type): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen get_attributes (component: ANY): SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL static signature (System.Object): System.ComponentModel.AttributeCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetAttributes"
		end

	frozen get_events_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen add_editor_table (editor_base_type: SYSTEM_TYPE; table: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL static signature (System.Type, System.Collections.Hashtable): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"AddEditorTable"
		end

	frozen refresh_type (type: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"Refresh"
		end

	frozen get_component_name_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): STRING is
		external
			"IL static signature (System.Object, System.Boolean): System.String use System.ComponentModel.TypeDescriptor"
		alias
			"GetComponentName"
		end

	frozen create_event_type_string (component_type: SYSTEM_TYPE; name: STRING; type: SYSTEM_TYPE; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL static signature (System.Type, System.String, System.Type, System.Attribute[]): System.ComponentModel.EventDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"CreateEvent"
		end

	frozen create_designer (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; designer_base_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNER is
		external
			"IL static signature (System.ComponentModel.IComponent, System.Type): System.ComponentModel.Design.IDesigner use System.ComponentModel.TypeDescriptor"
		alias
			"CreateDesigner"
		end

	frozen create_event (component_type: SYSTEM_TYPE; old_event_descriptor: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL static signature (System.Type, System.ComponentModel.EventDescriptor, System.Attribute[]): System.ComponentModel.EventDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"CreateEvent"
		end

	frozen get_default_property_type (component_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Type): System.ComponentModel.PropertyDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultProperty"
		end

	frozen refresh_object (component: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"Refresh"
		end

	frozen get_events_type_array_attribute (component_type: SYSTEM_TYPE; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Type, System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen get_attributes_type (component_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL static signature (System.Type): System.ComponentModel.AttributeCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetAttributes"
		end

	frozen get_default_event_type (component_type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL static signature (System.Type): System.ComponentModel.EventDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultEvent"
		end

	frozen get_attributes_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.AttributeCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetAttributes"
		end

	frozen refresh (module: SYSTEM_REFLECTION_MODULE) is
		external
			"IL static signature (System.Reflection.Module): System.Void use System.ComponentModel.TypeDescriptor"
		alias
			"Refresh"
		end

	frozen get_editor_object_type (component: ANY; editor_base_type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.ComponentModel.TypeDescriptor"
		alias
			"GetEditor"
		end

	frozen get_converter_object (component: ANY): SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL static signature (System.Object): System.ComponentModel.TypeConverter use System.ComponentModel.TypeDescriptor"
		alias
			"GetConverter"
		end

	frozen get_properties_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen get_properties_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen get_converter_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.TypeConverter use System.ComponentModel.TypeDescriptor"
		alias
			"GetConverter"
		end

	frozen get_component_name (component: ANY): STRING is
		external
			"IL static signature (System.Object): System.String use System.ComponentModel.TypeDescriptor"
		alias
			"GetComponentName"
		end

	frozen get_class_name_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): STRING is
		external
			"IL static signature (System.Object, System.Boolean): System.String use System.ComponentModel.TypeDescriptor"
		alias
			"GetClassName"
		end

	frozen get_properties (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen get_events_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetEvents"
		end

	frozen get_default_property_object_boolean (component: ANY; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Object, System.Boolean): System.ComponentModel.PropertyDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultProperty"
		end

	frozen get_editor_object_type_boolean (component: ANY; editor_base_type: SYSTEM_TYPE; no_custom_type_desc: BOOLEAN): ANY is
		external
			"IL static signature (System.Object, System.Type, System.Boolean): System.Object use System.ComponentModel.TypeDescriptor"
		alias
			"GetEditor"
		end

	frozen get_editor (type: SYSTEM_TYPE; editor_base_type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Type, System.Type): System.Object use System.ComponentModel.TypeDescriptor"
		alias
			"GetEditor"
		end

	frozen get_default_property (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Object): System.ComponentModel.PropertyDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"GetDefaultProperty"
		end

	frozen get_properties_object_array_attribute_boolean (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]; no_custom_type_desc: BOOLEAN): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL static signature (System.Object, System.Attribute[], System.Boolean): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeDescriptor"
		alias
			"GetProperties"
		end

	frozen create_property_type_string (component_type: SYSTEM_TYPE; name: STRING; type: SYSTEM_TYPE; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Type, System.String, System.Type, System.Attribute[]): System.ComponentModel.PropertyDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"CreateProperty"
		end

	frozen create_property (component_type: SYSTEM_TYPE; old_property_descriptor: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL static signature (System.Type, System.ComponentModel.PropertyDescriptor, System.Attribute[]): System.ComponentModel.PropertyDescriptor use System.ComponentModel.TypeDescriptor"
		alias
			"CreateProperty"
		end

	frozen get_converter (type: SYSTEM_TYPE): SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL static signature (System.Type): System.ComponentModel.TypeConverter use System.ComponentModel.TypeDescriptor"
		alias
			"GetConverter"
		end

end -- class SYSTEM_COMPONENTMODEL_TYPEDESCRIPTOR
