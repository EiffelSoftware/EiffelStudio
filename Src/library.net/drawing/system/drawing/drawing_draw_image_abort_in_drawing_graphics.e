indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Graphics+DrawImageAbort"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_draw_image_abort_in_drawing_graphics

feature {NONE} -- Initialization

	frozen make_drawing_draw_image_abort_in_drawing_graphics (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Graphics+DrawImageAbort"
		end

feature -- Basic Operations

	begin_invoke (callbackdata: POINTER; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Graphics+DrawImageAbort"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
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

end -- class DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS
