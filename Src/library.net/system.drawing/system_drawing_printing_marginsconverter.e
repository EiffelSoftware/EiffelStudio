indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.MarginsConverter"

external class
	SYSTEM_DRAWING_PRINTING_MARGINSCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_EXPANDABLEOBJECTCONVERTER
		redefine
			get_create_instance_supported_itype_descriptor_context,
			create_instance_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_marginsconverter

feature {NONE} -- Initialization

	frozen make_marginsconverter is
		external
			"IL creator use System.Drawing.Printing.MarginsConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Drawing.Printing.MarginsConverter"
		alias
			"ConvertTo"
		end

	create_instance_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; property_values: SYSTEM_COLLECTIONS_IDICTIONARY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.Drawing.Printing.MarginsConverter"
		alias
			"CreateInstance"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.Printing.MarginsConverter"
		alias
			"GetCreateInstanceSupported"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Drawing.Printing.MarginsConverter"
		alias
			"ConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Drawing.Printing.MarginsConverter"
		alias
			"CanConvertTo"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Drawing.Printing.MarginsConverter"
		alias
			"CanConvertFrom"
		end

end -- class SYSTEM_DRAWING_PRINTING_MARGINSCONVERTER
