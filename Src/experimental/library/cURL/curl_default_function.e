note
	description: "[
					Default implementation of CURL_FUNCTION.
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_DEFAULT_FUNCTION

inherit
	CURL_FUNCTION

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			set_object_and_function_address
		end

feature -- Command

	progress_function (a_object_id: POINTER; a_download_total, a_download_now, a_upload_total, a_upload_now: REAL_64): INTEGER
		do
		end

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
		local
			l_c_string: C_STRING
		do
				-- Returns the number of bytes actually saved into object identified by `a_object_id'
			Result := a_size * a_nmemb
			create l_c_string.make_shared_from_pointer_and_count (a_data_pointer, Result)

			check attached {CURL_STRING} (create {IDENTIFIED}).id_object (a_object_id.to_integer_32) as l_string then
				l_string.append (l_c_string.substring (1, Result))
			end
		end

	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- A callback readfunction
		do
		end

	debug_function (a_curl_handle: POINTER; a_curl_infotype: INTEGER; a_char_pointer: POINTER; a_size: INTEGER; a_object_id: POINTER): INTEGER
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
				print ("%N== Info: " + l_c_string.string)
			else
				check type_unknow: False end
			end
		end

feature {NONE} -- Implementation

	dump (a_text: STRING; a_char_pointer: POINTER; a_size: INTEGER)
			-- Dump debug information
		require
			not_void: a_text /= Void
			exists: a_char_pointer /= default_pointer
			non_negative: a_size >= 0
		local
			l_c_string: C_STRING
		do
			create l_c_string.make_shared_from_pointer_and_count (a_char_pointer, a_size)
			print ("%N" + a_text + "%N" + l_c_string.string)
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
