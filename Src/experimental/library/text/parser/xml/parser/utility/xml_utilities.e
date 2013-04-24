note
	description: "Summary description for {XML_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_UTILITIES

feature -- Conversion

	escaped_xml (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := xml_encoder.encoded_string (s)
		end

	escaped_unicode_xml (s: READABLE_STRING_32): STRING_32
		do
			Result := xml_encoder.encoded_string_32 (s)
		end

	unescaped_xml (s: READABLE_STRING_8): STRING_32
		do
			Result := xml_encoder.decoded_string (s)
		end

feature {NONE} -- Implementation

	xml_encoder: XML_ENCODER
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
