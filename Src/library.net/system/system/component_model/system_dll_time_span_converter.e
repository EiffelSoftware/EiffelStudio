indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.TimeSpanConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TIME_SPAN_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_system_dll_time_span_converter

feature {NONE} -- Initialization

	frozen make_system_dll_time_span_converter is
		external
			"IL creator use System.ComponentModel.TimeSpanConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.TimeSpanConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.TimeSpanConverter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.TimeSpanConverter"
		alias
			"ConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.TimeSpanConverter"
		alias
			"CanConvertTo"
		end

end -- class SYSTEM_DLL_TIME_SPAN_CONVERTER
