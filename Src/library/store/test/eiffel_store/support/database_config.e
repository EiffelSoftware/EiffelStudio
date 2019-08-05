note
	description: "Summary description for {DATABASE_CONFIG}."
	author: ""
	date: "$Date: 2017-02-01 15:21:00 +0100 (Wed, 01 Feb 2017) $"
	revision: "$Revision: 99782 $"

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
