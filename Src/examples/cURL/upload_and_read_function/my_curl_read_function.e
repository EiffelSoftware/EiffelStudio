note
	description: "Redefined cURL readfunction"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date:(Wed, 18 Feb 2009) $"
	revision: "$Revision$"

class
	MY_CURL_READ_FUNCTION

inherit
	CURL_DEFAULT_FUNCTION
		redefine
			read_function
		end

create
	make

feature -- Redefine

	file_to_read: RAW_FILE
			-- File for sending data
		once
			create Result.make_with_name ("eiffel_tower.jpg")
			Result.open_read
			Result.start
		ensure
			exists: Result.exists
		end

	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER_32; a_object_id: POINTER): INTEGER_32
			-- <Precursor>
		local
			l_pointer: MANAGED_POINTER
			l_file: RAW_FILE
			l_max_transfer, l_byte_transfered: INTEGER
		do
			l_file := file_to_read
			if not l_file.after then
				l_max_transfer := a_size * a_nmemb
				if l_max_transfer > l_file.count - l_file.position then
					l_max_transfer := l_file.count - l_file.position
				end
				create l_pointer.share_from_pointer (a_data_pointer, l_max_transfer)

				from
				until
					l_file.after or l_byte_transfered >= l_max_transfer
				loop
					l_file.read_character
					l_pointer.put_character (l_file.last_character, l_byte_transfered)

					l_byte_transfered := l_byte_transfered + 1
				end

				Result := l_max_transfer
			else
				-- Result is 0 means stop file transfer
				Result := 0
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class APPLICATION
