indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ArrayConverter"

external class
	SYSTEM_COMPONENTMODEL_ARRAYCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_COLLECTIONCONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute,
			convert_to_itype_descriptor_context
		end

create
	make_arrayconverter

feature {NONE} -- Initialization

	frozen make_arrayconverter is
		external
			"IL creator use System.ComponentModel.ArrayConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.ComponentModel.ArrayConverter"
		alias
			"ConvertTo"
		end

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.ArrayConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ArrayConverter"
		alias
			"GetProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_ARRAYCONVERTER
