indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SelectionRangeConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SELECTION_RANGE_CONVERTER

inherit
	SYSTEM_DLL_TYPE_CONVERTER
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
	make_winforms_selection_range_converter

feature {NONE} -- Initialization

	frozen make_winforms_selection_range_converter is
		external
			"IL creator use System.Windows.Forms.SelectionRangeConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.SelectionRangeConverter"
		alias
			"ConvertTo"
		end

	get_properties_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.SelectionRangeConverter"
		alias
			"GetPropertiesSupported"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.SelectionRangeConverter"
		alias
			"GetCreateInstanceSupported"
		end

	create_instance_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; property_values: IDICTIONARY): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.Windows.Forms.SelectionRangeConverter"
		alias
			"CreateInstance"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.SelectionRangeConverter"
		alias
			"GetProperties"
		end

	convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object): System.Object use System.Windows.Forms.SelectionRangeConverter"
		alias
			"ConvertFrom"
		end

	can_convert_from_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; source_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.SelectionRangeConverter"
		alias
			"CanConvertFrom"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.SelectionRangeConverter"
		alias
			"CanConvertTo"
		end

end -- class WINFORMS_SELECTION_RANGE_CONVERTER
