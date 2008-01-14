indexing
	description	: "[
						cURL get_in_memory example Eiffel version. 
						For original C version, please see:
						http://curl.haxx.se/lxr/source/docs/examples/getinmemory.c
						
						This demo will get html source from http://www.google.com, then write it to an Eiffel string object.
						This demo will download the html file to Eiffel string object only.
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

	make is
			-- Run application.
		local
			l_result: INTEGER
			l_curl_string: CURL_STRING
		do
			print ("Eiffel cURL get in memory example.%N")

			create l_curl_string.make_empty

			curl.global_init

			-- Init the curl session
			curl_handle := curl_easy.init

			-- Specify URL to get
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "http://www.google.com")

			-- Send all data to default Eiffel curl write function
			curl_easy.set_write_function (curl_handle)

			-- We pass our `l_curl_string''s object id to the callback function */
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string.object_id)

			-- Get it!
			l_result := curl_easy.perform (curl_handle)

			--  Cleanup curl stuff
			curl_easy.cleanup (curl_handle)

			--Now, our `l_curl_string' contains the remote html source codes.

			--Do something nice with it!
			if not l_curl_string.is_empty then
				print ("Remote html source got. Size is: " + l_curl_string.count.out + ". ")
			end

			--You don't need to be aware of memory management issue since Eiffel will handle all of them for you.

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

	curl_string: CURL_STRING
			-- String used by Eiffel cURL library.

	curl_handle: POINTER;
			-- cURL handle

indexing
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
