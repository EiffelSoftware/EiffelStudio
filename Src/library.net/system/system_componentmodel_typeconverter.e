indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.TypeConverter"

external class
	SYSTEM_COMPONENTMODEL_TYPECONVERTER

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

	frozen can_convert_from (source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertFrom"
		end

	frozen convert_from_invariant_string_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; text: STRING): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromInvariantString"
		end

	frozen can_convert_to (destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertTo"
		end

	frozen convert_to_invariant_string (value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToInvariantString"
		end

	frozen is_valid (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"IsValid"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	is_valid_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"IsValid"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"CanConvertFrom"
		end

	frozen convert_to (value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Object, System.Type): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
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

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetPropertiesSupported"
		end

	frozen convert_from (value: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFrom"
		end

	frozen get_properties_itype_descriptor_context_object (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	frozen create_instance (property_values: SYSTEM_COLLECTIONS_IDICTIONARY): ANY is
		external
			"IL signature (System.Collections.IDictionary): System.Object use System.ComponentModel.TypeConverter"
		alias
			"CreateInstance"
		end

	frozen convert_from_string (text: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetCreateInstanceSupported"
		end

	frozen convert_from_string_itype_descriptor_context_string (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; text: STRING): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	frozen convert_to_invariant_string_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY): STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToInvariantString"
		end

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
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

	create_instance_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; property_values: SYSTEM_COLLECTIONS_IDICTIONARY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.ComponentModel.TypeConverter"
		alias
			"CreateInstance"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertTo"
		end

	frozen convert_to_string (value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	frozen get_properties (value: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"GetProperties"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFrom"
		end

	frozen convert_to_string_itype_descriptor_context_object (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY): STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValues"
		end

	frozen convert_from_string_itype_descriptor_context_culture_info (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; text: STRING): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromString"
		end

	frozen convert_from_invariant_string (text: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.ComponentModel.TypeConverter"
		alias
			"ConvertFromInvariantString"
		end

	frozen get_standard_values: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	frozen convert_to_string_itype_descriptor_context_culture_info (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): STRING is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.String use System.ComponentModel.TypeConverter"
		alias
			"ConvertToString"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.TypeConverter"
		alias
			"GetStandardValuesSupported"
		end

feature {NONE} -- Implementation

	frozen get_convert_to_exception (value: ANY; destination_type: SYSTEM_TYPE): SYSTEM_EXCEPTION is
		external
			"IL signature (System.Object, System.Type): System.Exception use System.ComponentModel.TypeConverter"
		alias
			"GetConvertToException"
		end

	frozen get_convert_from_exception (value: ANY): SYSTEM_EXCEPTION is
		external
			"IL signature (System.Object): System.Exception use System.ComponentModel.TypeConverter"
		alias
			"GetConvertFromException"
		end

	frozen sort_properties (props: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION; names: ARRAY [STRING]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptorCollection, System.String[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.TypeConverter"
		alias
			"SortProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_TYPECONVERTER
