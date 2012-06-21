note
	description	: "System's root class"
	author: "VT"

class
	JSO_TEST

inherit
	ES_TEST

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			add_boolean_case (agent bool1)
			add_boolean_case (agent test_insert_hi)
			add_boolean_case (agent test_insert_hi_internals)
			add_boolean_case (agent test_insert_three_words)
			add_boolean_case (agent test_insert_four_words)
			add_boolean_case (agent test_insert_many_ref)
			add_boolean_case (agent test_hold_count_null_character)
			add_boolean_case (agent test_hold_count_two)
			add_boolean_case (agent test_hold_count_three_words)
			add_boolean_case (agent test_insert_a_word_and_null)
			add_violation_case (agent viol1)
			--to_html("tests.htm")
		end

feature -- Boolean Test cases


	bool1: BOOLEAN
		local
			t: TRIE[CHARACTER]
			empty_list: LINKED_LIST[CHARACTER]
		do
			comment("Test an empty trie")
			create empty_list.make
			create t.make
			Result := t.count = 0 and t.is_empty and t.height = 1
		end

	test_insert_hi: BOOLEAN
		local
			t: TRIE[CHARACTER]
			hi: LINKED_LIST[CHARACTER]
		do
			comment("	test_insert_hi")
			create t.make
			hi := stringToLL("hi")
			create t.make
			t.insert(hi)
			Result :=  t.contains (hi) and not t.is_empty and t.count = 1 and t.height = 3
		end

	test_insert_hi_internals: BOOLEAN
		local
			t: TRIE[CHARACTER]
			hi: LINKED_LIST[CHARACTER]
			h, i: TRIE[CHARACTER]
		do
			comment("	test_insert_hi_internals; export `element', `terminal' to UNIT_TEST")
			create t.make
			hi := stringToLL("hi")
			create t.make
			t.insert(hi)
			h := t.ll.item; i := h.ll.item
			Result := t.element = '%U' and not t.terminal
				check Result  end
			Result := h.element = 'h' and not h.terminal and h.height = 2
				check Result  end
			Result := i.element = 'i' and i.terminal and i.height = 1
		end

	test_insert_three_words: BOOLEAN
		local
			t: TRIE[CHARACTER]
			hi, go, him: LINKED_LIST[CHARACTER]
		do
			comment("	test_insert_three_words")
			create t.make
			hi := stringToLL("hi")
			go := stringtoll ("go")
			him := stringtoll ("him")
			create t.make
			t.insert(hi)
			Result := t.contains(hi)
			check Result  end
			t.insert (go)
			Result := t.contains(hi) and t.contains (go)
			check Result  end
			t.insert (him)
			Result :=   t.height = 4 and t.count = 3
			check Result  end
			Result := t.contains (hi)
		end

test_insert_four_words: BOOLEAN
		local
			t: TRIE[CHARACTER]
			he, hers, his, she, hissing: LINKED_LIST[CHARACTER]
		do
			comment("	test_insert_four_words")
			create t.make
			he := stringToLL("he")
			hers := stringtoll ("hers")
			his := stringtoll ("his")
			she := stringtoll ("she")
			hissing := stringtoll ("hissing")
			create t.make
			t.insert(he)
			t.insert(hers)
			t.insert(his)
			t.insert(she)
			Result := t.contains (he) and t.contains(hers) and t.contains(his) and t.contains(she)
			check Result end
			Result := t.count = 4 and t.height = 5
			check Result  end
			Result := not t.contains(hissing)
		end

	test_insert_a_word_and_null: BOOLEAN
		local
			t: TRIE[CHARACTER]
			l1, l2: LINKED_LIST[CHARACTER]
		do
			comment("test_insert_a_word_and_null")
			create t.make
			l1 := stringToLL("hi")
			t.insert(l1)
			l2 := stringToLL("")
			t.insert(l2)
			Result := t.count = 2 and
			          not t.is_empty and
			          t.height = 3 and
			          t.contains(l1) and
			          t.contains(l2)
		end

feature -- Test quantifiers

	test_hold_count_null_character: BOOLEAN
			local
				t: TRIE[CHARACTER]
				null_list: LINKED_LIST[CHARACTER]
			do
				comment("test_hold_count_null_character")
				create null_list.make
				null_list.extend('%U')
				create t.make
				Result := t.hold_count(agent start_with_h(?)) = 0
			end

	test_hold_count_two: BOOLEAN
			local
				t: TRIE[CHARACTER]
			do
				comment("test_hold_count_two")
				create t.make
				t.insert(stringtoll ("hi"))
				t.insert (stringtoll ("hello"))
				Result := t.hold_count(agent start_with_h(?)) = 2
			end

	test_hold_count_three_words: BOOLEAN
		local
			t: TRIE[CHARACTER]
			hi, go, him: LINKED_LIST[CHARACTER]
		do
			comment("	test_hold_count_three_words")
			create t.make
			hi := stringToLL("hi")
			go := stringtoll ("go")
			him := stringtoll ("him")
			create t.make
			t.insert(hi)
			t.insert (go)
			t.insert (him)
			Result := t.hold_count(agent start_with_h(?)) = 2
		end

	start_with_h(seq: LINKED_LIST[CHARACTER]): BOOLEAN
			do
				if not seq.is_empty then
					Result := seq.first = 'h'
				end
			end


feature -- Reference Tests

	test_insert_many_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l1, l2, l3: LINKED_LIST[PERSON]
		do
			comment("test_insert_many_ref")
			create t.make
			l1 := string_to_persons("hi")
			t.insert(l1)
			l2 := string_to_persons("hello")
			t.insert(l2)
			Result := t.count = 2 and
			          not t.is_empty and
			          t.height = 6 and
			          t.contains(l1) and
			          t.contains(l2)
			check Result  end
			l3 := string_to_persons("hell")
			t.insert(l3)
			Result := Result and
			          t.count = 3 and
			          not t.is_empty and
			          t.height = 6 and
			          t.contains(l1) and
			          t.contains(l2) and
			          t.contains(l3)
		end

feature -- Violation Test cases
		viol1
		local
			t: TRIE[CHARACTER]
		do
			comment("Test that inserting the same sequence twice causes a violation")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("hi"))
		end

feature {NONE} -- Implementation

	stringtoLL (s: STRING): LINKED_LIST[CHARACTER]
			-- Transform a string into a linked list of characters
		local
			i: INTEGER
		do
			create Result.make
			from
				i := 1
			invariant
				Result.count = i - 1
				Result.count <= s.count

			until
				i > s.count
			loop
				Result.extend(s.item(i))
				i := i + 1
			variant
				s.count - i + 1
			end
		end

	string_to_persons (s: STRING): LINKED_LIST[PERSON]
	  		-- Transform a string into a linked list of PERSON objects
		  local
			  i: INTEGER
			  p: PERSON
		  do
		    create Result.make
			from i := 1
			invariant
			  Result.count = i - 1
			  Result.count <= s.count

			until i > s.count
			loop
				create p.make(s.substring(i,i), 66)
			  Result.extend(p)
			  i := i + 1
			  variant  s.count - i + 1
		    end
		end

end -- class ROOT_CLASS
