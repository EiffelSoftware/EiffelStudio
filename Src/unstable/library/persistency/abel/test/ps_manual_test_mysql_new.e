note
	description: "Summary description for {PS_MANUAL_TEST_MYSQL_NEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_MYSQL_NEW

inherit

	PS_REPOSITORY_TESTS

feature

	experiment_stored_procedure
		local
			internal_connection: MYSQLI_CLIENT
		do
				-- Create a new `internal_connection'
			create internal_connection.make
			internal_connection.set_username (username)
			internal_connection.set_password (password)
			internal_connection.set_database (db_name)
			internal_connection.set_host (db_host)
			internal_connection.set_port (db_port)
			internal_connection.connect

			internal_connection.execute_query ("call generateprimaries(5);")
			across internal_connection.last_results.first as cursor
			loop
				print (cursor.item)
			end
			print (internal_connection.last_results.last.out + internal_connection.last_results.count.out)


		end

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

	make_repository: PS_DEFAULT_REPOSITORY
			-- Create the repository for this test
		local
			database: PS_MYSQL_DATABASE
			backend: PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND
		do
			create database.make (username, password, db_name, db_host, db_port)
			create backend.make (database, create {PS_MYSQL_STRINGS})
			backend.wipe_out
			create Result.make (backend)
			Result.add_collection_handler (create {PS_SPECIAL_COLLECTION_HANDLER}.make)
		end

	username: STRING = "eiffelstoretest"

	password: STRING = "eiffelstoretest"

	db_name: STRING = "eiffelstoretest"

	db_host: STRING = "127.0.0.1"

	db_port: INTEGER = 3306

end
