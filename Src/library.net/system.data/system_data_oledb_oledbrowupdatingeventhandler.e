indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbRowUpdatingEventHandler"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBROWUPDATINGEVENTHANDLER

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
	make_oledbrowupdatingeventhandler

feature {NONE} -- Initialization

	frozen make_oledbrowupdatingeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.OleDb.OleDbRowUpdatingEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBROWUPDATINGEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatingEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.OleDb.OleDbRowUpdatingEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.OleDb.OleDbRowUpdatingEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBROWUPDATINGEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatingEventArgs): System.Void use System.Data.OleDb.OleDbRowUpdatingEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBROWUPDATINGEVENTHANDLER
