indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListViewItemConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LIST_VIEW_ITEM_CONVERTER

inherit
	SYSTEM_DLL_EXPANDABLE_OBJECT_CONVERTER
		redefine
			convert_to_itype_descriptor_context,
			can_convert_to_itype_descriptor_context
		end

create
	make_winforms_list_view_item_converter

feature {NONE} -- Initialization

	frozen make_winforms_list_view_item_converter is
		external
			"IL creator use System.Windows.Forms.ListViewItemConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; culture: CULTURE_INFO; value: SYSTEM_OBJECT; destination_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.ListViewItemConverter"
		alias
			"ConvertTo"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; destination_type: TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.ListViewItemConverter"
		alias
			"CanConvertTo"
		end

end -- class WINFORMS_LIST_VIEW_ITEM_CONVERTER
