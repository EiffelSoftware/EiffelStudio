note
	description: "Test DICTIONARY_ quantifiers"
	author: "JSO"
	modified_by: "Faraz A. Torshizi, Eiffel Software"
	date: "$Date$"
	revision: "1.1"

class
	DICTIONARY_TESTS_QUANTIFIERS
inherit
	ES_TEST
		redefine
			setup
		end
create
	make
feature -- Create Tests

		make
				do
					add_boolean_case (agent all_people_in_dictionary_over_18)
					add_boolean_case (agent trudel_exists_in_dictionary_aged_80)
				end

feature -- Test cases

	all_people_in_dictionary_over_18: BOOLEAN
			do
				comment("all people in dictionary over 18")
        		Result := dictionary.for_all(agent older_than(?, ?, 18))

			end

	trudel_exists_in_dictionary_aged_80:BOOLEAN
			do
				comment("trudel exists in dictionary aged 80")
				Result := dictionary.exists(agent with_name_and_aged(?, ?, "TRUDEL", 80))
			end

feature -- help for test cases

   older_than (v: INTEGER; k: STRING; this: INTEGER): BOOLEAN
   		-- is key and value older than 'this'?
   require
   		this > 0
   	do
   		Result := this < v
   	end

    with_name_and_aged (v: INTEGER; k: STRING; this: STRING; age:INTEGER): BOOLEAN
		-- if k is 'this', is it older than 'age'?
	do
		Result := equal(k, this) and age = v
	end

feature -- Setup

	dictionary: DICTIONARY_[INTEGER, STRING]

	setup
				--
			do
				create dictionary.make
				dictionary.put(21, "LARRY")
				dictionary.put(22, "CURLY")
				dictionary.put(23, "MOE")
				dictionary.put(80, "TRUDEL")
				dictionary.put(19, "ZEBULON")
				dictionary.put(20, "ZEKE")
				dictionary.put(20, "ZUMANBAKAWAKI")
			end

end
