indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.ImageConverter"

external class
	SYSTEM_DRAWING_IMAGECONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute,
			convert_to_itype_descriptor_context
		end

create
	make_imageconverter

feature {NONE} -- Initialization

	frozen make_imageconverter is
		external
			"IL creator use System.Drawing.ImageConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Drawing.ImageConverter"
		alias
			"ConvertTo"
		end

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Drawing.ImageConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Drawing.ImageConverter"
		alias
			"GetProperties"
		end

end -- class SYSTEM_DRAWING_IMAGECONVERTER
