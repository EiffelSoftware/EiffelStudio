note
	description: "[
			Proxy interface on WSF_REQUEST_UTILITY interface.
			Used to factorize code.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_REQUEST_UTILITY_PROXY

feature {NONE} -- Implementation

	utility: WSF_REQUEST_UTILITY
		once
			create Result
		end

feature -- Request

	request: WSF_REQUEST
		deferred
		end

feature -- Url Query

	script_absolute_url (a_path: STRING): READABLE_STRING_8
			-- Absolute Url for the script if any, extended by `a_path'
		do
			Result := utility.script_absolute_url (request, a_path)
		end

	script_url (a_path: STRING): READABLE_STRING_8
			-- Url relative to script name if any, extended by `a_path'
		do
			Result := utility.script_url (request, a_path)
		end

	url (args: detachable STRING; abs: BOOLEAN): READABLE_STRING_8
			-- Associated url based on `path' and `args'
			-- if `abs' then return absolute url
		do
			Result := utility.url (request, request.script_name, args, abs)
		end

feature -- Parameter

	item (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Variable value for parameter or variable `a_name'
			-- See `{WSF_REQUEST}.item(s)'
		do
			Result := utility.item (request, a_name)
		end

	string_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for any variable of parameter `a_name' if relevant.	
		do
			Result := utility.string_item (request, a_name)
		end

	string_array_item (a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		do
			Result := utility.string_array_item (request, a_name)
		end

feature -- Query parameter	

	query_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Parameter value for query variable `a_name'	
			--| i.e after the ? character
		do
			Result := utility.query_parameter (request, a_name)
		end

	string_query_parameter (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for query parameter `a_name' if relevant.	
		do
			Result := utility.string_query_parameter (request, a_name)
		end

	string_array_query_parameter (a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for query parameter `a_name' if relevant.
		do
			Result := utility.string_array_query_parameter (request, a_name)
		end

	is_integer_query_parameter (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is query parameter related to `a_name' an integer value?
		do
			Result := utility.is_integer_query_parameter (request, a_name)
		end

	integer_query_parameter (a_name: READABLE_STRING_GENERAL): INTEGER
			-- Integer value for query parameter  `a_name' if relevant.
		do
			Result := utility.integer_query_parameter (request, a_name)
		end

feature -- Path parameter

	path_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
		do
			Result := utility.path_parameter (request, a_name)
		end

	string_path_parameter (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- String value for path parameter `a_name' if relevant.	
		do
			Result := utility.string_path_parameter (request, a_name)
		end

	string_array_path_parameter (a_name: READABLE_STRING_GENERAL): detachable ARRAY [READABLE_STRING_32]
			-- Array of string values for path parameter `a_name' if relevant.
		do
			Result := utility.string_array_path_parameter (request, a_name)
		end

	is_integer_path_parameter (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is path parameter related to `a_name' an integer value?
		do
			Result := utility.is_integer_path_parameter (request, a_name)
		end

	integer_path_parameter (a_name: READABLE_STRING_GENERAL): INTEGER
			-- Integer value for path parameter  `a_name' if relevant.
		do
			Result := utility.integer_path_parameter (request, a_name)
		end

feature -- Content type

	request_accepted_content_type (a_supported_content_types: detachable ARRAY [READABLE_STRING_8]): detachable READABLE_STRING_8
			-- Accepted content-type for the request, among the supported content types `a_supported_content_types'
		do
			Result := utility.request_accepted_content_type (request, a_supported_content_types)
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
