indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.FontConverter+FontNameConverter"

frozen external class
	FONTNAMECONVERTER_IN_SYSTEM_DRAWING_FONTCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context,
			finalize
		end

create
	make_fontnameconverter

feature {NONE} -- Initialization

	frozen make_fontnameconverter is
		external
			"IL creator use System.Drawing.FontConverter+FontNameConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.FontConverter+FontNameConverter"
		alias
			"GetStandardValuesExclusive"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Drawing.FontConverter+FontNameConverter"
		alias
			"CanConvertFrom"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Drawing.FontConverter+FontNameConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Drawing.FontConverter+FontNameConverter"
		alias
			"GetStandardValues"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.FontConverter+FontNameConverter"
		alias
			"GetStandardValuesSupported"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.FontConverter+FontNameConverter"
		alias
			"Finalize"
		end

end -- class FONTNAMECONVERTER_IN_SYSTEM_DRAWING_FONTCONVERTER
