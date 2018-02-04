note
	description: "[
		The multi interface offers several abilities that the easy interface doesn't. They are mainly:
		1. Enable a "pull" interface. The application that uses libcurl decides where and when to ask libcurl to get/send data.
		2. Enable multiple simultaneous transfers in the same thread without making it complicated for the application.
		3. Enable the application to wait for action on its own file descriptors and curl's file descriptors simultaneous easily.
		
		More info: http://curl.haxx.se/libcurl/c/libcurl-multi.html
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_MULTI_EXTERNALS

inherit
	CURL_MULTI_EXTERNALS_I

feature -- Status report

	is_api_available: BOOLEAN
		do
			Result := {CURL_UTILITY}.is_static
		end

feature -- Function pointer

	curl_multi_init_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_init"
		end

	curl_multi_add_handle_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_add_handle"
		end

	curl_multi_remove_handle_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_remove_handle"
		end

	curl_multi_cleanup_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_cleanup"
		end

	curl_multi_perform_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_perform"
		end

	curl_multi_info_read_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_multi_info_read"
		end

--feature -- Command

--	init
--			-- Create a multi handle.
--			-- If success, Result is a cURL multi hanlde just created.
--			-- This feature maybe failed in some cases: cannot find required DLL, etc.
--			-- Then the post condition would be violated.
--		require
--			is_api_available: is_api_available
--		do
--			item := c_init (curl_multi_init_ptr)
--		end

--	add_handle (a_easy_handle: POINTER)
--			-- Add an easy handle to a multi session.
--		require
--			is_api_available: is_api_available
--			is_multi_handle_exists: is_exists
--		do
--			c_add_handle (curl_multi_add_handle_ptr, item, a_easy_handle)
--		end

--	remove_handle (a_easy_handle: POINTER)
--			-- Remove an easy handle from a multi session.
--		require
--			is_api_available: is_api_available
--			is_multi_handle_exists: is_exists
--		do
--			c_remove_handle (curl_multi_remove_handle_ptr, item, a_easy_handle)
--		end

--	cleanup: INTEGER
--			-- Close down a multi session.
--			-- Result is one value from {CURL_MULTI_CODES}.
--		require
--			is_api_available: is_api_available
--			is_multi_handle_exists: is_exists
--		do
--			Result := c_cleanup (curl_multi_cleanup_ptr, item)
--		end

--	perform (a_running_handle: CELL [INTEGER]): INTEGER
--			-- Reads/writes available data from each easy handle.
--			-- Result is one value from {CURL_MULTI_CODES}.
--		require
--			is_api_available: is_api_available
--			is_multi_handle_exists: is_exists
--		local
--			l_running_handle: INTEGER
--		do
--			Result := c_perform (curl_multi_perform_ptr, item, $l_running_handle)
--			a_running_handle.put (l_running_handle)
--		end

--	info_read (a_msgs_in_queue: CELL [INTEGER]): POINTER
--			-- Read multi stack informationals.
--			-- The result is C struct CURLMsg {CURL_MSG_STRUCT}.
--			-- Repeated calls to this function will return a new struct each time, until a NULL
--			-- is returned as a signal that there is no more to get at this point. The integer
--			-- pointed to with msgs_in_queue will contain the number of remaining messages after
--			-- this function was called.
--			-- When you fetch a message using this function, it is removed from the internal queue
--			-- so calling this function again will not return the same message again. It will instead
--			-- return new messages at each new invoke until the queue is emptied.
--		require
--			is_api_available: is_api_available
--			is_multi_handle_exists: is_exists
--		local
--			l_msgs_in_queue: INTEGER
--		do
--			Result := c_info_read (curl_multi_info_read_ptr, item, $l_msgs_in_queue)
--			a_msgs_in_queue.put (l_msgs_in_queue)
--		end

--	is_api_available: BOOLEAN
--		do
--			Result := True
--		end

---- Feature not yet wrapped/tested
----	curl_multi_assign
----	curl_multi_fdset
----	curl_multi_setopt
----	curl_multi_socket
----	curl_multi_socket_action
----	curl_multi_strerror
----	curl_multi_timeout

--feature -- Query

--	is_exists: BOOLEAN
--			-- If C pointer exists?
--		do
--			Result := item /= default_pointer
--		end

--feature {NONE} -- Implementation

--	item: POINTER
--		-- C pointer item for cURL multi

--feature {NONE} -- C externals

--	c_init (a_api: POINTER): POINTER
--			-- Declared as curl_multi_init ().
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				return (FUNCTION_CAST(CURLM *, ()) $a_api)();
--			]"
--		end

--	c_cleanup (a_api: POINTER; a_multi_handle: POINTER): INTEGER
--			-- Declared as curl_multi_cleanup ().
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				return (FUNCTION_CAST(CURLMcode, (CURLM *)) $a_api)
--													((CURLM *)$a_multi_handle);
--			]"
--		end

--	c_add_handle (a_api: POINTER; a_multi_handle: POINTER; a_easy_handle: POINTER)
--			-- Declared as curl_multi_add_handle ().
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				(FUNCTION_CAST(void, (CURLM *, CURL *)) $a_api)
--											((CURLM *) $a_multi_handle,
--											(CURL *) $a_easy_handle);
--			]"
--		end

--	c_remove_handle (a_api: POINTER; a_multi_handle: POINTER; a_easy_handle: POINTER)
--			-- Declared as curl_multi_remove_handle ().
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				(FUNCTION_CAST(void, (CURLM *, CURL *)) $a_api)
--											((CURLM *) $a_multi_handle,
--											(CURL *) $a_easy_handle);
--			]"
--		end

--	c_perform (a_api: POINTER; a_multi_handle: POINTER; a_running_handles: TYPED_POINTER [INTEGER]): INTEGER
--			-- Declared as curl_multi_perform.
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				return (FUNCTION_CAST(CURLMcode, (CURLM *, int *)) $a_api)
--											((CURLM *) $a_multi_handle,
--											(int *) $a_running_handles);
--			]"
--		end

--	c_info_read (a_api: POINTER; a_multi_handle: POINTER; a_msgs_in_queue: TYPED_POINTER [INTEGER]): POINTER
--				-- Declared as curl_multi_info_read.
--		require
--			exists: not a_api.is_default_pointer
--		external
--			"C inline use <curl/curl.h>"
--		alias
--			"[
--				return (FUNCTION_CAST(CURLMsg *, (CURLM *, int *)) $a_api)
--											((CURLM *) $a_multi_handle,
--											(int *) $a_msgs_in_queue);
--			]"
--		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
