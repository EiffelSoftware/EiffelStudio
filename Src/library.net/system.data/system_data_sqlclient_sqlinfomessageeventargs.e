indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlInfoMessageEventArgs"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLINFOMESSAGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_errors: SYSTEM_DATA_SQLCLIENT_SQLERRORCOLLECTION is
		external
			"IL signature (): System.Data.SqlClient.SqlErrorCollection use System.Data.SqlClient.SqlInfoMessageEventArgs"
		alias
			"get_Errors"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLINFOMESSAGEEVENTARGS
