indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Graphics+DrawImageAbort"

frozen external class
	DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS

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
	make_drawimageabort

feature {NONE} -- Initialization

	frozen make_drawimageabort (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Graphics+DrawImageAbort"
		end

feature -- Basic Operations

	begin_invoke (callbackdata: POINTER; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Graphics+DrawImageAbort"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Drawing.Graphics+DrawImageAbort"
		alias
			"EndInvoke"
		end

	invoke (callbackdata: POINTER): BOOLEAN is
		external
			"IL signature (System.IntPtr): System.Boolean use System.Drawing.Graphics+DrawImageAbort"
		alias
			"Invoke"
		end

end -- class DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS
