indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.PropertyValueUIItemInvokeHandler"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PROPERTY_VALUE_UIITEM_INVOKE_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_property_value_uiitem_invoke_handler

feature {NONE} -- Initialization

	frozen make_drawing_property_value_uiitem_invoke_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		end

feature -- Basic Operations

	begin_invoke (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; descriptor: SYSTEM_DLL_PROPERTY_DESCRIPTOR; invoked_item: DRAWING_PROPERTY_VALUE_UIITEM; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Drawing.Design.PropertyValueUIItem, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"EndInvoke"
		end

	invoke (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; descriptor: SYSTEM_DLL_PROPERTY_DESCRIPTOR; invoked_item: DRAWING_PROPERTY_VALUE_UIITEM) is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Drawing.Design.PropertyValueUIItem): System.Void use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"Invoke"
		end

end -- class DRAWING_PROPERTY_VALUE_UIITEM_INVOKE_HANDLER
