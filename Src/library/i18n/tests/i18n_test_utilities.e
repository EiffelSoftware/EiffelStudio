note
	description: "Summary description for {I18N_TEST_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TEST_UTILITIES

inherit
	UTF8_READER_WRITER

feature {NONE} -- Comparison

	has_same_content_as_string (a_path: STRING; a_string: READABLE_STRING_8): BOOLEAN
			-- Does target file for path have same content as given string?
			--
			-- `a_path': Path relative to target_directory of file
			-- `a_string': String to be compared with content of file
			-- `Result': True if file has same content as `a_string', False otherwise
			--
			-- Note: if file does not exists or is not readable an exception is raised.
		require
			a_path_not_empty: not a_path.is_empty
		local
			l_filename: READABLE_STRING_8
			l_file: FILE
			i, l_count: INTEGER_32
		do
			l_filename := a_path
			create {PLAIN_TEXT_FILE} l_file.make (l_filename)
			l_file.open_read
			from
				i := 1
				l_count := a_string.count
				Result := True
				l_file.read_character
			until
				i > l_count or l_file.end_of_file or not Result
			loop
				Result := a_string.item (i) = l_file.last_character
				l_file.read_character
				i := i + 1
			end
			if Result then
				Result := i > l_count and l_file.end_of_file
			end
			l_file.close
		end

feature {NONE} -- Output function

	clean_cache
		do
			if cached_output /= Void then
				cached_output.wipe_out
			end
		end

	save_cache_to_file (a_file_name: STRING)
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write (a_file_name)
			file_write_string_32 (l_file, cached_output)
			l_file.close
		end

	output_integer (i: INTEGER)
		do
			output_string (i.out)
		end

	output_string (s: STRING_32)
		do
			if cached_output = Void then
				create cached_output.make_empty
			end
			cached_output.append_string (s)
		end

	print_line (a_string: STRING_32)
		do
			output_string (a_string)
			output_string ("%N")
		end

	print_string_indented_line (a_string: STRING_32)
		do
			output_string ("  ")
			output_string (a_string)
			output_string ("%N")
		end

	cached_output: STRING_32;

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
