indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.TypeConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TYPE_CONVERTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.TypeConverter"
		end

feature -- Basic Operations

	frozen get_create_instance_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetCreateInstanceSupported"
		end

	frozen can_convert_from (source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertFrom"
		end

	frozen convert_from_invariant_string_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; text: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromInvariantString"
		end

	frozen can_convert_to (destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertTo"
		end

	frozen convert_to_invariant_string (value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToInvariantString"
		end

	frozen is_valid (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"IsValid"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	is_valid_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"IsValid"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertFrom"
		end

	frozen convert_to (value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Type): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertTo"
		end

	frozen get_standard_values_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValuesSupported"
		end

	get_properties_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetPropertiesSupported"
		end

	frozen convert_from (value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFrom"
		end

	frozen get_properties_itype_descriptor_context_object (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	frozen create_instance (property_values: IDICTIONARY): SYSTEM_OBJECT is
		external
			"IL signature (System.Collections.IDictionary): System.Object use System.ComponentModel.TypeConverter"
		alias
			"CreateInstance"
		end

	frozen convert_from_string (text: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetCreateInstanceSupported"
		end

	frozen convert_from_string_itype_descriptor_context_string (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; text: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	frozen convert_to_invariant_string_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToInvariantString"
		end

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValuesExclusive"
		end

	frozen get_properties_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetPropertiesSupported"
		end

	create_instance_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; property_values: IDICTIONARY): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.ComponentModel.TypeConverter"
		alias
			"CreateInstance"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertTo"
		end

	frozen convert_to_string (value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	frozen get_properties (value: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFrom"
		end

	frozen convert_to_string_itype_descriptor_context_object (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValues"
		end

	frozen convert_from_string_itype_descriptor_context_culture_info (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; text: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	frozen convert_from_invariant_string (text: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromInvariantString"
		end

	frozen get_standard_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValues"
		end

	frozen get_standard_values_exclusive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValuesExclusive"
		end

	frozen convert_to_string_itype_descriptor_context_culture_info (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValuesSupported"
		end

feature {NONE} -- Implementation

	frozen get_convert_to_exception (value: SYSTEM_OBJECT; destination_type: TYPE): EXCEPTION is
		external
			"IL signature (System.Object, System.Type): System.Exception use System.ComponentModel.TypeConverter"
		alias
			"GetConvertToException"
		end

	frozen get_convert_from_exception (value: SYSTEM_OBJECT): EXCEPTION is
		external
			"IL signature (System.Object): System.Exception use System.ComponentModel.TypeConverter"
		alias
			"GetConvertFromException"
		end

	frozen sort_properties (props: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION; names: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptorCollection, System.String[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"SortProperties"
		end

end -- class SYSTEM_DLL_TYPE_CONVERTER
