indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.MergeFailedEventHandler"

frozen external class
	SYSTEM_DATA_MERGEFAILEDEVENTHANDLER

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
	make_mergefailedeventhandler

feature {NONE} -- Initialization

	frozen make_mergefailedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.MergeFailedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_MERGEFAILEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.MergeFailedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.MergeFailedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.MergeFailedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_MERGEFAILEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.MergeFailedEventArgs): System.Void use System.Data.MergeFailedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_MERGEFAILEDEVENTHANDLER
