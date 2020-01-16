note
	description	: "[
						cURL simple sftp Eiffel version. 
						For original C version, please see:
						hhttps://curl.haxx.se/libcurl/c/sftpget.html
						
						Gets a file using an SFTP URL.

					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			l_result: INTEGER
			l_write_func: SFTP_WRITE_FUNCTION
		do
			io.put_string ("Eiffel cURL simple sftp.")
			io.put_new_line

			if curl_easy.is_api_available then

				curl.global_init


				curl_handle := curl_easy.init

					-- First we specify which URL we would like to get file from sftp.
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "sftp://test.rebex.net/readme.txt")

					-- Setup the user credentials
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_USERPWD, "demo:password")

				create l_write_func.make
				l_write_func.set_file_to_write (create {RAW_FILE}.make_create_read_write ("download.txt"))

					-- Define our callback to get called when there's data to be written */
				curl_easy.set_curl_function (l_write_func)
				curl_easy.set_write_function (curl_handle)

					-- use a self-signed test server, skip verification during debugging
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 0)

					-- verbose output
				curl_easy.setopt_integer (curl_handle,{CURL_OPT_CONSTANTS}.curlopt_verbose, 1)


				l_result := curl_easy.perform (curl_handle)

					-- Always cleanup
				curl_easy.cleanup (curl_handle)
				curl.global_cleanup
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	curl_handle: POINTER;
			-- cURL handle

	curl: CURL_EXTERNALS
			-- cURL externals
		once
			create Result
		end


note
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class APPLICATION
