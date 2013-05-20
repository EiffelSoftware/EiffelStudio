note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_XML_ENCODER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_xml_encoded_encoder
		note
			testing:  "xml-encoded"
		do
			test_xml_encoded_encoding ({STRING_32}"il était une fois Ni & Hao (你好)")
		end

	test_xml_encoded_encoding (s: STRING_32)
		local
			u: STRING_32
			e: STRING_8
			b: XML_ENCODER
		do
			create b
			e := b.encoded_string (s)
			u := b.decoded_string (e)
			assert ("decoded encoded string is same", u ~ s)
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
