indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.PlayRecordCallback"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PLAY_RECORD_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_play_record_callback

feature {NONE} -- Initialization

	frozen make_drawing_play_record_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Imaging.PlayRecordCallback"
		end

feature -- Basic Operations

	begin_invoke (record_type: DRAWING_EMF_PLUS_RECORD_TYPE; flags: INTEGER; data_size: INTEGER; record_data: POINTER; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"EndInvoke"
		end

	invoke (record_type: DRAWING_EMF_PLUS_RECORD_TYPE; flags: INTEGER; data_size: INTEGER; record_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr): System.Void use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"Invoke"
		end

end -- class DRAWING_PLAY_RECORD_CALLBACK
