indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbInfoMessageEventHandler"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTHANDLER

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
	make_oledbinfomessageeventhandler

feature {NONE} -- Initialization

	frozen make_oledbinfomessageeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.OleDb.OleDbInfoMessageEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbInfoMessageEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.OleDb.OleDbInfoMessageEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.OleDb.OleDbInfoMessageEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbInfoMessageEventArgs): System.Void use System.Data.OleDb.OleDbInfoMessageEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTHANDLER
