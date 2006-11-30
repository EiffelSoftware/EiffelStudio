indexing
	description: "Information about a compiler test"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INFO

create
	make

feature -- Initialization

	make (the_result, name,key : STRING) is
			-- Initialize
		do
			test_result := the_result
			test_real_name := name
			test_key := key
		end


feature -- Access

	test_result: STRING
		-- Test's result is "passed", "failed" or "manual".

	test_real_name: STRING
		-- Test's full name

	test_key : STRING
		-- Test's code

end -- class TEST_INFO
