note
	description: "[
						cURL library info constants.
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_INFO_CONSTANTS

feature -- Constants

	curlinfo_string: INTEGER = 0x100000
			-- Declared as CURLINFO_STRING

	curlinfo_long: INTEGER = 0x200000
			-- Declared as CURLINFO_LONG

	curlinfo_double: INTEGER = 0x300000
			-- Declared as CURLINFO_DOUBLE

	curlinfo_slist: INTEGER = 0x400000
			-- Declared as CURLINFO_SLIST

	curlinfo_mask: INTEGER = 0x0fffff
			-- Declared as CURLINFO_MASK

	curlinfo_typemask: INTEGER = 0xf00000
			-- Declared as CURLINFO_TYPEMASK

feature -- Info constants

	curlinfo_effective_url: INTEGER = 0x100001  			-- CURLINFO_STRING + 1,
	curlinfo_response_code: INTEGER = 0x200002				-- CURLINFO_LONG   + 2,
	curlinfo_total_time: INTEGER = 0x300003					-- CURLINFO_DOUBLE + 3,
	curlinfo_namelookup_time: INTEGER = 0x300004			-- CURLINFO_DOUBLE + 4,
	curlinfo_connect_time: INTEGER = 0x300005				-- CURLINFO_DOUBLE + 5,
	curlinfo_pretransfer_time: INTEGER = 0x300006			-- CURLINFO_DOUBLE + 6,
	curlinfo_size_upload: INTEGER = 0x300007				-- CURLINFO_DOUBLE + 7,
	curlinfo_size_download: INTEGER = 0x300008				-- CURLINFO_DOUBLE + 8,
	curlinfo_speed_download: INTEGER = 0x300009				-- CURLINFO_DOUBLE + 9,
	curlinfo_speed_upload: INTEGER = 0x30000a				-- CURLINFO_DOUBLE + 10,
	curlinfo_header_size: INTEGER = 0x20000b				-- CURLINFO_LONG   + 11,
	curlinfo_request_size: INTEGER = 0x20000c				-- CURLINFO_LONG   + 12,
	curlinfo_ssl_verifyresult: INTEGER = 0x20000d			-- CURLINFO_LONG   + 13,
	curlinfo_filetime: INTEGER = 0x20000e					-- CURLINFO_LONG   + 14,
	curlinfo_content_length_download: INTEGER = 0x30000f	-- CURLINFO_DOUBLE + 15,
	curlinfo_content_length_upload: INTEGER = 0x300010		-- CURLINFO_DOUBLE + 16,
	curlinfo_starttransfer_time: INTEGER = 0x300011			-- CURLINFO_DOUBLE + 17,
	curlinfo_content_type: INTEGER = 0x100012				-- CURLINFO_STRING + 18,
	curlinfo_redirect_time: INTEGER = 0x300013				-- CURLINFO_DOUBLE + 19,
	curlinfo_redirect_count: INTEGER = 0x200014				-- CURLINFO_LONG   + 20,
	curlinfo_private: INTEGER = 0x100015					-- CURLINFO_STRING + 21,
	curlinfo_http_connectcode: INTEGER = 0x200016			-- CURLINFO_LONG   + 22,
	curlinfo_httpauth_avail: INTEGER = 0x200017				-- CURLINFO_LONG   + 23,
	curlinfo_proxyauth_avail: INTEGER = 0x200018			-- CURLINFO_LONG   + 24,
	curlinfo_os_errno: INTEGER = 0x200019					-- CURLINFO_LONG   + 25,
	curlinfo_num_connects: INTEGER = 0x20001a				-- CURLINFO_LONG   + 26,
	curlinfo_ssl_engines: INTEGER = 0x40001b				-- CURLINFO_SLIST  + 27,
	curlinfo_cookielist: INTEGER = 0x40001c					-- CURLINFO_SLIST  + 28,
	curlinfo_lastsocket: INTEGER = 0x20001d					-- CURLINFO_LONG   + 29,
	curlinfo_ftp_entry_path: INTEGER = 0x10001e				-- CURLINFO_STRING + 30,

feature -- Contract support

	is_valid (a_code: INTEGER): BOOLEAN
			-- Is `a_code' valid?
		do
			inspect a_code
			when
				curlinfo_effective_url,
				curlinfo_response_code,
				curlinfo_total_time,
				curlinfo_namelookup_time,
				curlinfo_connect_time,
				curlinfo_pretransfer_time,
				curlinfo_size_upload,
				curlinfo_size_download,
				curlinfo_speed_download,
				curlinfo_speed_upload,
				curlinfo_header_size,
				curlinfo_request_size,
				curlinfo_ssl_verifyresult,
				curlinfo_filetime,
				curlinfo_content_length_download,
				curlinfo_content_length_upload,
				curlinfo_starttransfer_time,
				curlinfo_content_type,
				curlinfo_redirect_time,
				curlinfo_redirect_count,
				curlinfo_private,
				curlinfo_http_connectcode,
				curlinfo_httpauth_avail,
				curlinfo_proxyauth_avail,
				curlinfo_os_errno,
				curlinfo_num_connects,
				curlinfo_ssl_engines,
				curlinfo_cookielist,
				curlinfo_lastsocket,
				curlinfo_ftp_entry_path 
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
