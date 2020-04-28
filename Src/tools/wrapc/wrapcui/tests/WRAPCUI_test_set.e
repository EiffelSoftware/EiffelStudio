note
	description: "Tests of {WRAPCUI}."
	testing: "type/manual"

class
	WRAPCUI_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines: XML

	xml_parser_tests
			-- `xml_parser_tests'
		local
			l_factory: XML_PARSER_FACTORY
			l_parser: XML_STANDARD_PARSER
			l_callbacks: WUI_XML_CALLBACKS
		do
			create l_factory
			l_parser := l_factory.new_standard_parser
			create l_callbacks
			l_parser.set_callbacks (l_callbacks)
			l_parser.parse_from_string (sample_xml)
			assert_integers_equal ("has_two", 2, l_callbacks.contents.count)
			assert_strings_equal ("one_tag", "one", l_callbacks.contents [1].local_part)
			assert_strings_equal ("one_content", "1", l_callbacks.contents [1].content)
			assert_strings_equal ("two_tag", "two", l_callbacks.contents [2].local_part)
			assert_strings_equal ("two_content", "2", l_callbacks.contents [2].content)
		end

feature {NONE} -- Test Support: XML

	sample_xml: STRING = "[
<config>
	<one>1</one>
	<two>2</two>
</config>
]"

end
