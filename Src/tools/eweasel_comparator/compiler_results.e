indexing
	description: "HASH_TABLE of tests and their results for a given compilor version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_RESULTS

inherit
	DS_HASH_TABLE [TEST_INFO, STRING]
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
			line_test_info, test, name, l_key, test_result : STRING
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
						l_key := line_test_info.substring (index1 + 1, index2 - 1)

						index1 := line_test_info.index_of (':',1)
						index2 := line_test_info.count
						test_result := line_test_info.substring (index1 + 2, index2)
					end

					create test_info.make(test_result, name, l_key)
					force_last (test_info, l_key)
				end

			end

		end


feature

	result_of (a_key: STRING) : STRING is
			-- Return item stored with key `akey'
		do
			if has (a_key) then
				Result := item (a_key).test_result
			else
				Result := "-"
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class COMPILER_RESULTS
