indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkArea+LinkAreaConverter"

external class
	LINKAREACONVERTER_IN_SYSTEM_WINDOWS_FORMS_LINKAREA

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute,
			get_create_instance_supported_itype_descriptor_context,
			create_instance_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			convert_from_itype_descriptor_context,
			can_convert_to_itype_descriptor_context,
			can_convert_from_itype_descriptor_context
		end

create
	make_linkareaconverter

feature {NONE} -- Initialization

	frozen make_linkareaconverter is
		external
			"IL creator use System.Windows.Forms.LinkArea+LinkAreaConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"ConvertTo"
		end

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"GetPropertiesSupported"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"GetCreateInstanceSupported"
		end

	create_instance_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; property_values: SYSTEM_COLLECTIONS_IDICTIONARY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"CreateInstance"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"GetProperties"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"ConvertFrom"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; source_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"CanConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.LinkArea+LinkAreaConverter"
		alias
			"CanConvertTo"
		end

end -- class LINKAREACONVERTER_IN_SYSTEM_WINDOWS_FORMS_LINKAREA
