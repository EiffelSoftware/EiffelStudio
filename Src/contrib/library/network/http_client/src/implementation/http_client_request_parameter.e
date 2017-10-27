note
	description: "Summary description for {HTTP_CLIENT_REQUEST_PARAMETER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_CLIENT_REQUEST_PARAMETER

inherit
	DEBUG_OUTPUT

feature -- Access

	name: READABLE_STRING_32

	content_type: detachable READABLE_STRING_8

	count: INTEGER
			-- Integer representing the length of source value.
		deferred
		end

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make_empty
			Result.append (name)
			Result.append ("=...")
		end

feature -- Conversion

	append_form_url_encoded_to (a_output: STRING_8)
			-- Append as form url encoded string to `a_output`.
		deferred
		end

	append_query_value_encoded_to (a_output: STRING_8)
		deferred
		end

	append_as_mime_encoded_to (a_output: STRING_8)
		deferred
		end

feature -- Element change

	set_name (a_name: READABLE_STRING_GENERAL)
		do
			name := a_name.as_string_32
		end

	set_content_type (ct: detachable READABLE_STRING_8)
		do
			content_type := ct
		end

feature {NONE} -- Implementation

	x_www_form_url_encoder: X_WWW_FORM_URL_ENCODER
			-- Shared x-www-form-urlencoded encoder.
		once
			create Result
		end

	uri_percent_encoder: URI_PERCENT_ENCODER
		once
			create Result
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
