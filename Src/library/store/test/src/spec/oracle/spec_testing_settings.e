note
	description : "Objects that ..."
	author      : "$Author: tedf $"
	date        : "$Date: 2014-01-16 02:35:27 +0100 (Thu, 16 Jan 2014) $"
	revision    : "$Revision: 94023 $"

class
	SPEC_TESTING_SETTINGS

inherit
	TESTING_SETTINGS

feature -- Storage

	host: STRING
		once
			if attached json_configuration.item ("database.oracle.host") as l_host and then not l_host.is_empty then
				Result := l_host
			else
				Result := "localhost"
			end
		end

	database_name: STRING
		once
			if attached json_configuration.item ("database.oracle.name") as l_host and then not l_host.is_empty then
				Result := l_host
			else
				Result := "test"
			end
		end

	user_login: STRING
		once
			if attached json_configuration.item ("database.oracle.administrative_user") as l_user and then not l_user.is_empty then
				Result := l_user
			else
				Result := "root"
			end
		end

	user_password: STRING
		once
			if attached json_configuration.item ("database.oracle.administrative_user_passwd") as l_p and then not l_p.is_empty then
				Result := l_p
			else
				Result := ""
			end
		end

feature -- Query

	is_mysql: BOOLEAN = False
	is_odbc: BOOLEAN = False
	is_oracle: BOOLEAN = True
	is_sybase: BOOLEAN = False

end
