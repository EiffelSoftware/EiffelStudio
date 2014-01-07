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

			Result := factory.new_repository
		end

	username: STRING = "eiffelstoretest"

	password: STRING = "eiffelstoretest"

	db_name: STRING = "eiffelstoretest"

end
