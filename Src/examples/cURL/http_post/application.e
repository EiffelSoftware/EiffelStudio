indexing
	description	: "[
						cURL http post example Eiffel version. 
						For original C version, please see:
						http://curl.haxx.se/lxr/source/docs/examples/http-post.c
						
						This demo will post something to target http website. 
						This demo will not works since the target http website URL is fake.
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
		do
			print ("Eiffel cURL http post example.%N")

			curl_handle := curl_easy.init

			if curl_handle /= default_pointer then
				-- First set the URL that is about to receive our POST. This URL can
				-- just as well be a https:// URL if that is what should receive the
				-- data.
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "http://postit.example.com/moo.cgi")

				-- Now specify the POST data
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, "name=daniel&project=curl")

				-- Perform the request, `l_result' will get the return code
				l_result := curl_easy.perform (curl_handle)

				-- Always cleanup
				curl_easy.cleanup (curl_handle)
			end

		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS is
			-- cURL easy externals
		once
			create Result
		end

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
