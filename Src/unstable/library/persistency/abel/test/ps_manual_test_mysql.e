note
	description: "Tests ABEL with a MySQL backend"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_MYSQL

inherit

	PS_REPOSITORY_TESTS

feature

	mysql_tuple_queries
		do
			tuple_query_tests.test_simple_query
			tuple_query_tests.test_query_with_criteria
			tuple_query_tests.test_query_projection
			tuple_query_tests.test_query_criteria_not_in_projection
			tuple_query_tests.test_query_references
			tuple_query_tests.test_query_objects_in_projection
			tuple_query_tests.test_query_reference_cycle
		end

	mysql_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	mysql_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	mysql_references
		do
			crud_tests.all_references_tests
		end

	mysql_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	mysql_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end

	mysql_polymorphism
		do
			crud_tests.all_polymorphism_tests
		end

	mysql_transaction_lost
		do
			transaction_tests.test_no_lost_update
		end

	mysql_transaction_dirty
		do
			transaction_tests.test_no_dirty_reads
		end

	mysql_transaction_repeatable_read
		do
			transaction_tests.test_repeatable_read
		end

	mysql_transaction_cleanup
		do
			transaction_tests.test_correct_insert_rollback
			transaction_tests.test_correct_update_rollback
			transaction_tests.test_correct_delete_rollback
		end

feature {NONE} -- Initialization

	make_repository: PS_REPOSITORY_COMPATIBILITY
			-- Create the repository for this test
		local
			database: PS_MYSQL_DATABASE
			backend: PS_GENERIC_LAYOUT_SQL_BACKEND
		do
			create database.make (username, password, db_name, db_host, db_port)
			create backend.make (database, create {PS_MYSQL_STRINGS})
			backend.wipe_out
			create Result.make (backend)
		end

	--	username:STRING = "pfadief_eiffel"
	--	password:STRING = "eiffelstore"
	--	db_name:STRING = "pfadief_eiffelstoretest"
	--	db_host:STRING = "pfadief.mysql.db.hostpoint.ch"
	--	db_port:INTEGER = 3306

	username: STRING = "eiffelstoretest"

	password: STRING = "eiffelstoretest"

	db_name: STRING = "eiffelstoretest"

	db_host: STRING = "127.0.0.1"

	db_port: INTEGER = 3306

end
