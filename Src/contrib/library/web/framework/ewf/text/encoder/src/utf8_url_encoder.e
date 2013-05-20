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
			default_create,
			name,
			general_encoded_string,
			encoded_string, partial_encoded_string,
			decoded_string
		end

	UTF8_ENCODER_HELPER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor {UTF8_ENCODER_HELPER}
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
			Result := utf32_to_utf8 (s)
			Result := Precursor (Result)
		end

	general_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			if attached {READABLE_STRING_32} s as s32 then
				Result := utf32_to_utf8 (s32)
			else
				Result := s.as_string_8
			end
			Result := Precursor (Result)
		end

	partial_encoded_string (s: READABLE_STRING_GENERAL; a_ignore: ARRAY [CHARACTER]): STRING_8
			-- URL-encoded value of `s'.
		do
			Result := Precursor (s, a_ignore)
			if not has_error then
				Result := utf32_to_utf8 (Result)
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The URL-encoded equivalent of the given string
		do
			Result := Precursor (v)
			if not has_error then
				if is_valid_utf8 (Result) then
					Result := utf8_to_utf32 (Result)
					has_error := not last_conversion_successful
				end
			end
		end

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
