note
	description: "Object that handle a database connection for ODBC"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_CONNECTION_ODBC

inherit

	ESA_DATABASE_CONNECTION
		redefine
			db_application
		end

create
	make, make_common

feature -- Initialization

	make_common
			-- Create a database handler for ODBC with common settings
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
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end

	make (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler for ODBC
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

feature -- Databse Connection

	db_application: DATABASE_APPL [ODBC]
			-- Database application




end
