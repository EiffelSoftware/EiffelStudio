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


feature {NONE} -- Implementation

	tata: STRING = "tata"
	tutu: STRING = "tutu"
	titi: STRING = "titi"
	toto: STRING = "toto"
end


