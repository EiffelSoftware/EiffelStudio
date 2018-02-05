note
	description: "[
					cURL easy externals.
					For more informaton see:
					http://curl.haxx.se/libcurl/c/
				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_EASY_EXTERNALS

inherit
	CURL_EASY_EXTERNALS_I

	CURL_DYNAMIC_EXTERNALS_I

feature -- Function pointer

	curl_easy_init_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_init")
		end

	curl_easy_setopt_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_setopt")
		end

	curl_easy_getinfo_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_getinfo")
		end

	curl_easy_cleanup_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_cleanup")
		end

	curl_easy_perform_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_perform")
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
