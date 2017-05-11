note
	description: "Tests for dictionary"
	author: "Faraz A. Torshizi, Eiffel Software"
	date: "$Date$$"
	revision: "1.1"

class
	DICTIONARY_TESTS_YOURS

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

    make
	          -- Run all tests.
    do
  			-- Tests of class DIC_ITEM_
        add_violation_case (agent  t0_0)
        add_boolean_case (agent  t0_1)
        add_boolean_case (agent  t0_2)
        	-- Tests of feature 'make' of the DICTIONARY class
        add_boolean_case (agent  t1_0)
        	-- Tests of feature 'put' of the DICTIONARY class
        add_boolean_case (agent  t2_0)
        add_violation_case (agent  t2_1)
        add_violation_case (agent  t2_2)
        add_boolean_case (agent  t2_3)
        add_boolean_case (agent  t2_4)
        add_boolean_case (agent  t2_5)
        	-- Tests of feature 'put_defensive' of the DICTIONARY class
        add_boolean_case (agent  t3_0)
        add_boolean_case (agent  t3_1)
        add_boolean_case (agent  t3_2)
        add_boolean_case (agent  t3_3)
        add_boolean_case (agent  t3_4)
        	-- Tests of feature 'has' of the DICTIONARY class
        add_boolean_case (agent  t4_0)
        add_violation_case (agent  t4_1)
        add_boolean_case (agent  t4_2)
        	-- Tests of feature 'at and @' of the DICTIONARY class
        add_boolean_case (agent  t5_0)
        add_violation_case (agent  t5_1)
        add_violation_case (agent  t5_2)
        	-- Tests of feature 'remove' of the DICTIONARY class
        add_boolean_case (agent  t6_0)
        add_boolean_case (agent  t6_1)
        add_violation_case (agent  t6_2)
        add_violation_case (agent  t6_3)
        	-- Tests of feature 'has_defensive' of the DICTIONARY class
        add_boolean_case (agent  t7_0)
        add_boolean_case (agent  t7_1)
           	-- Tests of feature 'for_all' of the DICTIONARY class
        add_boolean_case (agent  t8_0)
        add_boolean_case (agent  t8_1)
        add_boolean_case (agent  t8_2)
        	-- Tests of feature 'exists' of the DICTIONARY class
        add_boolean_case (agent t9_0)
        add_boolean_case (agent t9_1)
        add_boolean_case (agent t9_2)
        add_boolean_case (agent t9_3)
        add_boolean_case (agent t10_0)
   end

feature  -- tests cases

   t0_0
   			-- fails to make a_dic_item with void key and value v
   local
   		a_dic_item: DIC_ITEM_ [INTEGER, STRING]
   	do
   		comment("Does it fail to make a_dic_item with void key?")
   		create  a_dic_item.make (1, void)

   	end

	t0_1: BOOLEAN
   			-- make a_dic_item with key k and value v and get that key and value
   local
   		a_dic_item: DIC_ITEM_ [INTEGER, STRING]
   	do
   		comment("Does it return the key and the value of DIC_ITEM_?")
   		create  a_dic_item.make (1, "key1")
   		Result := equal(a_dic_item.get_key , "key1") and equal(a_dic_item.get_value , 1)

   	end

   t0_2: BOOLEAN
   			-- make a_dic_item with void value
   local
   		a_dic_item: DIC_ITEM_ [STRING, STRING]
   	do
   		comment("Does make a DIC_ITEM_ with void value?")
   		create  a_dic_item.make (void, "key")
   		Result := a_dic_item.get_value = void
   	end

   t1_0: BOOLEAN
   			-- make an empty dictionary
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
   	do
   		comment("Does it make an empty dictionary?")
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0

   	end

   t2_0: BOOLEAN
   			-- make a dictionary and put a key and its value in it
   local
   		a_dictionary: DICTIONARY_ [STRING, STRING]
		k: STRING
    	v: STRING
   	do
   		comment("Does it put a key and its value in it?")
   		k := "t1"
        v := "t1@cs.yorku.ca"
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
   		a_dictionary.put(v, k)
   		Result:= not a_dictionary.is_empty and a_dictionary.count = 1 and equal (a_dictionary.at ("t1"),"t1@cs.yorku.ca")
   	end

  	t2_1
   			-- make a dictionary, fails to put void key into dictionary
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
		v: INTEGER
   	do
   		comment("Does it fail to put void key in the dictionary?")
   		v := 123
   		create  a_dictionary.make
   		check a_dictionary.is_empty and a_dictionary.count = 0 end
		a_dictionary.put(v, void)
   	end

  	t2_2
   			-- make a dictionary, fails to put key which already exists
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
		v: INTEGER
		k1: STRING
		k2: STRING
   	do
   		comment("Does it fail to put a key which already exists?")
   		v := 123
   		k1 := "key1"
   		k2 := "key1"
   		create  a_dictionary.make
   		check a_dictionary.is_empty and a_dictionary.count = 0 end
   		a_dictionary.put(v, k1)
   		check  not a_dictionary.is_empty and a_dictionary.count = 1 end
		a_dictionary.put(v, k2)
   	end

  t2_3: BOOLEAN
   			-- make a dictionary put 5 keys in it
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]

  	do
   		comment("put more keys in the dictionary")
   		create  a_dictionary.make
   		check a_dictionary.is_empty and a_dictionary.count = 0 end
   		add_5_names (a_dictionary)
   		Result:=  not a_dictionary.is_empty and a_dictionary.count = 5 and a_dictionary.at ("AB") = 6
   		and a_dictionary.at ("CD") = 13 and a_dictionary.at ("EF") = 10 and a_dictionary.at ("GH") = 21 and
   		a_dictionary.at ("IJ") = 45
   	end

   t2_4: BOOLEAN
   			-- make a dictionary put void value in it
   local
   		a_dictionary: DICTIONARY_ [STRING, STRING]

  	do
   		comment("Does it allow for void values?")
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
		a_dictionary.put (void, "key")
		Result:=  not a_dictionary.is_empty and a_dictionary.count = 1 and a_dictionary.at ("key") = void
   	end


   t2_5: BOOLEAN
   			-- Make a dictionary put 100 keys and values in it.
   local
   		a_dictionary: DICTIONARY_ [INTEGER, INTEGER]
   		i: INTEGER
  	do
   		comment("Dictionary with 100 keys and values")
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
		from
			i := 0
		until
			i >= 100
		loop
			a_dictionary.put (i, i)
			i := i + 1
		end
		Result := true
		from
			i := 0
		until
			i >= 100
		loop
			if
				a_dictionary.at (i) /= i
			then
				Result := false
			end
			i := i + 1
		end

   	end


	t3_0: BOOLEAN
   			-- make a dictionary and put_defensive a key and its value in it
   local
   		a_dictionary: DICTIONARY_ [STRING, STRING]
		k: STRING
    	v: STRING
   	do
   		comment("Does it put_defensive key and value")
   		k := "t"
        v := "t@cs.yorku.ca"
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
   		a_dictionary.put_defensive(v, k)
   		Result:= not a_dictionary.is_empty and a_dictionary.count = 1 and equal (a_dictionary.at ("t"), "t@cs.yorku.ca")
   	end

	t3_1: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and put_defensive a similar key, different value. old value should be changed
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it put_defensive another key which already exists with new value?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        Result := a_dictionary.at("AB") = 6
        check Result end
        a_dictionary.put_defensive(100, "AB")	-- already existing key with different value
        Result := a_dictionary.at("AB") = 100 and a_dictionary.count = 5
    end

	t3_2: BOOLEAN
   			-- make a dictionary, put_defensive void key into dictionary
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
		v: INTEGER
   	do
   		comment("Does it put_defensive void key in the dictionary?")
   		v := 930
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
   		a_dictionary.put_defensive(v, void)
   		Result := a_dictionary.is_empty and a_dictionary.count = 0 -- nothing should happen
   	end

   t3_3: BOOLEAN
   			-- make a dictionary put_defensive 5 keys in it
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]

  	do
   		comment("put_defensive more keys in the dictionary")
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
   		add_5_names_2 (a_dictionary)
   		Result:=  not a_dictionary.is_empty and a_dictionary.count = 5 and a_dictionary.at ("A") = 9
   		and a_dictionary.at ("B") = 19 and a_dictionary.at ("C") = 20 and a_dictionary.at ("D") = 22 and
   		a_dictionary.at ("E") = 59
   	end

   	t3_4 : BOOLEAN
		-- put_defensive 6 keys and values with 2 keys are the same.
	local
		a_dictionary: DICTIONARY_ [STRING, STRING]
	do
		comment("Does put_defensive overwrites old values?")
		create a_dictionary.make
		check a_dictionary.is_empty end
		a_dictionary.put_defensive ("old_john@website.com","John")
		a_dictionary.put_defensive ("old_tina@website.com","Tina")
		a_dictionary.put_defensive ("ali@website.com","ali")
		a_dictionary.put_defensive ("xu@website.com","xu")
		a_dictionary.put_defensive ("new_john@website.com","John")
		a_dictionary.put_defensive ("new_tina@website.com","Tina")

		check a_dictionary.has("John") and a_dictionary.count = 4 and a_dictionary.has("Tina")
		end
		Result := a_dictionary.at("Tina").is_equal ("new_tina@website.com") and a_dictionary.at("John").is_equal ("new_john@website.com")
	end

	t4_0: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values test to see if it has a specified key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it return true if the key is in the dictionary?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := a_dictionary.is_empty and a_dictionary.count = 5
        check not Result end
        Result := a_dictionary.has("AB") and a_dictionary.has("CD") and a_dictionary.has("EF") and
        a_dictionary.has("GH") and a_dictionary.has("IJ") and not a_dictionary.has("KL")
    end

	t4_1
    		-- make a dictionary and put 5 keys and their
    		-- values test to see if fails for void key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    	temp: BOOLEAN
    do
    	comment("Does it fail to check (has) for a void key")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        check  not a_dictionary.is_empty and a_dictionary.count = 5 end
   		temp := a_dictionary.has(void)
    end

    t4_2: BOOLEAN
    		-- has returns false on an empty dictionary
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    	temp: BOOLEAN
    do
    	comment("has returns false on empty dictionary")
    	create  a_dictionary.make
        Result := a_dictionary.is_empty and a_dictionary.count = 0
        check Result end
   		temp := a_dictionary.has("gabligoo")
   		Result := temp = false
    end

	t5_0: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values at specifeid keys
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
   	do
    	comment("Does it return values at specified keys?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check  Result end
        Result := a_dictionary.at("AB") = 6 and a_dictionary.at("CD") = 13 and a_dictionary.at("EF") = 10
        and  a_dictionary @ "GH" = 21  and a_dictionary @ "IJ" = 45
    end

	t5_1
    		-- make a dictionary and put 5 keys and their
    		-- values test to see if fails for void key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    	temp: INTEGER
    do
    	comment("Does it fail to access void key?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        check  not a_dictionary.is_empty and a_dictionary.count = 5 end
  		temp := a_dictionary.at(void)
    end

	t5_2
    		-- make a dictionary and put 5 keys and their
    		-- values test to see if fails for accessing non existing key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    	temp: INTEGER
    do
    	comment("Does it fail to access a non-existing key?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        check  not a_dictionary.is_empty and a_dictionary.count = 5 end
   		temp := a_dictionary.at("balablah")
    end

	t6_0: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and remove a key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it remove a key?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        a_dictionary.remove("AB")
        Result:= not a_dictionary.is_empty and a_dictionary.count = 4 and
        		not a_dictionary.has("AB")
   end

	t6_1: BOOLEAN
   			-- make a dictionary and put a key and remove that key
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
		k: STRING
    	v: INTEGER
   	do
   		comment("put a key and remove that key")
   		k := "A"
        v := 90
   		create  a_dictionary.make
   		Result := a_dictionary.is_empty and a_dictionary.count = 0
   		check Result end
   		a_dictionary.put(v, k)
   	    Result := not a_dictionary.is_empty and a_dictionary.count = 1
   	    check Result end
   		a_dictionary.remove("A")
   		Result := a_dictionary.is_empty and a_dictionary.count = 0 and not a_dictionary.has_defensive("A")
   	end

	t6_2
   			-- make an empty dictionary and fails to remove a key
   local
   		a_dictionary: DICTIONARY_ [INTEGER, STRING]
	do
   		comment("Does it make an empty dictionary and fail to remove a key?")
   		create  a_dictionary.make
   		check a_dictionary.is_empty and a_dictionary.count = 0 end
 		a_dictionary.remove("A")
   	end

	t6_3
   			-- make a dictionary and put 5 keys and fails to remove a non existing key
  local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it fail to remove a non-existing key?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        check  not a_dictionary.is_empty and a_dictionary.count = 5 end
        a_dictionary.remove("blablah")
   end

   t7_0: BOOLEAN
    	-- make an empty dictionary and check if it has_defensive a key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it perform has_defensive on an empty dictionary?")
    	create  a_dictionary.make
        Result := a_dictionary.has_defensive ("a_key") = false -- should return false
    end

    t7_1: BOOLEAN
    	-- make a dictionary and check if it has_defensive a void key
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Does it perform has_defensive with void key?")
    	create  a_dictionary.make
    	add_5_names (a_dictionary)
        Result := a_dictionary.has_defensive (void) = false
    end

   t8_0: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and check if all of the item in the dictionary can
    		-- satisfy the test 'more_than'
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Are all values in the dictionary more than 5 and not more than 46?")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        Result := a_dictionary.for_all(agent more_than(?, ?, 5)) and not a_dictionary.for_all(agent more_than(?, ?, 46))
   end

   t8_1: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and check if all of the item in the dictionary can
    		-- satisfy the test key_starts_with
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Do all keys in the dictionary start with letter s? and not letter 'A'")
    	create  a_dictionary.make
        a_dictionary.put(123, "sara")
        a_dictionary.put(124, "sib")
        a_dictionary.put(125, "soosool")
        Result := not a_dictionary.is_empty and a_dictionary.count = 3
        check Result end
        Result := a_dictionary.for_all(agent key_starts_with(?, ?, 's'))
        	   and not a_dictionary.for_all(agent key_starts_with(?, ?, 'A'))
   end

   t8_2: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and check if all of the item in the dictionary can
    		-- satisfy the test has_value
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Do all values in the dictionary equal to 20?")
    	create  a_dictionary.make
        a_dictionary.put(20, "sara")
        a_dictionary.put(20, "sib")
        a_dictionary.put(20, "soosool")
        Result :=  not a_dictionary.is_empty and a_dictionary.count = 3
        check Result end
        Result := a_dictionary.for_all(agent has_value(?, ?, 20))
        	   and not a_dictionary.for_all(agent has_value(?, ?, 60))
   end

   t9_0: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- Is there any value in dictionary which is more than 20 and not more than 93

    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Is there any value in dictionary which is more than 20 and not more than 93")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        Result := a_dictionary.exists(agent more_than (?, ? , 20)) and
        		  not a_dictionary.exists(agent more_than (?, ? , 93))
   end

    t9_1: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and check if there exist items whose keys start with E
    		-- and there exists no items whose keys start with Z
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("Is there an item whose name start with E and no items whose name start with Z")
    	create  a_dictionary.make
        add_5_names (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        Result := a_dictionary.exists(agent key_starts_with(?, ?, 'E')) and not
        a_dictionary.exists(agent key_starts_with(?, ?, 'Z'))
   end

    t9_2: BOOLEAN
    		-- make a dictionary and put 5 keys and their
    		-- values and check if values for keys with key "C" are more than 8
    		--
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    do
    	comment("check if values for keys with key C are more than 8")
    	create  a_dictionary.make
        add_5_names_2 (a_dictionary)
        Result := not a_dictionary.is_empty and a_dictionary.count = 5
        check Result end
        Result := a_dictionary.exists(agent with_key_and_more_than(?, ?, "C", 8))
   end

    t9_3: BOOLEAN
    		-- Do all items whose key starts with a "A" have value 10?
    local
    	a_dictionary: DICTIONARY_ [INTEGER, STRING]
    	temp: BOOLEAN
    do
    	comment("Do all items whose key starts with a 'A' have value 10")
    	create  a_dictionary.make
        a_dictionary.put(10, "Aeeb")
        a_dictionary.put(10, "Aibi")
        a_dictionary.put(95, "sib")
        Result := not a_dictionary.is_empty and a_dictionary.count = 3
        check Result end
        temp := a_dictionary.for_all(agent if_starts_with_has_value(?, ?, 'A', 10))
        a_dictionary.put(22, "Abbb") -- make it false
        Result :=  not a_dictionary.for_all(agent if_starts_with_has_value(?, ?, 'A', 10)) and temp
   end

	t10_0: BOOLEAN
	    		-- Reference check
	    local
	    	p1, p2, p3: PERSON
	    	a_dictionary: DICTIONARY_ [STRING, PERSON]
	    do
	   		comment("Reference check")
	   		create a_dictionary.make
	   		create p1.make ("Faraz", 23)
	   		create p3.make ("Faraz", 23)
	   		create p2.make ("Biti", 19)

	   		a_dictionary.put ("york", p1)
	   		Result := a_dictionary.has(p1)
	   		check Result end
	end

feature  {NONE} -- Implementation
	add_5_names (a_dictionary: DICTIONARY_ [INTEGER, STRING])
    		-- resuse in various tests
    local
    	k: STRING
        v: INTEGER
    do
    	k := "AB"
        v := 6
        a_dictionary.put (v, k)
        k := "CD"
        v := 13
        a_dictionary.put (v, k)
        k := "EF"
        v := 10
        a_dictionary.put (v, k)
        k := "GH"
        v := 21
        a_dictionary.put (v, k)
        k := "IJ"
        v := 45
        a_dictionary.put (v, k)
   end

   add_5_names_2 (a_dictionary: DICTIONARY_ [INTEGER, STRING])
    		-- resuse in various tests
    local
    	k: STRING
        v: INTEGER
    do
    	k := "A"
        v := 9
        a_dictionary.put_defensive (v, k)
        k := "B"
        v := 19
        a_dictionary.put_defensive (v, k)
        k := "C"
        v := 20
        a_dictionary.put_defensive (v, k)
        k := "D"
        v := 22
        a_dictionary.put_defensive (v, k)
        k := "E"
        v := 59
        a_dictionary.put_defensive (v, k)
   end

   more_than (v: INTEGER; k: STRING; this: INTEGER): BOOLEAN
   		-- is key and value more than 'this'?
   require
   		this > 0
   	do
   		Result := this < v
   	end

   key_starts_with (v: INTEGER; k: STRING; letter: CHARACTER): BOOLEAN
   		-- Does k starts with 'letter'?
   	require
   		k /= void
--   		letter /= void
   	do
   		Result := k [1] = letter
   	end

   has_value (v: INTEGER; k: STRING; val: INTEGER): BOOLEAN
   		-- Does value equals to 'val'?
   	require
   		val > 0
   	do
   		Result := v = val
   	end

	if_starts_with_has_value (v: INTEGER; k: STRING; letter: CHARACTER; val:INTEGER): BOOLEAN
		-- if k starts with letter, does v equals to val?
	do
		if key_starts_with(v, k, letter) then
			Result := has_value(v, k, val)
		else
			Result := True
		end
	end

    with_key_and_more_than (v: INTEGER; k: STRING; this: STRING; n:INTEGER): BOOLEAN
		-- if k is 'this', is it more than 'n'?
	do
		Result := equal(k, this) and more_than(v, k, n)
	end

end
