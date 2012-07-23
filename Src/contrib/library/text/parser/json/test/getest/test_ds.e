class TEST_DS
    
inherit
    SHARED_GOBO_EJSON
 
    TS_TEST_CASE
    
create
    make_default

feature {NONE} -- Initialization

    make is
            -- Create test object.
        do
        end

feature -- Test

    test_ds_linked_list_converter is
        local
            jc: JSON_DS_LINKED_LIST_CONVERTER
            l: DS_LINKED_LIST [STRING]
            l2: DS_LINKED_LIST [ANY]
            s: STRING
            jv: JSON_VALUE
        do
            create jc.make
            json.add_converter (jc)
            create l.make
            s := "foo"
            l.put_last (s)
            s := "bar"
            l.put_last (s)
            jv := json.value (l)
            assert ("jv /= Void", jv /= Void)
            s := jv.representation
            l2 ?= json.object (jv, "DS_LINKED_LIST")
            assert ("l2 /= Void", l2 /= Void)
        end

    test_ds_hash_table_converter is
        local
            tc: JSON_DS_HASH_TABLE_CONVERTER
            t: DS_HASH_TABLE [STRING, STRING]
            t2: DS_HASH_TABLE [ANY, HASHABLE]
            s: STRING
            ucs_key, ucs_value: UC_STRING
            jv: JSON_VALUE
        do
            create tc.make
            json.add_converter (tc)
            create t.make (2)
            t.put ("foo", "1")
            t.put ("bar", "2")
            jv := json.value (t)
            assert ("jv /= Void", jv /= Void)
            s := jv.representation
            t2 ?= json.object (jv, "DS_HASH_TABLE")
            assert ("t2 /= Void", t2 /= Void)
            create ucs_key.make_from_string ("1")
            ucs_value ?= t2 @ ucs_key
            assert ("ucs_value /= Void", ucs_value /= Void)
            assert ("ucs_value.string.is_equal (%"foo%")", ucs_value.string.is_equal ("foo"))
            create ucs_key.make_from_string ("2")
            ucs_value ?= t2 @ ucs_key
            assert ("ucs_value /= Void", ucs_value /= Void)
            assert ("ucs_value.string.is_equal (%"bar%")", ucs_value.string.is_equal ("bar"))
        end

end -- class TEST_DS
