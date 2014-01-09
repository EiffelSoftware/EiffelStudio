note
	description: "A factory class for creating a MySQL repository."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Default settings

	default_host: STRING = "127.0.0.1"

	default_port: INTEGER = 3306

feature -- Access

	user: detachable STRING
			-- The database login name.
		note
			option: stable
		attribute
		end

	password: detachable STRING
			-- The database login password.
		note
			option: stable
		attribute
		end

	database: detachable STRING
			-- The name of the database.
		note
			option: stable
		attribute
		end

	host: detachable STRING
			-- The host on which the database is running.
		note
			option: stable
		attribute
		end

	port: INTEGER
			-- The port number.

feature -- Status report

	is_buildable: BOOLEAN
			-- Does `Current' have enough information to build a repository?
		do
			Result := attached user and attached password and attached database
		end

feature -- Element change

	set_user (value: STRING)
			-- Set `user' to `value'.
		require
			not_empty: not value.is_empty
		do
			user := value
		ensure
			user_set: user ~ value
		end

	set_password (value: STRING)
			-- Set `password' to `value'.
		require
			not_empty: not value.is_empty
		do
			password := value
		ensure
			password_set: password ~ value
		end

	set_database (value: STRING)
			-- Set `database' to `value'.
		require
			not_empty: not value.is_empty
		do
			database := value
		ensure
			database_set: database ~ value
		end

	set_host (value: STRING)
			-- Set `host' to `value'.
		require
			not_empty: not value.is_empty
		do
			host := value
		ensure
			host_set: host ~ value
		end

	set_port (value: INTEGER)
			-- Set `port' to `value'.
		require
			positve: value > 0
		do
			port := value
		ensure
			port_set: port = value
		end

feature {NONE} -- Implementation

	new_internal_database: PS_MYSQL_DATABASE
			-- Create a MySQL database connection.
		local
			l_host: STRING
			l_port: INTEGER
		do
			if attached host as h then
				l_host := h
			else
				l_host := default_host
			end

			if port > 0 then
				l_port := port
			else
				l_port := default_port
			end

			check
				attached user as l_user
				and attached password as l_password
				and attached database as l_database
			then
				create Result.make (l_user, l_password, l_database, l_host, l_port)
			end
		end


	new_connector: PS_REPOSITORY_CONNECTOR
			-- <Precursor>
		local
			strings: PS_MYSQL_STRINGS
		do
			create strings
			create {PS_MYSQL_BACKEND} Result.make (new_internal_database, strings)
		end

end
