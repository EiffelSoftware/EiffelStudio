indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ExpandableObjectConverter"

external class
	SYSTEM_COMPONENTMODEL_EXPANDABLEOBJECTCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute
		end

create
	make_expandableobjectconverter

feature {NONE} -- Initialization

	frozen make_expandableobjectconverter is
		external
			"IL creator use System.ComponentModel.ExpandableObjectConverter"
		end

feature -- Basic Operations

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.ExpandableObjectConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ExpandableObjectConverter"
		alias
			"GetProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_EXPANDABLEOBJECTCONVERTER
