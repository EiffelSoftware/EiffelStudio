class TEST_JSON_CUSTOM_CLASSES

inherit
    SHARED_EJSON
    	rename default_create as shared_default_create end
	EQA_TEST_SET
		select default_create end
feature -- Test

    test_custom_classes
        local
            bc: detachable BOOK_COLLECTION
            jbc: JSON_BOOK_CONVERTER
            jbcc: JSON_BOOK_COLLECTION_CONVERTER
            jac: JSON_AUTHOR_CONVERTER
            jo: detachable JSON_OBJECT
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
            jo := Void
            jo ?= parser.parse
            assert ("jo /= Void", jo /= Void)
            bc := Void
            bc ?= json.object (jo, "BOOK_COLLECTION")
            assert ("bc /= Void", bc /= Void)
            jo ?= json.value (bc)
            assert ("jo /= Void", jo /= Void)
            if attached jo as l_jo then
            	assert ("JSON representation is correct", l_jo.representation.same_string ("{%"name%":%"Test collection%",%"books%":[{%"title%":%"eJSON: The Definitive Guide%",%"isbn%":%"123123-413243%",%"author%":{%"name%":%"Foo Bar%"}}]}"))
            end

        end

end -- class TEST_JSON_CUSTOM_CLASS
