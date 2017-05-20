note
	description: "Summary description for {DATABASE_CONNECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_CONNECTION

inherit

	DATABASE_CONFIG

	GLOBAL_SETTINGS


feature {NONE} -- Initialization

	login_with_connection_string (a_string: STRING)
			-- Login with `a_connection_string'and immediately connect to database.
		deferred
		end

feature -- Databse Connection

	db_application: DATABASE_APPL [DATABASE]
			-- Database application.

	db_control: DB_CONTROL
			-- Database control.

	keep_connection: BOOLEAN
			-- Keep connection alive?

feature -- Conection

	connect
			-- Connect to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database.
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

end
