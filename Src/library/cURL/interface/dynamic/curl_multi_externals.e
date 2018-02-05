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
			-- Is cURL API available?
			-- Are required .dll/.so files available?
		do
			Result := api_loader.is_interface_usable
		end

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
