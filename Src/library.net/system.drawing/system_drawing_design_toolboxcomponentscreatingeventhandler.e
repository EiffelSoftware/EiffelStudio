indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatingEventHandler"

frozen external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTHANDLER

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
	make_toolboxcomponentscreatingeventhandler

feature {NONE} -- Initialization

	frozen make_toolboxcomponentscreatingeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Design.ToolboxComponentsCreatingEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Drawing.Design.ToolboxComponentsCreatingEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.ToolboxComponentsCreatingEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.ToolboxComponentsCreatingEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTARGS) is
		external
			"IL signature (System.Object, System.Drawing.Design.ToolboxComponentsCreatingEventArgs): System.Void use System.Drawing.Design.ToolboxComponentsCreatingEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTHANDLER
