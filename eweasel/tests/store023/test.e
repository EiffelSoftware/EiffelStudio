class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
		do
			create l_file.make ("output.data")
			create a.make

				-- Basic store
			l_file.open_write
			l_file.basic_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- General store
			l_file.open_write
			l_file.general_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- Independent store
			l_file.open_write
			l_file.independent_store (a)
			l_file.close

			l_file.open_read
			if attached {A} l_file.retrieved as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

end
