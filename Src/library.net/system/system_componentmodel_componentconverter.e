indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ComponentConverter"

external class
	SYSTEM_COMPONENTMODEL_COMPONENTCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_REFERENCECONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute
		end

create
	make_componentconverter

feature {NONE} -- Initialization

	frozen make_componentconverter (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.ComponentConverter"
		end

feature -- Basic Operations

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.ComponentConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ComponentConverter"
		alias
			"GetProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_COMPONENTCONVERTER
