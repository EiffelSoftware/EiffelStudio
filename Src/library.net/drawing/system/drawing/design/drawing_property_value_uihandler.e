indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.PropertyValueUIHandler"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PROPERTY_VALUE_UIHANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_property_value_uihandler

feature {NONE} -- Initialization

	frozen make_drawing_property_value_uihandler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Design.PropertyValueUIHandler"
		end

feature -- Basic Operations

	begin_invoke (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR; value_uiitem_list: ARRAY_LIST; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Collections.ArrayList, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"EndInvoke"
		end

	invoke (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR; value_uiitem_list: ARRAY_LIST) is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Collections.ArrayList): System.Void use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"Invoke"
		end

end -- class DRAWING_PROPERTY_VALUE_UIHANDLER
