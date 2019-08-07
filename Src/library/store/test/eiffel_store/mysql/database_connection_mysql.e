note
	description: "Summary description for {DATABASE_CONNECTION_MYSQL}."
	author: ""
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
	login_with_connection_string

feature -- Initialization


	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'and immediately connect to database.
		local
			l_server: STRING
			l_port: STRING
			l_database: STRING
			l_user: STRING
			l_password: STRING
		do
			io.put_string (generator +".login_with_connection_string")
			io.put_new_line
			l_server := connection_string_item (a_string, "Server", default_hostname)
			l_database := connection_string_item (a_string, "Database", default_database_name)
			l_port := connection_string_item (a_string, "Port", "3306")
			l_user := connection_string_item (a_string, "Uid", default_username)
			l_password := connection_string_item (a_string, "Pwd", default_password)

			create db_application
			db_application.set_application (l_database)
			db_application.set_hostname (l_server + ":" + l_port)
			db_application.login_and_connect (l_user, l_password)
			db_application.set_data_source (l_database)
			db_application.set_base
			create db_control.make
			keep_connection := is_keep_connection
			set_use_extended_types (True)
		end


feature {NONE} -- Implementaion

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

feature -- Databse Connection

	db_application: DATABASE_APPL [MYSQL]
			-- Database application.

end
