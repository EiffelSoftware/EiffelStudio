indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.BooleanConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_BOOLEAN_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_system_dll_boolean_converter

feature {NONE} -- Initialization

	frozen make_system_dll_boolean_converter is
		external
			"IL creator use System.ComponentModel.BooleanConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValuesExclusive"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"CanConvertFrom"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.BooleanConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValues"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValuesSupported"
		end

end -- class SYSTEM_DLL_BOOLEAN_CONVERTER
