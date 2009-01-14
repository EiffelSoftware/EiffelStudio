class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create tag_server
			save_to_file
			retrieve_from_file
		end

feature {NONE} -- Implementation

	storage_file_name: STRING = "stored_file"

	retrieve_from_file
			-- Retrieve storage from file	
		local
			l_file: ?RAW_FILE
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
					if not {l_tuple: TUPLE [tag_server: like tag_server]}l_facility.retrieved (l_reader, True) then
						print ("Deserialization failed.%N")
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
			l_tuple: TUPLE [tag_server: like tag_server]
			l_file: ?RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_tuple := [tag_server]
				create l_file.make_create_read_write (storage_file_name)
				create l_writer.make (l_file)
				create l_facility
				l_facility.independent_store (l_tuple, l_writer, True)
				l_file.close
			end
		rescue
			l_retried := True
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

	tag_server: !SERVER [STRING_32, STRING_32]
			-- Tag server

end
