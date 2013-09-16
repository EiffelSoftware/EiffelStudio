note
	description: "[
			This class is to represent the CONTENT_TYPE value
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RFC3875", "protocol=URI", "src=http://tools.ietf.org/html/rfc3875"

class
	HTTP_CONTENT_TYPE

inherit
	HTTP_MEDIA_TYPE

create
	make,
	make_from_string

feature -- Access

	charset_parameter: detachable READABLE_STRING_8
		do
			if has_charset_parameter then
				Result := parameter (charset_parameter_name)
			end
		end

	has_charset_parameter: BOOLEAN
		do
			Result := has_parameter (charset_parameter_name)
		end

feature -- Constant

	charset_parameter_name: STRING_8 = "charset"

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
