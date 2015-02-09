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
	make, make_common, make_basic, login_with_connection_string, login_with_schema

feature -- Initialization

	make_common
			-- Create a database handler for MYSQL with common settings.
		local
			l_retried: BOOLEAN
		do
			create database_error_handler.make
			create db_application.login (username, password)

			if not l_retried then
				db_application.set_hostname (hostname)
				db_application.set_data_source (database_name)
				db_application.set_base
				create db_control.make
				keep_connection := is_keep_connection
				if keep_connection then
					connect
				end
			else
				create db_control.make
			end
		rescue
			create database_error_handler.make
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			l_retried := True
			retry
		end

	make_basic (a_database_name: STRING)
			-- Create a database handler and
			-- set database_name to `a_database_name'.
		local
			l_retried: BOOLEAN
		do
			create database_error_handler.make
			create db_application.login (username, password)

			if not l_retried then
				db_application.set_hostname (hostname)
				db_application.set_data_source (a_database_name)
				db_application.set_base
				create db_control.make
				keep_connection := is_keep_connection
				if keep_connection then
					connect
				end
			else
				create db_control.make
			end
		rescue
			create database_error_handler.make
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			l_retried := True
			retry
		end

	make (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

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
			-- Login with `a_connection_string'and immediately connect to database.
		local
			l_string: LIST[STRING]
			l_server: STRING
			l_port: STRING
			l_schema: STRING
			l_user: STRING
			l_password: STRING
		do
			create database_error_handler.make

			l_string := a_string.split (';')
			l_server := l_string.at (2).split ('=').at (2)
			l_port := l_string.at (3).split ('=').at (2)
			l_schema := l_string.at (4).split ('=').at (2)
			l_user := l_string.at (5).split ('=').at (2)
			l_password := l_string.at (6).split ('=').at (2)

			create db_application
			db_application.set_application (l_schema)
			db_application.set_hostname (l_server + ":" + l_port)
			db_application.login_and_connect (l_user, l_password)
			db_application.set_base
			create db_control.make
			keep_connection := is_keep_connection
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

feature -- Databse Connection

	db_application: DATABASE_APPL [MYSQL]
			-- Database application.

end
