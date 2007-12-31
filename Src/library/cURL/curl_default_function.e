indexing
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

	make is
			-- Creation method
		do
			set_object_and_function_address
		end

feature -- Command

	progress_function (a_object_id: POINTER; a_download_total, a_download_now, a_upload_total, a_upload_now: REAL_64): INTEGER is
			-- Redefine
		do
		end

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER is
			-- Redefine
		local
			l_c_string: C_STRING
			l_string: CURL_STRING
			l_identified: IDENTIFIED
		do
			Result := a_size * a_nmemb
			create l_c_string.share_from_pointer_and_count (a_data_pointer, Result)

			create l_identified
			l_string ?= l_identified.id_object (a_object_id.to_integer_32)
			check not_void: l_string /= Void end
			l_string.append (l_c_string.string)
		end

	debug_function (a_curl_handle: POINTER; a_curl_infotype: INTEGER; a_char_pointer: POINTER; a_size: INTEGER; a_object_id: POINTER): INTEGER is
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
				print ("%N== Info: " + l_c_string.string)
			else
				check type_unknow: False end
			end
		end

feature {NONE} -- Implementation

	dump (a_text: STRING; a_char_pointer: POINTER; a_size: INTEGER) is
			-- Dump debug information
		require
			not_void: a_text /= Void
			exists: a_char_pointer /= default_pointer
			non_negative: a_size >= 0
		local
			l_c_string: C_STRING
		do
			create l_c_string.share_from_pointer_and_count (a_char_pointer, a_size)
			print ("%N" + a_text + "%N" + l_c_string.string)
		end

indexing
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
