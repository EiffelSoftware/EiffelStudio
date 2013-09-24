note
	description: "Tests ABEL with an in-memory 'database' backend."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_IN_MEMORY

inherit

	PS_REPOSITORY_TESTS

feature {NONE}

	make_repository: PS_IN_MEMORY_REPOSITORY
			-- Create the repository for this test
		do
			create Result.make_empty
		end

feature

	test_criteria_in_memory
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	test_crud_flat_in_memory
		do
			crud_tests.all_flat_object_tests
		end

	test_references_in_memory
		do
			crud_tests.all_references_tests
		end

	test_collections_in_memory
		do
			crud_tests.all_collection_tests
		end

	test_transaction_lost
		do
			transaction_tests.test_no_lost_update
		end

	test_transaction_dirty
		do
			transaction_tests.test_no_dirty_reads
		end

	test_transaction_repeatable_read
		do
			transaction_tests.test_repeatable_read
		end

	test_object_graph_write_settings
		do
			object_graph_tests.test_write_settings
		end

	test_object_graph_read_settings
		do
			object_graph_tests.test_retrieval_settings
		end

	test_tuple_queries
		do
			tuple_query_tests.test_simple_query
			tuple_query_tests.test_query_with_criteria
			tuple_query_tests.test_query_projection
			tuple_query_tests.test_query_criteria_not_in_projection
			tuple_query_tests.test_query_references
			tuple_query_tests.test_query_objects_in_projection
			tuple_query_tests.test_query_reference_cycle
		end

end
