note
	description: "Summary description for {TEST_DATABASE}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DATABASE

feature -- Object Factory

	mysql_connection: DATABASE_CONNECTION
		once
			create {DATABASE_CONNECTION_MYSQL} Result.login_with_connection_string (connection_string_mysql_server)
			check Result.is_connected end
		end

	odbc_connection: DATABASE_CONNECTION
		once
			create {DATABASE_CONNECTION_ODBC} Result.login_with_connection_string (connection_string_sql_server)
			check Result.is_connected end
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
				a_parameters.put (a_user.userid, "userid")
			end
			a_parameters.put (a_user.email, "email")
			create Result.data_reader (SQL_update_user,a_parameters)
		end

	update_user_with_params (a_name: detachable STRING; a_datetime: detachable STRING; a_email: detachable STRING; a_username:STRING): DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put (a_name, "name")
			a_parameters.put (a_datetime, "datetime")
			a_parameters.put (a_username, "username")
			a_parameters.put (a_email, "email")
			create Result.data_reader (SQL_update_user,a_parameters)
		end

feature  -- SQL helpers

	query_user_by_username (a_name: STRING): DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (1)
			a_parameters.put (a_name, "username")
			create Result.data_reader (SQL_query_by_username,a_parameters)
		end

	query_count_users: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (0)
			create Result.data_reader (SQL_query_count_users,a_parameters)
		end

	query_delete_users: DATABASE_QUERY
		local
			a_parameters: STRING_TABLE [detachable ANY]
		do
			create a_parameters.make (0)
			create Result.data_reader (sql_delete_user,a_parameters)
		end

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

	SQL_insert_user: STRING = "INSERT INTO new_users (name, username, email, datetime, userid ) VALUES (:name, :username, :email, :datetime, :userid)"

	SQL_update_user: STRING = "UPDATE new_users SET name = :name, datetime = :datetime, email = :email WHERE username =:username"

	SQL_query_user_by_datetime_null: STRING = "SELECT * FROM new_users where datetime = :datetime"

	SQL_query_new_users: STRING = "SELECT * FROM new_users"

	SQL_delete_user: STRING = "DELETE FROM new_users"

	SQL_query_count_users: STRING = "SELECT count(*) FROM new_users"

	SQL_query_by_username: STRING = "SELECT name, username, email, datetime, userid FROM new_users where username =:username"

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
		-- "Driver={SQL Server};Server=$SERVER;Database=$DATABASE;Uid=$USER;Pwd=$PASSWORD;TrustedConnection=Yes"

	connection_string_mysql_server:STRING = "Driver={mysql};Server=$SERVER;Port=$PORT;Database=$DATABASE;Uid=$USER;Pwd=$PASSWORD;"
		-- MySQL server: Update the string with your Database settings.
		-- example:"Driver={mysql};Server=localhost;Port=3306;Database=test;Uid=root;Pwd=;"
		-- "Driver={mysql};Server=$SERVER;Port=$PORT;Database=$DATABASE;Uid=$USER;Pwd=$PASSWORD;"
end
