note
	description: "Object that handle a database connection for ODBC"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONNECTION_MYSQL

inherit

	DATABASE_CONNECTION
		redefine
			db_application
		end

create
	login, login_with_default, login_with_database_name, login_with_connection_string, login_with_schema

feature -- Initialization

	login_with_default
			-- Create a database handler for MYSQL with common settings.
		do
			login_with_database_name (default_database_name)
		end

	login_with_database_name (a_database_name: STRING)
			-- Create a database handler and
			-- set database_name to `a_database_name'.
		do
			login (default_username, default_password, default_hostname, a_database_name, is_keep_connection)
		end

	login (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler for ODBC and set `username' to `a_username',
			-- `password' to `a_password'
			-- `database_name' to `a_database_name'
			-- `connection' to `a_connection'
		do
			create database_error_handler.make
			create db_application.login (a_username, a_password)
			db_application.set_hostname (a_hostname)
			db_application.set_data_source (a_database_name)
			db_application.set_base
			create db_control.make
			keep_connection := connection
			if keep_connection then
				connect
			end
		end

	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string' and immediately connect to database.
		local
			l_server: STRING
			l_port: STRING
			l_database: STRING
			l_user: STRING
			l_password: STRING
		do
			create database_error_handler.make
			l_server := connection_string_item (a_string, "Server", default_hostname)
			l_database := connection_string_item (a_string, "Database", default_database_name)
			l_port := connection_string_item (a_string, "Port", "3306")
			l_user := connection_string_item (a_string, "Uid", default_username)
			l_password := connection_string_item (a_string, "Pwd", default_password)

			create db_application
			db_application.set_application (l_database)
			db_application.set_hostname (l_server + ":" + l_port)
			db_application.login_and_connect (l_user, l_password)
			db_application.set_base
			create db_control.make
			keep_connection := is_keep_connection
		end

	connection_string_item (a_connection_string: STRING; k: STRING; dft: STRING): STRING
		local
			i,j: INTEGER
		do
			i := a_connection_string.substring_index (k + "=", 1)
			if i = 0 then
				i := a_connection_string.substring_index (k.as_lower + "=", 1)
			end
			if i > 0 then
				i := i + k.count + 1
				j := a_connection_string.index_of (';', i)
				if j = 0 then
					j := a_connection_string.count + 1
				end
				Result := a_connection_string.substring (i, j - 1)
			else
				Result := dft
			end
		end

	login_with_schema (a_schema: STRING; a_username: STRING; a_password: STRING)
			-- Login with `a_connection_string'and immediately connect to database.
		do
			create database_error_handler.make
			create db_application
			db_application.set_application (a_schema)
			db_application.login_and_connect (a_username, a_password)
			db_application.set_base
			create db_control.make
			keep_connection := is_keep_connection
		end

feature -- Database Connection

	db_application: DATABASE_APPL [MYSQL]
			-- Database application.

end
