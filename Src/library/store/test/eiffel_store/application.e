note
	description: "Main class, to test null values, sql injection, store procedures and DB_PROC.store."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			-- TODO extract configuration to a JSON file.
			-- Verify the results.
--			test_repository_store
--			test_not_null_sql_server
--			test_not_null_mysql_server
--			test_insert_null_mysql
--			test_insert_update_null_mysql
--			test_select_user_by_datetime_null
--			test_sql_injection_1
--			test_sql_injection_2
--			test_sql_injection_3
--			test_sql_injection_4
--			test_sql_injection_5
--			test_sql_injection_6
--			unsafe_query
--			safe_query
		end


feature -- Encoding

	string: STRING_32 = "'this data needs to be escaped: ] '"
	string2: STRING_32 = "'this data needs ' to be escaped: ] '"

	encode (a_string: READABLE_STRING_GENERAL): READABLE_STRING_32
			-- Escape single quote (') and braces ([,]).
		local
			l_string: STRING_32
		do
			create l_string.make_from_string_general (a_string)
			if not l_string.is_empty then
				l_string.replace_substring_all ({STRING_32} "[", {STRING_32} "[[")
				l_string.replace_substring_all ({STRING_32} "]", {STRING_32} "]]")
				if l_string.index_of ('%'', 1) > 0 then
					l_string.replace_substring ({STRING_32} "[", l_string.index_of ('%'', 1), l_string.index_of ('%'', 1))
				end
				if l_string.last_index_of ('%'', l_string.count) > 0 then
					l_string.replace_substring ({STRING_32} "]", l_string.last_index_of ('%'', l_string.count), l_string.count)
				end
			end
			Result := l_string
		end

feature -- Repository Store

	test_repository_store
		local
			l_connection: DATABASE_CONNECTION
			l_executor: DATABASE_EXECUTOR
			l_user1: NEW_USERS
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_executor.make (l_connection)
				-- User 1
			create l_user1.make
			l_user1.set_name ("mike")
			l_executor.create_item (l_user1)
		end

feature -- SQL safe and unsafe queries

	unsafe_query
		local
			l_connection: DATABASE_CONNECTION
			db_selection: DB_SELECTION
			l_query: STRING
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_query.make_from_string (SQL_query_user_by_datetime_null)
			l_query.replace_substring_all (":datetime", "\''; DROP TABLE new_users; --" )
			create db_selection.make
			db_selection.set_query (l_query)
			db_selection.execute_query
		end


	safe_query
		local
			l_connection: DATABASE_CONNECTION
			db_selection: DB_SELECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			create db_selection.make
			db_selection.set_query (SQL_query_user_by_datetime_null)
			db_selection.set_map_name ("\''; DROP TABLE new_users; --", ":datetime")
			db_selection.execute_query
			db_selection.unset_map_name (":datetime")
		end


feature -- SQL injection

	test_sql_injection_1
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_1)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end

	test_sql_injection_2
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_2)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end

	test_sql_injection_3
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_3)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end

	test_sql_injection_4
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_4)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end

	test_sql_injection_5
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_5)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end

	test_sql_injection_6
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_sql_injection_6)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end


feature -- Test SQL statements and store procedures with Null parameters.

	test_insert_update_null_mysql
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
			l_user: NEW_USERS
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			create l_user.make
			l_user.set_username ("jim")
			l_handler.set_query (new_user (l_user))
			l_handler.execute_change
			l_user.set_name ("pedro")
			l_handler.set_query (update_user (l_user))
			l_handler.execute_change
		end

	test_select_user_by_datetime_null_mysql
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_query (query_user_by_datetime_null)
			l_handler.execute_query
			if not l_handler.after then
				from
					l_handler.start
				until
					l_handler.after
				loop
					io.put_string (l_handler.item.out)
					l_handler.forth
				end
			end
		end


	test_insert_null_mysql
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
			l_user: NEW_USERS
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			create l_user.make
			l_user.set_username ("username")
			l_handler.set_query (new_user (l_user))
			l_handler.execute_change
		end


	test_not_null_mysql_server
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_MYSQL} l_connection.login_with_connection_string (connection_string_mysql_server)
			check l_connection.is_connected end
			create l_handler.make (l_connection)
			l_handler.set_store (store_example_mysql)
			l_handler.execute_reader
			if not l_handler.after then
				if attached l_handler.read_integer_32 (1) as l_item_name then
					io.put_new_line
					io.put_string ("Return value:")
					io.put_string (l_item_name.out)
					io.put_new_line
				end
			end
		end

	test_not_null_sql_server
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_ODBC} l_connection.login_with_connection_string (connection_string_sql_server)
			check l_connection.is_connected end
			new_store_sql_server
			create l_handler.make (l_connection)
			l_handler.set_store (store_example_sql_server)
			l_handler.execute_reader
			if not l_handler.after then
				if attached l_handler.read_integer_32 (1) as l_item_name then
					io.put_new_line
					io.put_string ("Return value:")
					io.put_string (l_item_name.out)
					io.put_new_line
				end
			end
		end

feature -- Store Helper

	store_example_sql_server: DATABASE_STORE_PROCEDURE
		local
			a_parameters: HASH_TABLE [detachable ANY, STRING_32]
		do
			create a_parameters.make (1)
			a_parameters.force (Void, "PARAM")
			create Result.data_reader ("StoreProcedure", a_parameters)
		end

	store_example_mysql: DATABASE_STORE_PROCEDURE
		local
			a_parameters: HASH_TABLE [detachable ANY, STRING_32]
		do
			create a_parameters.make (1)
			a_parameters.force (Void, "PARAM")
			create Result.data_reader ("new_store_2", a_parameters)
		end

	new_store_sql_server
		local
			l_db: DATABASE_STORE_PROCEDURE
			a_parameters: HASH_TABLE [detachable ANY, STRING_32]
		do
			create a_parameters.make (1)
			a_parameters.force (Void, "PARAM")
			create l_db.new_store_2 (store_name, stored_example)
		end

	new_store_mysql
		local
			l_db: DATABASE_STORE_PROCEDURE
		do
			create l_db.new_store_2 (store_name, stored_example)
		end

feature  -- Domain Users

	new_user (a_user: NEW_USERS): DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			if a_user.name.is_empty then
				a_parameters.put (Void, "name")
			else
				a_parameters.put (a_user.name, "name")
			end
			if a_user.username.is_empty then
				a_parameters.put (Void, "username")
			else
				a_parameters.put (a_user.username, "username")
			end
			if a_user.email.is_empty then
				a_parameters.put (Void, "email")
			else
				a_parameters.put (a_user.email, "email")
			end
			a_parameters.put (a_user.datetime, "datetime")
			if a_user.userid = 0 then
				a_parameters.put (Void, "userid")
			else
				a_parameters.put (a_user.userid, "email")
			end
			create Result.data_reader (SQL_insert_user,a_parameters)
		end

	update_user (a_user: NEW_USERS): DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put (a_user.name, "name")
			a_parameters.put (Void, "datetime")
			a_parameters.put (a_user.username, "username")
			if a_user.userid = 0 then
				a_parameters.put (Void, "userid")
			else
				a_parameters.put (a_user.userid, "email")
			end
			create Result.data_reader (SQL_update_user,a_parameters)
		end

feature  -- SQL helpers

	query_user_by_datetime_null: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put (Void, "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	query_user_sql_injection_1: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("x'; DROP TABLE new_users; --", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end


	query_user_sql_injection_2: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("\''; DROP TABLE new_users; --", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	query_user_sql_injection_3: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("anything' OR anything' OR 'x'='x", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	query_user_sql_injection_4: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("23 OR 1=1", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	query_user_sql_injection_5: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("x\'; DROP TABLE new_users; --\", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	query_user_sql_injection_6: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put ("xabd\n'; DROP TABLE new_users; --\", "datetime")
			create Result.data_reader (SQL_query_user_by_datetime_null,a_parameters)
		end

	SQL_insert_user: STRING = "INSERT INTO new_users (name, username, email, datetime, userid ) VALUES (:name, :username, :email, :datetime, :userid);"

	SQL_update_user: STRING = "UPDATE new_users SET name = :name, datetime = :datetime WHERE username =:username;"

	SQL_query_user_by_datetime_null: STRING = "SELECT * FROM new_users where datetime = :datetime"


	store_name: STRING = "new_store_2"

	stored_example: STRING = "[
		CREATE PROCEDURE new_store_2 
		(
		   IN param varchar(64)
		) 
		BEGIN
			IF (param IS NOT NULL) THEN 
				SELECT 1;
			ELSE
				SELECT 0;
		    END IF;   
		END;
	]"

feature -- Connection String


	connection_string_sql_server: STRING = "Driver={SQL Server};Server=$SERVER;Database=$DATABASE;Uid=$USER;Pwd=$PASSWORD;TrustedConnection=Yes"
		-- Sql Server storedb Update the string with your Database settings.
		-- Example:"Driver={SQL Server};Server=MssServer;Database=test;Uid=SA;Pwd=123456;TrustedConnection=Yes"

	connection_string_mysql_server:STRING = "Driver={mysql};Server=$SERVER;Port=$PORT;Database=$DATABASE;Uid=$USER;Pwd=$PASSWORD;"
		--		-- MySQL server: Update the string with your Database settings.
		-- example:"Driver={mysql};Server=localhost;Port=3306;Database=test;Uid=root;Pwd=;"

end
