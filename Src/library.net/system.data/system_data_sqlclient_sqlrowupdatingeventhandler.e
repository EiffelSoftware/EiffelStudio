indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlRowUpdatingEventHandler"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTHANDLER

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
	make_sqlrowupdatingeventhandler

feature {NONE} -- Initialization

	frozen make_sqlrowupdatingeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.SqlClient.SqlRowUpdatingEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.SqlClient.SqlRowUpdatingEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.SqlClient.SqlRowUpdatingEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.SqlClient.SqlRowUpdatingEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.SqlClient.SqlRowUpdatingEventArgs): System.Void use System.Data.SqlClient.SqlRowUpdatingEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLROWUPDATINGEVENTHANDLER
