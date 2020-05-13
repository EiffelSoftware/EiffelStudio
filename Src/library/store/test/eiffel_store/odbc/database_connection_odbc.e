note
	description: "Summary description for {DATABASE_CONNECTION_ODBC}."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONNECTION_ODBC

inherit
	DATABASE_CONNECTION
		redefine
			db_application
		end

create
	login_with_connection_string

feature {NONE} -- Initialization

	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'and immediately connect to database.
		do
			io.put_string (generator +".login_with_connection_string")
			io.put_new_line
			create db_application.login_with_connection_string (a_string)
			db_application.set_base
			create db_control.make
			io.put_string (generator +".login_with_connection_string, is_keep_connection? "+ is_keep_connection.out )
			io.put_new_line
			keep_connection := is_keep_connection
			if keep_connection then
				connect
				if not db_control.is_ok then
					io.put_string (generator +".login_with_connection_string:"+ db_control.error_code.out )
					io.put_new_line
					io.put_string (generator +".login_with_connection_string:")
					io.put_string_32 (db_control.error_message_32 )
					io.put_new_line
				end
				io.put_string (generator +".login_with_connection_string, After connect, is_connected? "+ is_connected.out)
				io.put_new_line
			end
			set_use_extended_types (True)
		end


feature -- Databse Connection

	db_application: DATABASE_APPL [ODBC]
			-- Database application.
end

