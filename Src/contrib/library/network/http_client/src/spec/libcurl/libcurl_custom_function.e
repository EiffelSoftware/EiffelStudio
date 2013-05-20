note
	description: "[
				LIBCURL_CUSTOM_FUNCTION is used to custom the input and output libcurl execution

			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_CUSTOM_FUNCTION

inherit
	LIBCURL_DEFAULT_FUNCTION
		redefine
			read_function,
			write_function
		end

create
	make

feature -- Access

	write_procedure: detachable PROCEDURE [ANY, TUPLE [READABLE_STRING_8]]
			-- File for sending data

	file_to_read: detachable FILE
			-- File for sending data

feature -- Change

	set_write_procedure (proc: like write_procedure)
		do
			write_procedure := proc
		end

	set_file_to_read (f: like file_to_read)
		do
			file_to_read := f
		end

feature -- Basic operation

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- Redefine
		local
			l_c_string: C_STRING
			s: STRING
		do
			if attached write_procedure as agt then
				Result := a_size * a_nmemb
				create l_c_string.make_shared_from_pointer_and_count (a_data_pointer, Result)
				s := l_c_string.substring (1, Result)
				agt.call ([s])
			else
				Result := Precursor (a_data_pointer, a_size, a_nmemb, a_object_id)
			end
		end

	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER_32; a_object_id: POINTER): INTEGER_32
			-- <Precursor>
		local
			l_pointer: MANAGED_POINTER
			l_max_transfer, l_byte_transfered: INTEGER
		do
			if attached file_to_read as l_file then
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
			else
				Result := Precursor (a_data_pointer, a_size, a_nmemb, a_object_id)
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
