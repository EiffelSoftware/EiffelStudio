class
	TEST_JSON_VISITOR

inherit
	EQA_TEST_SET

	TEST_JSON_I

feature -- Test

	test_iterator
		local
			s, o: STRING
			p: like new_parser
			null_remover: JSON_NULL_AND_FALSE_MEMBER_REMOVER
			printer: JSON_SERIALIZATION_VISITOR
		do
			s := "[
				{
					"first": ["abc", 123, false, null],
					"second": {
						"string": "hello",
						"null": null,
						"false": false,
						"true": true,
						"object": {
								"one": 1,
								"two": 2,
								"null": null
						}
					}
				}
			]"
			p := new_parser (s)
			p.parse_content
			check p.is_valid and p.is_parsed end
			if attached p.parsed_json_object as jo then
				create null_remover
				jo.accept (null_remover)

				create o.make_empty
				create printer.make (o)
				jo.accept (printer)
				assert ("no more null and false", o.same_string ("{%"first%":[%"abc%",123,false,null],%"second%":{%"string%":%"hello%",%"true%":true,%"object%":{%"one%":1,%"two%":2}}}"))
			end
		end

end
