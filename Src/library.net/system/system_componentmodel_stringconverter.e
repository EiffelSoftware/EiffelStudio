indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.StringConverter"

external class
	SYSTEM_COMPONENTMODEL_STRINGCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_stringconverter

feature {NONE} -- Initialization

	frozen make_stringconverter is
		external
			"IL creator use System.ComponentModel.StringConverter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.StringConverter"
		alias
			"CanConvertFrom"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.StringConverter"
		alias
			"ConvertFrom"
		end

end -- class SYSTEM_COMPONENTMODEL_STRINGCONVERTER
