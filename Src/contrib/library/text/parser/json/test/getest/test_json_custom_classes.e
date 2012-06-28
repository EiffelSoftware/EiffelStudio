class TEST_JSON_CUSTOM_CLASSES
    
inherit
    SHARED_EJSON
 
    TS_TEST_CASE
    
create
    make_default

feature {NONE} -- Initialization

    make is
            -- Create test object.
        do
        end

feature -- Test

    test_custom_classes is
        local
            bc: BOOK_COLLECTION
            jbc: JSON_BOOK_CONVERTER
            jbcc: JSON_BOOK_COLLECTION_CONVERTER
            jac: JSON_AUTHOR_CONVERTER
            jo: JSON_OBJECT
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
            assert ("JSON representation is correct", jo.representation.is_equal ("{%"books%":[{%"title%":%"eJSON: The Definitive Guide%",%"isbn%":%"123123-413243%",%"author%":{%"name%":%"Foo Bar%"}}],%"name%":%"Test collection%"}"))
        end
        
end -- class TEST_JSON_CUSTOM_CLASS
