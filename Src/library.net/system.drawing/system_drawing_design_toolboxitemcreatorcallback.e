indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxItemCreatorCallback"

frozen external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCREATORCALLBACK

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
	make_toolboxitemcreatorcallback

feature {NONE} -- Initialization

	frozen make_toolboxitemcreatorcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Design.ToolboxItemCreatorCallback"
		end

feature -- Basic Operations

	begin_invoke (serialized_object: ANY; format: STRING; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL signature (System.IAsyncResult): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"EndInvoke"
		end

	invoke (serialized_object: ANY; format: STRING): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL signature (System.Object, System.String): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCreatorCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCREATORCALLBACK
