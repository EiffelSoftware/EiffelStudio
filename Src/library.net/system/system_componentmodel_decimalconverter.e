indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DecimalConverter"

external class
	SYSTEM_COMPONENTMODEL_DECIMALCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_BASENUMBERCONVERTER
		redefine
			convert_to_itype_descriptor_context,
			can_convert_to_itype_descriptor_context
		end

create
	make_decimalconverter

feature {NONE} -- Initialization

	frozen make_decimalconverter is
		external
			"IL creator use System.ComponentModel.DecimalConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.DecimalConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.DecimalConverter"
		alias
			"CanConvertTo"
		end

end -- class SYSTEM_COMPONENTMODEL_DECIMALCONVERTER
