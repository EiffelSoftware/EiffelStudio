indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.PlayRecordCallback"

frozen external class
	SYSTEM_DRAWING_IMAGING_PLAYRECORDCALLBACK

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
	make_playrecordcallback

feature {NONE} -- Initialization

	frozen make_playrecordcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Imaging.PlayRecordCallback"
		end

feature -- Basic Operations

	begin_invoke (record_type: SYSTEM_DRAWING_IMAGING_EMFPLUSRECORDTYPE; flags: INTEGER; data_size: INTEGER; record_data: POINTER; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"EndInvoke"
		end

	invoke (record_type: SYSTEM_DRAWING_IMAGING_EMFPLUSRECORDTYPE; flags: INTEGER; data_size: INTEGER; record_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.EmfPlusRecordType, System.Int32, System.Int32, System.IntPtr): System.Void use System.Drawing.Imaging.PlayRecordCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_IMAGING_PLAYRECORDCALLBACK
