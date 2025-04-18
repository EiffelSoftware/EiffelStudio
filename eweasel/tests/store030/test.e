class
	TEST

inherit
	ARGUMENTS

	SED_STORABLE_FACILITIES

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
			test_c_basic_storable
			test_c_general_storable
			test_c_independent_storable
			test_sed_storable
		end

	test_sed_storable
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_reader_writer: SED_MEDIUM_READER_WRITER
			l_is_storing: BOOLEAN
		do
			create a.make
			create l_file.make_with_name ("output.data")
			create l_reader_writer.make (l_file)

			if argument_count >= 1 and then argument (1).is_integer then
				l_is_storing := argument (1).to_integer = 1
			end

			create a.make

				-- Independent store
			l_file.make_with_name ("output.data.sed.independent")
			if l_is_storing then
				l_file.open_write
				l_reader_writer.set_for_writing
				store (a, l_reader_writer)
				l_file.close
			end

			l_file.open_read
			l_reader_writer.set_for_reading
			if not attached {A} retrieved (l_reader_writer, False) then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

	test_c_basic_storable
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_is_storing: BOOLEAN
		do
			if argument_count >= 1 and then argument (1).is_integer then
				l_is_storing := argument (1).to_integer = 1
			end

			create a.make

				-- Basic store
			create l_file.make_with_name ("output.data.basic")
			if l_is_storing then
				l_file.open_write
				l_file.basic_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

	test_c_general_storable
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_is_storing: BOOLEAN
		do
			if argument_count >= 1 and then argument (1).is_integer then
				l_is_storing := argument (1).to_integer = 1
			end

			create a.make

				-- General store
			create l_file.make_with_name ("output.data.general")
			if l_is_storing then
				l_file.open_write
				l_file.general_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

	test_c_independent_storable
		local
			a: A
			l_any: ANY
			l_file: RAW_FILE
			l_is_storing: BOOLEAN
		do
			if argument_count >= 1 and then argument (1).is_integer then
				l_is_storing := argument (1).to_integer = 1
			end

			create a.make

				-- Independent store
			create l_file.make_with_name ("output.data.independent")
			if l_is_storing then
				l_file.open_write
				l_file.independent_store (a)
				l_file.close
			end

			l_file.open_read
			if not attached {A} l_file.retrieved then
				io.put_string ("Failure")
				io.put_new_line
			end
			l_file.close
		end

end
