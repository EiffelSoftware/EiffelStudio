note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TABLE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_hash_table
			-- New test routine
		local
			t: HASH_TABLE_EX [STRING, STRING]
		do
			create t.make_with_key_tester (0, create {REFERENCE_EQUALITY_TESTER [STRING]})
			t.put ("a", tata)
			t.put ("u", tutu)
			t.put ("i", titi)
			t.put ("o", toto)
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			t.put ("o", "tata")
			assert ("has tata", t.has (tata))
			assert ("not has tata", not t.has ("tata"))
		end

	test_string_table
			-- New test routine
		local
			t: STRING_TABLE [STRING]
		do
			create t.make (5)
			t.put ("the lower", "lower")
			t.put ("the UPPER", "UPPER")
			t.put ("the mixED", "mixED")

			assert ("has lower", t.has ("lower"))
			assert ("has UPPER", t.has ("UPPER"))
			assert ("has mixED", t.has ("mixED"))
			assert ("not has MIXED", not t.has ("MIXED"))
			assert ("not has LOWER", not t.has ("LOWER"))
			assert ("not has upper", not t.has ("upper"))

			t.put ("abc", text_as_immutable_string_32)

			assert ("has text", t.has (text))
			assert ("has text_as_string_8", t.has (text_as_string_8))
			assert ("has text_as_string_32", t.has (text_as_string_32))
			assert ("has text_as_immutable_string_8", t.has (text_as_immutable_string_8))
			assert ("has text_as_immutable_string_32", t.has (text_as_immutable_string_32))
			assert ("has text", t.has ("text"))
		end

	test_caseless_string_table
			-- New test routine
		local
			t: STRING_TABLE [STRING]
		do
			create t.make_caseless (5)
			t.put ("the lower", "lower")
			t.put ("the UPPER", "UPPER")
			t.put ("the mixED", "mixED")

			assert ("has lower", t.has ("lower"))
			assert ("has UPPER", t.has ("UPPER"))
			assert ("has mixED", t.has ("mixED"))
			assert ("has MIXED", t.has ("MIXED"))
			assert ("has LOWER", t.has ("LOWER"))
			assert ("has upper", t.has ("upper"))

			t.put ("abc", text_as_immutable_string_32)

			assert ("has text", t.has (text))
			assert ("has text_as_string_8", t.has (text_as_string_8))
			assert ("has text_as_string_32", t.has (text_as_string_32))
			assert ("has text_as_immutable_string_8", t.has (text_as_immutable_string_8))
			assert ("has text_as_immutable_string_32", t.has (text_as_immutable_string_32))
			assert ("has text", t.has ("text"))
			assert ("has text", t.has ("tExT"))
			assert ("has text", t.has ({STRING_32} "text"))
		end




feature {NONE} -- Implementation

	tata: STRING = "tata"
	tutu: STRING = "tutu"
	titi: STRING = "titi"
	toto: STRING = "toto"

	text: STRING = "text"

	text_as_string_8: STRING_8
		once
			Result := text
		end

	text_as_string_32: STRING_32
		once
			Result := text.to_string_32
		end

	text_as_immutable_string_32: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general (text)
		end

	text_as_immutable_string_8: IMMUTABLE_STRING_8
		once
			create Result.make_from_string (text)
		end
note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


