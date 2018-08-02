note
	description: "[
					cURL externals.
					For more information, see:
					http://curl.haxx.se/libcurl/c/
			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_EXTERNALS

inherit
	CURL_EXTERNALS_I

	CURL_DYNAMIC_EXTERNALS_I

feature -- Function pointer

	curl_global_init_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_global_init")
		end

	curl_global_cleanup_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_global_cleanup")
		end

	curl_slist_append_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_slist_append")
		end

	curl_slist_free_all_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_slist_free_all")
		end

	curl_easy_strerror_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_easy_strerror")
		end

	curl_formfree_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_formfree")
		end

	curl_formadd_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_formadd")
		end

	curl_mime_init_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_init")
		end

	curl_mime_addpart_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_addpart")
		end

	curl_mime_data_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_data")
		end

	curl_mime_type_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_type")
		end

	curl_mime_subparts_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_subparts")
		end

	curl_mime_headers_ptr:  POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_headers")
		end

	curl_mime_filedata_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_filedata")
		end

	curl_mime_free_ptr: POINTER
		do
			Result := api_loader.api_pointer ("curl_mime_free")
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
