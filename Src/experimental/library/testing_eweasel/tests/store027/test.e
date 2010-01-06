class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			print_list ("Original", (create {A}).entries.linear_representation)
			print_special ("Original_special", (create {A}).spec)
			save_to_file
			retrieve_from_file
		end

feature {NONE} -- Implementation

	storage_file_name: STRING = "stored_file"

	retrieve_from_file
			-- Retrieve storage from file	
		local
			l_file: detachable RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (storage_file_name)
				if l_file.exists then
					l_file.open_read
					create l_reader.make (l_file)
					l_reader.set_for_reading
					create l_facility
					if attached {A} l_facility.retrieved (l_reader, True) as l_a then
						print_list ("A", l_a.entries.linear_representation)
						print_special ("Special", l_a.spec)
					end
				end
				if not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			l_retried := True
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

	save_to_file
			-- Save storage to file when needed.
		local
			l_file: detachable RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make_create_read_write (storage_file_name)
				create l_writer.make (l_file)
				create l_facility
				l_facility.independent_store (create {A}, l_writer, False)
				l_file.close
			end
		rescue
			l_retried := True
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

	print_list (tag: STRING; l: LINEAR [STRING])
		do
			io.put_string ("Test #" + tag + ":%N")
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
					io.put_string (l.item)
					io.put_character (' ')
					l.forth
				end
				io.put_new_line
			end
			io.put_new_line
		end

	print_special (tag: STRING; a_spec: SPECIAL [detachable STRING])
		local
			i, nb: INTEGER
		do
			io.put_string ("Test #" + tag + ":%N")
			from
				nb := a_spec.count
			until
				i = nb
			loop
				if attached a_spec.item (i) as l_string then
					io.put_string (l_string)
				else
					io.put_string ("Void")
				end
				io.put_character (' ')
				i := i + 1
			end
			io.put_new_line
			io.put_new_line
		end

end
