indexing
	description: "Project Shared variables"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_WIZARD_SHARED

feature -- Access

	odbc: STRING is "odbc"

	oracle: STRING is "oracle"

	db_manager: DATABASE_MANAGER[DATABASE] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
		do
			if database_type.is_equal(odbc) then
--				Result := db_manager_odbc 
				Result := db_manager_oracle
			elseif database_type.is_equal(oracle) then
				Result := db_manager_oracle
--				Result := db_manager_odbc
			end	
		ensure
			exists: Result /= Void
		end

	is_oracle: BOOLEAN is
		do
			Result := (database_type.is_equal(oracle))
		end

	is_odbc: BOOLEAN is
		do
			Result := (database_type.is_equal(odbc))
		end

feature -- Settings

	set_database(s: STRING) is
		require
			supported: s /= Void and then (s.is_equal(odbc) or s.is_equal(oracle))
		do
			database_type.wipe_out
			database_type.append(s)
		end

feature {NONE} -- Implementation

	database_type: STRING is
			-- Database type.
		once
			Create Result.make(10)
			Result.append(odbc)
		end
		
	db_manager_oracle: DATABASE_MANAGER[ORACLE] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
		once
			Create Result
		ensure
			exists: Result /= Void
		end

--	db_manager_odbc: DATABASE_MANAGER[ODBC] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
--		once
--			Create Result
--		ensure
--			exists: Result /= Void
--		end

end -- class PROJECT_WIZARD_SHARED
