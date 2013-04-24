note
	description: "[
						cURL library info type constants.
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_INFO_TYPE

feature -- Enumeration

	curlinfo_text: INTEGER = 0
			-- Declared as CURLINFO_TEXT

	curlinfo_header_in: INTEGER = 1
			-- Declared as CURLINFO_HEADER_IN

	curlinfo_header_out: INTEGER = 2
			-- Declared as CURLINFO_HEADER_OUT

	curlinfo_data_in: INTEGER = 3
			-- Declared as CURLINFO_DATA_IN

	curlinfo_data_out: INTEGER = 4
			-- Declared as CURLINFO_DATA_OUT

	curlinfo_ssl_data_in: INTEGER = 5
	 		-- Declared as CURLINFO_SSL_DATA_IN

	curlinfo_ssl_data_out: INTEGER = 6
			-- Declared as CURLINFO_SSL_DATA_OUT

feature -- Contract support

	is_valid (a_type: INTEGER): BOOLEAN
			-- If `a_type' valid?
		do
			inspect a_type
			when
				curlinfo_data_in,
				curlinfo_data_out,
				curlinfo_header_in,
				curlinfo_header_out,
				curlinfo_ssl_data_in,
				curlinfo_ssl_data_out,
				curlinfo_text
			then
				Result := True
			else
				Result := False
			end
		end

note
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
