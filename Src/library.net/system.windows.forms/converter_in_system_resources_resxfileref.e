indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResXFileRef+Converter"

external class
	CONVERTER_IN_SYSTEM_RESOURCES_RESXFILEREF

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_converter

feature {NONE} -- Initialization

	frozen make_converter is
		external
			"IL creator use System.Resources.ResXFileRef+Converter"
		end

feature -- Basic Operations

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Resources.ResXFileRef+Converter"
		alias
			"CanConvertFrom"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Resources.ResXFileRef+Converter"
		alias
			"ConvertTo"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Resources.ResXFileRef+Converter"
		alias
			"ConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Resources.ResXFileRef+Converter"
		alias
			"CanConvertTo"
		end

end -- class CONVERTER_IN_SYSTEM_RESOURCES_RESXFILEREF
