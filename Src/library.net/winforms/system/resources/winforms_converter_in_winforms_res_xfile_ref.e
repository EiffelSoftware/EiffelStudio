indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResXFileRef+Converter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONVERTER_IN_WINFORMS_RES_XFILE_REF

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_winforms_converter_in_winforms_res_xfile_ref

feature {NONE} -- Initialization

	frozen make_winforms_converter_in_winforms_res_xfile_ref is
		external
			"IL creator use System.Resources.ResXFileRef+Converter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Resources.ResXFileRef+Converter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Resources.ResXFileRef+Converter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Resources.ResXFileRef+Converter"
		alias
			"ConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Resources.ResXFileRef+Converter"
		alias
			"CanConvertTo"
		end

end -- class WINFORMS_CONVERTER_IN_WINFORMS_RES_XFILE_REF
