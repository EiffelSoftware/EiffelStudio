indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Image+GetThumbnailImageAbort"

frozen external class
	GETTHUMBNAILIMAGEABORT_IN_SYSTEM_DRAWING_IMAGE

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
	make_getthumbnailimageabort

feature {NONE} -- Initialization

	frozen make_getthumbnailimageabort (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Image+GetThumbnailImageAbort"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Image+GetThumbnailImageAbort"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): BOOLEAN is
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

end -- class GETTHUMBNAILIMAGEABORT_IN_SYSTEM_DRAWING_IMAGE
