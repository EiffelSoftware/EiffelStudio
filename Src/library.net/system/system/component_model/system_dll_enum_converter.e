indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.EnumConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ENUM_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			is_valid_itype_descriptor_context,
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_system_dll_enum_converter

feature {NONE} -- Initialization

	frozen make_system_dll_enum_converter (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.EnumConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.EnumConverter"
		alias
			"GetStandardValuesExclusive"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.EnumConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.EnumConverter"
		alias
			"ConvertTo"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.EnumConverter"
		alias
			"GetStandardValuesSupported"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.EnumConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.EnumConverter"
		alias
			"GetStandardValues"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.EnumConverter"
		alias
			"CanConvertTo"
		end

	is_valid_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object): System.Boolean use System.ComponentModel.EnumConverter"
		alias
			"IsValid"
		end

feature {NONE} -- Implementation

	get_comparer: ICOMPARER is
		external
			"IL signature (): System.Collections.IComparer use System.ComponentModel.EnumConverter"
		alias
			"get_Comparer"
		end

	frozen get_values: SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.EnumConverter"
		alias
			"get_Values"
		end

	frozen get_enum_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.EnumConverter"
		alias
			"get_EnumType"
		end

	frozen set_values (value: SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER) is
		external
			"IL signature (System.ComponentModel.TypeConverter+StandardValuesCollection): System.Void use System.ComponentModel.EnumConverter"
		alias
			"set_Values"
		end

end -- class SYSTEM_DLL_ENUM_CONVERTER
