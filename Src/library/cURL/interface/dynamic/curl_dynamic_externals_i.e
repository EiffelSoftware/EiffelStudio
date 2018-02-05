note
	description: "[
					Common interface for cURL externals based on dynamic module (.dll or .so).
					For more information, see:
					http://curl.haxx.se/libcurl/c/
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CURL_DYNAMIC_EXTERNALS_I

feature -- Status report

	is_api_available: BOOLEAN
			-- <Precursor>.
			-- i.e if dll/so file exists.
		do
			Result := api_loader.is_interface_usable
		end

	is_dynamic_library_exists: BOOLEAN
			-- dll/so file exists?
		obsolete
			"Use is_api_available [2018-01-15]"
		do
			Result := is_api_available
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
