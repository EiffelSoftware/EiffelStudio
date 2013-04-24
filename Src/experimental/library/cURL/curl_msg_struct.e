note
	description: "[
	
		C Struct CURLMsg wrapper
		Read multi stack informationals
		
		This class is used by {CURL_MSG_STRUCT}.info_read
		
		More info:
		http://curl.haxx.se/libcurl/c/curl_multi_info_read.html
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_MSG_STRUCT

create
	make

feature {NONE} -- Initialization

	make (a_pointer: POINTER)
			-- Creation method
			-- Bind message structure to the address `a_pointer'".
		require
			not_default: a_pointer /= default_pointer
		do
			item := a_pointer
		ensure
			set: item = a_pointer
		end

feature -- Query

	curl_handle: POINTER
			-- CURL easy_handle
			-- The handle it concerns
		do
			Result := c_curl_handle (item)
		end

	msg: INTEGER
			-- What does this message mean?
			-- It's one value from {CURLMSG}
		do
			Result := c_msg (item)
		end

feature {NONE} -- Implementation

	item: POINTER
			-- C struct item

feature {NONE} -- C externals

	c_curl_handle (a_item: POINTER): POINTER
			-- cURL easy handle it concerns
		external
			"C inline use <curl/curl.h>"
		alias
			"return (CURL *)((CURLMsg *)$a_item)->easy_handle;"
		end

	c_msg (a_item: POINTER): INTEGER
			-- Get msg
		external
			"C inline use <curl/curl.h>"
		alias
			"return (CURLMSG)((CURLMsg *)$a_item)->msg;"
		end

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
