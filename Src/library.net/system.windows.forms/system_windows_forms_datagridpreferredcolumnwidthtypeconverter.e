indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"

external class
	SYSTEM_WINDOWS_FORMS_DATAGRIDPREFERREDCOLUMNWIDTHTYPECONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_datagridpreferredcolumnwidthtypeconverter

feature {NONE} -- Initialization

	frozen make_datagridpreferredcolumnwidthtypeconverter is
		external
			"IL creator use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.DataGridPreferredColumnWidthTypeConverter"
		alias
			"ConvertFrom"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATAGRIDPREFERREDCOLUMNWIDTHTYPECONVERTER
