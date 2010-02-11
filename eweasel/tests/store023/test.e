class
	TEST

inherit
	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Initialization

	make
		do
			test_sed_storable
			test_c_storable
		end

feature -- Initialization

	test_sed_storable is
			-- Creation procedure.
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_reader_writer: SED_MEDIUM_READER_WRITER
		do
			create a.make
			create l_file.make ("output.data")
			create l_reader_writer.make (l_file)

				-- Session store
			l_file.open_write
			l_reader_writer.set_for_writing
			session_store (a, l_reader_writer, True)
			l_file.close

			l_file.open_read
			l_reader_writer.set_for_reading
			if attached {A} retrieved (l_reader_writer, False) as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- Basic store
			l_file.open_write
			l_reader_writer.set_for_writing
			basic_store (a, l_reader_writer, True)
			l_file.close

			l_file.open_read
			l_reader_writer.set_for_reading
			if attached {A} retrieved (l_reader_writer, False) as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close

				-- Independent store
			l_file.open_write
			l_reader_writer.set_for_writing
			independent_store (a, l_reader_writer, True)
			l_file.close

			l_file.open_read
			l_reader_writer.set_for_reading
			if attached {A} retrieved (l_reader_writer, False) as l_a then
				l_a.dump
			else
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

	test_c_storable is
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
