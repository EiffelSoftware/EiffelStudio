indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DecimalConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DECIMAL_CONVERTER

inherit
	SYSTEM_DLL_BASE_NUMBER_CONVERTER
		redefine
			convert_to_itype_descriptor_context,
			can_convert_to_itype_descriptor_context
		end

create
	make_system_dll_decimal_converter

feature {NONE} -- Initialization

	frozen make_system_dll_decimal_converter is
		external
			"IL creator use System.ComponentModel.DecimalConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.DecimalConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.DecimalConverter"
		alias
			"CanConvertTo"
		end

end -- class SYSTEM_DLL_DECIMAL_CONVERTER
