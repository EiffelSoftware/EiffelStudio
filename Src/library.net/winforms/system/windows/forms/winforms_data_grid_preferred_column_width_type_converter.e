indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_PREFERRED_COLUMN_WIDTH_TYPE_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_winforms_data_grid_preferred_column_width_type_converter

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_preferred_column_width_type_converter is
		external
			"IL creator use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"ConvertFrom"
		end

end -- class WINFORMS_DATA_GRID_PREFERRED_COLUMN_WIDTH_TYPE_CONVERTER
