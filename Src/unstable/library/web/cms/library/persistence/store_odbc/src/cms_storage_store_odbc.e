note
	description: "Summary description for {CMS_STORAGE_STORE_ODBC}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_STORE_ODBC

inherit
	CMS_STORAGE_STORE_SQL
		redefine
			make
		end

	CMS_CORE_STORAGE_SQL_I

	CMS_USER_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make,
	make_with_driver

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- <Precursor>
		do
			Precursor (a_connection)
			create odbc_driver.make_from_string_general ("odbc")
		end

	make_with_driver (a_connection: DATABASE_CONNECTION; a_driver: detachable READABLE_STRING_GENERAL)
		require
			is_connected: a_connection.is_connected
		do
			make (a_connection)
			if a_driver /= Void then
				create odbc_driver.make_from_string_general (a_driver)
			end
		end

feature -- Status report

	odbc_driver: IMMUTABLE_STRING_32
			-- Database's driver name.
			--  sqlite, mysql, ...

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := has_user
		end

feature -- Conversion

	sql_statement (a_statement: STRING): STRING
			-- <Precursor>.
		local
			i: INTEGER
		do
			Result := a_statement
			if odbc_driver.same_caseless_characters_general ("sqlite3", 1, 5, 1) then
				from
					i := 1
				until
					i = 0
				loop
					i := a_statement.substring_index ("AUTO_INCREMENT", i)
					if i > 0 then
						if Result = a_statement then
							create Result.make_from_string (a_statement)
						end
						Result.remove (i + 4)
						i := i + 14
					end
				end
			end
		end

end
