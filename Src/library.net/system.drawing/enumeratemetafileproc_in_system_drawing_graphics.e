indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Graphics+EnumerateMetafileProc"

frozen external class
	ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS

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
	make_enumeratemetafileproc

feature {NONE} -- Initialization

	frozen make_enumeratemetafileproc (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Graphics+EnumerateMetafileProc"
		end

feature -- Basic Operations

	begin_invoke (record_type: SYSTEM_DRAWING_IMAGING_EMFPLUSRECORDTYPE; flags: INTEGER; data_size: INTEGER; data: POINTER; callback_data: SYSTEM_DRAWING_IMAGING_PLAYRECORDCALLBACK; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.Drawing.Imaging.PlayRecordCallback, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"EndInvoke"
		end

	invoke (record_type: SYSTEM_DRAWING_IMAGING_EMFPLUSRECORDTYPE; flags: INTEGER; data_size: INTEGER; data: POINTER; callback_data: SYSTEM_DRAWING_IMAGING_PLAYRECORDCALLBACK): BOOLEAN is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.Drawing.Imaging.PlayRecordCallback): System.Boolean use System.Drawing.Graphics+EnumerateMetafileProc"
		alias
			"Invoke"
		end

end -- class ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS
