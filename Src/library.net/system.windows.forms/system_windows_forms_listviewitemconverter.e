indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListViewItemConverter"

external class
	SYSTEM_WINDOWS_FORMS_LISTVIEWITEMCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_EXPANDABLEOBJECTCONVERTER
		redefine
			convert_to_itype_descriptor_context,
			can_convert_to_itype_descriptor_context
		end

create
	make_listviewitemconverter

feature {NONE} -- Initialization

	frozen make_listviewitemconverter is
		external
			"IL creator use System.Windows.Forms.ListViewItemConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.ListViewItemConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.ListViewItemConverter"
		alias
			"CanConvertTo"
		end

end -- class SYSTEM_WINDOWS_FORMS_LISTVIEWITEMCONVERTER
