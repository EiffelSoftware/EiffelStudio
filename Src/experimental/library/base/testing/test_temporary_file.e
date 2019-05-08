note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEMPORARY_FILE

inherit
	EQA_TEST_SET

feature -- Test

	test_temporary_plain_text_file
		local
			l_file: PLAIN_TEXT_FILE
			l_name: STRING_32
			l_data: STRING
		do
			create l_file.make_open_temporary
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open starts with eiftmp", l_name.starts_with ("eiftmp"))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_with_name (l_name)
			l_file.open_read
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close

			l_file.delete
		end

	test_temporary_plain_text_file_with_prefix
		local
			l_file: PLAIN_TEXT_FILE
			l_name: STRING_32
			l_data: STRING
		do
			create l_file.make_open_temporary_with_prefix ("tmp_")
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open starts with tfn", l_name.starts_with ("tmp_"))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_open_read (l_name)
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close

			l_file.delete
		end


	test_temporary_plain_text_file_with_prefix_with_space
		local
			l_file: PLAIN_TEXT_FILE
			l_name: STRING_32
			l_data: STRING
		do
			create l_file.make_open_temporary_with_prefix ("tmp_ ")
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open starts with tfn", l_name.starts_with ("tmp_ "))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_open_read (l_name)
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close

			l_file.delete
		end


	test_temporary_plain_text_file_with_path_and_prefix
		local
			l_file: PLAIN_TEXT_FILE
			l_name: STRING_32
			l_data: STRING
			l_path: PATH
		do
			if {PLATFORM}.is_windows then
				create l_path.make_from_string ("C:/WINDOWS/TEMP")
			else
				create l_path.make_from_string ("/tmp")
			end
			l_path := l_path.extended ("tmp_")
			create l_file.make_open_temporary_with_prefix (l_path.absolute_path.name.string)
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open has substring tmp_", l_name.has_substring ("tmp_"))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_open_read (l_name)
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close
			l_file.delete
		end

	test_temporary_raw_file
		local
			l_file: RAW_FILE
			l_name: STRING_32
			l_data: STRING
		do
			create l_file.make_open_temporary
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open starts with eiftmp", l_name.starts_with ("eiftmp"))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_open_read (l_name)
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close

			l_file.delete
		end

	test_temporary_raw_file_with_prefix
		local
			l_file: RAW_FILE
			l_name: STRING_32
			l_data: STRING
		do
			create l_file.make_open_temporary_with_prefix ("tmp_")
			assert ("File Open Read and Write", l_file.is_open_read and then l_file.is_open_write)
			l_name := l_file.path.name
			assert ("Default Temporary Open starts with tfn", l_name.starts_with ("tmp_"))
			l_file.put_string ("Example: how to write text to a file")
			l_file.close

			create l_file.make_open_read (l_name)
			l_file.read_stream (l_file.count)
			l_data := l_file.last_string.twin
			assert ("Expected data: ", l_data.same_string_general ("Example: how to write text to a file"))
			l_file.close

			l_file.delete
		end


note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
