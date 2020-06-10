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
	GLOBAL_SETTINGS

create
	make, make_common, make_basic, login_with_connection_string

feature {NONE} -- Initialization

	make_common
			-- Create a database handler for ODBC with common settings.
		local
			l_retried: BOOLEAN
		do
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
				set_successful
			else
				create db_control.make
			end
		rescue
			create db_control.make
			set_last_error_from_exception ("Connection execution")
			log.write_critical (generator + ".make_common:" + last_error_message.to_string_8)
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

			if not l_retried then
				db_application.set_hostname (hostname)
				db_application.set_data_source (a_database_name)
				db_application.set_base
				create db_control.make
				keep_connection := is_keep_connection
				if keep_connection then
					connect
				end
				set_successful
			else
				create db_control.make
			end
		rescue
			create db_control.make
			set_last_error_from_exception ("Connection execution")
			log.write_critical (generator + ".make_common:" + last_error_message.to_string_8)
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
			debug
				log.write_debug (generator +".login_with_connection_string")
			end
			create db_application.login_with_connection_string (a_string)
			db_application.set_base
			create db_control.make
			debug
				log.write_debug (generator +".login_with_connection_string, is_keep_connection? "+ is_keep_connection.out )
			end
			keep_connection := is_keep_connection
			if keep_connection then
				connect
				if not db_control.is_ok then
					log.write_critical (generator +".login_with_connection_string:"+ db_control.error_code.out )
					log.write_critical (generator +".login_with_connection_string:"+ db_control.error_message_32.to_string_8 )
				end
				log.write_debug (generator +".login_with_connection_string, After connect, is_connected? "+ is_connected.out)
			end
			set_use_extended_types (True)
		end

feature -- Databse Connection

	db_application: DATABASE_APPL [ODBC]
			-- Database application.

end
