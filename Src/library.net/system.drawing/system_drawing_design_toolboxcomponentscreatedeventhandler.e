indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatedEventHandler"

frozen external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object	
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_toolboxcomponentscreatedeventhandler

feature {NONE} -- Initialization

	frozen make_toolboxcomponentscreatedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Design.ToolboxComponentsCreatedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Drawing.Design.ToolboxComponentsCreatedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.ToolboxComponentsCreatedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.ToolboxComponentsCreatedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Drawing.Design.ToolboxComponentsCreatedEventArgs): System.Void use System.Drawing.Design.ToolboxComponentsCreatedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTHANDLER
