class TEST

inherit
	ARGUMENTS

create
	make

feature

	make is
			--
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_open_read (test_file_name)
			f.read_word
			check_object (f.last_string, expected_word_1)
			check_object (f.separator.out, " ")
			f.read_word
			check_object (f.last_string, expected_word_2)
			check_object (f.separator.out, "%T")
			f.read_word
			check_object (f.last_string, expected_word_3)
			check_object (f.separator.out, " ")
			f.read_word
			check_object (f.last_string, expected_word_4)
			check_object (f.separator.out, "%N")
			f.read_word
			check_object (f.last_string, expected_word_1)
			check_object (f.separator.out, " ")
			f.close

			create f.make_open_read (test_file_name)
			f.read_word_thread_aware
			check_object (f.last_string, expected_word_1)
			check_object (f.separator.out, " ")
			f.read_word_thread_aware
			check_object (f.last_string, expected_word_2)
			check_object (f.separator.out, "%T")
			f.read_word_thread_aware
			check_object (f.last_string, expected_word_3)
			check_object (f.separator.out, " ")
			f.read_word_thread_aware
			check_object (f.last_string, expected_word_4)
			check_object (f.separator.out, "%N")
			f.read_word_thread_aware
			check_object (f.last_string, expected_word_1)
			check_object (f.separator.out, " ")
			f.close

			create f.make_open_read (test_file_name)
			from
				f.read_line
				check_object (f.last_string, expected_value)
			until
				f.end_of_file
			loop
				f.read_line
				if not f.end_of_file then
					check_object (f.last_string, expected_value)
				end
			end
			f.close

			create f.make_open_read (test_file_name)
			from
				f.read_line_thread_aware
				check_object (f.last_string, expected_value)
			until
				f.end_of_file
			loop
				f.read_line_thread_aware
				if not f.end_of_file then
					check_object (f.last_string, expected_value)
				end
			end
			f.close

			create f.make_open_read (test_file_name)
			f.read_stream (expected_value.count)
			check_object (f.last_string, expected_value)
			f.close

			create f.make_open_read (test_file_name)
			f.read_stream_thread_aware (expected_value.count)
			check_object (f.last_string, expected_value)
			f.close
		end

feature {NONE} -- Implementation

	check_object (a_str1, a_str2: STRING) is
		local
			l_result: BOOLEAN
		do
			l_result := equal (a_str1, a_str2)
			if not l_result then
				print ("Not OK")
			end
		end

	test_file_name: STRING = "file.txt"
	expected_value: STRING = "qaqaqaqaqaqaqaqaqaqaqaqaqaqaqaq aqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa%Tqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa  qaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa"

	expected_word_1: STRING = "qaqaqaqaqaqaqaqaqaqaqaqaqaqaqaq"
	expected_word_2: STRING = "aqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa"
	expected_word_3: STRING = "qaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa"
	expected_word_4: STRING = "qaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqaqa"

end
