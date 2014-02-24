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
			ld: ESA_DATA_PROVIDER
		do
			create ld.make
			assert ("Expected False", not ld.add_user ("test001", "test001","test001", "test001", "test001", "answer", "token", 1))
		end

end
