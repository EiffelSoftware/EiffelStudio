indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TargetConverter"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TARGETCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_STRINGCONVERTER
		redefine
			get_standard_values_supported_itype_descriptor_context,
			get_standard_values_exclusive_itype_descriptor_context,
			get_standard_values_itype_descriptor_context
		end

create
	make_targetconverter

feature {NONE} -- Initialization

	frozen make_targetconverter is
		external
			"IL creator use System.Web.UI.WebControls.TargetConverter"
		end

feature -- Basic Operations

	get_standard_values_exclusive_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Web.UI.WebControls.TargetConverter"
		alias
			"GetStandardValuesExclusive"
		end

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Web.UI.WebControls.TargetConverter"
		alias
			"GetStandardValues"
		end

	get_standard_values_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Web.UI.WebControls.TargetConverter"
		alias
			"GetStandardValuesSupported"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TARGETCONVERTER
