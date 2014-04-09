note
	description: "[
			Summary description for {URL_ENCODER}.
			
			See: http://www.faqs.org/rfcs/rfc3986.html
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	URL_ENCODER

inherit
	ENCODER [READABLE_STRING_32, READABLE_STRING_8]

	PLATFORM
		export
			{NONE} all
		end

	PERCENT_ENCODER
		rename
			percent_encoded_string as general_encoded_string,
			percent_decoded_string as general_decoded_string
		end

feature -- Access

	name: READABLE_STRING_8
		do
			create {IMMUTABLE_STRING_8} Result.make_from_string ("URL-encoded")
		end

feature -- Encoder

	encoded_string (s: READABLE_STRING_32): STRING_8
			-- URL-encoded value of `s'.
		do
			Result := general_encoded_string (s)
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The URL-encoded equivalent of the given string
		do
			Result := general_decoded_string (v)
		end

note
	copyright: "Copyright (c) 2011-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
