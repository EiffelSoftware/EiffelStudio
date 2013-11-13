note
	description: "Summary description for {PS_TUPLE_QUERY_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TUPLE_QUERY_TESTS

inherit
	PS_TEST_PROVIDER
		redefine
			initialize
		end

create
	make

feature


	test_simple_query
			-- Test a simple tuple query with no criteria and standard projection
		local
			query:PS_TUPLE_QUERY[TEST_PERSON]
			res: LINKED_LIST[TUPLE[STRING, STRING, INTEGER]]
		do
			repository.set_global_pool (True)
			across test_data.people as p loop executor.execute_insert(p.item) end
			create query.make
			create res.make
			assert ("Query projection array is less than 3", query.projection.count >=3)
			assert ("Query projection array has wrong attribute names",
				query.projection[1].is_equal ("first_name")
				and  query.projection[2].is_equal ("last_name")
				and  query.projection[3].is_equal ("items_owned"))

			executor.execute_tuple_query (query)

			assert ("Query result is empty", not query.result_cursor.after)

			across query as q
			loop
				assert ("Tuple type is wrong", attached {TUPLE[STRING, STRING, INTEGER]} q.item)
				check attached {TUPLE[STRING, STRING, INTEGER]} q.item as item then
					res.extend (item)
				end
			end

			assert ("Number of retrieved items is wrong", res.count = 4)

			assert ("Data is wrong",
				across test_data.people as person
				all
					across res as retrieved_person
					some
						attach (retrieved_person.item[1]).is_equal (person.item.first_name)
						and attach (retrieved_person.item[2]).is_equal (person.item.last_name)
						and person.item.items_owned = retrieved_person.item.integer_item (3)
					end
				end
				)
			repository.set_global_pool (False)
		end


	test_query_with_criteria
				-- Test a simple query with default projection and some criteria
		local
			query:PS_TUPLE_QUERY[TEST_PERSON]
		do
			repository.set_global_pool (True)
			across test_data.people as p loop executor.execute_insert(p.item) end
			create query.make_with_criterion (factory.create_predefined ("last_name", factory.equals, test_data.people.first.last_name))

			executor.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)
			assert ("Tuple type is wrong", attached {TUPLE[STRING, STRING, INTEGER]} query.result_cursor.item)

			check attached {TUPLE[STRING, STRING, INTEGER]} query.result_cursor.item as res then

				assert ("Data is wrong",
					attach (res[1]).is_equal (test_data.people.first.first_name)
					and attach (res[2]).is_equal (test_data.people.first.last_name)
					and res.integer_item (3) = test_data.people.first.items_owned
					)
			end

			query.result_cursor.forth
			assert ("Too many items", query.result_cursor.after)
			repository.set_global_pool (False)
		end


	test_query_projection
			-- Test a simple query with a custom projection and some criteria
		local
			query:PS_TUPLE_QUERY[TEST_PERSON]
		do
			repository.set_global_pool (True)
			across test_data.people as p loop executor.execute_insert(p.item) end
			create query.make_with_criterion (factory.create_predefined ("last_name", factory.equals, test_data.people.first.last_name))
			query.set_projection (<<"last_name">>)

			executor.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)
			assert ("Tuple type is wrong", attached {TUPLE[STRING]} query.result_cursor.item
						and not attached {TUPLE[STRING, STRING]} query.result_cursor.item)

			check attached {TUPLE[STRING]} query.result_cursor.item as res then
				assert ("Data is wrong", attach (res[1]).is_equal (test_data.people.first.last_name))
			end

			query.result_cursor.forth
			assert ("Too many items", query.result_cursor.after)
			repository.set_global_pool (False)
		end

	test_query_criteria_not_in_projection
			-- Test a query which has a criterion on an attribute not included in the projection array
		local
			query:PS_TUPLE_QUERY[TEST_PERSON]
		do
			repository.set_global_pool (True)
			across test_data.people as p loop executor.execute_insert(p.item) end
			create query.make_with_criterion (factory.create_predefined ("last_name", factory.equals, test_data.people.first.last_name))
			query.set_projection (<<"first_name">>)

			executor.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)
			assert ("Tuple type is wrong", attached {TUPLE[STRING]} query.result_cursor.item
						and not attached {TUPLE[STRING, STRING]} query.result_cursor.item)

			check attached {TUPLE[STRING]} query.result_cursor.item as res then
				assert ("Data is wrong", attach (res[1]).is_equal (test_data.people.first.first_name))
			end

			query.result_cursor.forth
			assert ("Too many items", query.result_cursor.after)
			repository.set_global_pool (False)
		end


	test_query_references
			-- Test if an object containing references gets correctly loaded
		local
			query: PS_TUPLE_QUERY[REFERENCE_CLASS_1]
			res: LINKED_LIST[TUPLE[INTEGER]]
			transaction: PS_TRANSACTION_CONTEXT
		do
			repository.clean_db_for_testing
			transaction := repository.new_transaction_context

--			repository.set_global_pool (True)
--			executor.execute_insert (test_data.reference_to_single_other)
			transaction.insert (test_data.reference_to_single_other)

			create query.make
			create res.make
			assert ("Wrong default projection", query.projection.count = 1 and then	query.projection[1].is_equal ("ref_class_id"))

--			executor.execute_tuple_query (query)
			transaction.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)

			across query as q
			loop
				assert ("Tuple type is wrong", attached {TUPLE[INTEGER]} q.item)
				check attached {TUPLE[INTEGER]} q.item as item then
					res.extend (item)
				end
			end

			assert ("Number of retrieved items is wrong", res.count = 2)

			assert ("Data is wrong",
				across <<1,2>> as nr
				all
					across res as retrieved
					some
						nr.item = retrieved.item.integer_item (1)
					end
				end
			)
			query.close
			transaction.commit
--			repository.set_global_pool (False)
		end

	test_query_objects_in_projection
			-- Test if queries that include non-expanded attributes in their projection get correctly loaded
		local
			query: PS_TUPLE_QUERY[REFERENCE_CLASS_1]
			res: LINKED_LIST[TUPLE[INTEGER, detachable REFERENCE_CLASS_1]]
		do
			repository.clean_db_for_testing
			repository.set_global_pool (True)
			executor.execute_insert (test_data.reference_to_single_other)
			create query.make
			create res.make
			query.set_projection (<<"ref_class_id", "refer">>)

			executor.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)

			across query as q
			loop
				assert ("Tuple type is wrong", attached {TUPLE[INTEGER, detachable REFERENCE_CLASS_1]} q.item)
				check attached {TUPLE[INTEGER, detachable REFERENCE_CLASS_1]} q.item as item then
					res.extend (item)
				end
			end

			assert ("Number of retrieved items is wrong", res.count = 2)

			across res as cursor
			loop
				if cursor.item.integer_item (1) = test_data.reference_to_single_other.ref_class_id then
					assert ("Reference not loaded", attached {REFERENCE_CLASS_1} cursor.item[2])
					assert ("Data is wrong", deep_equal (cursor.item[2], test_data.reference_to_single_other.refer))
				elseif cursor.item.integer_item (1) = 2 then
					assert ("`refer' attribute of second object should be void", not attached cursor.item[2])
				else
					assert ("Error: Object with wrong ref_class_id loaded", false)
				end
			end
			repository.set_global_pool (False)
		end

	test_query_reference_cycle
			-- Test loading an object that is part of a reference cycle in a tuple query
		local
			query: PS_TUPLE_QUERY[REFERENCE_CLASS_1]
		do
			repository.clean_db_for_testing
			repository.set_global_pool (True)
			executor.execute_insert (test_data.reference_cycle)
			create query.make_with_criterion (factory.create_predefined ("ref_class_id", factory.equals, test_data.reference_cycle.ref_class_id))
			query.set_projection (<<"ref_class_id", "refer">>)

			executor.execute_tuple_query (query)

			assert ("Result is empty", not query.result_cursor.after)

			assert ("Tuple type is wrong", attached {TUPLE[INTEGER, detachable REFERENCE_CLASS_1]} query.result_cursor.item)
			check attached {TUPLE[INTEGER, detachable REFERENCE_CLASS_1]} query.result_cursor.item as tup then

				assert ("ref_class_id is wrong", tup.integer_item (1) = test_data.reference_cycle.ref_class_id)
				assert ("attribute refer is Void", attached {REFERENCE_CLASS_1} tup[2])
				assert ("Data is wrong", deep_equal (tup[2], test_data.reference_cycle.refer))
			end

			query.result_cursor.forth
			assert ("Too many items", query.result_cursor.after)
			repository.set_global_pool (False)
		end

feature {NONE} -- Initialization

	factory: PS_CRITERION_FACTORY


	initialize
			-- Fill backend with data
		do
			create factory
			repository.set_global_pool (True)
		end

end
