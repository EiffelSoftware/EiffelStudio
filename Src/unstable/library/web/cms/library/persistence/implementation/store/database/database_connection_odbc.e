note
	description: "Object that handle a database connection for ODBC"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONNECTION_ODBC

inherit

	DATABASE_CONNECTION
		redefine
			db_application
		end

	SHARED_LOGGER

create
	make, make_common, make_basic, login_with_connection_string

feature -- Initialization

	make_common
			-- Create a database handler for ODBC with common settings.
		local
			l_retried: BOOLEAN
		do
			create db_application.login (username, password)
			create database_error_handler.make
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
			create db_control.make
--			set_last_error_from_exception ("Connection execution")
--			write_critical_log (generator + ".make_common:" + last_error_message)
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end

	make_basic (a_database_name: STRING)
			-- Create a database handler and
			-- set database_name to `a_database_name'.
		local
			l_retried: BOOLEAN
		do
			create db_application.login (username, password)
			create database_error_handler.make
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
			create db_control.make
--			set_last_error_from_exception ("Connection execution")
--			write_critical_log (generator + ".make_common:" + last_error_message)
			if is_connected then
				disconnect
			end
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
		do
			write_debug_log (generator +".login_with_connection_string")
			create db_application.login_with_connection_string (a_string)
			create database_error_handler.make
			db_application.set_base
			create db_control.make
			write_debug_log (generator +".login_with_connection_string, is_keep_connection? "+ is_keep_connection.out )
			keep_connection := is_keep_connection
			if keep_connection then
				connect
				if not db_control.is_ok then
					write_critical_log (generator +".login_with_connection_string:"+ db_control.error_code.out )
					write_critical_log (generator +".login_with_connection_string:"+ db_control.error_message_32 )
				end
				write_debug_log (generator +".login_with_connection_string, After connect, is_connected? "+ is_connected.out)
			end
		end

feature -- Databse Connection

	db_application: DATABASE_APPL [ODBC]
			-- Database application.

end
