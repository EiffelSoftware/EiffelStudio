indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CursorConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CURSOR_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_winforms_cursor_converter

feature {NONE} -- Initialization

	frozen make_winforms_cursor_converter is
		external
			"IL creator use System.Windows.Forms.CursorConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.CursorConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.CursorConverter"
		alias
			"ConvertTo"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Windows.Forms.CursorConverter"
		alias
			"GetStandardValues"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.CursorConverter"
		alias
			"ConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.CursorConverter"
		alias
			"CanConvertTo"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.CursorConverter"
		alias
			"GetStandardValuesSupported"
		end

end -- class WINFORMS_CURSOR_CONVERTER
