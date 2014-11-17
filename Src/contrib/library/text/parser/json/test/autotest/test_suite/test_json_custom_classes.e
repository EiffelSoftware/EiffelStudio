note
	description: "Parsing and converter of book collection test."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_CUSTOM_CLASSES

inherit

	SHARED_EJSON
		undefine
			default_create
		end

	EQA_TEST_SET

feature -- Test

	test_custom_classes
			-- Parse JSON representation to JSON_OBJECT and test book collection converter.
		local
			jbc: JSON_BOOK_CONVERTER
			jbcc: JSON_BOOK_COLLECTION_CONVERTER
			jac: JSON_AUTHOR_CONVERTER
			parser: JSON_PARSER
			jrep: STRING
		do
			create jbc.make
			json.add_converter (jbc)
			create jbcc.make
			json.add_converter (jbcc)
			create jac.make
			json.add_converter (jac)
			jrep := "{%"name%":%"Test collection%",%"books%":[{%"title%":%"eJSON: The Definitive Guide%",%"isbn%":%"123123-413243%",%"author%":{%"name%":%"Foo Bar%"}}]}"
			create parser.make_parser (jrep)
			if attached {JSON_OBJECT} parser.parse as l_json_object then
				if attached {BOOK_COLLECTION} json.object (l_json_object, "BOOK_COLLECTION") as l_collection then
					if attached {JSON_OBJECT} json.value (l_collection) as l_json_object_2 then
						assert ("JSON representation is correct", l_json_object_2.representation.same_string (jrep))
					else
						assert ("BOOK_COLLECTION converted to JSON_OBJECT", False)
					end
				else
					assert ("JSON_OBJECT converted to BOOK_COLLECTION", False)
				end
			else
				assert ("JSON object representation to JSON_OBJECT", False)
			end
		end

end -- class TEST_JSON_CUSTOM_CLASS
