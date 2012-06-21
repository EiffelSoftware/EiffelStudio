note
	description	: "System's root class"
	author: "VT"

class
	VT_TEST

inherit
	ES_TEST

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			-- Test cases by V. Tzerpos
			all_expanded_tests
			all_reference_tests
			-- Test cases by G. Gotshalks
			all_make_tests
    		all_height_tests
			all_insert_tests
			all_contains_tests
			all_count_tests
			all_precondition_tests
			-- Test cases by J. Ostroff
			add_boolean_case (agent test_insert_four_words)
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
			Result := t.contains (he) and t.contains(hers) and
					t.contains(his) and t.contains(she)
			check Result end
			Result := t.count = 4 and t.height = 5
			check Result  end
			Result := not t.contains(hissing)
		end

	all_expanded_tests
			-- Test cases using an expanded generic parameter (CHARACTER)
			do
				add_boolean_case (agent test_empty_trie)
				add_boolean_case (agent test_insert_one)
				add_boolean_case (agent test_insert_null)
				add_boolean_case (agent test_insert_one_and_null)
				add_boolean_case (agent test_insert_many)
				add_boolean_case (agent test_for_all_empty)
				add_boolean_case (agent test_for_all_true)
				add_boolean_case (agent test_for_all_false)
				add_boolean_case (agent test_for_all_one_true)
				add_boolean_case (agent test_for_all_one_false)
				add_boolean_case (agent test_exists_true)
				add_boolean_case (agent test_exists_false)
				add_boolean_case (agent test_exists_one_true)
				add_boolean_case (agent test_exists_one_false)
				add_boolean_case (agent test_exists_empty)
				add_boolean_case (agent test_exists1_true)
				add_boolean_case (agent test_exists1_false)
				add_boolean_case (agent test_exists1_one_true)
				add_boolean_case (agent test_exists1_one_false)
				add_boolean_case (agent test_exists1_empty)
				add_violation_case (agent test_insert_same_1)
				add_violation_case (agent test_insert_same_2)
			end

	all_reference_tests
			-- Test cases using an reference generic parameter (PERSON)
			do
				add_boolean_case (agent test_empty_trie_ref)
				add_boolean_case (agent test_insert_one_ref)
				add_boolean_case (agent test_insert_null_ref)
				add_boolean_case (agent test_insert_one_and_null_ref)
				add_boolean_case (agent test_insert_many_ref)
				add_boolean_case (agent test_for_all_empty_ref)
				add_boolean_case (agent test_for_all_true_ref)
				add_boolean_case (agent test_for_all_false_ref)
				add_boolean_case (agent test_for_all_one_true_ref)
				add_boolean_case (agent test_for_all_one_false_ref)
				add_boolean_case (agent test_exists_true_ref)
				add_boolean_case (agent test_exists_false_ref)
				add_boolean_case (agent test_exists_one_true_ref)
				add_boolean_case (agent test_exists_one_false_ref)
				add_boolean_case (agent test_exists_empty_ref)
				add_boolean_case (agent test_exists1_true_ref)
				add_boolean_case (agent test_exists1_false_ref)
				add_boolean_case (agent test_exists1_one_true_ref)
				add_boolean_case (agent test_exists1_one_false_ref)
				add_boolean_case (agent test_exists1_empty_ref)
				add_boolean_case (agent test_insert_same_1_ref)
				add_violation_case (agent test_insert_same_2_ref)
			end

feature -- Expanded test cases

	test_empty_trie: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test an empty trie")
			create t.make
			Result := t.count = 0 and t.is_empty and t.height = 1
		end

	test_insert_one: BOOLEAN
		local
			t: TRIE[CHARACTER]
			l: LINKED_LIST[CHARACTER]
		do
			comment("Test insert when adding one sequence")
			create t.make
			l := stringToLL("hi")
			t.insert(l)
			Result := t.count = 1 and
			          not t.is_empty and
			          t.height = 3 and
			          t.contains(l)
		end

	test_insert_null: BOOLEAN
		local
			t: TRIE[CHARACTER]
			l: LINKED_LIST[CHARACTER]
		do
			comment("Test insert when adding one null sequence")
			create t.make
			l := stringToLL("")
			t.insert(l)
			Result := t.count = 1 and
			          not t.is_empty and
			          t.height = 1 and
			          t.contains(l)
		end

	test_insert_one_and_null: BOOLEAN
		local
			t: TRIE[CHARACTER]
			l1, l2: LINKED_LIST[CHARACTER]
		do
			comment("Test insert when adding one sequence and then a null one")
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

	test_insert_many: BOOLEAN
		local
			t: TRIE[CHARACTER]
			l1, l2, l3: LINKED_LIST[CHARACTER]
		do
			comment("Test insert when adding many sequences")
			create t.make
			l1 := stringToLL("hi")
			t.insert(l1)
			l2 := stringToLL("hello")
			t.insert(l2)
			Result := t.count = 2 and
			          not t.is_empty and
			          t.height = 6 and
			          t.contains(l1) and
			          t.contains(l2)
			l3 := stringToLL("hell")
			t.insert(l3)
			Result := Result and
			          t.count = 3 and
			          not t.is_empty and
			          t.height = 6 and
			          t.contains(l1) and
			          t.contains(l2) and
			          t.contains(l3)
		end

	test_for_all_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test for_all with expected true result")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("hello"))
			Result := t.for_all (agent startsWithH)
		end

	test_for_all_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test for_all with expected false result")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("yo"))
			Result := not t.for_all (agent startsWithH)
		end

	test_for_all_one_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test for_all with expected true result and only one sequence")
			create t.make
			t.insert(stringToLL("hello"))
			Result := t.for_all (agent startsWithH)
		end

	test_for_all_one_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test for_all with expected false result and only one sequence")
			create t.make
			t.insert(stringToLL("yo"))
			Result := not t.for_all (agent startsWithH)
		end

	test_for_all_empty: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test for_all with an empty trie")
			create t.make
			Result := t.for_all (agent startsWithH)
		end

	test_exists_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists with expected true result")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("hello"))
			Result := t.exists (agent startsWithH)
		end

	test_exists_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists with expected false result")
			create t.make
			t.insert(stringToLL("yo"))
			t.insert(stringToLL("cheers"))
			Result := not t.exists (agent startsWithH)
		end

	test_exists_one_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists with expected true result and only one sequence")
			create t.make
			t.insert(stringToLL("hi"))
			Result := t.exists (agent startsWithH)
		end

	test_exists_one_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists with expected false result and only one sequence")
			create t.make
			t.insert(stringToLL("cheers"))
			Result := not t.exists (agent startsWithH)
		end

	test_exists_empty: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists with an empty trie")
			create t.make
			Result := not t.exists (agent startsWithH)
		end

	test_exists1_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists1 with expected true result")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("cheers"))
			Result := t.exists1 (agent startsWithH)
			t.insert(stringToLL("yo"))
			t.insert(stringToLL("bye"))
			Result := Result and t.exists1 (agent startsWithH)
		end

	test_exists1_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists1 with expected false result")
			create t.make
			t.insert(stringToLL("yo"))
			t.insert(stringToLL("cheers"))
			Result := not t.exists1 (agent startsWithH)
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("hello"))
			Result := Result and not t.exists1 (agent startsWithH)
		end

	test_exists1_one_true: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists1 with expected true result and only one sequence")
			create t.make
			t.insert(stringToLL("hi"))
			Result := t.exists1 (agent startsWithH)
		end

	test_exists1_one_false: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists1 with expected false result and only one sequence")
			create t.make
			t.insert(stringToLL("cheers"))
			Result := not t.exists1 (agent startsWithH)
		end

	test_exists1_empty: BOOLEAN
		local
			t: TRIE[CHARACTER]
		do
			comment("Test exists1 with an empty trie")
			create t.make
			Result := not t.exists1 (agent startsWithH)
		end

	test_insert_same_1
		local
			t: TRIE[CHARACTER]
		do
			comment("Test that inserting a similar sequence twice causes a violation for expanded types")
			create t.make
			t.insert(stringToLL("hi"))
			t.insert(stringToLL("hi"))
		end

	test_insert_same_2
		local
			t: TRIE[CHARACTER]
			l: LINKED_LIST[CHARACTER]
		do
			comment("Test that inserting the same sequence twice causes a violation for expanded types")
			create t.make
			l := stringToLL("hi")
			t.insert(l)
			t.insert(l)
		end

feature -- Reference test cases

	test_empty_trie_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test an empty trie for reference types")
			create t.make
			Result := t.count = 0 and t.is_empty and t.height = 1
		end

	test_insert_one_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l: LINKED_LIST[PERSON]
		do
			comment("Test insert when adding one sequence for reference types")
			create t.make
			l := string_to_persons("hi")
			t.insert(l)
			Result := t.count = 1 and
			          not t.is_empty and
			          t.height = 3 and
			          t.contains(l)
		end

	test_insert_null_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l: LINKED_LIST[PERSON]
		do
			comment("Test insert when adding one null sequence for reference types")
			create t.make
			l := string_to_persons("")
			t.insert(l)
			Result := t.count = 1 and
			          not t.is_empty and
			          t.height = 1 and
			          t.contains(l)
		end

	test_insert_one_and_null_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l1, l2: LINKED_LIST[PERSON]
		do
			comment("Test insert when adding one sequence and then a null one for reference types")
			create t.make
			l1 := string_to_persons("hi")
			t.insert(l1)
			l2 := string_to_persons("")
			t.insert(l2)
			Result := t.count = 2 and
			          not t.is_empty and
			          t.height = 3 and
			          t.contains(l1) and
			          t.contains(l2)
		end

	test_insert_many_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l1, l2, l3: LINKED_LIST[PERSON]
		do
			comment("Test insert when adding many sequences for reference types")
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

	test_for_all_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test for_all with expected true result for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			t.insert(string_to_persons("hello"))
			Result := t.for_all (agent first_person_is_h)
		end

	test_for_all_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test for_all with expected false result for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			t.insert(string_to_persons("yo"))
			Result := not t.for_all (agent first_person_is_h)
		end

	test_for_all_one_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test for_all with expected true result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("hello"))
			Result := t.for_all (agent first_person_is_h)
		end

	test_for_all_one_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test for_all with expected false result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("yo"))
			Result := not t.for_all (agent first_person_is_h)
		end

	test_for_all_empty_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test for_all with an empty trie for reference types")
			create t.make
			Result := t.for_all (agent first_person_is_h)
		end

	test_exists_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists with expected true result for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			t.insert(string_to_persons("hello"))
			Result := t.exists (agent first_person_is_h)
		end

	test_exists_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists with expected false result for reference types")
			create t.make
			t.insert(string_to_persons("yo"))
			t.insert(string_to_persons("cheers"))
			Result := not t.exists (agent first_person_is_h)
		end

	test_exists_one_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists with expected true result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			Result := t.exists (agent first_person_is_h)
		end

	test_exists_one_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists with expected false result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("cheers"))
			Result := not t.exists (agent first_person_is_h)
		end

	test_exists_empty_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists with an empty trie for reference types")
			create t.make
			Result := not t.exists (agent first_person_is_h)
		end

	test_exists1_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists1 with expected true result for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			t.insert(string_to_persons("cheers"))
			Result := t.exists1 (agent first_person_is_h)
			t.insert(string_to_persons("yo"))
			t.insert(string_to_persons("bye"))
			Result := Result and t.exists1 (agent first_person_is_h)
		end

	test_exists1_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists1 with expected false result for reference types")
			create t.make
			t.insert(string_to_persons("yo"))
			t.insert(string_to_persons("cheers"))
			Result := not t.exists1 (agent first_person_is_h)
			t.insert(string_to_persons("hi"))
			t.insert(string_to_persons("hello"))
			Result := Result and not t.exists1 (agent first_person_is_h)
		end

	test_exists1_one_true_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists1 with expected true result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("hi"))
			Result := t.exists1 (agent first_person_is_h)
		end

	test_exists1_one_false_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists1 with expected false result and only one sequence for reference types")
			create t.make
			t.insert(string_to_persons("cheers"))
			Result := not t.exists1 (agent first_person_is_h)
		end

	test_exists1_empty_ref: BOOLEAN
		local
			t: TRIE[PERSON]
		do
			comment("Test exists1 with an empty trie for reference types")
			create t.make
			Result := not t.exists1 (agent first_person_is_h)
		end

	test_insert_same_1_ref: BOOLEAN
		local
			t: TRIE[PERSON]
			l1, l2: LINKED_LIST[PERSON]
		do
			comment("Test that inserting a sequence with similar objects twice is OK for reference types")
			create t.make
			l1 := string_to_persons("hi")
			l2 := string_to_persons("hi")
			t.insert(l1)
			t.insert(l2)
			Result := t.count = 2 and
					  not t.is_empty and
					  t.height = 3 and
					  t.contains(l1) and
					  t.contains(l2)
		end

	test_insert_same_2_ref
		local
			t: TRIE[PERSON]
			l: LINKED_LIST[PERSON]
		do
			comment("Test that inserting the same sequence twice causes a violation for reference types")
			create t.make
			l := string_to_persons("hi")
			t.insert(l)
			t.insert(l)
		end

feature -- Gunnar tests

all_make_tests
  -- Collection of all make tests
  do
	add_boolean_case (agent empty_trie_is_empty)
	add_boolean_case (agent empty_trie_count)
	add_boolean_case (agent empty_trie_height)
  end

empty_trie_is_empty: BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Empty trie is empty")
	create t.make
	Result := t.is_empty
  end

empty_trie_count: BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Empty trie count is 0")
	create t.make
	Result := t.count = 0
  end

empty_trie_height: BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Empty trie height is 1")
	create t.make
	Result := t.height = 1
  end

--=============================================================
feature -- Insert

all_insert_tests
  -- Collect all insert cases together
  do
  	add_boolean_case (agent insert_null)
  	add_boolean_case (agent insert_1_ln_1)
  	add_boolean_case (agent insert_1_ln_1_null)
  	add_boolean_case (agent insert_3_ln_1)
  	add_boolean_case (agent insert_1_ln_q)
  	add_boolean_case (agent insert_3_ln_q_diff)
  	add_boolean_case (agent insert_3_ln_q_sub_1st)
  	add_boolean_case (agent insert_3_ln_q_ext_1st)
  	add_boolean_case (agent insert_3_ln_q_split_1st)
  end

insert_null : BOOLEAN
  -- Insert just the null sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Insert null sequence")
  	create t.make
  	t.insert(stringToLL(""))
    Result := t.terminal and t.ll.count = 0
  end

insert_1_ln_1 : BOOLEAN
  -- Insert one length 1 sequence
  local t  : TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
  do
  	comment("Insert 1 length 1 sequence")
  	create t.make
  	t.insert(stringToLL("a"))
  	t1 := t.ll.first
    Result :=     not t.terminal and t.ll.count = 1
              and check_trie_node(t1,'a',True,0)
  end

insert_1_ln_1_null : BOOLEAN
  -- Insert null sequence after inserting 1 length 1 sequence
  local t :  TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
  do
  	comment("Insert null after inserting 1 length 1 sequence")
  	create t.make
  	t.insert(stringToLL("a"))
  	t.insert(stringToLL(""))
  	t1 := t.ll.first
    Result :=     t.terminal and t.ll.count = 1
              and check_trie_node(t1,'a',True,0)
  end

insert_3_ln_1 : BOOLEAN
  -- Insert 3 length 1 sequences
  local t :  TRIE[CHARACTER]
        l  : LINKED_LIST[TRIE[CHARACTER]]
  do
  	comment("Insert 3 length 1 sequences")
  	create t.make
  	t.insert(stringToLL("a"))
  	t.insert(stringToLL("b"))
  	t.insert(stringToLL("c"))
  	  Result := not t.terminal and t.ll.count = 3
  	l := t.ll  l.start
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'a',True,0)
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'b',True,0)
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'c',True,0)
  end

insert_1_ln_q : BOOLEAN
  -- Insert 1 length many sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Insert 1 length many sequence")
  	create t.make
  	t.insert(stringToLL("abc"))
  	  Result := not t.terminal and t.ll.count = 1
  	t := t.ll.first
  	  Result := Result and check_trie_node(t,'a',False,1)
  	t := t.ll.first
  	  Result := Result and check_trie_node(t,'b',False,1)
  	t := t.ll.first
  	  Result := Result and check_trie_node(t,'c',True,0)
  end

insert_3_ln_q_diff : BOOLEAN
  -- Insert 3 length many sequences with no overlap first string
  local t  : TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
        l  : LINKED_LIST[TRIE[CHARACTER]]
  do
  	comment ("Insert 3 different length many strings")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("ghi"))
  	  Result := not t.terminal and t.ll.count = 3
  	l := t.ll  l.start
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'a',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'b',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'c',True,0)

  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'d',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'e',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'f',True,0)

  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'g',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'h',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'i',True,0)
  end

insert_3_ln_q_sub_1st : BOOLEAN
  -- Insert 3 length many sequences first two no overlap
  -- third string is substring of first string
  local t  : TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
        l  : LINKED_LIST[TRIE[CHARACTER]]
  do
  	comment("Insert 3 length many, 2 no overlap, 1 subseq of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("ab"))
  	  Result := not t.terminal and t.ll.count = 2
  	l := t.ll  l.start
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'a',False,1)
  	  check a_after: Result end
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'b',True,1)
  	  check b_after: Result end
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'c',True,0)
  	  check c_after: Result end

  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'d',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'e',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'f',True,0)
  end

insert_3_ln_q_ext_1st : BOOLEAN
  -- Insert 3 length many sequences first no overlap
  -- third string is an extention of first string
  local t  : TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
        l  : LINKED_LIST[TRIE[CHARACTER]]
  do
  	comment("Insert 3 length many, 2 no overlap, 1 extension of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abcd"))
  	  Result := not t.terminal and t.ll.count = 2
  	l := t.ll  l.start
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'a',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'b',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'c',True,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'d',True,0)

  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'d',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'e',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'f',True,0)
  end

insert_3_ln_q_split_1st : BOOLEAN
  -- Insert 3 length many sequences first no overlap
  -- third string splits off at second char of first string
  local t  : TRIE[CHARACTER]
        t1 : TRIE[CHARACTER]
        l  : LINKED_LIST[TRIE[CHARACTER]]
        l1 : LINKED_LIST[TRIE[CHARACTER]]
  do
  	comment("Insert 3 length many, 2 no overlap, 1 split of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abd"))
  	  Result := not t.terminal and t.ll.count = 2
  	l := t.ll  l.start
  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'a',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'b',False,2)
    l1 := t1.ll  l1.start
  	t1 := l1.item  l1.forth
  	  Result := Result and check_trie_node(t1,'c',True,0)
  	t1 := l1.item
  	  Result := Result and check_trie_node(t1,'d',True,0)

  	t := l.item  l.forth
  	  Result := Result and check_trie_node(t,'d',False,1)
  	t1 := t.ll.first
  	  Result := Result and check_trie_node(t1,'e',False,1)
  	t1 := t1.ll.first
  	  Result := Result and check_trie_node(t1,'f',True,0)
  end

--=============================================================
feature -- Contains

-- Tests for contains and precondition are similar so we use the same
-- cases.

all_contains_tests
  -- Collect all contains cases
  do
  	add_boolean_case (agent contains_null_1_1n_0_seq)
  	add_boolean_case (agent contains_null_1_ln_1_seq)
  	add_boolean_case (agent contains_null_p_ln_1_seq)
  	add_boolean_case (agent contains_null_1_ln_q_seq)
  	add_boolean_case (agent contains_null_p_ln_q__seq)

  	add_boolean_case (agent contains_ln_1_1_ln_1_seq)
  	add_boolean_case (agent contains_ln_1_1st_of_n_ln_1_seq)
  	add_boolean_case (agent contains_ln_1_mid_of_n_ln_1_seq)
  	add_boolean_case (agent contains_ln_1_last_of_n_ln_1_seq)
  	add_boolean_case (agent contains_ln_1_in_1_ln_q_seq)
  	add_boolean_case (agent contains_ln_1_in_1st_of_p_ln_q_seq)
  	add_boolean_case (agent contains_ln_1_in_mid_of_p_ln_q_seq)
  	add_boolean_case (agent contains_ln_1_in_last_of_p_ln_q_seq)

  	add_boolean_case (agent contains_ln_q_in_1_ln_q_seq_same)
  	add_boolean_case (agent contains_ln_q_in_1_ln_q_seq_longer)
  	add_boolean_case (agent contains_ln_q_in_mid_of_p_ln_q_seq_same)
  	add_boolean_case (agent contains_ln_q_in_mid_of_p_ln_q_seq_longer)
  	add_boolean_case (agent contains_ln_q_in_last_of_p_ln_q_seq_same)
  	add_boolean_case (agent contains_ln_q_in_last_of_p_ln_q_seq_longer)
  end

contains_null_1_1n_0_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains null with only null sequence")
	create t.make
	t.insert(stringToLL(""))
	Result := t.contains(stringToLL(""))
  end

contains_null_1_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains null with 1 length 1 sequence")
	create t.make
	t.insert(stringToLL("a"))
	t.insert(stringToLL(""))
	Result := t.contains(stringToLL(""))
  end

contains_null_p_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains null with many length 1 sequences")
	t :=  create_many_ln_1_seq_char
	t.insert(stringToLL(""))
	Result := t.contains(stringToLL(""))
  end

contains_null_1_ln_q_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains null with one length many sequence")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL(""))
	Result := t.contains(stringToLL(""))
  end

contains_null_p_ln_q__seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains null with many length many sequence")
	t :=  create_many_ln_q_seq_char
	t.insert(stringToLL(""))
	Result := t.contains(stringToLL(""))
  end

contains_ln_1_1_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence with one length 1 sequences")
	create t.make
	t.insert(stringToLL("a"))
	Result := t.contains(stringToLL("a"))
  end

contains_ln_1_1st_of_n_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 as first of many length 1 sequences")
	t := create_many_ln_1_seq_char
	Result := t.contains(stringToLL("a"))
  end

contains_ln_1_mid_of_n_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence as middle of many length 1 sequences")
	t := create_many_ln_1_seq_char
	Result := t.contains(stringToLL("c"))
  end

contains_ln_1_last_of_n_ln_1_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence as last of many length 1 sequences")
	t := create_many_ln_1_seq_char
	Result := t.contains(stringToLL("e"))
  end

contains_ln_1_in_1_ln_q_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence with 1 length many sequence")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL("a"))
	Result := t.contains(stringToLL("a"))
  end

contains_ln_1_in_1st_of_p_ln_q_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence in first of many length many sequences")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("a"))
  end

contains_ln_1_in_mid_of_p_ln_q_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence in middle of many length many sequences")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("c"))
  end

contains_ln_1_in_last_of_p_ln_q_seq : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains length 1 sequence in last of many length many sequences")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("e"))
  end

contains_ln_q_in_1_ln_q_seq_same : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq with 1 length many seq same length")
	create t.make
	t.insert(stringToLL("abcde"))
	Result := t.contains(stringToLL("abcde"))
  end

contains_ln_q_in_1_ln_q_seq_longer : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq with 1 length many seq longer")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL("abc"))
	Result := t.contains(stringToLL("abc"))
  end

contains_ln_q_in_first_ln_q_seq_same : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in first of many length many seq same length")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("abcde"))
  end

contains_ln_q_in_first_ln_q_seq_longer : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in first of many length many seq longer")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("abc"))
  end

contains_ln_q_in_mid_of_p_ln_q_seq_same : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in middle of many length many seq same length")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("cdefgh"))
  end

contains_ln_q_in_mid_of_p_ln_q_seq_longer : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in middle of many length many seq longer")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("cde"))
  end

contains_ln_q_in_last_of_p_ln_q_seq_same : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in last of many length many seq same length")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("efghijk"))
  end

contains_ln_q_in_last_of_p_ln_q_seq_longer : BOOLEAN
  local t: TRIE[CHARACTER]
  do
	comment("Contains ln many seq in last of many length many seq longer")
	t := create_many_ln_q_seq_char
	Result := t.contains(stringToLL("efgh"))
  end


--=============================================================
feature -- Count

all_count_tests
  -- Collect all count cases together
  do
  	add_boolean_case (agent count_empty)
  	add_boolean_case (agent count_null)
  	add_boolean_case (agent count_1_ln_1)
  	add_boolean_case (agent count_1_ln_1_null)
  	add_boolean_case (agent count_3_ln_1)
  	add_boolean_case (agent count_1_ln_q)
  	add_boolean_case (agent count_3_ln_q_diff)
  	add_boolean_case (agent count_3_ln_q_sub_1st)
  	add_boolean_case (agent count_3_ln_q_ext_1st)
  	add_boolean_case (agent count_3_ln_q_split_1st)
  	add_boolean_case (agent count_create_many_ln_1)
  	add_boolean_case (agent count_create_many_ln_q)
  end

count_empty : BOOLEAN
  -- Count for an empty tree
  local t : TRIE[CHARACTER]
  do
    comment ("Count for an empty tree")
    create t.make
    Result := t.count = 0
  end

count_null : BOOLEAN
  -- Count just the null sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Count null sequence")
  	create t.make
  	t.insert(stringToLL(""))
    Result := t.count = 1
  end

count_1_ln_1 : BOOLEAN
  -- Count one length 1 sequence
  local t  : TRIE[CHARACTER]
  do
  	comment("Count 1 length 1 sequence")
  	create t.make
  	t.insert(stringToLL("a"))
    Result := t.count = 1
  end

count_1_ln_1_null : BOOLEAN
  -- Count null sequence after inserting 1 length 1 sequence
  local t :  TRIE[CHARACTER]
  do
  	comment("Count null after inserting 1 length 1 sequence")
  	create t.make
  	t.insert(stringToLL("a"))
  	t.insert(stringToLL(""))
    Result := t.count = 2
  end

count_3_ln_1 : BOOLEAN
  -- Count 3 length 1 sequences
  local t :  TRIE[CHARACTER]
  do
  	comment("Count 3 length 1 sequences")
  	create t.make
  	t.insert(stringToLL("a"))
  	t.insert(stringToLL("b"))
  	t.insert(stringToLL("c"))
    Result := t.count = 3
  end

count_1_ln_q : BOOLEAN
  -- Count 1 length many sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Count 1 length many sequence")
  	create t.make
  	t.insert(stringToLL("abc"))
  	Result := t.count = 1
  end

count_3_ln_q_diff : BOOLEAN
  -- Count 3 length many sequences with no overlap first string
  local t  : TRIE[CHARACTER]
  do
  	comment ("Count 3 different length many strings")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("ghi"))
  	Result := t.count = 3
  end

count_3_ln_q_sub_1st : BOOLEAN
  -- Count 3 length many sequences first two no overlap
  -- third string is substring of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Count 3 length many, 2 no overlap, 1 subseq of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("ab"))
  	Result := t.count = 3
  end

count_3_ln_q_ext_1st : BOOLEAN
  -- Count 3 length many sequences first no overlap
  -- third string is an extention of first string
  local t : TRIE[CHARACTER]
  do
  	comment("Count 3 length many, 2 no overlap, 1 extension of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abcd"))
  	Result := t.count = 3
  end

count_3_ln_q_split_1st : BOOLEAN
  -- Count 3 length many sequences first no overlap
  -- third string splits off at second char of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Count 3 length many, 2 no overlap, 1 split of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abd"))
  	Result := t.count = 3
  end

count_create_many_ln_1 : BOOLEAN
  -- Count many length 1 sequences
  local t  : TRIE[CHARACTER]
  do
  	comment("Count for create many length 1 function")
  	t := create_many_ln_1_seq_char
  	Result := t.count = 5
  end

count_create_many_ln_q : BOOLEAN
  -- Count 3 length many sequences first no overlap
  -- third string splits off at second char of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Count for create many length q function")
    t := create_many_ln_q_seq_char
  	Result := t.count = 11
  end

--=============================================================
feature -- Height

all_height_tests
  -- Collect all height cases together
  do
  	add_boolean_case (agent height_empty)
  	add_boolean_case (agent height_null)
  	add_boolean_case (agent height_1_ln_1)
  	add_boolean_case (agent height_create_many_ln_1)
  	add_boolean_case (agent height_1_ln_q)
  	add_boolean_case (agent height_3_ln_q_first_long)
  	add_boolean_case (agent height_3_ln_q_mid_long)
  	add_boolean_case (agent height_3_ln_q_1ast_long)
  	add_boolean_case (agent height_3_ln_q_sub_1st)
  	add_boolean_case (agent height_3_ln_q_ext_1st)
  	add_boolean_case (agent height_3_ln_q_split_1st)
  	add_boolean_case (agent height_create_many_ln_q)
  end

height_empty : BOOLEAN
  -- Height for an empty tree
  local t : TRIE[CHARACTER]
  do
    comment ("Height for an empty tree")
    create t.make
    Result := t.height = 1
  end

height_null : BOOLEAN
  -- Height just the null sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Height null sequence")
  	create t.make
  	t.insert(stringToLL(""))
    Result := t.height = 1
  end

height_1_ln_1 : BOOLEAN
  -- Height one length 1 sequence
  local t  : TRIE[CHARACTER]
  do
  	comment("Height 1 length 1 sequence")
  	create t.make
  	t.insert(stringToLL("a"))
    Result := t.height = 2
  end

height_create_many_ln_1 : BOOLEAN
  -- Height many length 1 sequences
  local t  : TRIE[CHARACTER]
  do
  	comment("Height for create many length 1 function")
  	t := create_many_ln_1_seq_char
  	Result := t.height = 2
  end

height_1_ln_q : BOOLEAN
  -- Height 1 length many sequence
  local t : TRIE[CHARACTER]
  do
  	comment("Height 1 length many sequence")
  	create t.make
  	t.insert(stringToLL("abc"))
  	Result := t.height = 4
  end

height_3_ln_q_first_long : BOOLEAN
  -- Height 3 length many sequences with no overlap first string
  local t  : TRIE[CHARACTER]
  do
  	comment ("Height 3 different length many strings")
  	create t.make
  	t.insert(stringToLL("abcdef"))
  	t.insert(stringToLL("defg"))
  	t.insert(stringToLL("ghi"))
  	Result := t.height = 7
  end

height_3_ln_q_mid_long : BOOLEAN
  -- Height 3 length many sequences with no overlap first string
  local t  : TRIE[CHARACTER]
  do
  	comment ("Height 3 different length many strings")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("defg"))
  	t.insert(stringToLL("ghi"))
  	Result := t.height = 5
  end

height_3_ln_q_1ast_long : BOOLEAN
  -- Height 3 length many sequences with no overlap first string
  local t  : TRIE[CHARACTER]
  do
  	comment ("Height 3 different length many strings")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("defg"))
  	t.insert(stringToLL("ghijkl"))
  	Result := t.height = 7
  end

height_3_ln_q_sub_1st : BOOLEAN
  -- Height 3 length many sequences first two no overlap
  -- third string is substring of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Height 3 length many, 2 no overlap, 1 subseq of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("ab"))
  	Result := t.height = 4
  end

height_3_ln_q_ext_1st : BOOLEAN
  -- Height 3 length many sequences first no overlap
  -- third string is an extention of first string
  local t : TRIE[CHARACTER]
  do
  	comment("Height 3 length many, 2 no overlap, 1 extension of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abcd"))
  	Result := t.height = 5
  end

height_3_ln_q_split_1st : BOOLEAN
  -- Height 3 length many sequences first no overlap
  -- third string splits off at second char of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Height 3 length many, 2 no overlap, 1 split of 1st")
  	create t.make
  	t.insert(stringToLL("abc"))
  	t.insert(stringToLL("def"))
  	t.insert(stringToLL("abd"))
  	Result := t.height = 4
  end

height_create_many_ln_q : BOOLEAN
  -- Height 3 length many sequences first no overlap
  -- third string splits off at second char of first string
  local t  : TRIE[CHARACTER]
  do
  	comment("Height for create many length q function")
    t := create_many_ln_q_seq_char
  	Result := t.height = 8
  end

--=============================================================
feature -- Precondition tests

-- It may appear that only one test is required for insert precondition
-- since it is "not contains", so if contains is tested first, then any
-- test that detects duplicates would be valid.  A problem occurs if
-- someone changes the requires clause.

-- Tests for contains and precondition are similar so we use the same
-- cases.

all_precondition_tests
  -- Collect all precondition cases together
  -- Simiplifies commenting out during development
  do
  	add_violation_case (agent insert_dup_null_1_1n_0_seq)
  	add_violation_case (agent insert_dup_null_1_ln_1_seq)
  	add_violation_case (agent insert_dup_null_p_ln_1_seq)
  	add_violation_case (agent insert_dup_null_1_ln_q_seq)
  	add_violation_case (agent insert_dup_null_p_ln_q__seq)

  	add_violation_case (agent insert_dup_ln_1_1_ln_1_seq)
  	add_violation_case (agent insert_dup_ln_1_1st_of_n_ln_1_seq)
  	add_violation_case (agent insert_dup_ln_1_mid_of_n_ln_1_seq)
  	add_violation_case (agent insert_dup_ln_1_last_of_n_ln_1_seq)
  	add_violation_case (agent insert_dup_ln_1_in_1_ln_q_seq)
  	add_violation_case (agent insert_dup_ln_1_in_1st_of_p_ln_q_seq)
  	add_violation_case (agent insert_dup_ln_1_in_mid_of_p_ln_q_seq)
  	add_violation_case (agent insert_dup_ln_1_in_last_of_p_ln_q_seq)

  	add_violation_case (agent insert_dup_ln_q_in_1_ln_q_seq_same)
  	add_violation_case (agent insert_dup_ln_q_in_1_ln_q_seq_longer)
  	add_violation_case (agent insert_dup_ln_q_in_mid_of_p_ln_q_seq_same)
  	add_violation_case (agent insert_dup_ln_q_in_mid_of_p_ln_q_seq_longer)
  	add_violation_case (agent insert_dup_ln_q_in_last_of_p_ln_q_seq_same)
  	add_violation_case (agent insert_dup_ln_q_in_last_of_p_ln_q_seq_longer)
  end

insert_dup_null_1_1n_0_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate null with only null sequence")
	create t.make
	t.insert(stringToLL(""))
	t.insert(stringToLL(""))
  end

insert_dup_null_1_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate null with 1 length 1 sequence")
	create t.make
	t.insert(stringToLL("a"))
	t.insert(stringToLL(""))
	t.insert(stringToLL(""))
  end

insert_dup_null_p_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate null with many length 1 sequences")
	t :=  create_many_ln_1_seq_char
	t.insert(stringToLL(""))
	t.insert(stringToLL(""))
  end

insert_dup_null_1_ln_q_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate null with one length many sequence")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL(""))
	t.insert(stringToLL(""))
  end

insert_dup_null_p_ln_q__seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate null with many length many sequence")
	t :=  create_many_ln_q_seq_char
	t.insert(stringToLL(""))
	t.insert(stringToLL(""))
  end

insert_dup_ln_1_1_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence with one length 1 sequences")
	create t.make
	t.insert(stringToLL("a"))
	t.insert(stringToLL("a"))
  end

insert_dup_ln_1_1st_of_n_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 as first of many length 1 sequences")
	t := create_many_ln_1_seq_char
	t.insert(stringToLL("a"))
  end

insert_dup_ln_1_mid_of_n_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence as middle of many length 1 sequences")
	t := create_many_ln_1_seq_char
	t.insert(stringToLL("c"))
  end

insert_dup_ln_1_last_of_n_ln_1_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence as last of many length 1 sequences")
	t := create_many_ln_1_seq_char
	t.insert(stringToLL("e"))
  end

insert_dup_ln_1_in_1_ln_q_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence with 1 length many sequence")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL("a"))
	t.insert(stringToLL("a"))
  end

insert_dup_ln_1_in_1st_of_p_ln_q_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence in first of many length many sequences")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("a"))
  end

insert_dup_ln_1_in_mid_of_p_ln_q_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence in middle of many length many sequences")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("c"))
  end

insert_dup_ln_1_in_last_of_p_ln_q_seq
  local t: TRIE[CHARACTER]
  do
	comment("Duplicate length 1 sequence in last of many length many sequences")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("e"))
  end

insert_dup_ln_q_in_1_ln_q_seq_same
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq with 1 length many seq same length")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL("abcde"))
  end

insert_dup_ln_q_in_1_ln_q_seq_longer
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq with 1 length many seq longer")
	create t.make
	t.insert(stringToLL("abcde"))
	t.insert(stringToLL("abc"))
	t.insert(stringToLL("abc"))
  end

insert_dup_ln_q_in_first_ln_q_seq_same
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in first of many length many seq same length")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("abcde"))
  end

insert_dup_ln_q_in_first_ln_q_seq_longer
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in first of many length many seq longer")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("abc"))
  end

insert_dup_ln_q_in_mid_of_p_ln_q_seq_same
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in middle of many length many seq same length")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("cdefgh"))
  end

insert_dup_ln_q_in_mid_of_p_ln_q_seq_longer
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in middle of many length many seq longer")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("cde"))
  end

insert_dup_ln_q_in_last_of_p_ln_q_seq_same
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in last of many length many seq same length")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("efghijk"))
  end

insert_dup_ln_q_in_last_of_p_ln_q_seq_longer
  local t: TRIE[CHARACTER]
  do
	comment("Dup length many seq in last of many length many seq longer")
	t := create_many_ln_q_seq_char
	t.insert(stringToLL("efgh"))
  end

--=============================================================
feature -- Support

stringtoLL (s: STRING): LINKED_LIST[CHARACTER]
  -- Transform a string into a linked list of characters
  local i: INTEGER
  do
    create Result.make
	from i := 1
	invariant
	  Result.count = i - 1
	  Result.count <= s.count

	until i > s.count
	loop
	  Result.extend(s.item(i))
	  i := i + 1
	  variant  s.count - i + 1
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
		create p.make(s.substring(i,i),66)
	  Result.extend(p)
	  i := i + 1
	  variant  s.count - i + 1
    end
end

	startsWithH(seq:LINKED_LIST[CHARACTER]):BOOLEAN
		do
			if not seq.is_empty then
				Result := seq.first = 'h'
			end
		end

	first_person_is_h(seq:LINKED_LIST[PERSON]):BOOLEAN
		do
			if not seq.is_empty then
				Result := seq.first.name.is_equal("h")
			end
		end

create_many_ln_1_seq_char : TRIE[CHARACTER]
  -- Create TRIE with many length 1 sequences
  do
  	create Result.make
  	Result.insert(stringtoLL("a"))
  	Result.insert(stringtoLL("b"))
  	Result.insert(stringtoLL("c"))
  	Result.insert(stringtoLL("d"))
  	Result.insert(stringtoLL("e"))
  end

create_many_ln_q_seq_char : TRIE[CHARACTER]
  -- Create TRIE with many length 1 sequences
  do
  	create Result.make
  	Result.insert(stringtoLL("abcde"))
  	Result.insert(stringtoLL("bcde"))
  	Result.insert(stringtoLL("cdefgh"))
  	Result.insert(stringtoLL("defghi"))
  	Result.insert(stringtoLL("efghijk"))
  	Result.insert(stringtoLL("a")) -- for length 1 tests
  	Result.insert(stringtoLL("c")) -- for length 1 tests
  	Result.insert(stringtoLL("e")) -- for length 1 tests
  	Result.insert(stringtoLL("abc")) -- for length q tests
  	Result.insert(stringtoLL("cde")) -- for length q tests
  	Result.insert(stringtoLL("efgh")) -- for length q tests
  end

check_trie_node( t : TRIE[CHARACTER] ;
                 c : CHARACTER ; ter : BOOLEAN ; subtries : INTEGER) : BOOLEAN
  -- Check the contents of a trie node
  do
    Result := t.terminal = ter and t.element = c and t.ll.count = subtries
  end

end -- class ROOT_CLASS
