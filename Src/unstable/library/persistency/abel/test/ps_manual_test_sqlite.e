note
	description: "Tests for the SQLite repository."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_SQLITE

inherit

	PS_REPOSITORY_TESTS
		redefine
			on_clean
		end

feature -- Tests

	sqlite_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	sqlite_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	sqlite_references
		do
			crud_tests.all_references_tests
		end

feature {NONE} -- Initialization

	make_repository: PS_REPOSITORY_COMPATIBILITY
			-- Create the repository for this test
		local
			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
		do
			create database.make (sqlite_file)
			create backend.make (database, create {PS_SQLITE_STRINGS})
			backend.wipe_out
			create Result.make (backend)
		end

	sqlite_file: STRING = "/home/roman/sqlite_database.db"
			-- The SQLite database file

	--sqlite_file: STRING = "/Users/marcopiccioni/sqlite_database.db"
			-- The SQLite database file

	database: PS_SQLITE_DATABASE
			-- The actual database

	on_clean
			-- Called before `clean' performs any cleaning up.
		do
			database.close_connections
		end

end
