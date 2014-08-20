note
	description: "Summary description for {ADD_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test

	test_add_user
		local
			ld: REPORT_DATA_PROVIDER
		do
			create ld.make (connection)
--			assert ("Expected False", not ld.add_user ("test001", "test001","test001", "test001", "test001", "answer", "token", 1))
		end

	connection: DATABASE_CONNECTION
		once
			create {DATABASE_CONNECTION_ODBC}Result.make_common
		end

end
