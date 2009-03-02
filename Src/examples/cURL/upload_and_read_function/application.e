note
	description	: "[
						cURL http put (post) example. 
						This example show how to redefine cURL read function also. Please
						check {MY_CURL_READ_FUNCTION}

						Before running this application, you need to:
						1.copy "put.php" to your PHP web server
						2.change "put.php"'s content (change saving file path)
						3.change following "http://your_php_server_url/put.php" to your value
					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date:(Wed, 18 Feb 2009) $"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			l_result: INTEGER
			l_fupload: RAW_FILE
			l_str: STRING
		do
			print ("Eiffel cURL http put example.%N")

			curl.global_init

				-- Init the curl session
			curl_handle := curl_easy.init

				-- enable uploadig
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_upload, 1)

				-- specify target URL
			create l_str.make_from_string ("http://your_php_server_url/put.php")	-- Please change to your PHP server's url
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_str)

				-- specify callback read function for upload file
			curl_easy.set_curl_function (create {MY_CURL_READ_FUNCTION}.make)
			curl_easy.set_read_function (curl_handle)

				-- provide the file size
			create l_fupload.make_open_read ("eiffel_tower.jpg")
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_infilesize_large, l_fupload.count)

				-- perform, result is one value from {CURL_CODES} (0 = ok)
			l_result := curl_easy.perform (curl_handle)
			print ("perform result is: " + l_result.out + "%N")

			l_fupload.close
			--  Cleanup curl stuff
			curl_easy.cleanup (curl_handle)
			curl.global_cleanup
		end

feature {NONE} -- Implementation

	curl: CURL_EXTERNALS is
			-- cURL externals
		once
			create Result
		end

	curl_easy: CURL_EASY_EXTERNALS is
			-- cURL easy externals
		once
			create Result
		end

	curl_handle: POINTER;
			-- cURL handle

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
