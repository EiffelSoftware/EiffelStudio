indexing
	description: "Project Shared variables"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROJECT_SHARED

feature -- Access

	is_oracle (code: INTEGER): BOOLEAN is
			-- Is selected DBMS Oracle?
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := code = Available_dbms.Oracle_code
		end

	is_odbc (code: INTEGER): BOOLEAN is
			-- Is selected DBMS ODBC?
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := code = Available_dbms.Odbc_code
		end

	db_manager (code: INTEGER): DATABASE_MANAGER [DATABASE] is
			-- Database manager, responsible for interactions
			-- with the database.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := Available_dbms.db_manager_list.i_th (code)
		ensure
			exists: Result /= Void
		end

	db_display_name (code: INTEGER): STRING is
			-- DBMS display name.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := Available_dbms.db_display_name_list.i_th (code)
		ensure
			exists: Result /= Void
		end

	handle_name (code: INTEGER): STRING is
			-- DBMS handle name.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := db_manager (code).database_handle_name
		ensure
			exists: Result /= Void
		end

	Available_dbms: AVAILABLE_DBMS is
			-- Available DBMS information.
		once
			create Result
		ensure
			exists: Result /= Void
		end

end -- class WIZARD_PROJECT_SHARED
