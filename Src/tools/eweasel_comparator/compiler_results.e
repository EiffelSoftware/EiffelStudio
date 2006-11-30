indexing
	description: "HASH_TABLE of tests and their results for a given compilor version"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_RESULTS

inherit
	HASH_TABLE [TEST_INFO, STRING]
		rename
			make as table_make
		end
	
create
	make

feature -- Initialization

	make (name: STRING) is
			-- Open an Output file for reading, select useful information
			-- Build a Hash Table for tests : code, name, result.
		local
			file_path_name: STRING
		do
			file_path_name := name			
			create file.make (file_path_name)	
			table_make (10)
			if file.exists then
				file.open_read
				build_test_hash_table (file)
			else
				io.error.put_string ("Could not read file %"" + name + "%".%N")
			end
		end

feature -- Access

	file: PLAIN_TEXT_FILE
		-- Contain tests results of a compiler version

feature -- Measurement

	build_test_hash_table (f : PLAIN_TEXT_FILE) is
			-- Select useful information of file `f'
			-- Store test's name and result with key `code'
		local	
			line_test_info, test, name, key, test_result : STRING
			index1, index2 : INTEGER
			test_info : TEST_INFO
		do
			
			from
				f.start
			until
				f.exhausted
			loop
				f.read_line
				line_test_info := f.last_string	
				test := line_test_info.substring (1,4)
			
				if equal (test, "Test") then			
					line_test_info := line_test_info.substring (5,line_test_info.count)

					if line_test_info.count /= 0 then
						index1 := line_test_info.index_of (' ',1)
						index2 := line_test_info.index_of (' ',2)
						name := line_test_info.substring (index1 + 1, index2)

						index1 := line_test_info.index_of ('(',1)
						index2 := line_test_info.index_of (')',2)
						key := line_test_info.substring (index1 + 1, index2 - 1)

						index1 := line_test_info.index_of (':',1)
						index2 := line_test_info.count
						test_result := line_test_info.substring (index1 + 2, index2)					
					end

					create test_info.make(test_result, name, key)
					put (test_info, key)
				end
	
			end
			
		end


feature

	result_of (key: STRING) : STRING is
			-- Return item stored with key `key'
		do
			if has (key) then
				Result := item (key).test_result
			else
				Result := "-"
			end
		end

end -- class COMPILER_RESULTS
