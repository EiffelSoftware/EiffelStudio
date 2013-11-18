note
	description: "Tests some settings in PS_OBJECT_GRAPH_SETTINGS."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_GRAPH_SETTINGS_TEST

inherit

	PS_TEST_PROVIDER

	PS_UNSAFE
		undefine
			default_create
		end

create
	make

feature {PS_REPOSITORY_TESTS}

	test_all_settings
		do
			test_write_operations
			test_immediate_retrieve
			test_exact_retrieve_depth
		end

	test_write_operations
			-- Test the initialization depth for write operations.
		local
			query: PS_OBJECT_QUERY [CHAIN_HEAD]
			res, res2: CHAIN_HEAD
			transaction: PS_TRANSACTION
		do
			create query.make
			transaction := repository.new_transaction

			transaction.insert (test_data.reference_chain)
			transaction.execute_query (query)
			res := query.new_cursor.item
			assert ("Insert-Retrieve cycle failed:", res.is_deep_equal (test_data.reference_chain))

			res.tail.increment

			-- Should have no effect as we only modified a referenced object.
			transaction.direct_update (res)

			query.reset
			transaction.execute_query (query)
			res2 := query.new_cursor.item
			assert ("A direct update has updated referenced items as well", res2.is_deep_equal (test_data.reference_chain))

 			-- Full update should have an effect
			transaction.update (res)

			query.reset
			transaction.execute_query (query)
			assert ("An update failed to update referenced items", res.is_deep_equal (query.new_cursor.item))

			query.close
			transaction.commit
			repository.clean_db_for_testing
		end

	test_immediate_retrieve
			-- Test if a retrieve with `object_initialization_depth' = 1 only retrieves the first object
		local
			transaction: PS_TRANSACTION
			head_query: PS_OBJECT_QUERY [CHAIN_HEAD]
		do
			transaction := repository.new_transaction
			transaction.insert (test_data.reference_chain)

			create head_query.make
			head_query.set_object_initialization_depth (1)

			transaction.execute_query (head_query)

			assert ("The reference of the retrieved object should be Void", head_query.result_cursor.item.tail = Void)

			head_query.close
			transaction.commit
			repository.clean_db_for_testing
		end

	test_exact_retrieve_depth
			-- Test if a query with an arbitrary `object_initialization_depth' works
		local
			tail_count: INTEGER
			transaction: PS_TRANSACTION
			query: PS_OBJECT_QUERY [CHAIN_HEAD]
			tail_query: PS_OBJECT_QUERY [CHAIN_TAIL]
		do
			create query.make
			create tail_query.make

			transaction := repository.new_transaction
			transaction.insert (test_data.reference_chain)

			query.set_object_initialization_depth (some_depth)
			transaction.execute_query (query)

			assert ("The reference of the retrieved object should be Void", query.result_cursor.item.tail.next.next.last)

			tail_query.set_object_initialization_depth (1)
			transaction.execute_query (tail_query)

			across
				tail_query as res
			loop
				assert ("The tail links are not void", res.item.last)
				tail_count := tail_count + 1
			end
			tail_query.close

			query.reset
			query.set_object_initialization_depth (1)
			transaction.execute_query (query)
			assert ("There should be no tail", not attached query.result_cursor.item.tail)

			query.reset
			query.set_object_initialization_depth (2)
			transaction.execute_query (query)
			assert ("There should be only one tail", query.result_cursor.item.tail.last)

			query.reset
			query.set_object_initialization_depth (3)
			transaction.execute_query (query)
			assert ("There should be only two tails", query.result_cursor.item.tail.next.last)

			query.reset
			query.set_object_initialization_depth (4)
			transaction.execute_query (query)
			assert ("There should be only three tails", query.result_cursor.item.tail.next.next.last)

			query.close
			transaction.commit
			repository.clean_db_for_testing
		end

feature {NONE} -- Constants

	some_depth: INTEGER = 4
			-- An arbitrary depth

end
