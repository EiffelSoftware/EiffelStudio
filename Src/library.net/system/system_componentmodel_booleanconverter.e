indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.BooleanConverter"

external class
	SYSTEM_COMPONENTMODEL_BOOLEANCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_booleanconverter

feature {NONE} -- Initialization

	frozen make_booleanconverter is
		external
			"IL creator use System.ComponentModel.BooleanConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValuesExclusive"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"CanConvertFrom"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.ComponentModel.BooleanConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValues"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.BooleanConverter"
		alias
			"GetStandardValuesSupported"
		end

end -- class SYSTEM_COMPONENTMODEL_BOOLEANCONVERTER
