note
	description: "[
					Default implementation of CURL_FUNCTION.
					Fixing eventual issue from CURL_DEFAULT_FUNCTION
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_DEFAULT_FUNCTION

inherit
	CURL_DEFAULT_FUNCTION
		redefine
			write_function,
			debug_function,
			dump
		end

create
	make

feature -- Command

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- Redefine
		local
			l_c_string: C_STRING
			l_identified: IDENTIFIED
		do
			Result := a_size * a_nmemb
			create l_c_string.make_shared_from_pointer_and_count (a_data_pointer, Result)

			create l_identified
			if attached {CURL_STRING} l_identified.id_object (a_object_id.to_integer_32) as l_string then
				l_string.append (l_c_string.substring (1, Result))
			else
				check False end
			end
		end

	debug_function (a_curl_handle: POINTER; a_curl_infotype: INTEGER; a_char_pointer: POINTER; a_size: INTEGER; a_object_id: POINTER): INTEGER
			-- Redefine
		local
			l_c_string: C_STRING
		do
			inspect
				a_curl_infotype
			when {CURL_INFO_TYPE}.curlinfo_data_in then
				dump ("<= Recv data", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_data_out then
				dump ("=> Send data", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_header_in then
				dump ("<= Recv header", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_header_out then
				dump ("=> Send header", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_ssl_data_in then
				dump ("<= Recv SSL data", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_ssl_data_out then
				dump ("=> Send SSL data", a_char_pointer, a_size)
			when {CURL_INFO_TYPE}.curlinfo_text then
				create l_c_string.make_by_pointer_and_count (a_char_pointer, a_size)
				print ("%N== Info: " + l_c_string.substring (1, a_size))
			else
				check type_unknow: False end
			end
		end

feature {NONE} -- Implementation

	dump (a_text: STRING; a_char_pointer: POINTER; a_size: INTEGER)
			-- Dump debug information
		local
			l_c_string: C_STRING
		do
			create l_c_string.make_shared_from_pointer_and_count (a_char_pointer, a_size)
			print ("%N" + a_text + "%N" + l_c_string.substring (1, a_size))
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
