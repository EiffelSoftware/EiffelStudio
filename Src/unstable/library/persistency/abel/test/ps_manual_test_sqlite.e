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

	sqlite_tuple_queries
		do
			tuple_query_tests.test_simple_query
			tuple_query_tests.test_query_with_criteria
			tuple_query_tests.test_query_projection
			tuple_query_tests.test_query_criteria_not_in_projection
			tuple_query_tests.test_query_references
			tuple_query_tests.test_query_objects_in_projection
			tuple_query_tests.test_query_reference_cycle
		end

	sqlite_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	sqlite_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end

	sqlite_polymorphism
		do
			crud_tests.all_polymorphism_tests
		end

	sqlite_object_graph_settings
		do
			object_graph_tests.test_all_settings
		end


feature {NONE} -- Initialization

	make_repository:
				--PS_REPOSITORY_COMPATIBILITY
				PS_DEFAULT_REPOSITORY
			-- Create the repository for this test
		local
--			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
			backend: PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
			tuple_handler: PS_TUPLE_COLLECTION_HANDLER
		do
			create database.make (sqlite_file)
			create backend.make (database, create {PS_SQLITE_STRINGS})
			backend.wipe_out
			create Result.make (backend)

			create special_handler.make
			create tuple_handler
			Result.add_collection_handler (special_handler)
			Result.add_collection_handler (tuple_handler)
		end


--	make_repository: PS_REPOSITORY
--			-- Create the repository for this test
--		local
--			factory: PS_SQLITE_REPOSITORY_FACTORY
--		do
--			create factory
--			factory.set_database (sqlite_file)
--			Result := factory.new_repository
--			-- TODO: implement close sqlite database...
--			database := attach (factory.sqlite_database)
--		end

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
