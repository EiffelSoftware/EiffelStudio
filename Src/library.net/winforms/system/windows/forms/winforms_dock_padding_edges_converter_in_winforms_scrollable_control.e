indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DOCK_PADDING_EDGES_CONVERTER_IN_WINFORMS_SCROLLABLE_CONTROL

inherit
	SYSTEM_DLL_TYPE_CONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute
		end

create
	make_winforms_dock_padding_edges_converter_in_winforms_scrollable_control

feature {NONE} -- Initialization

	frozen make_winforms_dock_padding_edges_converter_in_winforms_scrollable_control is
		external
			"IL creator use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		end

feature -- Basic Operations

	get_properties_supported_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; value: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		alias
			"GetProperties"
		end

end -- class WINFORMS_DOCK_PADDING_EDGES_CONVERTER_IN_WINFORMS_SCROLLABLE_CONTROL
