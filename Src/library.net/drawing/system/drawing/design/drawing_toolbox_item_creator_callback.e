indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.ToolboxItemCreatorCallback"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_TOOLBOX_ITEM_CREATOR_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_toolbox_item_creator_callback

feature {NONE} -- Initialization

	frozen make_drawing_toolbox_item_creator_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Design.ToolboxItemCreatorCallback"
		end

feature -- Basic Operations

	begin_invoke (serialized_object: SYSTEM_OBJECT; format: SYSTEM_STRING; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): DRAWING_TOOLBOX_ITEM is
		external
			"IL signature (System.IAsyncResult): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"EndInvoke"
		end

	invoke (serialized_object: SYSTEM_OBJECT; format: SYSTEM_STRING): DRAWING_TOOLBOX_ITEM is
		external
			"IL signature (System.Object, System.String): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"Invoke"
		end

end -- class DRAWING_TOOLBOX_ITEM_CREATOR_CALLBACK
