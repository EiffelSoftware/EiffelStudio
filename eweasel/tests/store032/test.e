class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_thread: WORKER_THREAD
			l_file: RAW_FILE
		do
			create l_thread.make (agent read_write)
			l_thread.launch
			l_thread.join

			create l_file.make_open_read ("file1")
			if attached l_file.retrieved as l_data then
				io.put_string (l_data.generating_type)
				io.put_new_line
			end
			l_file.close
		end

	read_write
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write ("file1")
			l_file.independent_store (create {ANY})
			l_file.close
		end

end
