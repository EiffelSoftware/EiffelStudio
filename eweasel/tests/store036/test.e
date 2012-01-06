class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_object: ANY
			l_file: RAW_FILE
		do
			create l_file.make ("file.store")
			l_file.open_read
			l_object := l_file.retrieved
			l_file.close
		end

	s2: ROSE_DATE

end
