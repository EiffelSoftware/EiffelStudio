note
	description: "Summary description for {TEST_WSF_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WSF_VALUE

inherit
	EQA_TEST_SET

feature {NONE} -- Events

	test_table
		local
			tb: WSF_TABLE
		do
			create tb.make ("table")
			assert ("Ok", True)
		end

end
