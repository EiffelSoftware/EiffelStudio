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

feature -- Command

	init
			-- Create a multi handle.
			-- If success, Result is a cURL multi hanlde just created.
			-- This feature maybe failed in some cases: cannot find required DLL, etc.
			-- Then the post condition would be violated.
		require
			dynamic_library_exists: is_dynamic_library_exists
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("curl_multi_init")
			if l_api /= default_pointer then
				item := c_init (l_api)
			end
		end

	add_handle (a_easy_handle: POINTER)
			-- Add an easy handle to a multi session.
		require
			dynamic_library_exists: is_dynamic_library_exists
			is_multi_handle_exists: is_exists
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("curl_multi_add_handle")
			if l_api /= default_pointer then
				c_add_handle (l_api, item, a_easy_handle)
			end
		end

	remove_handle (a_easy_handle: POINTER)
			-- Remove an easy handle from a multi session.
		require
			dynamic_library_exists: is_dynamic_library_exists
			is_multi_handle_exists: is_exists
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("curl_multi_remove_handle")
			if l_api /= default_pointer then
				c_remove_handle (l_api, item, a_easy_handle)
			end
		end

	cleanup: INTEGER
			-- Close down a multi session.
			-- Result is one value from {CURL_MULTI_CODES}.
		require
			dynamic_library_exists: is_dynamic_library_exists
			is_multi_handle_exists: is_exists
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("curl_multi_cleanup")
			if l_api /= default_pointer then
				Result := c_cleanup (l_api, item)
			end
		end

	perform (a_running_handle: CELL [INTEGER]): INTEGER
			-- Reads/writes available data from each easy handle.
			-- Result is one value from {CURL_MULTI_CODES}.
		require
			dynamic_library_exists: is_dynamic_library_exists
			is_multi_handle_exists: is_exists
		local
			l_api: POINTER
			l_running_handle: INTEGER
		do
			l_api := api_loader.api_pointer ("curl_multi_perform")
			if l_api /= default_pointer then
				Result := c_perform (l_api, item, $l_running_handle)
				a_running_handle.put (l_running_handle)
			end
		end

	info_read (a_msgs_in_queue: CELL [INTEGER]): POINTER
			-- Read multi stack informationals.
			-- The result is C struct CURLMsg {CURL_MSG_STRUCT}.
			-- Repeated calls to this function will return a new struct each time, until a NULL
			-- is returned as a signal that there is no more to get at this point. The integer
			-- pointed to with msgs_in_queue will contain the number of remaining messages after
			-- this function was called.
			-- When you fetch a message using this function, it is removed from the internal queue
			-- so calling this function again will not return the same message again. It will instead
			-- return new messages at each new invoke until the queue is emptied.
		require
			dynamic_library_exists: is_dynamic_library_exists
			is_multi_handle_exists: is_exists
		local
			l_api: POINTER
			l_msgs_in_queue: INTEGER
		do
			l_api := api_loader.api_pointer ("curl_multi_info_read")
			if l_api /= default_pointer then
				Result := c_info_read (l_api, item, $l_msgs_in_queue)
				a_msgs_in_queue.put (l_msgs_in_queue)
			end
		end

	is_dynamic_library_exists: BOOLEAN
			-- Are required .dll/.so files available?
		do
			Result := api_loader.is_interface_usable
		end

-- Feature not yet wrapped/tested
--	curl_multi_assign
--	curl_multi_fdset
--	curl_multi_setopt
--	curl_multi_socket
--	curl_multi_socket_action
--	curl_multi_strerror
--	curl_multi_timeout

feature -- Query

	is_exists: BOOLEAN
			-- If C pointer exists?
		do
			Result := item /= default_pointer
		end

feature {NONE} -- Implementation

	item: POINTER
		-- C pointer item for cURL multi

feature {NONE} -- C externals

	c_init (a_api: POINTER): POINTER
			-- Declared as curl_multi_init ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURLM *, ()) $a_api)();
			]"
		end

	c_cleanup (a_api: POINTER; a_multi_handle: POINTER): INTEGER
			-- Declared as curl_multi_cleanup ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURLMcode, (CURLM *)) $a_api)
														((CURLM *)$a_multi_handle);
			]"
		end

	c_add_handle (a_api: POINTER; a_multi_handle: POINTER; a_easy_handle: POINTER)
			-- Declared as curl_multi_add_handle ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				(FUNCTION_CAST(void, (CURLM *, CURL *)) $a_api)
												((CURLM *) $a_multi_handle,
												(CURL *) $a_easy_handle);
			]"
		end

	c_remove_handle (a_api: POINTER; a_multi_handle: POINTER; a_easy_handle: POINTER)
			-- Declared as curl_multi_remove_handle ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				(FUNCTION_CAST(void, (CURLM *, CURL *)) $a_api)
												((CURLM *) $a_multi_handle,
												(CURL *) $a_easy_handle);
			]"
		end

	c_perform (a_api: POINTER; a_multi_handle: POINTER; a_running_handles: TYPED_POINTER [INTEGER]): INTEGER
			-- Declared as curl_multi_perform.
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURLMcode, (CURLM *, int *)) $a_api)
												((CURLM *) $a_multi_handle,
												(int *) $a_running_handles);
			]"
		end

	c_info_read (a_api: POINTER; a_multi_handle: POINTER; a_msgs_in_queue: TYPED_POINTER [INTEGER]): POINTER
				-- Declared as curl_multi_info_read.
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURLMsg *, (CURLM *, int *)) $a_api)
												((CURLM *) $a_multi_handle,
												(int *) $a_msgs_in_queue);
			]"
		end

feature {NONE} -- Implementation

	api_loader: DYNAMIC_MODULE
			-- Module name.
		local
			l_utility: CURL_UTILITY
		once
			create l_utility
			Result := l_utility.api_loader
		end


note
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
