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
			make
		end

create
	make

feature {PS_REPOSITORY_TESTS} -- Test criteria setting

	test_criteria_agents
			-- Some simple tests: strings and numbers with agent criteria
		do
			insert_data
			test_query_no_result
			test_query_one_result_agent_greater_than
			test_query_one_result_agent_equals_to
			test_query_one_result_agent_matching_string
			test_query_one_result_agent_less_than
			test_query_one_result_agent_string_contains
			test_query_one_result_two_agent_criteria_anded
			test_query_one_result_two_agent_criteria_ored

			repository.set_global_pool (False)
			repository.clean_db_for_testing
		end

	test_criteria_predefined
			-- All tests with predefined criteria
		do
			insert_data
			test_query_one_result_greater_than
			test_query_one_result_equals_to
			test_query_one_result_like_string
			test_query_no_result_like_string
			test_query_four_results_like_string
			test_query_many_results_two_criteria_anded
			test_query_many_results_two_criteria_ored
			repository.set_global_pool (False)
			repository.clean_db_for_testing
		end

	test_criteria_agents_and_predefined
			-- all tests with predefined and agent criteria combined
		do
			insert_data
			test_query_many_results_three_mixed_criteria
			repository.set_global_pool (False)
			repository.clean_db_for_testing
		end

feature {NONE} -- Implementation: Agent criteria tests

	test_query_no_result
			-- Test a query using agent criterion `items_greater_than' yielding no result.
		local
			q: PS_OBJECT_QUERY [PERSON]
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_greater_than(?, 7)]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 0.", q.matched.count = 0)
			assert ("The result list is not empty, but it should be.", q.result_cursor.after)
				-- How to establish the difference between the empty result list because there is no data matching
				-- and the empty list because the retrieval did not work correctly?
				-- You know the answer by looking at the last_error attribute.
		end

	test_query_one_result_agent_greater_than
			-- Test a query using agent criterion `items_greater_than' yielding one result.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_greater_than(?, 3)]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
		end

	test_query_one_result_agent_equals_to
			-- Test a query using agent criterion `items_equals_to'. One result expected.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_equal_to(?, 5)]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
			assert ("The person in result is supposed to be called Berno but is called " + p.first_name + " instead.", p.first_name.is_equal ("Berno"))
		end

	test_query_one_result_agent_matching_string
			-- Test a query using agent criterion `first_name_matches'. One result expected.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.first_name_matches(?, "Crispo")]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to be called Crispo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Crispo"))
		end

	test_query_one_result_agent_less_than
			-- Test a query using agent criterion `items_less_than'. One result expected.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_less_than(?, 3)]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to own 2 items but owns " + p.items_owned.out + " instead.", p.items_owned = 2)
		end

	test_query_one_result_agent_string_contains
			-- Test a query using agent criterion `string_contains'. One result expected.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.first_name_contains(?, "ris")]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to be called Crispo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Crispo"))
		end

	test_query_one_result_two_agent_criteria_anded
			-- Test a query using agent `items_reater_than' anded with agent `first_name_matches'. One result expected.
		local
			q: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_greater_than(?, 3)]] and factory [[agent p_dao.first_name_matches(?, "Berno")]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to be called Berno but is called " + p.first_name + " instead.", p.first_name.is_equal ("Berno"))
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
		end

	test_query_one_result_two_agent_criteria_ored
			-- Test a query using agent `items_greater_than' ored with agent `first_name_matches'. One result expected.
		local
			p: PERSON
			q: PS_OBJECT_QUERY [PERSON]
		do
			create q.make
			q.set_criterion (factory [[agent p_dao.items_less_than(?, 3)]] or factory [[agent p_dao.items_greater_than(?, 5)]])
			executor.execute_query (q)
				--assert ("The result list has " + q.matched.count.out + " items instead of 1.", q.matched.count = 1)
			assert ("The result list is empty", not q.result_cursor.after)
			p := q.result_cursor.item
			q.result_cursor.forth
			assert ("The result list has more than one item", q.result_cursor.after)
			assert ("The person in result is supposed to be called Dumbo but is called " + p.first_name + " instead.", p.first_name.is_equal ("Dumbo"))
			assert ("The person in result is supposed to own 2 items but owns " + p.items_owned.out + " instead.", p.items_owned = 2)
		end
			-- Tests with predefined criteria and projection

feature {NONE} -- Implementation: Predefined criteria tests

	test_query_one_result_greater_than
			-- Test a query using criterion greater_than. One result expected.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create query.make
				--query.set_projection (<<"first_name", "last_name", "items_owned">>)
			query.set_criterion (factory [["items_owned", factory.greater, 3]])
			executor.execute_query (query)
				--assert ("The result list has " + query.matched.count.out + " items instead of 1.", query.matched.count = 1)
			assert ("The result list is empty", not query.result_cursor.after)
			p := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than one item", query.result_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
		end

	test_query_one_result_equals_to
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create query.make
				--query.set_projection (<<"first_name", "items_owned">>)
			query.set_criterion (factory [["items_owned", factory.equals, 5]])
			executor.execute_query (query)
				--assert ("The result list has " + query.matched.count.out + " items instead of 1.", query.matched.count = 1)
			assert ("The result list is empty", not query.result_cursor.after)
			p := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than one item", query.result_cursor.after)
			assert ("The person in result is supposed to own 5 items but owns " + p.items_owned.out + " instead.", p.items_owned = 5)
		end

	test_query_no_result_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_OBJECT_QUERY [PERSON]
		do
			create query.make
			query.set_criterion (factory [["first_name", factory.like_string, "*lb*"]] and factory [["last_name", factory.like_string, "it*ssi"]])
			executor.execute_query (query)
			assert ("The result list is not empty, but it should be.", query.result_cursor.after)
		end

	test_query_one_result_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p: PERSON
		do
			create query.make
			query.set_criterion (factory [["first_name", factory.like_string, "*lb*"]] and factory [["last_name", factory.like_string, "*?ssi"]])
			executor.execute_query (query)
			assert ("The result list is empty", not query.result_cursor.after)
			p := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than one item", query.result_cursor.after)
			assert ("The person in result is supposed to own 3 items but owns " + p.items_owned.out + " instead.", p.items_owned = 3)
		end

	test_query_four_results_like_string
			-- Test a query using criterion equals_to. One result expected.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p1: PERSON
			p2: PERSON
			p3: PERSON
			p4: PERSON
			sum: INTEGER
		do
			create query.make
			query.set_criterion (factory [["last_name", factory.like_string, "*i"]])
			executor.execute_query (query)
			assert ("The result list is empty", not query.result_cursor.after)
			p1 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list only has one item, but it should have 4", not query.result_cursor.after)
			p2 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list only has two items, but it should have 4", not query.result_cursor.after)
			p3 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list only has three items, but it should have 4", not query.result_cursor.after)
			p4 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than four items", query.result_cursor.after)
			sum := p1.items_owned + p2.items_owned + p3.items_owned + p4.items_owned
			assert ("The person in result is supposed to own 13 items but owns " + sum.out + " instead.", sum = 13)
		end

	test_query_many_results_two_criteria_anded
			-- Test a query using two criteria anded.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p1: PERSON
			p2: PERSON
		do
			create query.make
				--query.set_projection (<<"last_name", "items_owned">>)
			query.set_criterion (factory [["items_owned", ">", 2]] and factory [["items_owned", factory.less, 5]])
			executor.execute_query (query)
				--assert ("The result list has " + query.matched.count.out + " items instead of 2.", query.matched.count = 2)
			assert ("The result list is empty", not query.result_cursor.after)
			p1 := query.result_cursor.item
			query.result_cursor.forth
			p2 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than two item", query.result_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 6 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 6)
		end

	test_query_many_results_two_criteria_ored
			-- Test a query using two criteria ored.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p1: PERSON
			p2: PERSON
		do
			create query.make
				--query.set_projection (<<"last_name", "items_owned">>)
			query.set_criterion (factory [["items_owned", ">", 3]] or factory [["items_owned", factory.less, 3]])
			executor.execute_query (query)
				--assert ("The result list has " + query.matched.count.out + " items instead of 2.", query.matched.count = 2)
			assert ("The result list is empty", not query.result_cursor.after)
			p1 := query.result_cursor.item
			query.result_cursor.forth
			p2 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than two item", query.result_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 7 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 7)
		end

feature {NONE} -- Implementation: Mixed criteria tests

	test_query_many_results_three_mixed_criteria
			-- Test a query using theree criteria, two predefined and one using an agent.
		local
			query: PS_OBJECT_QUERY [PERSON]
			p1, p2: PERSON
		do
			create query.make
				--query.set_projection (<<"last_name", "items_owned">>)
			query.set_criterion (factory [["items_owned", factory.greater, 3]] or factory [["items_owned", factory.less, 3]] and factory [[agent p_dao.items_equal_to(?, 2)]])
			executor.execute_query (query)
				--assert ("The result list has " + query.matched.count.out + " items instead of 2.", query.matched.count = 2)
			assert ("The result list is empty", not query.result_cursor.after)
			p1 := query.result_cursor.item
			query.result_cursor.forth
			p2 := query.result_cursor.item
			query.result_cursor.forth
			assert ("The result list has more than two item", query.result_cursor.after)
			assert ("The sum of the items owned by the retrieved persons is supposed to be 7 items but is " + (p1.items_owned + p2.items_owned).out + " instead.", p1.items_owned + p2.items_owned = 7)
		end

feature {NONE} -- Initialization

	insert_data
			-- Insert the data needed for the tests into the repository
		do
			repository.set_global_pool (True)
			across
				test_data.people as p
			loop
					--			print (p.item)
				executor.execute_insert (p.item)
			end
		end

	p_dao: PERSON_DAO

	factory: PS_CRITERION_FACTORY

	make (a_repository: PS_REPOSITORY)
		do
			precursor (a_repository)
			create p_dao
			create factory
		end

end
