indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ValidatedControlConverter"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_VALIDATEDCONTROLCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_STRINGCONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context
		end

create {NONE}

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Web.UI.WebControls.ValidatedControlConverter"
		alias
			"GetStandardValuesExclusive"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Web.UI.WebControls.ValidatedControlConverter"
		alias
			"GetStandardValues"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Web.UI.WebControls.ValidatedControlConverter"
		alias
			"GetStandardValuesSupported"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_VALIDATEDCONTROLCONVERTER
