indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.PropertyValueUIItem"

external class
	SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEM

create
	make

feature {NONE} -- Initialization

	frozen make (ui_item_image: SYSTEM_DRAWING_IMAGE; handler: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEMINVOKEHANDLER; tooltip: STRING) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Design.PropertyValueUIItemInvokeHandler, System.String) use System.Drawing.Design.PropertyValueUIItem"
		end

feature -- Access

	get_tool_tip: STRING is
		external
			"IL signature (): System.String use System.Drawing.Design.PropertyValueUIItem"
		alias
			"get_ToolTip"
		end

	get_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.Design.PropertyValueUIItem"
		alias
			"get_Image"
		end

	get_invoke_handler: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEMINVOKEHANDLER is
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

end -- class SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEM
