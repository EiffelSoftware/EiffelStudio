indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlRowUpdatedEventHandler"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTHANDLER

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
	make_sqlrowupdatedeventhandler

feature {NONE} -- Initialization

	frozen make_sqlrowupdatedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.SqlClient.SqlRowUpdatedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.SqlClient.SqlRowUpdatedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.SqlClient.SqlRowUpdatedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.SqlClient.SqlRowUpdatedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.SqlClient.SqlRowUpdatedEventArgs): System.Void use System.Data.SqlClient.SqlRowUpdatedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLROWUPDATEDEVENTHANDLER
