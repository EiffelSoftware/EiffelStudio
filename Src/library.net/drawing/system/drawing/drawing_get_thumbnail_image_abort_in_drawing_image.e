indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Image+GetThumbnailImageAbort"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_GET_THUMBNAIL_IMAGE_ABORT_IN_DRAWING_IMAGE

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_get_thumbnail_image_abort_in_drawing_image

feature {NONE} -- Initialization

	frozen make_drawing_get_thumbnail_image_abort_in_drawing_image (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Image+GetThumbnailImageAbort"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Image+GetThumbnailImageAbort"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Drawing.Image+GetThumbnailImageAbort"
		alias
			"EndInvoke"
		end

	invoke: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Image+GetThumbnailImageAbort"
		alias
			"Invoke"
		end

end -- class DRAWING_GET_THUMBNAIL_IMAGE_ABORT_IN_DRAWING_IMAGE
