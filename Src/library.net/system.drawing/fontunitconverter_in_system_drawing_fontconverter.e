indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.FontConverter+FontUnitConverter"

external class
	FONTUNITCONVERTER_IN_SYSTEM_DRAWING_FONTCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_ENUMCONVERTER
		redefine
			get_standard_values_itype_descriptor_context
		end

create
	make_fontunitconverter

feature {NONE} -- Initialization

	frozen make_fontunitconverter is
		external
			"IL creator use System.Drawing.FontConverter+FontUnitConverter"
		end

feature -- Basic Operations

	get_standard_values_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): STANDARDVALUESCOLLECTION_IN_SYSTEM_COMPONENTMODEL_TYPECONVERTER is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.ComponentModel.TypeConverter+StandardValuesCollection use System.Drawing.FontConverter+FontUnitConverter"
		alias
			"GetStandardValues"
		end

end -- class FONTUNITCONVERTER_IN_SYSTEM_DRAWING_FONTCONVERTER
