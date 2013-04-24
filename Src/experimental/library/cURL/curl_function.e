note
	description: "[
						cURL curl_easy_setopt callback functions' Eiffel wrappers.
						We need this class since cURL need a c function pointer as value but
						Eiffel function need frist parameter of any funciton call is object address.
						Client programmers can inherit this class to fit their needs.

						Note: descendants of this class have to call `set_object_and_function_address',
						otherwise cURL would not know how to call Eiffel features (such as `write_function').
						See example: $ISE_LIBRARY\examples\cURL\upload_and_read_function
						
						See http://curl.haxx.se/libcurl/c/curl_easy_setopt.html for libcurl documentation					
				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CURL_FUNCTION

inherit
	DISPOSABLE

feature -- Interactive with C

	set_object_and_function_address
			-- Set object and function addresses.
			-- Call this feature before call `c_set_progress_function', `c_set_debug_function' and `c_set_write_function, c_set_read_function'.
		do
			c_set_object ($Current)
			c_set_progress_function_address ($progress_function)
			c_set_write_function_address ($write_function)
			c_set_read_function_address ($read_function)
			c_set_debug_function_address ($debug_function)
		end

	c_set_progress_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_PROGRESSFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_PROGRESSFUNCTION,
												curl_progress_function);
			}
			]"
		end

	c_set_debug_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_DEBUGFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_DEBUGFUNCTION,
												curl_debug_function);
																													
			}
			]"
		end

	c_set_write_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_WRITEFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_WRITEFUNCTION,
												curl_write_function);
			}
			]"
		end

	c_set_read_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_READFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_READFUNCTION,
												curl_read_function);
			}
			]"
		end

feature -- cURL curl_easy_setopt functions

	progress_function (a_object_id: POINTER; a_download_total, a_download_now, a_upload_total, a_upload_now: REAL_64): INTEGER
			-- Function correspond to {CURL_OPT_CONSTANTS}.curlopt_progressfunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.
		deferred
		end

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- Function called by libcurl as soon as there is data received that needs to be saved.
			-- The size of the data pointed to by `a_data_pointer' is `a_size' multiplied with `a_nmemb', it will not be null terminated.
			-- Returns the number of bytes actually taken care of
			--
			-- Function corresponds to {CURL_OPT_CONSTANTS}.curlopt_writefunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.
			--| libcurl doc:
			--|  Function pointer that should match the following prototype: size_t function( char *ptr, size_t size, size_t nmemb, void *userdata);
			--|	 This function gets called by libcurl as soon as there is data received that needs to be saved.
			--|	 The size of the data pointed to by ptr is size multiplied with nmemb, it will not be zero terminated.
			--|	 Return the number of bytes actually taken care of.
			--|  If that amount differs from the amount passed to your function, it'll signal an error to the library.
			--|  This will abort the transfer and return CURLE_WRITE_ERROR.
			--|	 From 7.18.0, the function can return CURL_WRITEFUNC_PAUSE which then will cause writing to this connection to become paused.
			--|  See curl_easy_pause(3) for further details.
			--|
			--|  This function may be called with zero bytes data if the transferred file is empty.
			--|
			--|  Set this option to NULL to get the internal default function.
			--|  The internal default function will write the data to the FILE * given with CURLOPT_WRITEDATA.
			--|
			--|  Set the userdata argument with the CURLOPT_WRITEDATA option.
			--|
			--|  The callback function will be passed as much data as possible in all invokes,
			--|  but you cannot possibly make any assumptions. It may be one byte, it may be thousands.
			--|  The maximum amount of body data that can be passed to the write callback is defined
			--|  in the curl.h header file: CURL_MAX_WRITE_SIZE (the usual default is 16K).
			--|  If you however have CURLOPT_HEADER set, which sends header data to the write callback,
			--|  you can get up to CURL_MAX_HTTP_HEADER bytes of header data passed into it. This usually means 100K.			
		deferred
		end

	read_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- Function called by libcurl as soon as it needs to read data in order to send it to the peer.
			-- The data area pointed at by the pointer `a_data_pointer' may be filled with at most
			-- `a_size' multiplied with `a_nmemb' number of bytes. 
			-- Returns the actual number of bytes stored in that memory area.
			-- Returning 0 will signal end-of-file to the library and cause it to stop the current transfer.
			-- 
			-- Function corresponds to {CURL_OPT_CONSTANTS}.curlopt_readfunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.
			--| libcurl doc:
			--|  Function pointer that should match the following prototype: size_t function( void *ptr, size_t size, size_t nmemb, void *userdata);
			--|  This function gets called by libcurl as soon as it needs to read data in order to send it to the peer.
			--|  The data area pointed at by the pointer ptr may be filled with at most size multiplied with nmemb number of bytes. 
			--|  Your function must return the actual number of bytes that you stored in that memory area.
			--|  Returning 0 will signal end-of-file to the library and cause it to stop the current transfer.
			--|  
			--|  If you stop the current transfer by returning 0 "pre-maturely" (i.e before the server expected it,
			--|  like when you've said you will upload N bytes and you upload less than N bytes),
			--|  you may experience that the server "hangs" waiting for the rest of the data that won't come.
			--|  
			--|  The read callback may return CURL_READFUNC_ABORT to stop the current operation immediately,
			--|  resulting in a CURLE_ABORTED_BY_CALLBACK error code from the transfer (Added in 7.12.1)
			--|
			--|  From 7.18.0, the function can return CURL_READFUNC_PAUSE which then will cause reading from this connection to become paused.
			--|  See curl_easy_pause(3) for further details.
			--|  
			--|  Bugs: when doing TFTP uploads, you must return the exact amount of data that the callback wants,
			--|  or it will be considered the final packet by the server end and the transfer will end there.
			--|  
			--|  If you set this callback pointer to NULL, or don't set it at all, the default internal read function will be used.
			--|  It is doing an fread() on the FILE * userdata set with CURLOPT_READDATA.
		deferred
		end

	debug_function (a_curl_handle: POINTER; a_curl_infotype: INTEGER; a_char_pointer: POINTER; a_size: INTEGER; a_object_id: POINTER): INTEGER
			-- Function correspond to {CURL_OPT_CONSTANTS}.curlopt_debugfunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.			
		require
			vaild: (create {CURL_INFO_TYPE}).is_valid (a_curl_infotype)
		deferred
		end

feature {NONE} -- Externals

	c_set_object (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"eiffel_curl.h%""
		end

	c_release_object
			-- Release Current pointer in C
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_progress_function_address (a_address: POINTER)
			-- Set progress function address.
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_write_function_address (a_address: POINTER)
			-- Set write function address.
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_read_function_address (a_address: POINTER)
			-- Set read function address.
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_debug_function_address (a_address: POINTER)
			-- Set write function address.
		external
			"C use %"eiffel_curl.h%""
		end

feature {NONE} -- Implementation

	dispose
			-- Wean `Current'
		do
			c_release_object
			c_set_object (default_pointer)
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
