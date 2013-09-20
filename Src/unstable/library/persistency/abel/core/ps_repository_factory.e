note
	description: "[
	A factory class to create repositories with a database backend.
	Use this class as an entry point to the framework to get a repository object
	and then use it to create an executor.
	]"
	author: "Roman Schmocker, Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_REPOSITORY_FACTORY

feature -- Factory methods

--	create_mysql_repository (username, password, db_name, db_host: STRING; db_port: INTEGER): PS_RELATIONAL_REPOSITORY
--		-- Create a MySQL repository providing all the necessary information.
--		require
--			username_not_empty: not username.is_empty
--			db_name_not_empty: not db_name.is_empty
--			db_host_not_empty: not db_host.is_empty
--			db_port_legal: db_port > 1024 and db_port < 65535
--		local
--			database: PS_MYSQL_DATABASE
--			mysql_strings: PS_MYSQL_STRINGS
--			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
--		do
--			create database.make (username, password, db_name, db_host, db_port)
--			create mysql_strings
--			create backend.make (database, mysql_strings)
--			create Result.make (backend)
--		end

--	create_mysql_repository_with_default_host_port (username, password, db_name: STRING): PS_RELATIONAL_REPOSITORY
--		-- Create a MySQL repository relying on the default host 127.0.0.1 and port 3306.
--		require
--			username_not_empty: not username.is_empty
--			db_name_not_empty: not db_name.is_empty
--		local
--			database: PS_MYSQL_DATABASE
--			mysql_strings: PS_MYSQL_STRINGS
--			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
--		do
--			create database.make (username, password, db_name, "127.0.0.1", 3306)
--			create mysql_strings
--			create backend.make (database, mysql_strings)
--			create Result.make (backend)
--		end

--	create_sqlite_repository (db_file_name: STRING): PS_RELATIONAL_REPOSITORY
--		-- Create an SQLite repository named `db_file_name'.
--		-- If passing an empty string, then a private, temporary on-disk database is created.
--		local
--			database: PS_SQLITE_DATABASE
--			sqlite_strings: PS_SQLITE_STRINGS
--			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
--		do
--			create database.make (db_file_name)
--			create sqlite_strings
--			create backend.make (database, sqlite_strings)
--			create Result.make (backend)
--		end

	create_in_memory_repository: PS_RELATIONAL_REPOSITORY
		-- Create an in-memory repository that can be queried in a relational style.
		local
			repository: PS_IN_MEMORY_REPOSITORY
		do
			create repository.make_empty
			Result := repository
		end

--	create_cdb_repository(host:STRING; port:INTEGER): PS_RELATIONAL_REPOSITORY
--		-- Create a CouchDB repository
--		local
--			repository: CDB_REPOSITORY
--		do
--			if host.is_empty or port=0 then
--				create repository.make_empty
--			else
--				create repository.make_with_host_and_port(host, port)
--			end
--			Result := repository
--		end
end
