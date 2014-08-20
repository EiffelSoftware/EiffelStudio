note
	description: "Summary description for {ESA_ABSTRACT_DATABASE_TEST}."
	date: "$Date$"
	revision: "$Revision$"
	testing:"execution/serial"

class
	ESA_ABSTRACT_DATABASE_TEST

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
		local
			l_rest: ESA_RESET_DB
			l_list: ARRAYED_LIST[READABLE_STRING_GENERAL]
			l_old_dir : STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_old_dir := l_env.current_working_directory
		    l_env.change_working_directory (current_dir)
			create l_rest
			create l_list.make_from_array (<<{ESA_DATABASE_TEST_CONFIG}.server_name,{ESA_DATABASE_TEST_CONFIG}.database_name, {ESA_DATABASE_TEST_CONFIG}.schema>>)
			l_rest.reset_db (l_list, False, Void)
			assert ("not_has_error", not l_rest.has_error)
			l_env.change_working_directory (l_old_dir)

				--
			create {DATABASE_CONNECTION_ODBC} connection.login_with_connection_string ("Driver={SQL Server Native Client 11.0};Server=" + {ESA_DATABASE_TEST_CONFIG}.server_name + ";Database=" + {ESA_DATABASE_TEST_CONFIG}.database_name + ";Trusted_Connection=Yes;")
		end


feature -- Helper queries


	row_count (a_query:READABLE_STRING_32; a_parameters: STRING_TABLE[STRING] ): INTEGER
				-- Number of rows for the given query `a_query' using parameters `a_parameters'
		do
			connection.connect
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (a_query, a_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end
			connection.disconnect
		end

	exist (a_query:READABLE_STRING_32; a_parameters: STRING_TABLE[STRING] ): BOOLEAN
			-- Exist a row for the given query `a_query' using parameters `a_parameters'
		do
			Result := row_count (a_query, a_parameters) = 1
		end

feature -- Database Providers

	database_provider: REPORT_DATA_PROVIDER
		do
			create Result.make (connection)
		end

	login_provider: LOGIN_DATA_PROVIDER
		do
			create Result.make (connection)
		end

feature -- Database Hanlder

	db_handler: DATABASE_HANDLER
			-- Db handler
		once
			create {DATABASE_HANDLER_IMPL} Result.make (connection)
		end

feature -- Security Provider

	security: SECURITY_PROVIDER
		do
			create Result
		end

feature -- Configuration

	connection: DATABASE_CONNECTION
			-- Database connection

feature -- Script directory

	current_dir: STRING
		local
			l_path: PATH
			l_env: EXECUTION_ENVIRONMENT
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("database")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("mssql")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
		end
end
