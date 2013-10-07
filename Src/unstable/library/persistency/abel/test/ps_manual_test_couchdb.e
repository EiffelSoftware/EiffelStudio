note
	description: "Summary description for {PS_MANUAL_TEST_COUCHDB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_COUCHDB

inherit

	PS_REPOSITORY_TESTS

feature {NONE}

	make_repository: CDB_REPOSITORY
			-- Create the repository for this test
		do
			create Result.make_empty
		end

feature

	cdb_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	cdb_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	cdb_references
		do
			crud_tests.all_references_tests
		end

	cdb_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	cdb_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end
		
	cdb_transaction_lost
		do
			transaction_tests.test_no_lost_update
		end

	cdb_transaction_dirty
		do
			transaction_tests.test_no_dirty_reads
		end

	cdb_transaction_repeatable_read
		do
			transaction_tests.test_repeatable_read
		end

	cdb_object_graph_write_settings
		do
			object_graph_tests.test_write_settings
		end

	cdb_object_graph_read_settings
		do
			object_graph_tests.test_retrieval_settings
		end

end
