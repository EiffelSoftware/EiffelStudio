indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowChangeEventHandler"

frozen external class
	SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER

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
	make_datarowchangeeventhandler

feature {NONE} -- Initialization

	frozen make_datarowchangeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.DataRowChangeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.DataRowChangeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.DataRowChangeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.DataRowChangeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataRowChangeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER
