indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ComponentConverter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPONENT_CONVERTER

inherit
	SYSTEM_DLL_REFERENCE_CONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute
		end

create
	make_system_dll_component_converter

feature {NONE} -- Initialization

	frozen make_system_dll_component_converter (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.ComponentConverter"
		end

feature -- Basic Operations

	get_properties_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.ComponentModel.ComponentConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ComponentConverter"
		alias
			"GetProperties"
		end

end -- class SYSTEM_DLL_COMPONENT_CONVERTER
