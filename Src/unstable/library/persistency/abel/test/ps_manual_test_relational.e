note
	description: "Summary description for {PS_MANUAL_TEST_RELATIONAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_RELATIONAL

inherit
	PS_REPOSITORY_TESTS
		redefine
			on_clean
		end

feature {NONE} -- Test switch

	mysql: BOOLEAN = True

feature -- Tests

	test_query
			-- Test a simple query.
		local
			query: PS_QUERY [TEST_PERSON]
			count: INTEGER
		do
			repository.wipe_out
			populate

			create query.make
			repository.execute_query (query)

			assert ("No error", not query.has_error)

			across
				query as cursor
			loop
				count := count + 1
				print (cursor.item)
			end
			query.close
			assert ("Correct count.", count = 4)
		end

	test_expanded_override
			-- Test if a class without a primary key is treated like an expanded type.
		local
			query: PS_QUERY [TEST_PERSON]
		do
			repository.wipe_out
			populate

			create query.make
			repository.execute_query (query)
			assert ("No error", not query.has_error)

			across
				query as cursor
			loop
				assert ("is_expanded", repository.is_expanded (cursor.item.generating_type))
			end
			query.close
			assert ("no_error", not query.has_error)
		end

	test_criteria
			-- Test if criteria work.
		do
			repository.wipe_out
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	test_managed_primary_key_generation
			-- Test if primary key generation works.
		local
			flat: FLAT_CLASS_2
			transaction: PS_TRANSACTION
			query: PS_QUERY [FLAT_CLASS_2]

			count: INTEGER
		do
			repository.wipe_out
			transaction := repository.new_transaction

			create flat.make (42, "some")
			transaction.insert (flat)

			create flat.make (21, "thing")
			transaction.insert (flat)

			flat.string_value.append ("more")
			transaction.update (flat)

			create query.make
			transaction.execute_query (query)

			across
				query as cursor
			loop
				if cursor.item.int_value = 42 then
					cursor.item.string_value.append ("thing")
				elseif cursor.item.int_value = 21 then
					 cursor.item.string_value.wipe_out
					 cursor.item.string_value.append ("more")
				end
			end

			across
				query as cursor
			loop
				transaction.update (cursor.item)
			end

			query.close
			query.reset
			transaction.execute_query (query)

			across
				query as cursor
			loop
				print (cursor.item)
				assert ("first item correct", cursor.item.int_value = 42 implies cursor.item.string_value ~ "something")
				assert ("second item correct",cursor.item.int_value = 21 implies cursor.item.string_value ~ "more")
				count := count + 1
			end
			query.close
			transaction.commit

			assert ("count is two", count = 2)
		end

	test_managed_primary_key_update
			-- Check if a generated primary key gets stored in a managed object during insert.
		local
			transaction: PS_TRANSACTION
			object: FLAT_CLASS_2
			query: PS_QUERY [FLAT_CLASS_2]
		do
			repository.wipe_out
			transaction := repository.new_transaction

			create object.make (100, "a_string")
			print ("Before: " + object.out)
			transaction.insert (object)
			print ("After: " + object.out)

			assert ("has_primary", object.id > 0)

			object.string_value.remove_head (2)
			transaction.update (object)


			create query.make
			transaction.execute_query (query)
			across
				query as cursor
			loop
				print ("After update: " + cursor.item.out)
			end

			assert ("correct_count", query.result_cache.count = 1)
			assert ("no_error", not transaction.has_error)
			query.close
			transaction.commit
		end

	test_reject_nonzero_primary
			-- Test if an insert on a managed object gets rejected
			-- when the user sets a value manually.
		local
			transaction: detachable PS_TRANSACTION
			object: FLAT_CLASS_2
		do
			create object.make (42, "value")
			object.set_id (42)

			repository.wipe_out
			transaction := repository.new_transaction
			transaction.insert (object)

			assert ("has_error", transaction.has_error)
			assert ("correct_cleanup", not transaction.is_active and not repository.active_transactions.has (transaction))
		rescue
			if attached transaction then
				transaction.rollback
			end
		end

	test_manual_primary
			-- Check what happens when the user specifies
			-- a primary key on its own.
		local
			transaction: PS_TRANSACTION
			object: FLAT_CLASS_3
		do
			create object.make (42.123456789, "value")
			object.set_id (123)

			repository.wipe_out
			transaction := repository.new_transaction
			transaction.insert (object)
			print (object)
			transaction.commit
			assert ("same_primary", object.id = 123)
		end

	test_managed_multi_insert
			-- Test multiple inserts with the same managed object, which should
			-- be handled as update.
		local
			transaction: PS_TRANSACTION
			object: FLAT_CLASS_2
			i: INTEGER

			query: PS_QUERY [FLAT_CLASS_2]
		do
			from
				i := 1
				create object.make (42, "value")
				repository.wipe_out
				transaction := repository.new_transaction
			until
				i > 10
			loop
				transaction.insert (object)
				i := i + 1
			end
			transaction.commit

			create query.make

			repository.execute_query (query)

			across
				query as cursor
			from
				i := 0
			loop
				assert ("same_string_value", cursor.item.string_value ~ object.string_value)
				assert ("same_int_value", cursor.item.int_value = object.int_value)
				i := i + 1
			end
			query.close

			assert ("correct_count", i = 1)
		end

	test_unmanaged_multi_insert
			-- Test multiple inserts with the same, unmanaged object.
		local
			transaction: PS_TRANSACTION
			object: FLAT_CLASS_3
			i: INTEGER

			query: PS_QUERY [FLAT_CLASS_3]
			control: ARRAYED_LIST [BOOLEAN]
		do
			from
				i := 1
				create object.make (42.123, "value")
				repository.wipe_out
				transaction := repository.new_transaction
			until
				i > 10
			loop
				object.set_id (i)
				transaction.insert (object)
				i := i + 1
			end
			transaction.commit

			create query.make

			repository.execute_query (query)

			across
				query as cursor
			from
				i := 0
				create control.make_filled (10)
			loop
				assert ("same_string_value", cursor.item.string_value ~ object.string_value)
				assert ("same_real_value", cursor.item.real_value = object.real_value)
				assert ("in_range", 1 <= cursor.item.id and cursor.item.id <= 10)
				control [cursor.item.id] := True
				i := i + 1
			end
			query.close

			assert ("correct_count", i = 10)
			assert ("different", across control as cursor all cursor.item = True end)
		end

	test_void_attribute
			-- Test if a Void attribute gets converted to NULL.
		local
			transaction: PS_TRANSACTION
			object: FLAT_CLASS_3

			query: PS_QUERY [FLAT_CLASS_3]
		do
			create object.make (10, Void)
			object.set_id (55)
			repository.wipe_out
			transaction := repository.new_transaction
			transaction.insert (object)
			transaction.commit

			create query.make
			repository.execute_query (query)

			across
				query as cursor
			loop
				assert ("void_string", cursor.item.string_value = Void)
				assert ("same_real_value", cursor.item.real_value = object.real_value)
				assert ("same_id", cursor.item.id = object.id)
			end
			query.close

			assert ("no_error", not query.has_error)
		end

feature {NONE} -- Initialization

	on_clean
		do
			repository.close
		end

	populate
			-- Add some initial data.
		local
			transaction: PS_TRANSACTION
			data: PS_TEST_DATA
		do
			create data.make
			transaction := repository.new_transaction
			across
				data.people as cursor
			loop
				transaction.insert (cursor.item)
			end
			transaction.commit
		end

	make_repository: PS_REPOSITORY
			-- Create the repository for this test
		local
			mysql_factory: PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY
			sqlite_factory: PS_SQLITE_RELATIONAL_REPOSITORY_FACTORY
		do
			if mysql then
				create mysql_factory.make
				mysql_factory.set_user (username)
				mysql_factory.set_password (password)
				mysql_factory.set_database (db_name)
				mysql_factory.manage ({detachable FLAT_CLASS_2}, "id")
				Result := mysql_factory.new_repository
			else
				create sqlite_factory.make
				sqlite_factory.set_database (sqlite_file)
				sqlite_factory.manage ({FLAT_CLASS_2}, "id")
				Result := sqlite_factory.new_repository
			end

			Result.set_batch_retrieval_size (1)
		end

	username: STRING = "eiffelstoretest"

	password: STRING = "eiffelstoretest"

	db_name: STRING = "eiffelstoretest"

	sqlite_file: STRING = "abel_sqlite_test.db"
			-- The SQLite database file

end
