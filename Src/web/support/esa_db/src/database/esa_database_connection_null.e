note
	description: "Summary description for {ESA_DATABASE_CONNECTION_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_CONNECTION_NULL

inherit

	ESA_DATABASE_CONNECTION
		redefine
			db_application,
			is_connected
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
			db_application.set_hostname (hostname)
			db_application.set_data_source (database_name)
			db_application.set_base
			create db_control.make
		end

	make (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler for ODBC
		do
			make_common
		end


feature -- Databse Connection

	db_application: DATABASE_APPL[ESA_NULL_DATABASE]
			-- Database application


	is_connected: BOOLEAN
			-- True if connected to the database
		do
			Result := True
		end


end
