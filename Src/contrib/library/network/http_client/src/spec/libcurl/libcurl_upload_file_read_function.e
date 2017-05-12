note
	description: "[
				LIBCURL_UPLOAD_FILE_READ_FUNCTION is used to uploaded file as part of the client request
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_UPLOAD_FILE_READ_FUNCTION

obsolete
	"Use LIBCURL_CUSTOM_FUNCTION [2017-05-31]"

inherit
	LIBCURL_DEFAULT_FUNCTION
		redefine
			read_function
		end

create
	make_with_file

feature {NONE} -- Initialization

	make_with_file (f: FILE)
		require
			f_is_open: f.is_open_read
		do
			make
			file_to_read := f
		end

feature -- Access

	file_to_read: detachable FILE
			-- File for sending data

feature -- Basic operation

	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER_32; a_object_id: POINTER): INTEGER_32
			-- <Precursor>
		local
			l_pointer: MANAGED_POINTER
			l_max_transfer, l_byte_transfered: INTEGER
		do
			if attached file_to_read as l_file and then not l_file.after then
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
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
