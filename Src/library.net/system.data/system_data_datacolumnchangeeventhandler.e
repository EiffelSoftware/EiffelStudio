indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataColumnChangeEventHandler"

frozen external class
	SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER

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
	make_datacolumnchangeeventhandler

feature {NONE} -- Initialization

	frozen make_datacolumnchangeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.DataColumnChangeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.DataColumnChangeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.DataColumnChangeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.DataColumnChangeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.DataColumnChangeEventArgs): System.Void use System.Data.DataColumnChangeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER
