class TEST_DS

inherit
    SHARED_EJSON
	  	rename default_create as shared_default_create end
	EQA_TEST_SET
		select default_create end


feature -- Test

    test_linked_list_converter
        local
            jc: JSON_LINKED_LIST_CONVERTER
            l: LINKED_LIST [STRING]
            l2: detachable LINKED_LIST [detachable ANY]
            s: STRING
            jv: detachable JSON_VALUE
        do
            create jc.make
            json.add_converter (jc)
            create l.make
            s := "foo"
            l.force (s)
            s := "bar"
            l.force (s)
            jv := json.value (l)
            assert ("jv /= Void", jv /= Void)
            if attached jv as l_jv then
	            s := jv.representation
	            l2 ?= json.object (jv, "LINKED_LIST")
	            assert ("l2 /= Void", l2 /= Void)
            end
        end

    test_hash_table_converter
        local
            tc: JSON_HASH_TABLE_CONVERTER
            t: HASH_TABLE [STRING, STRING]
            t2: detachable HASH_TABLE [ANY, HASHABLE]
            s: STRING
            ucs_key, ucs_value: detachable STRING_32
            jv: detachable JSON_VALUE
        do
            create tc.make
            json.add_converter (tc)
            create t.make (2)
            t.put ("foo", "1")
            t.put ("bar", "2")
            jv := json.value (t)
            assert ("jv /= Void", jv /= Void)
            if attached jv as l_jv then
	            s := l_jv.representation
	            t2 ?= json.object (l_jv, "HASH_TABLE")
	            assert ("t2 /= Void", t2 /= Void)
	        end
            create ucs_key.make_from_string ("1")
            if attached t2 as l_t2 then
	            ucs_value ?= t2 @ ucs_key
	            assert ("ucs_value /= Void", ucs_value /= Void)
	            if attached ucs_value as l_ucs_value then
	            	assert ("ucs_value.string.is_equal (%"foo%")", l_ucs_value.string.is_equal ("foo"))
	            end
	            create ucs_key.make_from_string ("2")
	            ucs_value ?= t2 @ ucs_key
	            assert ("ucs_value /= Void", ucs_value /= Void)
	            if attached ucs_value as l_ucs_value then
	            	assert ("ucs_value.string.is_equal (%"bar%")", l_ucs_value.string.is_equal ("bar"))
	            end

        	end
        end

end -- class TEST_DS
