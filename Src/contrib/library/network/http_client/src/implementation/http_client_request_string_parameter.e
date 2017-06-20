note
	description: "Summary description for {HTTP_CLIENT_REQUEST_STRING_PARAMETER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_REQUEST_STRING_PARAMETER

inherit
	HTTP_CLIENT_REQUEST_PARAMETER

create
	make

feature {NONE} -- Initialization

	make (a_name, a_value: READABLE_STRING_GENERAL)
		do
			set_name (a_name)
			value := a_value.as_string_32
		end

feature -- Access

	value: READABLE_STRING_32

	count: INTEGER
		do
			Result := value.count
		end

feature -- Conversion

	append_form_url_encoded_to (a_output: STRING_8)
			-- Append as form url encoded string to `a_output`.
		do
			x_www_form_url_encoder.append_percent_encoded_string_to (value, a_output)
		end

	append_query_value_encoded_to (a_output: STRING_8)
		do
			uri_percent_encoder.append_query_value_encoded_string_to (value, a_output)
		end

	append_as_mime_encoded_to (a_output: STRING_8)
			-- Encoded unicode string for mime value.
			-- For instance uploaded filename, or form data key or values.
		local
			utf: UTF_CONVERTER
		do
				-- FIXME: find the proper encoding!
			utf.utf_32_string_into_utf_8_string_8 (value, a_output)
		end

invariant

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
