indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ImageIndexConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_IMAGE_INDEX_CONVERTER

inherit
	SYSTEM_DLL_INT32_CONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context
		end

create
	make_winforms_image_index_converter

feature {NONE} -- Initialization

	frozen make_winforms_image_index_converter is
		external
			"IL creator use System.Windows.Forms.ImageIndexConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValuesExclusive"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.ImageIndexConverter"
		alias
			"ConvertTo"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValues"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.ImageIndexConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValuesSupported"
		end

feature {NONE} -- Implementation

	get_include_none_as_standard_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"get_IncludeNoneAsStandardValue"
		end

end -- class WINFORMS_IMAGE_INDEX_CONVERTER
