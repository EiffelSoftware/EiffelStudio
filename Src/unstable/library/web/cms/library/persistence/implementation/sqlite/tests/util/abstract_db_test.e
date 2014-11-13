note
	description: "Summary description for {ABSTRACT_DB_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ABSTRACT_DB_TEST


feature -- Database connection

	connection: DATABASE_CONNECTION_ODBC
			-- odbc database connection
		once
--			create Result.login_with_connection_string ("Driver=SQLite3 ODBC Driver;Database=PATH/SQLITE.FILE;LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;")
			create Result.make_basic ("cms_dev")
		end

end
