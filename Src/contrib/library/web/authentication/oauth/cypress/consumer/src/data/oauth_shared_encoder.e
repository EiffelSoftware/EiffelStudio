note
	description: "Shared encoder for OAUTH purpose."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_SHARED_ENCODER

feature -- Encode

	oauth_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := oauth_encoder.encoded_string (s)
		end

feature -- Decode

	oauth_decoded_string (s: READABLE_STRING_GENERAL): STRING_32
		do
			Result := oauth_encoder.decoded_string (s)
		end
	
feature -- Access

	oauth_encoder: OAUTH_ENCODER
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
