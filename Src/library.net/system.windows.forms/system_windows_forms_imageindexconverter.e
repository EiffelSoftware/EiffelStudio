indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ImageIndexConverter"

external class
	SYSTEM_WINDOWS_FORMS_IMAGEINDEXCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_INT32CONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context
		end

create
	make_imageindexconverter

feature {NONE} -- Initialization

	frozen make_imageindexconverter is
		external
			"IL creator use System.Windows.Forms.ImageIndexConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValuesExclusive"
		end

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.ImageIndexConverter"
		alias
			"ConvertTo"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValues"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.ImageIndexConverter"
		alias
			"ConvertFrom"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"GetStandardValuesSupported"
		end

feature {NONE} -- Implementation

	get_include_none_as_standard_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageIndexConverter"
		alias
			"get_IncludeNoneAsStandardValue"
		end

end -- class SYSTEM_WINDOWS_FORMS_IMAGEINDEXCONVERTER
