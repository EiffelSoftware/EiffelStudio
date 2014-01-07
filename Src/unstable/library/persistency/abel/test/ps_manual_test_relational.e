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
			query: PS_QUERY [TEST_PERSON]
		do
			create query.make
			repository.execute_query (query)

			assert ("No error", not query.has_error)

			across
				query as cursor
			loop
				print (cursor.item)
			end

		end

feature {NONE} -- Initialization

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
