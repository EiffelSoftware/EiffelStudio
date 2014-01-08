note
	description: "Summary description for {PS_MANUAL_TEST_RELATIONAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_RELATIONAL

inherit
	PS_REPOSITORY_TESTS

feature -- Tests

	test_query
			-- Test a simple query.
		local
			transaction: PS_TRANSACTION

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

	test_criteria
			-- Test if criteria work.
		do
			repository.wipe_out
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	test_primary
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
				print (cursor.item.id.out + ", " + cursor.item.int_value.out + ", " + cursor.item.string_value + "%N")
				assert ("first item correct", cursor.item.int_value = 42 implies cursor.item.string_value ~ "something")
				assert ("second item correct",cursor.item.int_value = 21 implies cursor.item.string_value ~ "more")
				count := count + 1
			end
			query.close
			transaction.commit

			assert ("count is two", count = 2)
		end

feature {NONE} -- Initialization

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
			factory: PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY
		do
			create factory.make
			factory.set_user (username)
			factory.set_password (password)
			factory.set_database (db_name)

			factory.mapping.add_primary_key_column ("id", "flat_class_2")

			Result := factory.new_repository
		end

	username: STRING = "eiffelstoretest"

	password: STRING = "eiffelstoretest"

	db_name: STRING = "eiffelstoretest"

end
