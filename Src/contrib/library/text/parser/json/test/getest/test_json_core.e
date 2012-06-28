class TEST_JSON_CORE
    
inherit
    TS_TEST_CASE
    SHARED_EJSON
    
create
    make_default

feature {NONE} -- Initialization

    make is
            -- Create test object.
        do
        end

feature -- Test

    test_json_number_and_integer is
        local
            i: INTEGER
            i8: INTEGER_8
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            i := 42
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_integer (i)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42%")", jn.representation.is_equal ("42"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (i)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42%")", jn.representation.is_equal ("42"))
            -- JSON representation-> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_8 since the value is 42
            jrep := "42"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i8 := 0
            i8 ?= json.object (jn, Void)
            assert ("i8 = 42", i8 = 42)
        end
        
    test_json_number_and_integer_8 is
        local
            i8: INTEGER_8
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            i8 := 42
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_integer (i8)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42%")", jn.representation.is_equal ("42"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (i8)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42%")", jn.representation.is_equal ("42"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_8 since the value is 42
            jrep := "42"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)            
            i8 := 0
            i8 ?= json.object (jn, Void)
            assert ("i8 = 42", i8 = 42)
        end
        
    test_json_number_and_integer_16 is
        local
            i16: INTEGER_16
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            i16 := 300
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_integer (i16)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"300%")", jn.representation.is_equal ("300"))
            -- Eiffel value -> JSON with factory
            jn := Void
            jn ?= json.value (i16)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"300%")", jn.representation.is_equal ("300"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_16 since the value is 300
            jrep := "300"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i16 := 0
            i16 ?= json.object (jn, Void)
            assert ("i16 = 300", i16 = 300)
        end
        
    test_json_number_and_integer_32 is
        local
            i32: INTEGER_32
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            i32 := 100000
            -- Eiffel value -> JSON representation -> JSON value
            create jn.make_integer (i32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"100000%")", jn.representation.is_equal ("100000"))
            -- Eiffel value -> JSON representation -> JSON value with factory
            jn := Void
            jn ?= json.value (i32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"100000%")", jn.representation.is_equal ("100000"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_32 since the value is 100000
            jrep := "100000"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i32 := 0
            i32 ?= json.object (jn, Void)
            assert ("i32 = 100000", i32 = 100000)
        end

    test_json_number_and_integer_64 is
        local
            i64: INTEGER_64
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            i64 := 42949672960
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_integer (i64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42949672960%")", jn.representation.is_equal ("42949672960"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (i64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"42949672960%")", jn.representation.is_equal ("42949672960"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_32 since the value is 42949672960
            jrep := "42949672960"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i64 := 0
            i64 ?= json.object (jn, Void)
            assert ("i64 = 42949672960", i64 = 42949672960)
        end
        
    test_json_number_and_natural_8 is
        local
            n8: NATURAL_8
            i16: INTEGER_16
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            n8 := 200
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_natural (n8)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"200%")", jn.representation.is_equal ("200"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (n8)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"200%")", jn.representation.is_equal ("200"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_16 since the value is 200
            jrep := "200"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i16 := 0
            i16 ?= json.object (jn, Void)
            assert ("i16 = 200", i16 = 200)
        end

    test_json_number_and_natural_16 is
        local
            n16: NATURAL_16
            i32: INTEGER_32
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            n16 := 32768
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_natural (n16)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"32768%")", jn.representation.is_equal ("32768"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (n16)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"32768%")", jn.representation.is_equal ("32768"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_32 since the value is 32768
            jrep := "32768"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i32 := 0
            i32 ?= json.object (jn, Void)
            assert ("i32 = 32768", i32 = 32768)
        end

    test_json_number_and_natural_32 is
        local
            n32: NATURAL_32
            i64: INTEGER_64
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            n32 := 2147483648
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_natural (n32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"2147483648%")", jn.representation.is_equal ("2147483648"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn := Void
            jn ?= json.value (n32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"2147483648%")", jn.representation.is_equal ("2147483648"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_64 since the value is 2147483648
            jrep := "2147483648"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            i64 := 0
            i64 ?= json.object (jn, Void)
            assert ("i64 = 2147483648", i64 = 2147483648)
        end

    test_json_number_and_large_integers is
        local
            jrep: STRING
            jn: JSON_NUMBER
            n64: NATURAL_64
            parser: JSON_PARSER
        do
            n64 := 9223372036854775808
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_natural (n64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"9223372036854775808%")", jn.representation.is_equal ("9223372036854775808"))
            jn := Void
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn ?= json.value (n64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"9223372036854775808%")", jn.representation.is_equal ("9223372036854775808"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- we know it is INTEGER_32 since the value is 42949672960
            jrep := "9223372036854775808" -- 1 higher than largest positive number that can be represented by INTEGER 64
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            n64 := 0
            n64 ?= json.object (jn, Void)
        end
        
    test_json_number_and_eiffel_real is
        local
            r: REAL
            r64: REAL_64
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            r := 3.14
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_real (r)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1400001049041748%")", jn.representation.is_equal ("3.1400001049041748"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn ?= json.value (r)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1400001049041748%")", jn.representation.is_equal ("3.1400001049041748"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will always return a REAL_64 if the value
            -- of the JSON number is a floating point number
            jrep := "3.14"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            r64 := 0
            r64 ?= json.object (jn, Void)
            assert ("r64 = 3.1400000000000001", r64 = 3.1400000000000001)
        end
        
    test_json_number_and_eiffel_real_32 is
        local
            r32: REAL_32
            r64: REAL_64
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            r32 := 3.14
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_real (r32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1400001049041748%")", jn.representation.is_equal ("3.1400001049041748"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn ?= json.value (r32)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1400001049041748%")", jn.representation.is_equal ("3.1400001049041748"))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "3.1400001049041748"
            create parser.make_parser (jrep)
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            r64 := 0
            r64 ?= json.object (jn, Void)
            assert ("r64 = 3.1400001049041748", r64 = 3.1400001049041748)
        end
        
    test_json_number_and_eiffel_real_64 is
        local
            r64: REAL_64
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
        do
            r64 := 3.1415926535897931
            -- Eiffel value -> JSON value -> JSON representation
            create jn.make_real (r64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1415926535897931%")", jn.representation.is_equal ("3.1415926535897931"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn ?= json.value (r64)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"3.1415926535897931%")", jn.representation.is_equal ("3.1415926535897931"))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "3.1415926535897931"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            r64 := 0
            r64 ?= json.object (jn, Void)
            assert ("r64 = 3.1415926535897931", r64 = 3.1415926535897931)
        end
        
    test_json_boolean is
        local
            b: BOOLEAN
            jb: JSON_BOOLEAN
            jrep: STRING
            parser: JSON_PARSER
        do
            b := True
            -- Eiffel value -> JSON value -> JSON representation
            create jb.make_boolean (b)
            assert ("jb /= Void", jb /= Void)
            assert ("jb.representation.is_equal (%"true%")", jb.representation.is_equal ("true"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jb ?= json.value (b)
            assert ("jb /= Void", jb /= Void)
            assert ("jb.representation.is_equal (%"true%")", jb.representation.is_equal ("true"))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "true"
            create parser.make_parser (jrep)
            jb := Void
            jb ?= parser.parse
            assert ("jb /= Void", jb /= Void)
            b := False
            b ?= json.object (jb, Void)
            assert ("b = True", b = True)

            b := False
            -- Eiffel value -> JSON value -> JSON representation
            create jb.make_boolean (b)
            assert ("jb /= Void", jb /= Void)
            assert ("jb.representation.is_equal (%"false%")", jb.representation.is_equal ("false"))
            -- Eiffel value -> JSON value  -> JSON representation with factory
            jb ?= json.value (b)
            assert ("jb /= Void", jb /= Void)
            assert ("jb.representation.is_equal (%"false%")", jb.representation.is_equal ("false"))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "false"
            create parser.make_parser (jrep)
            jb := Void
            jb ?= parser.parse
            assert ("jb /= Void", jb /= Void)
            b := True
            b ?= json.object (jb, Void)
            assert ("b = False", b = False)
        end

    test_json_null is
        local
            a: ANY
            dummy_object: STRING
            jn: JSON_NULL
            jrep: STRING
            parser: JSON_PARSER
        do
            -- Eiffel value -> JSON value -> JSON representation
            create jn
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"%"null%"%")", jn.representation.is_equal ("null"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            jn ?= json.value (Void)
            assert ("jn /= Void", jn /= Void)
            assert ("jn.representation.is_equal (%"null%")", jn.representation.is_equal ("null"))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "null"
            create parser.make_parser (jrep)
            jn := Void
            jn ?= parser.parse
            assert ("jn /= Void", jn /= Void)
            create dummy_object.make_empty
            a := dummy_object
            a ?= json.object (jn, Void)
            assert ("a = Void", a = Void)
        end
        
    test_json_string_and_character is
        local
            c: CHARACTER
            js: JSON_STRING
            ucs: UC_STRING
            jrep: STRING
            parser: JSON_PARSER
        do
            c := 'a'
            -- Eiffel value -> JSON value -> JSON representation
            create js.make_json (c.out)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"a%"%")", js.representation.is_equal ("%"a%""))
            -- Eiffel value -> JSON value -> JSON representation with factory
            js ?= json.value (c)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"a%"%")", js.representation.is_equal ("%"a%""))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "%"a%""
            create parser.make_parser (jrep)
            js := Void
            js ?= parser.parse
            assert ("js /= Void", js /= Void)
            ucs ?= json.object (js, Void)
            assert ("ucs.string.is_equal (%"a%")", ucs.string.is_equal ("a"))
        end

    test_json_string_and_string is
        local
            s: STRING
            js: JSON_STRING
            ucs: UC_STRING
            jrep: STRING
            parser: JSON_PARSER
        do
            s := "foobar"
            -- Eiffel value -> JSON value -> JSON representation
            create js.make_json (s)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal ("%"foobar%""))
            -- Eiffel value -> JSON value -> JSON representation with factory
            js ?= json.value (s)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal ("%"foobar%""))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "%"foobar%""
            create parser.make_parser (jrep)
            js := Void
            js ?= parser.parse
            assert ("js /= Void", js /= Void)
            ucs ?= json.object (js, Void)
            assert ("ucs.string.is_equal (%"foobar%")", ucs.string.is_equal ("foobar"))
        end

    test_json_string_and_uc_string is
        local
            js: JSON_STRING
            ucs: UC_STRING
            jrep: STRING
            parser: JSON_PARSER
        do
            create ucs.make_from_string ("foobar")
            -- Eiffel value -> JSON value -> JSON representation
            create js.make_json (ucs)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal ("%"foobar%""))
            -- Eiffel value -> JSON value -> JSON representation with factory
            js ?= json.value (ucs)
            assert ("js /= Void", js /= Void)
            assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal ("%"foobar%""))
            -- JSON representation -> JSON value -> Eiffel value
            jrep := "%"foobar%""
            create parser.make_parser (jrep)
            js := Void
            js ?= parser.parse
            assert ("js /= Void", js /= Void)
            ucs := Void
            ucs ?= json.object (js, Void)
            assert ("ucs.string.is_equal (%"foobar%")", ucs.string.is_equal ("foobar"))
        end

    test_json_array is
        local
            ll: LINKED_LIST [INTEGER_8]
            ll2: LINKED_LIST [ANY]
            ja: JSON_ARRAY
            jn: JSON_NUMBER
            jrep: STRING
            parser: JSON_PARSER
            i, n: INTEGER
        do
            -- Eiffel value -> JSON value -> JSON representation
            create ll.make
            ll.extend (0)
            ll.extend (1)
            ll.extend (1)
            ll.extend (2)
            ll.extend (3)
            ll.extend (5)
            -- Note: Currently there is no simple way of creating a JSON_ARRAY
            -- from an LINKED_LIST.
            create ja.make_array
            from
                ll.start
            until
                ll.after
            loop
                create jn.make_integer (ll.item)
                ja.add (jn)
                ll.forth
            end
            assert ("ja /= Void", ja /= Void)
            assert ("ja.representation.is_equal (%"[0,1,1,2,3,5]%")", ja.representation.is_equal ("[0,1,1,2,3,5]"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            ja := Void
            ja ?= json.value (ll)
            assert ("ja /= Void", ja /= Void)
            assert ("ja.representation.is_equal (%"[0,1,1,2,3,5]%")", ja.representation.is_equal ("[0,1,1,2,3,5]"))
            -- JSON representation -> JSON value -> Eiffel value
            -- Note: The JSON_FACTORY will return the smallest INTEGER_* object
            -- that can represent the value of the JSON number, in this case 
            -- it means we will get an LINKED_LIST [ANY] containing the INTEGER_8
            -- values 0, 1, 1, 2, 3, 5
            jrep := "[0,1,1,2,3,5]"
            create parser.make_parser (jrep)
            ja := Void
            ja ?= parser.parse
            assert ("ja /= Void", ja /= Void)
            ll2 ?= json.object (ja, Void)
            assert ("ll2 /= Void", ll2 /= Void)
            --ll.compare_objects
            --ll2.compare_objects
            assert ("ll2.is_equal (ll)", ll2.is_equal (ll))
        end

    test_json_object is
        local
            t, t2: HASH_TABLE [ANY, UC_STRING]
            i: INTEGER
            ucs_key, ucs: UC_STRING
            a: ARRAY [INTEGER]
            jo: JSON_OBJECT
            jn: JSON_NUMBER
            js_key, js: JSON_STRING
            ja: JSON_ARRAY
            jrep: STRING
            parser: JSON_PARSER
        do
            -- Eiffel value -> JSON value -> JSON representation
            -- Note: Currently there is now way of creating a JSON_OBJECT from
            -- a DS_HASH_TABLE, so we do it manually. 
            -- t = {"name": "foobar", "size": 42, "contents", [0, 1, 1, 2, 3, 5]}
            create jo.make
            create js_key.make_json ("name")
            create js.make_json ("foobar")
            jo.put (js, js_key)
            create js_key.make_json ("size")
            create jn.make_integer (42)
            jo.put (jn, js_key)
            create js_key.make_json ("contents")
            create ja.make_array
            create jn.make_integer (0)
            ja.add (jn)
            create jn.make_integer (1)
            ja.add (jn)
            create jn.make_integer (1)
            ja.add (jn)
            create jn.make_integer (2)
            ja.add (jn)
            create jn.make_integer (3)
            ja.add (jn)
            create jn.make_integer (5)
            ja.add (jn)
            jo.put (ja, js_key)
            assert ("jo /= Void", jo /= Void)
            assert ("jo.representation.is_equal (%"{%"size%":42,%"contents%":[0,1,1,2,3,5],%"name%":%"foobar%"}%")", jo.representation.is_equal ("{%"size%":42,%"contents%":[0,1,1,2,3,5],%"name%":%"foobar%"}"))
            -- Eiffel value -> JSON value -> JSON representation with factory
            create t.make (3)
            create ucs_key.make_from_string ("name")
            create ucs.make_from_string ("foobar")
            t.put (ucs, ucs_key)
            create ucs_key.make_from_string ("size")
            i := 42
            t.put (i, ucs_key)
            create ucs_key.make_from_string ("contents")
            a := <<0, 1, 1, 2, 3, 5>>
            t.put (a, ucs_key)
            jo := Void
            jo ?= json.value (t)
            assert ("jo /= Void", jo /= Void)
            assert ("jo.representation.is_equal (%"{%"size%":42,%"contents%":[0,1,1,2,3,5],%"name%":%"foobar%"}%")", jo.representation.is_equal ("{%"size%":42,%"contents%":[0,1,1,2,3,5],%"name%":%"foobar%"}"))
            -- JSON representation -> JSON value -> Eiffel value -> JSON value -> JSON representation
            jrep := "{%"size%":42,%"contents%":[0,1,1,2,3,5],%"name%":%"foobar%"}"
            create parser.make_parser (jrep)
            jo := Void
            jo ?= parser.parse
            assert ("jo /= Void", jo /= Void)
            t2 ?= json.object (jo, Void)
            assert ("t2 /= Void", t2 /= Void)
            jo ?= json.value (t2)
            assert ("jo /= Void", jo /= Void)
            assert ("jrep.is_equal (jo.representation)", jrep.is_equal (jo.representation))
        end

    test_json_failed_json_conversion is
            -- Test converting an Eiffel object to JSON that is based on a class
            -- for which no JSON converter has been registered.
        local
            gv: KL_GOBO_VERSION
            jv: JSON_VALUE
            exception: BOOLEAN
        do
            if not exception then
                create gv
                jv := json.value (gv)
            else
                assert ("exceptions.is_developer_exception", exceptions.is_developer_exception)
                assert ("exceptions.is_developer_exception_of_name", exceptions.is_developer_exception_of_name ("eJSON exception: Failed to convert Eiffel object to a JSON_VALUE: KL_GOBO_VERSION"))
            end
        rescue
            exception := True
            retry
        end

    test_json_failed_eiffel_conversion is
            -- Test converting from a JSON value to an Eiffel object based on a
            -- class for which no JSON converter has been registered.
        local
            gv: KL_GOBO_VERSION
            jo: JSON_OBJECT
            exception: BOOLEAN
        do
            if not exception then
                create jo.make
                gv ?= json.object (jo, "KL_GOBO_VERSION")
            else
                assert ("exceptions.is_developer_exception", exceptions.is_developer_exception)
                assert ("exceptions.is_developer_exception_of_name", exceptions.is_developer_exception_of_name ("eJSON exception: Failed to convert JSON_VALUE to an Eiffel object: JSON_OBJECT -> KL_GOBO_VERSION"))
            end
        rescue
            exception := True
            retry
        end

end -- class TEST_JSON_CORE