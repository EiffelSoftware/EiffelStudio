indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.StringConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_STRING_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_system_dll_string_converter

feature {NONE} -- Initialization

	frozen make_system_dll_string_converter is
		external
			"IL creator use System.ComponentModel.StringConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.StringConverter"
		alias
			"CanConvertFrom"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.StringConverter"
		alias
			"ConvertFrom"
		end

end -- class SYSTEM_DLL_STRING_CONVERTER
