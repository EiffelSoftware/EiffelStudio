indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.FontConverter+FontUnitConverter"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_FONT_UNIT_CONVERTER_IN_DRAWING_FONT_CONVERTER

inherit
	SYSTEM_DLL_ENUM_CONVERTER
		redefine
			get_standard_values_itype_descriptor_context
		end

create
	make_drawing_font_unit_converter_in_drawing_font_converter

feature {NONE} -- Initialization

	frozen make_drawing_font_unit_converter_in_drawing_font_converter is
		external
			"IL creator use System.Drawing.FontConverter+FontUnitConverter"
		end

feature -- Basic Operations

	get_standard_values_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): SYSTEM_DLL_STANDARD_VALUES_COLLECTION_IN_SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Drawing.FontConverter+FontUnitConverter"
		alias
			"GetStandardValues"
		end

end -- class DRAWING_FONT_UNIT_CONVERTER_IN_DRAWING_FONT_CONVERTER
