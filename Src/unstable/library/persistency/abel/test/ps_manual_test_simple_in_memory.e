note
	description: "Summary description for {PS_MANUAL_TEST_SIMPLE_IN_MEMORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"


class
	PS_MANUAL_TEST_SIMPLE_IN_MEMORY

inherit

	PS_REPOSITORY_TESTS

feature {NONE}

	make_repository: PS_SIMPLE_IN_MEMORY_REPOSITORY
			-- Create the repository for this test
		do
			create Result
		end

feature

	memory_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	memory_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	memory_references
		do
			crud_tests.all_references_tests
		end

	memory_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	memory_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end

	memory_polymorphism
		do
			crud_tests.all_polymorphism_tests
		end

--	memory_transaction_lost
--		do
--			transaction_tests.test_no_lost_update
--		end

--	memory_transaction_dirty
--		do
--			transaction_tests.test_no_dirty_reads
--		end

--	memory_transaction_repeatable_read
--		do
--			transaction_tests.test_repeatable_read
--		end

	memory_object_graph_write_settings
		do
			object_graph_tests.test_write_settings
		end

	memory_object_graph_read_settings
		do
			object_graph_tests.test_retrieval_settings
		end

	memory_tuple_queries
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
