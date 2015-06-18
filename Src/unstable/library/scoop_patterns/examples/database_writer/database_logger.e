note
	description: "A worker that receives log strings in SQL form and sends them to a database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_LOGGER

inherit
	CP_WORKER [STRING, CP_STRING_IMPORTER]
		redefine
			cleanup
		end

create
	make, make_with_database

feature -- Initialization

	make_with_database (a_pool: like pool; a_factory: separate DATABASE_LOGGER_FACTORY)
			-- Initialization for `Current'.
		do
			make (a_pool)
			initialize_database (a_factory)
		end

	initialize_database (factory: separate DATABASE_LOGGER_FACTORY)
			-- Initialize the database with values from `factory'.
		local
			l_user, l_password, l_host, l_name: STRING
			l_database: DUMMY_CONNECTION
		do
			create l_user.make_from_separate (factory.username)
			create l_password.make_from_separate (factory.password)
			create l_host.make_from_separate (factory.host)
			create l_name.make_from_separate (factory.database_name)

			create l_database.make (l_user, l_password, l_host, l_name, factory.port)
			l_database.connect
			database := l_database
		end


feature -- Basic operations

	do_work (sql: STRING)
			-- Send `sql' to the database.
		local
			retried: BOOLEAN
		do
			if not retried and attached database as l_database then
				l_database.execute (sql)
			end
		rescue
				-- Print an error to the console if database logging fails.
			io.error.put_string ("Unable to log: " + sql + "%N")
			retried := True
			retry
		end

	cleanup
			-- <Precursor>
		do
			if attached database as l_database then
				l_database.close
			end
		end

feature {NONE} -- Implementation

	database: detachable DUMMY_CONNECTION
			-- A dummy database connection.

end
