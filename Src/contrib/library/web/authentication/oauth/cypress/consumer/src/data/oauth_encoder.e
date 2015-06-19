note
	description: "Summary description for {OAUTH_ENCODER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_ENCODER

feature -- Encode

	encoded_string (s: STRING_32): STRING_8
		do
			Result := url_encoder.encoded_string (s)
		end

feature -- Decode

	decoded_string (s: STRING_8): STRING_32
		do
			Result := url_encoder.decoded_string (s)
		end

feature {NONE} -- Implementation

	url_encoder: URL_ENCODER
		once
			create Result
		end

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
