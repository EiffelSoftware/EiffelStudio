note
	description: "Factory class for DATABASE_LOGGER objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_LOGGER_FACTORY

inherit

	CP_WORKER_FACTORY [STRING, CP_STRING_IMPORTER]

create make

feature {NONE} -- Initialization

	make (user, pass, a_host, name: separate STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		do
			create username.make_from_separate (user)
			create password.make_from_separate (pass)
			create host.make_from_separate (a_host)
			create database_name.make_from_separate (name)
			port := a_port
		end

feature -- Login data

	username: STRING

	password: STRING

	host: STRING

	database_name: STRING

	port: INTEGER

feature -- Factory functions

	new_worker (a_pool: separate CP_WORKER_POOL [STRING, CP_STRING_IMPORTER]): separate DATABASE_LOGGER
			-- Create a new worker belonging to `a_pool'.
		do
				-- Somehow lock passing of `a_pool' doesn't work.
				-- This is not a problem for {DATABASE_LOGGER}.make because `a_pool' is
				-- only used on the right-hand side of an assignment and thus never really locked
				-- (the "lazy locking" semantics in EiffelStudio guarantees this).

				-- However, when calling {DATABASE_LOGGER}.make_with_database, it will use
				-- the `factory' argument and, due to the semantics of SCOOP, it will also lock
				-- `a_pool' which results in a deadlock.

				-- Therefore it is necessary to split the two initialization functions.

			create Result.make (a_pool)
			logger_initialize_database (Result)
--			create Result.make_with_database (a_pool, Current)
		end

feature {NONE} -- Implementation

	logger_initialize_database (logger: separate DATABASE_LOGGER)
			-- Initialize the database in `logger'.
		do
			logger.initialize_database (Current)
		end

end
