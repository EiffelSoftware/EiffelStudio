note
	description: "CURL_PAYLOAD_DATA_FUNCTION is used to custom the input and output libcurl execution"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_PAYLOAD_DATA_FUNCTION

inherit

	CURL_DEFAULT_FUNCTION
		redefine
			read_function
		end

create
	make

feature -- Access

	data_to_read: detachable STRING
			-- Data for sending data

feature -- Change

	set_data_to_read (f: like data_to_read)
		do
			data_to_read := f
		end

feature -- Basic operation


	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER_32; a_object_id: POINTER): INTEGER_32
			-- <Precursor>
		local
			l_pointer: MANAGED_POINTER
			l_max_transfer, l_byte_transfered: INTEGER
			l_buffer: STRING
			index: INTEGER
		do
			if attached data_to_read as l_data then
				if not l_data.is_empty then
					l_max_transfer := a_size * a_nmemb
					create l_buffer.make_from_string (l_data)
					if l_max_transfer > l_buffer.count then
						l_max_transfer := l_buffer.count
					end
					create l_pointer.share_from_pointer (a_data_pointer, l_max_transfer)

					from
						index := 1
					until
						l_buffer.is_empty or l_byte_transfered >= l_max_transfer
					loop
						l_pointer.put_character (l_buffer.at (index), l_byte_transfered)
						index := index + 1
						l_byte_transfered := l_byte_transfered + 1
					end

					Result := l_max_transfer
				else
					-- Result is 0 means stop file transfer
					Result := 0
				end
			else
				Result := Precursor (a_data_pointer, a_size, a_nmemb, a_object_id)
			end
		end


--	read_function_2 (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER_32; a_object_id: POINTER): INTEGER_32
--			-- <Precursor>
--		local
--			l_pointer: MANAGED_POINTER
--			l_max_transfer, l_byte_transfered: INTEGER
--		do
--			if attached data_to_read as l_file then
--				if not l_file.after then
--					l_max_transfer := a_size * a_nmemb
--					if l_max_transfer > l_file.count - l_file.position then
--						l_max_transfer := l_file.count - l_file.position
--					end
--					create l_pointer.share_from_pointer (a_data_pointer, l_max_transfer)

--					from
--					until
--						l_file.after or l_byte_transfered >= l_max_transfer
--					loop
--						l_file.read_character
--						l_pointer.put_character (l_file.last_character, l_byte_transfered)

--						l_byte_transfered := l_byte_transfered + 1
--					end

--					Result := l_max_transfer
--				else
--					-- Result is 0 means stop file transfer
--					Result := 0
--				end
--			else
----				Result := Precursor (a_data_pointer, a_size, a_nmemb, a_object_id)
--			end
--		end

end
