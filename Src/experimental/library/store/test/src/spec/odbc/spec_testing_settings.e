note
	description : "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SPEC_TESTING_SETTINGS

inherit
	TESTING_SETTINGS
		redefine
			is_trusted
		end

feature -- Storage

	host: STRING
		once
			if attached json_configuration.item ("database.odbc.host") as l_host and then not l_host.is_empty then
				Result := l_host
			else
				Result := "localhost"
			end
		end

	database_name: STRING
		once
			if attached json_configuration.item ("database.odbc.name") as l_host and then not l_host.is_empty then
				Result := l_host
			else
				Result := "test"
			end
		end

	user_login: STRING
		once
			if attached json_configuration.item ("database.odbc.administrative_user") as l_user and then not l_user.is_empty then
				Result := l_user
			else
				Result := "root"
			end
		end

	user_password: STRING
		once
			if attached json_configuration.item ("database.odbc.administrative_user_passwd") as l_p and then not l_p.is_empty then
				Result := l_p
			else
				Result := ""
			end
		end

	is_trusted: BOOLEAN
			-- Is connection structed?
		once
			if attached json_configuration.item ("database.odbc.trusted") as l_p and then l_p.is_boolean then
				Result := l_p.to_boolean
			end
		end

feature -- Query

	is_mysql: BOOLEAN = False
	is_odbc: BOOLEAN = True
	is_oracle: BOOLEAN = False
	is_sybase: BOOLEAN = False

end
