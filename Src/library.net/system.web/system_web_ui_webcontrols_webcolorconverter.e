indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.WebColorConverter"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCOLORCONVERTER

inherit
	SYSTEM_DRAWING_COLORCONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context
		end

create
	make_webcolorconverter

feature {NONE} -- Initialization

	frozen make_webcolorconverter is
		external
			"IL creator use System.Web.UI.WebControls.WebColorConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Web.UI.WebControls.WebColorConverter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Web.UI.WebControls.WebColorConverter"
		alias
			"ConvertFrom"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_WEBCOLORCONVERTER
