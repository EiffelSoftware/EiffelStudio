indexing
	description: "List of existing tests"
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_TEST 

inherit
	HASH_TABLE [STRING, STRING]
		rename
			make as table_make
		end

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			table_make(2) 				
		end

feature 

	add_tests_from_compiler_results (cr : COMPILER_RESULTS) is
			-- add additional tests if not yet in list_test
		local

			key_compiler: ARRAY [STRING]
			key,name: STRING
			test_info: TEST_INFO
			index: INTEGER
		do

			key_compiler := cr.current_keys
			from
				index := 1
			until
				index > key_compiler.count
			loop
				key := key_compiler @ index
				if not has (key) then
					test_info := cr.item(key)
					name := test_info.test_real_name
					add_single_test (key, name)
				end
			index := index + 1
			end
		end

feature 
	add_single_test (key, name : STRING) is
			-- add test if not present
		do
			if not has (key) then
				put (name, key)
			end
		end

end -- class LIST_TEST
