indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Graphics+EnumerateMetafileProc"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_enumerate_metafile_proc_in_drawing_graphics

feature {NONE} -- Initialization

	frozen make_drawing_enumerate_metafile_proc_in_drawing_graphics (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Graphics+EnumerateMetafileProc"
		end

feature -- Basic Operations

	begin_invoke (record_type: DRAWING_EMF_PLUS_RECORD_TYPE; flags: INTEGER; data_size: INTEGER; data: POINTER; callback_data: DRAWING_PLAY_RECORD_CALLBACK; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.Drawing.Imaging.PlayRecordCallback, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"EndInvoke"
		end

	invoke (record_type: DRAWING_EMF_PLUS_RECORD_TYPE; flags: INTEGER; data_size: INTEGER; data: POINTER; callback_data: DRAWING_PLAY_RECORD_CALLBACK): BOOLEAN is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.Drawing.Imaging.PlayRecordCallback): System.Boolean use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"Invoke"
		end

end -- class DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS
