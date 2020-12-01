class TEST

create
	retrieve,
	store

feature {NONE} -- Creation

	store
			-- Store expanded objects attached to reference fields to a file.
		local
			file: RAW_FILE
			cell: CELL [ANY]
			serializer: SED_STORABLE_FACILITIES
			writer: SED_MEDIUM_READER_WRITER
			point: POINT
			special: SPECIAL [ANY]
		do
				-- Initialize serializer.
			create file.make_open_write (file_name)
			create writer.make_for_writing (file)
			create serializer
				-- Store basic expanded as reference.
			create cell.put ({INTEGER_8} 5)
			serializer.store (cell, writer)
				-- Store custom expanded as reference.
			point.set_x (2)
			point.set_y (5)
			cell.put (point)
			serializer.store (cell, writer)
				-- Store basic and custom expanded as reference in `{SPECIAL}'.
			create special.make_filled ("Foo", 3)
			special.put (True, 1)
			special.put ((create {POINT}).moved (1, 1), 2)
			serializer.store (special, writer)
				-- Cleanup resources.
			file.close
				-- Check that everything is stored correctly.
			retrieve
		end

	retrieve
			-- Retrieve data from a file and print it.
		local
			file: RAW_FILE
			reader: SED_MEDIUM_READER_WRITER
		do
				-- Initialize deserializer.
			create file.make_open_read (file_name)
			create reader.make_for_reading (file)
				-- Read and print stored data.
			report (reader)
			report (reader)
			report (reader)
				-- Cleanup resources.
			file.close
		end

feature {NONE} -- Output

	report (reader: SED_MEDIUM_READER_WRITER)
			-- Report what data is retrieved and print it.
		local
			deserializer: SED_STORABLE_FACILITIES
			data: ANY
		do
			create deserializer
			data := deserializer.retrieved (reader, True)
			if attached deserializer.retrieved_errors as es then
				io.put_string ("Error(s) retrieving data: ")
				across
					es as e
				loop
					io.put_string_32 (e.item.message)
					io.put_new_line
				end
			elseif attached data then
				if attached {CELL [ANY]} data as cell then
					io.put_character ('{')
					if attached cell.item as item then
						io.put_string (item.out)
					end
					io.put_character ('}')
				elseif attached {SPECIAL [ANY]} data as special then
					io.put_character ('[')
					across
						special as element
					loop
						if not element.is_first then
							io.put_string (", ")
						end
						if attached element.item as item then
							io.put_string (item.out)
						end
					end
					io.put_character (']')
				end
			else
				io.put_string ("Void")
			end
			io.put_new_line
			reader.cleanup
		end

feature {NONE} -- Access

	file_name: STRING_32
			-- A name of a file used to store data.
		local
			arguments: ARGUMENTS_32
		do
			create arguments
			if arguments.argument_count > 0 then
				Result := arguments.argument (1)
			else
				Result := {STRING_32} "test.dat"
			end
		end

end
