note
	description: "Tests some settings in PS_OBJECT_GRAPH_SETTINGS."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_GRAPH_SETTINGS_TEST

inherit

	PS_TEST_PROVIDER
		redefine
			initialize
		end

	PS_UNSAFE
		undefine
			default_create
		end

create
	make

feature {PS_REPOSITORY_TESTS}

	test_all_settings
		do
--			test_default_settings
--			test_cascading_update
--			test_update_exact_depth
--			test_cascading_delete
--			test_exact_delete
--			test_immediate_insert
--			test_exact_insert_depth
			test_immediate_retrieve
			test_exact_retrieve_depth
		end

	test_default_settings
			-- Test the default settings (Infinite read an insert, no updates or deletes on referenced objects)
		local
			res: CHAIN_HEAD
		do
			reset
			executor.execute_insert (test_data.reference_chain)
			executor.execute_query (query)
			res := query.result_cursor.item
			assert ("The result is not equal", res.is_deep_equal (test_data.reference_chain))
			res.tail.increment
			executor.execute_update (res) -- Should have no effect with update depth = 1
			query.reset
			executor.execute_query (query)
			res := query.result_cursor.item
			assert ("The result is not equal", res.is_deep_equal (test_data.reference_chain))
			executor.execute_delete (res) -- Should only delete the head
			query.reset
			executor.execute_query (query)
			assert ("The object has not been deleted", query.result_cursor.after)
			executor.execute_query (tail_query)
			assert ("The tail items have been deleted", not tail_query.result_cursor.after)
			repository.clean_db_for_testing
		end

	test_cascading_update
			-- Test if an update on a referenced object works if the update depth is set to Infinity
		do
			reset
			repository.default_object_graph.set_update_depth (repository.default_object_graph.object_graph_depth_infinite)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_query (query)
			query.result_cursor.item.tail.increment
			executor.execute_update (query.result_cursor.item) -- Should have an effect now
			executor.execute_query (query_2)
			assert ("Not successfully updated", query_2.result_cursor.item.is_deep_equal (query.result_cursor.item))
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_update_exact_depth
			-- Test if an update stops at a defined depth
		local
			tail, tail2: CHAIN_TAIL
			i: INTEGER
			depth: INTEGER
		do
			reset
			depth := 4 -- Arbitrary...
			repository.default_object_graph.set_update_depth (depth)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_query (query)
			from
				tail := query.result_cursor.item.tail
			until
				tail.last
			loop
				tail.increment
				tail := tail.next
			end
			executor.execute_update (query.result_cursor.item)
			executor.execute_query (query_2)
			from
				i := 1
				tail := query.result_cursor.item.tail
				tail2 := query_2.result_cursor.item.tail
			until
				tail.last or tail2.last
			loop
				if i < depth then
					assert ("The item has not been updated", tail.level = tail2.level)
				else
					assert ("The item has been updated, but it should not", tail.level - 1 = tail2.level)
				end
				i := i + 1
				tail := tail.next
				tail2 := tail2.next
			end
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_cascading_delete
			-- Test if a cascadubg delete works if the deletion depth is set to Infinity
		do
			reset
			repository.default_object_graph.set_delete_depth (repository.default_object_graph.object_graph_depth_infinite)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_delete (test_data.reference_chain)
			executor.execute_query (query)
			assert ("The head has not been deleted", query.result_cursor.after)
			executor.execute_query (tail_query)
			assert ("At least one tail item has not been deleted", tail_query.result_cursor.after)
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_exact_delete
			-- Test if a delete up to a defined depth works
		local
			tail_count: INTEGER
		do
			reset
			repository.default_object_graph.set_delete_depth (arbitrary_depth)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_delete (test_data.reference_chain)
			executor.execute_query (tail_query)
			across
				tail_query as res
			loop
				tail_count := tail_count + 1
			end
			assert ("The number of tails in the database is wrong", tail_count = 10 - (arbitrary_depth - 1))
				-- test_data.reference_chain has exactly 10 tails, and (depth - 1) should be deleted (the -1 because of the head)
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_immediate_insert
			-- Test if an insert with depth=1 works
		do
			reset
			repository.default_object_graph.set_insert_depth (1)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_query (query)
			assert ("The reference of the retrieved object should be Void", query.result_cursor.item.tail = Void)
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_exact_insert_depth
			-- Test if an insert with an arbitrary depth works
		local
			tail_count: INTEGER
		do
			reset
			repository.default_object_graph.set_insert_depth (arbitrary_depth)
			executor.execute_insert (test_data.reference_chain)
			executor.execute_query (query)
			assert ("The reference of the retrieved object should be Void", query.result_cursor.item.tail.next.next.last)
			executor.execute_query (tail_query)
			across
				tail_query as res
			loop
				tail_count := tail_count + 1
			end
			assert ("The number of tails is wrong", tail_count = arbitrary_depth - 1)
			repository.clean_db_for_testing
			repository.default_object_graph.reset_to_default
		end

	test_immediate_retrieve
			-- Test if a retrieve with depth = 1 only retrieves the first object
		local
			transaction: PS_TRANSACTION
			head_query: PS_OBJECT_QUERY [CHAIN_HEAD]
		do
			transaction := repository.new_transaction_context
			transaction.insert (test_data.reference_chain)

			create head_query.make
			head_query.set_object_initialization_depth (1)

			transaction.execute_query (head_query)

			assert ("The reference of the retrieved object should be Void", head_query.result_cursor.item.tail = Void)

			head_query.close
			transaction.commit
			repository.clean_db_for_testing
--			
--			reset
--			query.object_initialization_depth (1)
--			
--			--repository.default_object_graph.set_query_depth (1)
--			executor.execute_insert (test_data.reference_chain)
--			executor.execute_query (query)
--			assert ("The reference of the retrieved object should be Void", query.result_cursor.item.tail = Void)
--			repository.clean_db_for_testing
--			repository.default_object_graph.reset_to_default
		end

	test_exact_retrieve_depth
			-- Test if a query with an arbitrary depth works
		local
			tail_count: INTEGER
			transaction: PS_TRANSACTION
		do
			reset
--			repository.default_object_graph.set_query_depth (arbitrary_depth)

			transaction := repository.new_transaction_context
			transaction.insert (test_data.reference_chain)

			query.set_object_initialization_depth (arbitrary_depth)
			transaction.execute_query (query)

			--executor.execute_insert (test_data.reference_chain)
			--executor.execute_query (query)
			assert ("The reference of the retrieved object should be Void", query.result_cursor.item.tail.next.next.last)

			tail_query.set_object_initialization_depth (1)
			transaction.execute_query (tail_query)
--			repository.default_object_graph.set_query_depth (1)
--			executor.execute_query (tail_query)
			across
				tail_query as res
			loop
				assert ("The tail links are not void", res.item.last)
				tail_count := tail_count + 1
			end
			-- This test is wrong: ABEL will still load all CHAIN_TAIL objects it can find for a tail query.
			--assert ("The number of tails is wrong", arbitrary_depth - 1 = tail_count)
			tail_query.close

--			repository.default_object_graph.set_query_depth (1)
--			query.reset
--			executor.execute_query (query)
			query.reset
			query.set_object_initialization_depth (1)
			transaction.execute_query (query)
			assert ("There should be no tail", not attached query.result_cursor.item.tail)


--			repository.default_object_graph.set_query_depth (2)
--			query.reset
--			executor.execute_query (query)
			query.reset
			query.set_object_initialization_depth (2)
			transaction.execute_query (query)
			assert ("There should be only one tail", query.result_cursor.item.tail.last)

--			repository.default_object_graph.set_query_depth (3)
--			query.reset
--			executor.execute_query (query)
			query.reset
			query.set_object_initialization_depth (3)
			transaction.execute_query (query)
			assert ("There should be only two tails", query.result_cursor.item.tail.next.last)

--			repository.default_object_graph.set_query_depth (4)
--			query.reset
--			executor.execute_query (query)
			query.reset
			query.set_object_initialization_depth (4)
			transaction.execute_query (query)
			assert ("There should be only three tails", query.result_cursor.item.tail.next.next.last)

			query.close
			transaction.commit
			repository.clean_db_for_testing
--			repository.default_object_graph.reset_to_default
		end

feature {PS_TEST_PROVIDER}

	initialize
			-- Initialize queries
		do
			create query.make
			create query_2.make
			create query_3.make
			create tail_query.make
			create tail_query_2.make
		end

	reset
			-- Reset queries
		do
			query.reset
			query_2.reset
			query_3.reset
			tail_query.reset
			tail_query_2.reset
		end

	query, query_2, query_3: PS_OBJECT_QUERY [CHAIN_HEAD]
			-- Some queries on CHAIN_HEAD to be used for testing

	tail_query, tail_query_2: PS_OBJECT_QUERY [CHAIN_TAIL]
			-- Some queries on CHAIN_TAIL to be used for testing

	arbitrary_depth: INTEGER = 4
			-- An arbitrary depth

end
