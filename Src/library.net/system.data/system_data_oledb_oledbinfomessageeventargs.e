indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbInfoMessageEventArgs"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTARGS

inherit
	SYSTEM_EVENTARGS
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_errors: SYSTEM_DATA_OLEDB_OLEDBERRORCOLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbErrorCollection use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Errors"
		end

	frozen get_message: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Message"
		end

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Source"
		end

	frozen get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_ErrorCode"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"ToString"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTARGS
