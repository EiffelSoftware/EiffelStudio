note
	description: "Linked list and hash table converters test."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DS

inherit

	SHARED_EJSON
		undefine
			default_create
		end

	EQA_TEST_SET

feature -- Test

	test_linked_list_converter
			-- Convert a linked list to a json value and
			-- convert this one to a linked list.
		local
			l: LINKED_LIST [STRING]
			s: STRING
		do
			create l.make
			l.force ("foo")
			l.force ("bar")
			if attached json.value (l) as l_value then
				s := l_value.representation
				assert ("JSON array converted to LINKED_LIST", attached {LINKED_LIST [detachable ANY]} json.object (l_value, "LINKED_LIST"))
			else
				assert ("LINKED_LIST converted to a JSON value", False)
			end
		end

	test_hash_table_converter
			-- Convert a hash table to a json value and
			-- convert this one to a hash table.
		local
			t: HASH_TABLE [STRING, STRING]
			s: STRING
			l_ucs_key: detachable STRING_32
		do
			create t.make (2)
			t.put ("foo", "1")
			t.put ("bar", "2")
			if attached json.value (t) as l_value then
				s := l_value.representation
				if attached {HASH_TABLE [ANY, HASHABLE]} json.object (l_value, "HASH_TABLE") as t2 then
					create l_ucs_key.make_from_string ("1")
					if attached {STRING_32} t2 [l_ucs_key] as l_ucs_value then
						assert ("ucs_value.string.is_equal (%"foo%")", l_ucs_value.same_string_general ("foo"))
					else
						assert ("ucs_value /= Void", False)
					end
					create l_ucs_key.make_from_string ("2")
					if attached {STRING_32} t2 [l_ucs_key] as l_ucs_value then
						assert ("ucs_value.string.is_equal (%"bar%")", l_ucs_value.same_string_general ("bar"))
					else
						assert ("ucs_value /= Void", False)
					end
				else
					assert ("JSON object converted to HASH_TABLE", False);
				end
			else
				assert ("HASH_TABLE converted to a JSON value", False)
			end
		end

end -- class TEST_DS
