note
	description: "Provides tests for different kinds and combinations of criteria."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERIA_TESTS

inherit

	PS_TEST_PROVIDER
		redefine
			initialize
		end

create
	make

feature {PS_REPOSITORY_TESTS} -- Test criteria setting

	test_criteria_agents
			-- Some simple tests: strings and numbers with agent criteria
		do

			repository.wipe_out
			transaction := repository.new_transaction
			insert_data

			test_query_no_result
			test_query_one_result_agent_greater_than
			test_query_one_result_agent_equals_to
			test_query_one_result_agent_matching_string
			test_query_one_result_agent_less_than
			test_query_one_result_agent_string_contains
			test_query_one_result_two_agent_criteria_anded
			test_query_one_result_two_agent_criteria_ored

			transaction.commit
			repository.wipe_out
		end

	test_criteria_predefined
			-- All tests with predefined criteria
		do
			transaction := repository.new_transaction
			insert_data

			test_query_one_result_greater_than
			test_query_one_result_equals_to
			test_query_one_result_like_string
			test_query_no_result_like_string
			test_query_four_results_like_string
			test_query_many_results_two_criteria_anded
			test_query_many_results_two_criteria_ored


			transaction.commit
			repository.wipe_out
		end

	test_criteria_agents_and_predefined
			-- all tests with predefined and agent criteria combined
		do
			transaction := repository.new_transaction
			insert_data

			test_query_many_results_three_mixed_criteria

			transaction.commit
			repository.wipe_out
		end

feature {NONE} -- Implementation: Agent criteria tests

	test_query_no_result
			-- Test a query using agent criterion `items_greater_than' yielding no result.
		local
			query: PS_QUERY [TEST_PERSON]
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_greater_than (?, 7)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor
			assert ("The result list is not empty, but it should be.", l_cursor.after)
				-- How to establish the difference between the empty result list because there is no data matching
				-- and the empty list because the retrieval did not work correctly?
				-- You know the answer by looking at the last_error attribute.
			query.close
		end

	test_query_one_result_agent_greater_than
			-- Test a query using agent criterion `items_greater_than' yielding one result.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_greater_than (?, 3)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			query.close
		end

	test_query_one_result_agent_equals_to
			-- Test a query using agent criterion `items_equals_to'. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_equal_to (?, 5)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			assert ("The person in result is supposed to be called Berno but is called " + p.first_name + " instead.", p.first_name.is_equal ("Berno"))
			query.close
		end

	test_query_one_result_agent_matching_string
			-- Test a query using agent criterion `first_name_matches'. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.first_name_matches (?, "Crispo")))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to be called Crispo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Crispo"))
			query.close
		end

	test_query_one_result_agent_less_than
			-- Test a query using agent criterion `items_less_than'. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_less_than (?, 3)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 2 items but owns " + p.items_owned.out + " instead.", p.items_owned = 2)
			query.close
		end

	test_query_one_result_agent_string_contains
			-- Test a query using agent criterion `string_contains'. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.first_name_contains (?, "ris")))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to be called Crispo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Crispo"))
			query.close
		end

	test_query_one_result_two_agent_criteria_anded
			-- Test a query using agent `items_reater_than' anded with agent `first_name_matches'. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_greater_than (?, 3)) and factory (agent p_dao.first_name_matches (?, "Berno")))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to be called Berno but is called " + p.first_name + " instead.", p.first_name.is_equal ("Berno"))
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			query.close
		end

	test_query_one_result_two_agent_criteria_ored
			-- Test a query using agent `items_greater_than' ored with agent `first_name_matches'. One result expected.
		local
			p: TEST_PERSON
			query: PS_QUERY [TEST_PERSON]
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory (agent p_dao.items_less_than (?, 3)) or factory (agent p_dao.items_greater_than (?, 5)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to be called Dumbo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Dumbo"))
			assert ("The person in result is supposed to own 2 items but owns " + p.items_owned.out + " instead.", p.items_owned = 2)
			query.close
		end
			-- Tests with predefined criteria and projection

feature {NONE} -- Implementation: Predefined criteria tests

	test_query_one_result_greater_than
			-- Test a query using criterion greater_than. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make

			query.set_criterion (factory ("items_owned", factory.greater, 3))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			query.close
		end

	test_query_one_result_equals_to
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make

			query.set_criterion (factory ("items_owned", factory.equals, 5))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			query.close
		end

	test_query_no_result_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory ("first_name", factory.like_string, "*lb*") and factory ("last_name", factory.like_string, "it*ssi"))
			transaction.execute_query (query)
			l_cursor := query.new_cursor
			assert ("The result list is not empty, but it should be.", l_cursor.after)
			query.close
		end

	test_query_one_result_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory ("first_name", factory.like_string, "*lb*") and factory ("last_name", factory.like_string, "*?ssi"))
			transaction.execute_query (query)
			l_cursor := query.new_cursor
			assert ("The result list is empty", not l_cursor.after)
			p := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than one item", l_cursor.after)
			assert ("The person in result is supposed to own 3 items but owns " + p.items_owned.out + " instead.", p.items_owned = 3)
			query.close
		end

	test_query_four_results_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_QUERY [TEST_PERSON]
			p1: TEST_PERSON
			p2: TEST_PERSON
			p3: TEST_PERSON
			p4: TEST_PERSON
			sum: INTEGER
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
			query.set_criterion (factory ("last_name", factory.like_string, "*i"))
			transaction.execute_query (query)
			l_cursor := query.new_cursor
			assert ("The result list is empty", not l_cursor.after)
			p1 := l_cursor.item
			l_cursor.forth
			assert ("The result list only has one item, but it should have 4", not l_cursor.after)
			p2 := l_cursor.item
			l_cursor.forth
			assert ("The result list only has two items, but it should have 4", not l_cursor.after)
			p3 := l_cursor.item
			l_cursor.forth
			assert ("The result list only has three items, but it should have 4", not l_cursor.after)
			p4 := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than four items", l_cursor.after)
			sum := p1.items_owned + p2.items_owned + p3.items_owned + p4.items_owned
			assert ("The person in result is supposed to own 13 items but owns " + sum.out + " instead.", sum = 13)
			query.close
		end

	test_query_many_results_two_criteria_anded
			-- Test a query using two criteria anded.
		local
			query: PS_QUERY [TEST_PERSON]
			p1: TEST_PERSON
			p2: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make

			query.set_criterion (factory ("items_owned", ">", 2) and factory ("items_owned", factory.less, 5))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p1 := l_cursor.item
			l_cursor.forth
			p2 := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than two item", l_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 6 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 6)
			query.close
		end

	test_query_many_results_two_criteria_ored
			-- Test a query using two criteria ored.
		local
			query: PS_QUERY [TEST_PERSON]
			p1: TEST_PERSON
			p2: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make

			query.set_criterion (factory ("items_owned", ">", 3) or factory ("items_owned", factory.less, 3))
			transaction.execute_query (query)
			l_cursor := query.new_cursor

			assert ("The result list is empty", not l_cursor.after)
			p1 := l_cursor.item
			l_cursor.forth
			p2 := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than two item", l_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 7 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 7)
			query.close
		end

feature {NONE} -- Implementation: Mixed criteria tests

	test_query_many_results_three_mixed_criteria
			-- Test a query using theree criteria, two predefined and one using an agent.
		local
			query: PS_QUERY [TEST_PERSON]
			p1, p2: TEST_PERSON
			l_cursor: ITERATION_CURSOR [TEST_PERSON]
		do
			create query.make
				--query.set_projection (<<"last_name", "items_owned">>)
			query.set_criterion (factory ("items_owned", factory.greater, 3) or factory ("items_owned", factory.less, 3) and factory (agent p_dao.items_equal_to (?, 2)))
			transaction.execute_query (query)
			l_cursor := query.new_cursor
				--assert ("The result list has " + query.matched.count.out + " items instead of 2.", query.matched.count = 2)
			assert ("The result list is empty", not l_cursor.after)
			p1 := l_cursor.item
			l_cursor.forth
			p2 := l_cursor.item
			l_cursor.forth
			assert ("The result list has more than two item", l_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 7 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 7)
			query.close
		end

feature {NONE} -- Initialization

	p_dao: PERSON_DAO

	factory: PS_CRITERION_FACTORY

	transaction: PS_TRANSACTION

	initialize
		do
			create p_dao
			create factory
			transaction := repository.new_transaction
			transaction.rollback
		end


	insert_data
			-- Insert the data needed for the tests into the repository
		do
			across
				test_data.people as p
			loop
				transaction.insert (p.item)
			end
		end
end
