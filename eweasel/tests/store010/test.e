class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			a: A
		do
			create a.make_reference
			a ?= store_retrieve_independent (a)
			io.put_boolean (a.b1 = a.b2)
			io.put_new_line
			create a.make_expanded
			a ?= store_retrieve_independent (a)
			io.put_boolean (a.b1 = a.b2)
			io.put_new_line
		end

feature {NONE} -- Implementation

	store_retrieve_independent (an_object: ANY): ANY is
			-- Store and retrieve `an_object'.
		local
			l_serializer: SED_STORABLE_FACILITIES
			l_med: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
		do
			create l_serializer

			create l_file.make ("output.data")
			create l_med.make (l_file)

			l_file.open_write
			l_med.set_for_writing
			l_serializer.independent_store (an_object, l_med, False)
			l_file.close

			l_file.open_read
			l_med.set_for_reading
			Result := l_serializer.retrieved (l_med, True)
			l_file.close
		end

end
