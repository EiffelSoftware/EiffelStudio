indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.PropertyValueUIItem"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_PROPERTY_VALUE_UIITEM

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (ui_item_image: DRAWING_IMAGE; handler: DRAWING_PROPERTY_VALUE_UIITEM_INVOKE_HANDLER; tooltip: SYSTEM_STRING) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Design.PropertyValueUIItemInvokeHandler, System.String) use System.Drawing.Design.PropertyValueUIItem"
		end

feature -- Access

	get_tool_tip: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.PropertyValueUIItem"
		alias
			"get_ToolTip"
		end

	get_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.Design.PropertyValueUIItem"
		alias
			"get_Image"
		end

	get_invoke_handler: DRAWING_PROPERTY_VALUE_UIITEM_INVOKE_HANDLER is
		external
			"IL signature (): System.Drawing.Design.PropertyValueUIItemInvokeHandler use System.Drawing.Design.PropertyValueUIItem"
		alias
			"get_InvokeHandler"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Drawing.Design.PropertyValueUIItem"
		alias
			"Reset"
		end

end -- class DRAWING_PROPERTY_VALUE_UIITEM
