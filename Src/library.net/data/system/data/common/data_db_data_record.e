indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DbDataRecord"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DB_DATA_RECORD

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	DATA_IDATA_RECORD
	SYSTEM_DLL_ICUSTOM_TYPE_DESCRIPTOR
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
			get_attributes as system_component_model_icustom_type_descriptor_get_attributes
		end

create {NONE}

feature -- Access

	frozen get_item (i: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.Common.DbDataRecord"
		alias
			"get_Item"
		end

	frozen get_item_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.Common.DbDataRecord"
		alias
			"get_Item"
		end

	frozen get_field_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.DbDataRecord"
		alias
			"get_FieldCount"
		end

feature -- Basic Operations

	frozen get_int64 (i: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32): System.Int64 use System.Data.Common.DbDataRecord"
		alias
			"GetInt64"
		end

	frozen get_int16 (i: INTEGER): INTEGER_16 is
		external
			"IL signature (System.Int32): System.Int16 use System.Data.Common.DbDataRecord"
		alias
			"GetInt16"
		end

	frozen get_data (i: INTEGER): DATA_IDATA_READER is
		external
			"IL signature (System.Int32): System.Data.IDataReader use System.Data.Common.DbDataRecord"
		alias
			"GetData"
		end

	frozen get_ordinal (name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DbDataRecord"
		alias
			"GetOrdinal"
		end

	frozen get_name (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.Common.DbDataRecord"
		alias
			"GetName"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.DbDataRecord"
		alias
			"GetHashCode"
		end

	frozen get_int32 (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Data.Common.DbDataRecord"
		alias
			"GetInt32"
		end

	frozen get_chars (i: INTEGER; data_index: INTEGER_64; buffer: NATIVE_ARRAY [CHARACTER]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.Common.DbDataRecord"
		alias
			"GetChars"
		end

	frozen get_string (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.Common.DbDataRecord"
		alias
			"GetString"
		end

	frozen get_byte (i: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Data.Common.DbDataRecord"
		alias
			"GetByte"
		end

	frozen get_boolean (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.Common.DbDataRecord"
		alias
			"GetBoolean"
		end

	frozen get_values (values: NATIVE_ARRAY [SYSTEM_OBJECT]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.Common.DbDataRecord"
		alias
			"GetValues"
		end

	frozen get_field_type (i: INTEGER): TYPE is
		external
			"IL signature (System.Int32): System.Type use System.Data.Common.DbDataRecord"
		alias
			"GetFieldType"
		end

	frozen get_guid (i: INTEGER): GUID is
		external
			"IL signature (System.Int32): System.Guid use System.Data.Common.DbDataRecord"
		alias
			"GetGuid"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DbDataRecord"
		alias
			"Equals"
		end

	frozen get_date_time (i: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Data.Common.DbDataRecord"
		alias
			"GetDateTime"
		end

	frozen get_bytes (i: INTEGER; data_index: INTEGER_64; buffer: NATIVE_ARRAY [INTEGER_8]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Byte[], System.Int32, System.Int32): System.Int64 use System.Data.Common.DbDataRecord"
		alias
			"GetBytes"
		end

	frozen get_char (i: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use System.Data.Common.DbDataRecord"
		alias
			"GetChar"
		end

	frozen get_data_type_name (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.Common.DbDataRecord"
		alias
			"GetDataTypeName"
		end

	frozen get_float (i: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use System.Data.Common.DbDataRecord"
		alias
			"GetFloat"
		end

	frozen is_dbnull (i: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.Common.DbDataRecord"
		alias
			"IsDBNull"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DbDataRecord"
		alias
			"ToString"
		end

	frozen get_double (i: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use System.Data.Common.DbDataRecord"
		alias
			"GetDouble"
		end

	frozen get_decimal (i: INTEGER): DECIMAL is
		external
			"IL signature (System.Int32): System.Decimal use System.Data.Common.DbDataRecord"
		alias
			"GetDecimal"
		end

	frozen get_value (i: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.Common.DbDataRecord"
		alias
			"GetValue"
		end

feature {NONE} -- Implementation

	frozen system_component_model_icustom_type_descriptor_get_events: SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.EventDescriptorCollection use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultProperty"
		end

	frozen system_component_model_icustom_type_descriptor_get_component_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetComponentName"
		end

	frozen system_component_model_icustom_type_descriptor_get_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen system_component_model_icustom_type_descriptor_get_class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetClassName"
		end

	frozen system_component_model_icustom_type_descriptor_get_property_owner (pd: SYSTEM_DLL_PROPERTY_DESCRIPTOR): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Object use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetPropertyOwner"
		end

	frozen get_events_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

	frozen system_component_model_icustom_type_descriptor_get_editor (editor_base_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEditor"
		end

	frozen system_component_model_icustom_type_descriptor_get_converter: SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetConverter"
		end

	frozen get_properties_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_event: SYSTEM_DLL_EVENT_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.EventDescriptor use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultEvent"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Data.Common.DbDataRecord"
		alias
			"Finalize"
		end

	frozen system_component_model_icustom_type_descriptor_get_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.Data.Common.DbDataRecord"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetAttributes"
		end

end -- class DATA_DB_DATA_RECORD
