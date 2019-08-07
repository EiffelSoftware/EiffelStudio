note
	description: "Summary description for {DATABASE_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_CONFIG

feature -- Database access

	default_hostname: STRING = ""
			-- Database hostname.

	default_username: STRING = ""
			-- Database username.

	default_password: STRING = ""
			-- Database password.

	default_database_name: STRING = "EiffelDB"
			-- Database name.

	is_keep_connection: BOOLEAN
			-- Keep Connection to database?
		do
			Result := True
		end

end
