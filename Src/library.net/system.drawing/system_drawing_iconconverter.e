indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.IconConverter"

external class
	SYSTEM_DRAWING_ICONCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_EXPANDABLEOBJECTCONVERTER
		redefine
			convert_to_itype_descriptor_context
		end

create
	make_iconconverter

feature {NONE} -- Initialization

	frozen make_iconconverter is
		external
			"IL creator use System.Drawing.IconConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Drawing.IconConverter"
		alias
			"ConvertTo"
		end

end -- class SYSTEM_DRAWING_ICONCONVERTER
