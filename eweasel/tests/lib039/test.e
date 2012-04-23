class TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make
feature

	make
		local
			l_file_1, l_file_2: PLAIN_TEXT_FILE
			l_file_1_info, l_file_2_info : UNIX_FILE_INFO
			l_file_1_date, l_file_2_date : INTEGER
		do
			create l_file_1.make_open_write ("input1")
			l_file_1.close
				-- Sleep 2s to have two different timestamps
			sleep (2_000_000_000)
			create l_file_2.make_open_write ("input2")
			l_file_2.close

			l_file_1_info := l_file_1.file_info
			l_file_1_date := l_file_1_info.date

			l_file_2_info := l_file_2.file_info
			l_file_2_date := l_file_2_info.date

			if l_file_1_date /= l_file_1_info.date then
					-- Error: values no longer match
				io.put_string ("Not OK!")
				io.put_new_line
			end

			create l_file_1_info.make
			l_file_1_info.update ("input1")
			l_file_1_date := l_file_1_info.date

			l_file_2_info := l_file_1_info.twin
			l_file_2_info.update ("input2")

			if l_file_1_date /= l_file_1_info.date then
					-- Error: values no longer match
				io.put_string ("Not OK!")
				io.put_new_line
			end
		end

end
