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
	UTF8_URL_ENCODER

inherit
	URL_ENCODER
		redefine
			name,
			general_encoded_string,
			encoded_string, partial_encoded_string,
			decoded_string
		select
			encoded_string,
			decoded_string,
			has_error
		end

	UTF8_ENCODER
		rename
			general_encoded_string as utf8_general_encoded_string,
			encoded_string as utf8_encoded_string,
			decoded_string as utf8_decoded_string,
			has_error as utf8_has_error
		redefine
			name
		end

feature -- Access

	name: READABLE_STRING_8
		do
			create {IMMUTABLE_STRING_8} Result.make_from_string ("UTF8-URL-encoded")
		end

feature -- Encoder

	encoded_string (s: READABLE_STRING_32): STRING_8
			-- URL-encoded value of `s'.
		do
			Result := general_encoded_string (s)
		end

	general_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := utf8_general_encoded_string (s)
			Result := Precursor {URL_ENCODER} (Result)
			has_error := has_error or utf8_has_error
		end

	partial_encoded_string (s: READABLE_STRING_GENERAL; a_ignore: ARRAY [CHARACTER]): STRING_8
			-- URL-encoded value of `s'.
		do
			Result := utf8_general_encoded_string (s)
			Result := Precursor {URL_ENCODER} (Result, a_ignore)
			has_error := has_error or utf8_has_error
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The URL-encoded equivalent of the given string
		do
			Result := Precursor {URL_ENCODER} (v)
			if not has_error then
				Result := utf8_decoded_string (Result)
				has_error := utf8_has_error
			end
		end

note
	copyright: "2011-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
