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

	CURL_DYNAMIC_EXTERNALS_I

feature -- Function pointer

	curl_multi_init_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_init")
		end

	curl_multi_add_handle_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_add_handle")
		end

	curl_multi_remove_handle_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_remove_handle")
		end

	curl_multi_cleanup_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_cleanup")
		end

	curl_multi_perform_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_perform")
		end

	curl_multi_info_read_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_multi_info_read")
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
