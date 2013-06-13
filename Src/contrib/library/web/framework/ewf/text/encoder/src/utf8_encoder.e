note
	description: "[
				Summary description for {UTF8_ENCODER}.
				
				see: http://en.wikipedia.org/wiki/UTF-8
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UTF8_ENCODER

inherit
	ENCODER [READABLE_STRING_32, READABLE_STRING_8]

	PLATFORM
		export
			{NONE} all
		end

feature -- Access

	name: READABLE_STRING_8
		do
			create {IMMUTABLE_STRING_8} Result.make_from_string ("UTF8-encoded")
		end

feature -- Status report

	has_error: BOOLEAN

feature -- Encoder

	encoded_string (s: READABLE_STRING_32): STRING_8
			-- UTF8-encoded value of `s'.
		do
			Result := general_encoded_string (s)
		end

	general_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := utf32_to_utf8 (s)
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The UTF8-encoded equivalent of the given string
		do
			Result := utf8_to_utf32 (v)
			has_error := not is_valid_utf8 (v)
		end

feature {NONE} -- UTF implementation

	utf32_to_utf8 (s: READABLE_STRING_GENERAL): STRING_8
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (s)
		end

	utf8_to_utf32 (s: READABLE_STRING_8): STRING_32
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_8_string_8_to_string_32 (s)
		end

	is_valid_utf8 (s: READABLE_STRING_8): BOOLEAN
		local
			utf: UTF_CONVERTER
		do
			Result := utf.is_valid_utf_8_string_8 (s)
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
