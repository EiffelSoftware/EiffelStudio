indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowView"

external class
	SYSTEM_DATA_DATAROWVIEW

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_COMPONENTMODEL_IDATAERRORINFO
		rename
			get_error as system_component_model_idata_error_info_get_error,
			get_item as system_component_model_idata_error_info_get_item,
			is_equal as equals_object
		end
	SYSTEM_COMPONENTMODEL_ICUSTOMTYPEDESCRIPTOR
		rename
			get_property_owner as system_component_model_icustom_type_descriptor_get_property_owner,
			get_properties as system_component_model_icustom_type_descriptor_get_properties,
			get_events as system_component_model_icustom_type_descriptor_get_events,
			get_editor as system_component_model_icustom_type_descriptor_get_editor,
			get_default_property as system_component_model_icustom_type_descriptor_get_default_property,
			get_default_event as system_component_model_icustom_type_descriptor_get_default_event,
			get_converter as system_component_model_icustom_type_descriptor_get_converter,
			get_component_name as system_component_model_icustom_type_descriptor_get_component_name,
			get_class_name as system_component_model_icustom_type_descriptor_get_class_name,
			get_attributes as system_component_model_icustom_type_descriptor_get_attributes,
			is_equal as equals_object
		end
	SYSTEM_COMPONENTMODEL_IEDITABLEOBJECT
		rename
			is_equal as equals_object
		end

create {NONE}

feature -- Access

	frozen get_is_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataRowView"
		alias
			"get_IsEdit"
		end

	frozen get_item (property: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.DataRowView"
		alias
			"get_Item"
		end

	frozen get_is_new: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataRowView"
		alias
			"get_IsNew"
		end

	frozen get_data_view: SYSTEM_DATA_DATAVIEW is
		external
			"IL signature (): System.Data.DataView use System.Data.DataRowView"
		alias
			"get_DataView"
		end

	frozen get_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataRowView"
		alias
			"get_Row"
		end

	frozen get_row_version: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL signature (): System.Data.DataRowVersion use System.Data.DataRowView"
		alias
			"get_RowVersion"
		end

	frozen get_item_int32 (ndx: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataRowView"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (ndx: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataRowView"
		alias
			"set_Item"
		end

	frozen set_item (property: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.DataRowView"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.DataRowView"
		alias
			"ToString"
		end

	frozen create_child_view (relation_name: STRING): SYSTEM_DATA_DATAVIEW is
		external
			"IL signature (System.String): System.Data.DataView use System.Data.DataRowView"
		alias
			"CreateChildView"
		end

	frozen create_child_view_data_relation (relation: SYSTEM_DATA_DATARELATION): SYSTEM_DATA_DATAVIEW is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataView use System.Data.DataRowView"
		alias
			"CreateChildView"
		end

	frozen cancel_edit is
		external
			"IL signature (): System.Void use System.Data.DataRowView"
		alias
			"CancelEdit"
		end

	equals_object (other: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataRowView"
		alias
			"Equals"
		end

	frozen begin_edit is
		external
			"IL signature (): System.Void use System.Data.DataRowView"
		alias
			"BeginEdit"
		end

	frozen end_edit is
		external
			"IL signature (): System.Void use System.Data.DataRowView"
		alias
			"EndEdit"
		end

	frozen delete is
		external
			"IL signature (): System.Void use System.Data.DataRowView"
		alias
			"Delete"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataRowView"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_component_model_icustom_type_descriptor_get_events: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL signature (): System.ComponentModel.EventDescriptorCollection use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultProperty"
		end

	frozen system_component_model_icustom_type_descriptor_get_component_name: STRING is
		external
			"IL signature (): System.String use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetComponentName"
		end

	frozen system_component_model_icustom_type_descriptor_get_properties: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen system_component_model_icustom_type_descriptor_get_class_name: STRING is
		external
			"IL signature (): System.String use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetClassName"
		end

	frozen system_component_model_idata_error_info_get_error: STRING is
		external
			"IL signature (): System.String use System.Data.DataRowView"
		alias
			"System.ComponentModel.IDataErrorInfo.get_Error"
		end

	frozen system_component_model_idata_error_info_get_item (col_name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Data.DataRowView"
		alias
			"System.ComponentModel.IDataErrorInfo.get_Item"
		end

	frozen system_component_model_icustom_type_descriptor_get_property_owner (pd: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): ANY is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Object use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetPropertyOwner"
		end

	frozen get_events_array_attribute (attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

	frozen system_component_model_icustom_type_descriptor_get_editor (editor_base_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEditor"
		end

	frozen system_component_model_icustom_type_descriptor_get_converter: SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetConverter"
		end

	frozen get_properties_array_attribute (attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_event: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.EventDescriptor use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultEvent"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Data.DataRowView"
		alias
			"Finalize"
		end

	frozen system_component_model_icustom_type_descriptor_get_attributes: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.Data.DataRowView"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetAttributes"
		end

end -- class SYSTEM_DATA_DATAROWVIEW
