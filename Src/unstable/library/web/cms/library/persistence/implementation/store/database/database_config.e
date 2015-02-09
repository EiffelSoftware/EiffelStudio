note
	description: "Database configuration"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_CONFIG

feature -- Database access

	hostname: STRING = ""
			-- Database hostname.

	username: STRING = ""
			-- Database username.

	password: STRING = ""
			-- Database password.

	database_name: STRING = "EiffelDB"
			-- Database name.

	is_keep_connection: BOOLEAN
			-- Keep Connection to database?
		do
			Result := True
		end

end
