class
	TEST_STRING_8

inherit
	STRING_SET

feature -- Tests

	test_adapt
		local
			s, t: STRING_8
		do
			t := "1234567890"
			s := t.adapt (t)
			check_equality ("adapt", s, t)
			check_equality ("adapt", s.area, t.area)
		end

	test_adapt_size
		local
			s: STRING_8
		do
			create s.make (1000)
			s.append ("12345")
			s.adapt_size
			check_equality ("adapt_size", s.count, 5)
		end

	test_additional_space
		local
			s: STRING_8
			i: INTEGER
		do
			create s.make (100)
			i := s.additional_space
			check_boolean ("additional_space", i >= 1)
		end

	test_append
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			check_equality ("append", s, "12345")

			s.append (s)
			check_equality ("append", s, "1234512345")

			s.append ("")
			check_equality ("append", s, "1234512345")
		end

	test_append_boolean
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_boolean (True)
			check_equality ("append_boolean", s, "True")

			s.wipe_out
			s.append_boolean (False)
			check_equality ("append_boolean", s, "False")
		end

	test_append_character, test_extend
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_character ('c')
			check_equality ("append_character", s, "c")
		end

	test_append_double
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_double (5.6)
			check_equality ("append_double", s, "5.5999999999999996")
			check_equality ("append_double", s.to_double, 5.6)
		end

	test_append_integer
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_integer (123)
			check_equality ("append_integer", s, "123")
			check_equality ("append_integer", s.to_integer, 123)

			s.wipe_out
			s.append_integer (0x80000000)
			check_equality ("append_integer", s, "-2147483648")
		end

	test_append_real
		local
			s: STRING_8
			r: REAL_32
		do
			r := {REAL_32} 5.6
			create s.make (10)
			s.append_real (r)
			check_equality ("append_real", s, "5.6")
			check_equality ("append_real", s.to_real, r)
		end

	test_append_string
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_string ("12345")
			check_equality ("append_string", s, "12345")

			s.append_string (s)
			check_equality ("append_string", s, "1234512345")

			s.append_string ("")
			check_equality ("append_string", s, "1234512345")

			s.append_string (Void)
			check_equality ("append_string", s, "1234512345")
		end

	test_as_lower
		local
			s, t: STRING_8
		do
			create s.make_from_string ("ABcd EF gh I 123 ;ü")
			t := s.as_lower
			check_equality ("as_lower", t, "abcd ef gh i 123 ;�")
			check_boolean ("as_lower", t /= s)

			s.to_lower
			check_equality ("as_lower", t, s)
		end

	test_as_upper
		local
			s, t: STRING_8
		do
			create s.make_from_string ("ABcd EF gh I 123 ;ü")
			t := s.as_upper
			check_equality ("as_upper", t, "ABCD EF GH I 123 ;ü")
			check_boolean ("as_upper", t /= s)

			s.to_upper
			check_equality ("as_upper", t, s)
		end

	test_automatic_grow
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("123")
			s.automatic_grow
			check_equality ("automatic_grow", s, "123")
			check_boolean ("automatic_grow", s.capacity >= 10)
		end

	test_center_justify
		local
			s: STRING_8
		do
			create s.make (20)
			s.append ("     1234567890  ")
			s.center_justify
			check_equality ("center_justify", s, "    1234567890   ")

			s.wipe_out
			s.append ("  1234567890     ")
			s.center_justify
			check_equality ("center_justify", s, "    1234567890   ")

			s.wipe_out
			s.append ("     1234567890  ")
			s.append ("  1234567890     ")
			s.center_justify
			check_equality ("center_justify", s, "     1234567890    1234567890     ")

			s.wipe_out
			s.append ("123456")
			s.center_justify
			check_equality ("center_justify", s, "123456")
		end

	test_character_justify
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("1234567890x1234567890")
			s.character_justify ('x', 3)
			check_equality ("character_justify", s, "90x1234567890        ")

			create s.make (10)
			s.append ("1234567890x1234567890")
			s.character_justify ('x', 20)
			check_equality ("character_justify", s, "         1234567890x1234567890")

			s := "1234567890x1234567890"
			s.character_justify ('s', 1)
			check_equality ("character_justify", s, "1234567890x1234567890")
		end

	test_copy
		local
			s, t: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			s.copy (s)
			check_equality ("copy",	s, "12345")

			s.copy ("1234567890")
			check_equality ("copy",	s, "1234567890")

			create s.make (0)
			t := "12345"
			s.copy (t)
			check_equality ("copy", s, t)
			check_boolean ("copy", not s.shared_with (t))
		end

	test_ends_with
		local
			s: STRING_8
		do
			s := "1234567890"
			check_boolean ("Ends with empty%N", s.ends_with (""))
			check_boolean ("Ends with itself%N", s.ends_with (s))
			check_boolean ("Ends with its twin%N", s.ends_with (s.twin))
			check_boolean ("Not ends with itself twice%N", not s.ends_with (s + s))
			check_boolean ("Not ends with 123%N", not s.ends_with ("123"))
			check_boolean ("Not ends with 23%N", not s.ends_with ("23"))
			check_boolean ("Ends with 890%N", s.ends_with ("890"))
			check_boolean ("Not ends with 89%N", not s.ends_with ("89"))
		end

	test_fill_blank
		local
			s: STRING_8
		do
			create s.make (10)
			s.fill_blank
			check_equality ("fill_blank", s, "          ")

			s.wipe_out
			s.append ("12345")
			s.fill_blank
			check_equality ("fill_blank", s, "          ")
		end

	test_fill_character
		local
			s: STRING_8
		do
			create s.make (10)
			s.fill_character ('1')
			check_equality ("fill_character", s, "1111111111")

			s.wipe_out
			s.append ("12345")
			s.fill_character ('1')
			check_equality ("fill_character", s, "1111111111")
		end

	test_fill_with
		local
			s: STRING_8
		do
			create s.make (10)
			s.fill_with ('1')
			check_equality ("fill_with", s, "")

			s.wipe_out
			s.append ("12345")
			s.fill_with ('1')
			check_equality ("fill_with", s, "11111")
		end

	test_from_c
		local
			l_ptr: MANAGED_POINTER
			s: STRING_8
		do
			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.from_c (l_ptr.item)
			check_boolean ("from_c", s.is_equal ("0123456"))

			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.from_c (l_ptr.item)
			check_boolean ("from_c", s.is_empty)
		end

	test_from_c_substring
		local
			l_ptr: MANAGED_POINTER
			s: STRING_8
		do
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} <<65,66,67,68>>)
			create s.make (2)

			s.from_c_substring (l_ptr.item, 3, 3)
			check_boolean ("from_c_substring", s.is_equal ("C"))

			s.from_c_substring (l_ptr.item, 2, 3)
			check_boolean ("from_c_substring", s.is_equal ("BC"))

			s.from_c_substring (l_ptr.item, 1, 3)
			check_boolean ("from_c_substring", s.is_equal ("ABC"))

			s.from_c_substring (l_ptr.item, 1, 4)
			check_boolean ("from_c_substring", s.is_equal ("ABCD"))
		end

	test_fuzzy_index
		local
			s: STRING_8
			i: INTEGER
		do
			s := "Eiffel Software Enterprise Edition"
			i := s.fuzzy_index ("Soltware", 1, 1)
			check_equality ("fuzzy_index", i, 8)

			i := s.fuzzy_index ("Sotware", 1, 1)
			check_equality ("fuzzy_index", i, 0)

			i := s.fuzzy_index ("Edataon", 10, 2)
			check_equality ("fuzzy_index", i, 28)

			i := s.fuzzy_index ("Edataon", 29, 2)
			check_equality ("fuzzy_index", i, 0)

			i := s.fuzzy_index ("Enterprise", 1, 0)
			check_equality ("fuzzy_index", i, 17)

			i := s.fuzzy_index ("Entreprise", 1, 0)
			check_equality ("fuzzy_index", i, 0)

			i := s.fuzzy_index ("Enterprise", 1, 0)
			check_equality ("fuzzy_index", i, 17)
		end

	test_grow
		local
			s: STRING_8
		do
			s := ""
			s.grow (0)
			check_equality ("grow", s, "")
			s.grow (5)
			check_equality ("grow", s, "")
			s := "12345"
			s.grow (0)
			check_equality ("grow", s, "12345")
			s.grow (5)
			check_equality ("grow", s, "12345")
			s.grow (10)
			check_equality ("grow", s, "12345")
		end

	test_has
		local
			s: STRING_8
		do
			create s.make (10)
			check_boolean ("has", not s.has ('c'))
			check_boolean ("has", not s.has ('%U'))

			s.append ("1234c1234")
			check_boolean ("has", s.has ('c'))
			check_boolean ("has", not s.has ('9'))

			s.wipe_out
			check_boolean ("has", not s.has ('c'))
			check_boolean ("has", not s.has ('9'))
		end

	test_has_substring
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("!23")
			check_boolean ("has_substring", s.has_substring (s))
			check_boolean ("has_substring", s.has_substring ("23"))
			check_boolean ("has_substring", not s.has_substring ("12"))
			check_boolean ("has_substring", not s.has_substring ("!23 "))
			check_boolean ("has_substring", s.has_substring ("!23"))

			check_boolean ("has_substring", ("").has_substring (""))
			check_boolean ("has_substring", ("foobar").has_substring ("oo"))
			check_boolean ("has_substring", not ("foobar").has_substring ("abo"))
		end

	test_index_of
		local
			s: STRING_8
			i: INTEGER
		do
			create s.make (10)
			s.append ("1234567890")
			i := s.index_of ('0', 1)
			check_equality ("index_of", i, 10)

			i := s.index_of ('x', 1)
			check_equality ("index_of", i , 0)

			i := s.index_of ('5', 4)
			check_equality ("index_of", i , 5)

			i := s.index_of ('5', 5)
			check_equality ("index_of", i , 5)

			i := s.index_of ('5', 6)
			check_equality ("index_of", i , 0)
		end

	test_insert_character
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			s.insert_character ('c', 1)
			check_equality ("insert_character", s, "c12345")

			s.wipe_out
			s.append ("12345")
			s.insert_character ('c', 2)
			check_equality ("insert_character", s, "1c2345")

			s.wipe_out
			s.append ("12345")
			s.insert_character ('c', 3)
			check_equality ("insert_character", s, "12c345")

			s.wipe_out
			s.append ("12345")
			s.insert_character ('c', 4)
			check_equality ("insert_character", s, "123c45")

			s.wipe_out
			s.append ("12345")
			s.insert_character ('c', 5)
			check_equality ("insert_character", s, "1234c5")

			s.wipe_out
			s.append ("12345")
			s.insert_character ('c', 6)
			check_equality ("insert_character", s, "12345c")
		end

	test_insert_string
		local
			s, t: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			s.insert_string (s, 1)
			check_equality ("insert_string", s, "1234512345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (s, 2)
			check_equality ("insert_string", s, "1123452345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (s, 3)
			check_equality ("insert_string", s, "1212345345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (s, 4)
			check_equality ("insert_string", s, "1231234545")

			s.wipe_out
			s.append ("12345")
			s.insert_string (s, 5)
			check_equality ("insert_string", s, "1234123455")

			s.wipe_out
			s.append ("12345")
			s.insert_string (s, 6)
			check_equality ("insert_string", s, "1234512345")

			create s.make (10)
			t := "12345"
			s.append ("12345")
			s.insert_string (t, 1)
			check_equality ("insert_string", s, "1234512345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (t, 2)
			check_equality ("insert_string", s, "1123452345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (t, 3)
			check_equality ("insert_string", s, "1212345345")

			s.wipe_out
			s.append ("12345")
			s.insert_string (t, 4)
			check_equality ("insert_string", s, "1231234545")

			s.wipe_out
			s.append ("12345")
			s.insert_string (t, 5)
			check_equality ("insert_string", s, "1234123455")

			s.wipe_out
			s.append ("12345")
			s.insert_string (t, 6)
			check_equality ("insert_string", s, "1234512345")

			s := "bar"
			s.insert_string (s, 2)
			check_equality ("insert_string", s, "bbarar")

			s := "abcdef"
			s.insert_string (s, 3)
			check_equality ("insert_string", s, "ababcdefcdef")

			s := "bar"
			s.insert_string ("bar", 2)
			check_equality ("insert_string", s, "bbarar")
		end

	test_is_boolean
		local
			s: STRING_8
		do
			s := "true"
			check_boolean ("is_boolean", s.is_boolean)

			s := "    true   "
			check_boolean ("is_boolean", not s.is_boolean)

			s := "True"
			check_boolean ("is_boolean", s.is_boolean)

			s := "false"
			check_boolean ("is_boolean", s.is_boolean)

			s := "    false   "
			check_boolean ("is_boolean", not s.is_boolean)

			s := "false"
			check_boolean ("is_boolean", s.is_boolean)

			s := "TRUE"
			check_boolean ("is_boolean", s.is_boolean)

			s := "FALSE"
			check_boolean ("is_boolean", s.is_boolean)

			s := "Tru"
			check_boolean ("is_boolean", not s.is_boolean)

			s := "tru"
			check_boolean ("is_boolean", not s.is_boolean)

			s := "Fal"
			check_boolean ("is_boolean", not s.is_boolean)

			s := "fal"
			check_boolean ("is_boolean", not s.is_boolean)
		end

	test_is_case_insensitive_equal
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal (s))
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("12345"))
			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal ("123456"))
			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal ("1234"))

			s := "abcdef"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("ABCDEF"))

			s := "ABCDEF"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("abcdef"))

			s := "ABCdef"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("abcDEF"))

			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal (""))
		end

	test_is_double
		do
			check_boolean ("is_double", ("5").is_double)
			check_boolean ("is_double", ("5.5").is_double)
			check_boolean ("is_double", ("5E4").is_double)
			check_boolean ("is_double", not ("5 E4").is_double)
			check_boolean ("is_double", ("5e-4").is_double)
			check_boolean ("is_double", ("5e5").is_double)
			check_boolean ("is_double", not ("5e 5").is_double)
			check_boolean ("is_double", (".0").is_double)
			check_boolean ("is_double", ("0.1e10").is_double)
			check_boolean ("is_double", ("-1").is_double)
			check_boolean ("is_double", ("-1.0").is_double)
			check_boolean ("is_double", ("-1e1").is_double)
			check_boolean ("is_double", ("-1e-1").is_double)
			check_boolean ("is_double", ("-1.0e1").is_double)
			check_boolean ("is_double", ("-1.0e-1").is_double)
			check_boolean ("is_double", ("-.1").is_double)
			check_boolean ("is_double", ("1e5").is_double)
			check_boolean ("is_double", not ("e5").is_double)
			check_boolean ("is_double", not (".e1").is_double)
			check_boolean ("is_double", ("1e").is_double)
			check_boolean ("is_double", ("1e1").is_double)
			check_boolean ("is_double", ("  5").is_double)
			check_boolean ("is_double", ("5  ").is_double)
			check_boolean ("is_double", not ("%U5").is_double)
			check_boolean ("is_double", not ("5.6%U").is_double)
			check_boolean ("is_double", ("1").is_double)
		end

	test_is_empty
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("Fds")
			check_boolean ("is_empty", not s.is_empty)

			s.wipe_out
			check_boolean ("is_empty", s.is_empty)

			check_boolean ("is_empty", ("").is_empty)
		end

	test_is_equal
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			check_boolean ("is_equal", s.is_equal (s))
			check_boolean ("is_equal", s.is_equal ("12345"))
			check_boolean ("is_equal", not s.is_equal ("123456"))
			check_boolean ("is_equal", not s.is_equal ("1234"))

			s := "abcdef"
			check_boolean ("is_equal", not s.is_equal ("ABCDEF"))

			check_boolean ("is_equal", not s.is_equal (""))
		end

	test_is_inserted
		local
			s: STRING_8
		do
			s := "1234"
			s.extend ('c')
			check_boolean ("is_inserted", s.is_inserted ('c'))
		end

	test_is_integer
		do
			check_boolean ("is_integer", not ("a").is_integer)
			check_boolean ("is_integer", not ("%U1").is_integer)
			check_boolean ("is_integer", ("1").is_integer)
			check_boolean ("is_integer", (" 1").is_integer)
			check_boolean ("is_integer", ("1 ").is_integer)
		end

	test_is_real
		do
			check_boolean ("is_real", ("5").is_real)
			check_boolean ("is_real", ("5.5").is_real)
			check_boolean ("is_real", ("5E4").is_real)
			check_boolean ("is_real", not ("5 E4").is_real)
			check_boolean ("is_real", ("5e-4").is_real)
			check_boolean ("is_real", ("5e5").is_real)
			check_boolean ("is_real", not ("5e 5").is_real)
			check_boolean ("is_real", (".0").is_real)
			check_boolean ("is_real", ("0.1e10").is_real)
			check_boolean ("is_real", ("-1").is_real)
			check_boolean ("is_real", ("-1.0").is_real)
			check_boolean ("is_real", ("-1e1").is_real)
			check_boolean ("is_real", ("-1e-1").is_real)
			check_boolean ("is_real", ("-1.0e1").is_real)
			check_boolean ("is_real", ("-1.0e-1").is_real)
			check_boolean ("is_real", ("-.1").is_real)
			check_boolean ("is_real", ("1e5").is_real)
			check_boolean ("is_real", not ("e5").is_real)
			check_boolean ("is_real", not (".e1").is_real)
			check_boolean ("is_real", ("1e").is_real)
			check_boolean ("is_real", ("1e1").is_real)
			check_boolean ("is_real", ("  5").is_real)
			check_boolean ("is_real", ("5  ").is_real)
			check_boolean ("is_real", not ("%U5").is_real)
			check_boolean ("is_real", not ("5.6%U").is_real)
		end

	test_infix_greater
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean (">", not (s > s))
			check_boolean (">", not (s > p))
			p.append_character ('a')
			check_boolean (">", not (s > p))
			check_boolean (">", p > s)
			p := "12045"
			check_boolean (">", s > p)
			check_boolean (">", not (p > s))
			s := "123"
			check_boolean (">", s > p)
			check_boolean (">", not (p > s))

			s := ""
			p := ""
			check_boolean (">", not (s > s))
			check_boolean (">", not (s > p))
			p.append_character ('a')
			check_boolean (">", not (s > p))
			check_boolean (">", p > s)
		end

	test_infix_greater_or_equal
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean (">=", s >= s)
			check_boolean (">=", s >= p)
			p.append_character ('a')
			check_boolean (">=", not (s >= p))
			check_boolean (">=", p >= s)
			p := "12045"
			check_boolean (">=", s >= p)
			check_boolean (">=", not (p >= s))
			s := "123"
			check_boolean (">=", s >= p)
			check_boolean (">=", not (p >= s))

			s := ""
			p := ""
			check_boolean (">=", s >= s)
			check_boolean (">=", s >= p)
			p.append_character ('a')
			check_boolean (">=", not (s >= p))
			check_boolean (">=", p >= s)
		end

	test_infix_less
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean ("<", not (s < s))
			check_boolean ("<", not (s < p))
			p.append_character ('a')
			check_boolean ("<", s < p)
			check_boolean ("<", not (p < s))
			p := "12045"
			check_boolean ("<", not (s < p))
			check_boolean ("<", p < s)
			s := "123"
			check_boolean ("<", not (s < p))
			check_boolean ("<", p < s)

			s := ""
			p := ""
			check_boolean ("<", not (s < s))
			check_boolean ("<", not (s < p))
			p.append_character ('a')
			check_boolean ("<", s < p)
			check_boolean ("<", not (p < s))
		end

	test_infix_less_or_equal
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean ("<=", s <= s)
			check_boolean ("<=", s <= p)
			p.append_character ('a')
			check_boolean ("<=", s <= p)
			check_boolean ("<=", not (p <= s))
			p := "12045"
			check_boolean ("<=", not (s <= p))
			check_boolean ("<=", p <= s)
			s := "123"
			check_boolean ("<=", not (s <= p))
			check_boolean ("<=", p <= s)

			s := ""
			p := ""
			check_boolean ("<=", s <= s)
			check_boolean ("<=", s <= p)
			p.append_character ('a')
			check_boolean ("<=", s <= p)
			check_boolean ("<=", not (p <= s))
		end

	test_infix_plus
		local
			s: STRING_8
		do
			s := "12345"
			check_equality ("+", s + s, "1234512345")
			check_equality ("+", "" + "", "")
			check_equality ("+", "" + s, "12345")
			check_equality ("+", s + "", "12345")
		end

	test_keep_head
		local
			s: STRING_8
		do
			s := ""
			s.keep_head (0)
			check_equality ("keep_head", s, "")

			s := ""
			s.keep_head (1)
			check_equality ("keep_head", s, "")

			s := "12345"
			s.keep_head (0)
			check_equality ("keep_head", s, "")

			s := "12345"
			s.keep_head (1)
			check_equality ("keep_head", s, "1")

			s := "12345"
			s.keep_head (2)
			check_equality ("keep_head", s, "12")

			s := "12345"
			s.keep_head (3)
			check_equality ("keep_head", s, "123")

			s := "12345"
			s.keep_head (4)
			check_equality ("keep_head", s, "1234")

			s := "12345"
			s.keep_head (5)
			check_equality ("keep_head", s, "12345")

			s := "12345"
			s.keep_head (6)
			check_equality ("keep_head", s, "12345")

			s := "12345"
			s.keep_head (100)
			check_equality ("keep_head", s, "12345")
		end

	test_keep_tail
		local
			s: STRING_8
		do
			s := ""
			s.keep_tail (0)
			check_equality ("keep_tail", s, "")

			s := ""
			s.keep_tail (1)
			check_equality ("keep_tail", s, "")

			s := "12345"
			s.keep_tail (0)
			check_equality ("keep_tail", s, "")

			s := "12345"
			s.keep_tail (1)
			check_equality ("keep_tail", s, "5")

			s := "12345"
			s.keep_tail (2)
			check_equality ("keep_tail", s, "45")

			s := "12345"
			s.keep_tail (3)
			check_equality ("keep_tail", s, "345")

			s := "12345"
			s.keep_tail (4)
			check_equality ("keep_tail", s, "2345")

			s := "12345"
			s.keep_tail (5)
			check_equality ("keep_tail", s, "12345")

			s := "12345"
			s.keep_tail (6)
			check_equality ("keep_tail", s, "12345")

			s := "12345"
			s.keep_tail (100)
			check_equality ("keep_tail", s, "12345")
		end

	test_last_index_of
		local
			s: STRING_8
		do
			s := "a"
			check_equality ("last_boolean", s.last_index_of ('a', 1), 1)
			check_equality ("last_boolean", s.last_index_of ('b', 1), 0)

			s := "1234554321"
			check_equality ("last_boolean", s.last_index_of ('3', 10), 8)
			check_equality ("last_boolean", s.last_index_of ('3', 5), 3)
			check_equality ("last_boolean", s.last_index_of ('3', 3), 3)
			check_equality ("last_boolean", s.last_index_of ('3', 2), 0)
			check_equality ("last_boolean", s.last_index_of ('X', 10), 0)
		end

	test_left_adjust
		local
			s: STRING_8
		do
			s := "12345"
			s.left_adjust
			check_equality ("left_adjust", s, "12345")

			s := " %T%T12345"
			s.left_adjust
			check_equality ("left_adjust", s, "12345")

			s := "%N %T12345"
			s.left_adjust
			check_equality ("left_adjust", s, "12345")

			s := "a    12345"
			s.left_adjust
			check_equality ("left_adjust", s, "a    12345")
		end

	test_left_justify
		local
			s: STRING_8
		do
			s := "12345"
			s.left_justify
			check_equality ("left_justify", s, "12345")

			s := "12345  "
			s.left_justify
			check_equality ("left_justify", s, "12345  ")

			s := " 12345  "
			s.left_justify
			check_equality ("left_justify", s, "12345   ")

			s := "    12345"
			s.left_justify
			check_equality ("left_justify", s, "12345    ")

			s := ""
			s.left_justify
			check_equality ("left_justify", s, "")
		end

	test_linear_representation
		local
			s: STRING_8
			l_c: LINEAR [CHARACTER_8]
			i: INTEGER
		do
			s := "12345"
			l_c := s.linear_representation
			check_boolean ("linear_representation", l_c /= s.linear_representation)
			check_boolean ("linear_representation", not s.linear_representation.is_empty)
			from
				l_c.start
			until
				l_c.off
			loop
				i := i + 1
				check_boolean ("linear_representation", l_c.item = s.item (i))
				l_c.forth
			end
			check_boolean ("linear_representation", i = 5)
		end

	test_make
		local
			s: STRING_8
			p: SPECIAL [CHARACTER_8]
		do
			s := "1234567890"
			p := s.area
			s.make (2)
			check_boolean ("make", s.is_empty)
			check_boolean ("make", s.count = 0)
			check_boolean ("make", s.capacity >= 2)
			check_boolean ("make", s.area /= p)

			create s.make (2)
			check_boolean ("make", s.is_empty)
			check_boolean ("make", s.count = 0)
			check_boolean ("make", s.capacity >= 2)
				-- Extra check that there are no aliasing within a STRING_8 creation
			check_boolean ("make", s.area /= p)
		end

	test_make_empty
		local
			s: STRING_8
			p: SPECIAL [CHARACTER_8]
		do
			s := "1234567890"
			p := s.area
			s.make_empty
			check_boolean ("make_empty", s.is_empty)
			check_boolean ("make_empty", s.count = 0)
			check_boolean ("make_empty", s.capacity >= 0)
			check_boolean ("make_empty", s.area /= p)

			create s.make_empty
			check_boolean ("make_empty", s.is_empty)
			check_boolean ("make_empty", s.count = 0)
			check_boolean ("make_empty", s.capacity >= 0)
				-- Extra check that there are no aliasing within a STRING_8 creation
			check_boolean ("make_empty", s.area /= p)
		end

	test_make_filled
		local
			s: STRING_8
		do
			create s.make_filled (' ', 10)
			check_boolean ("make_filled", s.count = 10)
			check_boolean ("make_filled", s.capacity >= 10)
			check_boolean ("make_filled", s.occurrences (' ') = 10)
			check_boolean ("make_filled", s.occurrences ('x') = 0)
			check_boolean ("make_filled", s.is_equal ("          "))

			create s.make_filled ('a', 10)
			check_boolean ("make_filled", s.count = 10)
			check_boolean ("make_filled", s.capacity >= 10)
			check_boolean ("make_filled", s.occurrences (' ') = 0)
			check_boolean ("make_filled", s.occurrences ('x') = 0)
			check_boolean ("make_filled", s.occurrences ('a') = 10)
			check_boolean ("make_filled", s.is_equal ("aaaaaaaaaa"))
		end

	test_make_from_c
		local
			l_ptr: MANAGED_POINTER
			s: STRING_8
		do
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_equal ("0123456"))

			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_empty)

			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_equal ("0123456"))

			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_empty)
		end

	test_make_from_c_substring
		local
			l_ptr: MANAGED_POINTER
			s: STRING_8
		do
				-- Creation `make_from_c_substring`
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c_substring (l_ptr.item, 2, 5)
			check_boolean ("make_from_c_substring", s.is_equal ("1234"))

			create s.make_from_c_substring (l_ptr.item, 2, 2)
			check_boolean ("make_from_c_substring", s.is_equal ("1"))

			create s.make_from_c_substring (l_ptr.item, 3, 7)
			check_boolean ("make_from_c_substring", s.is_equal ("23456"))

			create s.make_from_c_substring (l_ptr.item, 1, 8)
			check_boolean ("make_from_c_substring", s.is_equal ("0123456%U"))


			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c_substring (l_ptr.item, 2, 8)
			check_boolean ("make_from_c_substring", s.is_equal ("0123456"))

			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 0, 52, 53, 54, 0 >>)
			create s.make_from_c_substring (l_ptr.item, 1, 10)
			check_boolean ("make_from_c_substring", s.is_equal ("%U0123%U456%U"))

				-- Procedure `make_from_c_substring`
			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.make_from_c_substring (l_ptr.item, 2, 5)
			check_boolean ("make_from_c_substring", s.is_equal ("1234"))

			s := "abcdef"
			s.make_from_c_substring (l_ptr.item, 3, 7)
			check_boolean ("make_from_c_substring", s.is_equal ("23456"))

			s := "abcdef"
			s.make_from_c_substring (l_ptr.item, 1, 8)
			check_boolean ("make_from_c_substring", s.is_equal ("0123456%U"))


			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			s.make_from_c_substring (l_ptr.item, 2, 8)
			check_boolean ("make_from_c_substring", s.is_equal ("0123456"))

			s := "abcdef"
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 0, 52, 53, 54, 0 >>)
			s.make_from_c_substring (l_ptr.item, 1, 10)
			check_boolean ("make_from_c_substring", s.is_equal ("%U0123%U456%U"))
		end

	test_make_from_string
		local
			s, p: STRING_8
		do
			p := "12345"
			s := p
			s.make_from_string (p)
			check_boolean ("make_from_string", s.area = p.area)
			check_boolean ("make_from_string", s.count = p.count)

			create s.make_from_string (p)
			check_boolean ("make_from_string", s.is_equal ("12345"))
			check_boolean ("make_from_string", s.area /= p.area)
		end

	test_max
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean ("max", s.max (s) = s)
			check_boolean ("max", s.max (p) = s)
			check_boolean ("max", p.max (s) = p)
			p.append_character ('a')
			check_boolean ("max", s.max (p) = p)
			check_boolean ("max", p.max (s) = p)
			p := "12045"
			check_boolean ("max", s.max (p) = s)
			check_boolean ("max", p.max (s) = s)

			s := ""
			p := ""
			check_boolean ("max", s.max (s) = s)
			check_boolean ("max", s.max (p) = s)
			check_boolean ("max", p.max (s) = p)
			p.append_character ('a')
			check_boolean ("max", s.max (p) = p)
			check_boolean ("max", p.max (s) = p)
		end

	test_min
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean ("min", s.min (s) = s)
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = p)
			p.append_character ('a')
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = s)
			p := "12045"
			check_boolean ("min", s.min (p) = p)
			check_boolean ("min", p.min (s) = p)

			s := ""
			p := ""
			check_boolean ("min", s.min (s) = s)
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = p)
			p.append_character ('a')
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = s)
		end

	test_mirror
		local
			s: STRING_8
		do
			s := ""
			s.mirror
			check_equality ("mirror", s, "")
			s := "a"
			s.mirror
			check_equality ("mirror", s, "a")
			s := "ab"
			s.mirror
			check_equality ("mirror", s, "ba")
			s := "abc"
			s.mirror
			check_equality ("mirror", s, "cba")
			s := "abcd"
			s.mirror
			check_equality ("mirror", s, "dcba")
			s := "abcde"
			s.mirror
			check_equality ("mirror", s, "edcba")
		end

	test_mirrored
		local
			s: STRING_8
			p: STRING_8
		do
			s := ""
			p := s.mirrored
			check_equality ("mirrored", s, "")
			check_equality ("mirrored", p, "")
			s := "a"
			p := s.mirrored
			check_equality ("mirrored", s, "a")
			check_equality ("mirrored", p, "a")
			s := "ab"
			p := s.mirrored
			check_equality ("mirrored", s, "ab")
			check_equality ("mirrored", p, "ba")
			s := "abc"
			p := s.mirrored
			check_equality ("mirrored", s, "abc")
			check_equality ("mirrored", p, "cba")
			s := "abcd"
			p := s.mirrored
			check_equality ("mirrored", s, "abcd")
			check_equality ("mirrored", p, "dcba")
			s := "abcde"
			p := s.mirrored
			check_equality ("mirrored", s, "abcde")
			check_equality ("mirrored", p, "edcba")
		end

	test_multiply
		local
			s: STRING_8
		do
			s := ""
			s.multiply (1)
			check_equality ("multiply", s, "")
			s.multiply (2)
			check_equality ("multiply", s, "")
			s.multiply (3)
			check_equality ("multiply", s, "")

			s := "a"
			s.multiply (1)
			check_equality ("multiply", s, "a")
			s := "a"
			s.multiply (2)
			check_equality ("multiply", s, "aa")
			s := "a"
			s.multiply (3)
			check_equality ("multiply", s, "aaa")

			s := "ab"
			s.multiply (1)
			check_equality ("multiply", s, "ab")
			s := "ab"
			s.multiply (2)
			check_equality ("multiply", s, "abab")
			s := "ab"
			s.multiply (3)
			check_equality ("multiply", s, "ababab")

			s := "abc"
			s.multiply (1)
			check_equality ("multiply", s, "abc")
			s := "abc"
			s.multiply (2)
			check_equality ("multiply", s, "abcabc")
			s := "abc"
			s.multiply (3)
			check_equality ("multiply", s, "abcabcabc")
		end

	test_occurrences
		do
			check_boolean ("occurrences", ("").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("").occurrences (' ') = 0)
			check_boolean ("occurrences", ("").occurrences ('a') = 0)
			check_boolean ("occurrences", ("%U").occurrences ('%U') = 1)
			check_boolean ("occurrences", ("%U").occurrences (' ') = 0)
			check_boolean ("occurrences", ("%U").occurrences ('a') = 0)
			check_boolean ("occurrences", (" ").occurrences ('%U') = 0)
			check_boolean ("occurrences", (" ").occurrences (' ') = 1)
			check_boolean ("occurrences", (" ").occurrences ('a') = 0)
			check_boolean ("occurrences", ("a").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("a").occurrences (' ') = 0)
			check_boolean ("occurrences", ("a").occurrences ('a') = 1)
			check_boolean ("occurrences", ("%U%U").occurrences ('%U') = 2)
			check_boolean ("occurrences", ("%U%U").occurrences (' ') = 0)
			check_boolean ("occurrences", ("%U%U").occurrences ('a') = 0)
			check_boolean ("occurrences", ("%U ").occurrences ('%U') = 1)
			check_boolean ("occurrences", ("%U ").occurrences (' ') = 1)
			check_boolean ("occurrences", ("%U ").occurrences ('a') = 0)
			check_boolean ("occurrences", (" %U").occurrences ('%U') = 1)
			check_boolean ("occurrences", (" %U").occurrences (' ') = 1)
			check_boolean ("occurrences", (" %U").occurrences ('a') = 0)
			check_boolean ("occurrences", ("  ").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("  ").occurrences (' ') = 2)
			check_boolean ("occurrences", ("  ").occurrences ('a') = 0)
			check_boolean ("occurrences", (" a").occurrences ('%U') = 0)
			check_boolean ("occurrences", (" a").occurrences (' ') = 1)
			check_boolean ("occurrences", (" a").occurrences ('a') = 1)
			check_boolean ("occurrences", ("a ").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("a ").occurrences (' ') = 1)
			check_boolean ("occurrences", ("a ").occurrences ('a') = 1)
			check_boolean ("occurrences", ("aa").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("aa").occurrences (' ') = 0)
			check_boolean ("occurrences", ("aa").occurrences ('a') = 2)
			check_boolean ("occurrences", ("%U%U%U").occurrences ('%U') = 3)
			check_boolean ("occurrences", ("%U%U%U").occurrences (' ') = 0)
			check_boolean ("occurrences", ("%U%U%U").occurrences ('a') = 0)
			check_boolean ("occurrences", (" %U%U").occurrences ('%U') = 2)
			check_boolean ("occurrences", (" %U%U").occurrences (' ') = 1)
			check_boolean ("occurrences", (" %U%U").occurrences ('a') = 0)
			check_boolean ("occurrences", ("%U %U").occurrences ('%U') = 2)
			check_boolean ("occurrences", ("%U %U").occurrences (' ') = 1)
			check_boolean ("occurrences", ("%U %U").occurrences ('a') = 0)
			check_boolean ("occurrences", ("%U%U ").occurrences ('%U') = 2)
			check_boolean ("occurrences", ("%U%U ").occurrences (' ') = 1)
			check_boolean ("occurrences", ("%U%U ").occurrences ('a') = 0)
			check_boolean ("occurrences", ("%U  ").occurrences ('%U') = 1)
			check_boolean ("occurrences", ("%U  ").occurrences (' ') = 2)
			check_boolean ("occurrences", ("%U  ").occurrences ('a') = 0)
			check_boolean ("occurrences", (" %U ").occurrences ('%U') = 1)
			check_boolean ("occurrences", (" %U ").occurrences (' ') = 2)
			check_boolean ("occurrences", (" %U ").occurrences ('a') = 0)
			check_boolean ("occurrences", ("  %U").occurrences ('%U') = 1)
			check_boolean ("occurrences", ("  %U").occurrences (' ') = 2)
			check_boolean ("occurrences", ("  %U").occurrences ('a') = 0)
			check_boolean ("occurrences", ("   ").occurrences ('%U') = 0)
			check_boolean ("occurrences", ("   ").occurrences (' ') = 3)
			check_boolean ("occurrences", ("   ").occurrences ('a') = 0)
		end

	test_out
		do
			check_equality ("out", ("").out, "")
			check_equality ("out", ("1").out, "1")
			check_equality ("out", ("12").out, "12")
			check_equality ("out", ("123").out, "123")
			check_equality ("out", ("1234").out, "1234")
			check_equality ("out", ("12345").out, "12345")
		end

	test_plus
		local
			is_32: IMMUTABLE_STRING_32
			is_8: IMMUTABLE_STRING_8
			s_32: STRING_32
			s_8: STRING_8
		do
			is_32 := "12345"
			s_32 := "12345"
			is_8 := "67890"
			s_8 := "67890"
			check_string_equality ("plus", s_8 + is_32, {IMMUTABLE_STRING_32}"6789012345")
			check_string_equality ("plus", s_8.as_string_32 + s_32, "6789012345")
			check_string_equality ("plus", s_8 + is_8, "6789067890")
			check_string_equality ("plus", s_8 + s_8, "6789067890")
			check_string_equality ("plus", s_8 + "", "67890")

			s_8 := ""
			check_string_equality ("plus", s_8 + is_32, "12345")
			check_string_equality ("plus", s_8.as_string_32 + s_32, "12345")
			check_string_equality ("plus", s_8 + is_8, "67890")
			check_string_equality ("plus", s_8 + s_8, "")
			check_string_equality ("plus", s_8 + "", "")

			is_32 := ""
			s_32 := ""
			is_8 := ""
			check_string_equality ("plus", s_8 + is_32, "")
			check_string_equality ("plus", s_8.as_string_32 + s_32, "")
			check_string_equality ("plus", s_8 + is_8, "")
			check_string_equality ("plus", s_8 + s_8, "")
			check_string_equality ("plus", s_8 + "", "")
		end

	test_precede
		local
			s: STRING_8
		do
			s := ""
			s.precede ('%U')
			check_equality ("precede", s, "%U")
			s.precede ('a')
			check_equality ("precede", s, "a%U")
			s.precede ('%N')
			check_equality ("precede", s, "%Na%U")
		end

	test_prepend
			-- Perform test on `prepend'.
		local
			s: STRING_8
		do
			s := ""
			s.prepend (s)
			check_equality ("prepend", s, "")
			s.prepend ("")
			check_equality ("prepend", s, "")
			s.prepend ("abc")
			check_equality ("prepend", s, "abc")
			s.prepend ("")
			check_equality ("prepend", s, "abc")

			s := "bar"
			s.prepend (s)
			check_equality ("prepend", s, "barbar")

			s := "bar"
			s.prepend ("bar")
			check_equality ("prepend", s, "barbar")
		end

	test_prepend_boolean
		local
			s: STRING_8
		do
			s := ""
			s.prepend_boolean (true)
			check_equality ("prepend_boolean", s, "True")
			s := ""
			s.prepend_boolean (false)
			check_equality ("prepend_boolean", s, "False")
			s.prepend_boolean (true)
			check_equality ("prepend_boolean", s, "TrueFalse")
			s.prepend_boolean (false)
			check_equality ("prepend_boolean", s, "FalseTrueFalse")
		end

	test_prepend_character
		local
			s: STRING_8
		do
			s := ""
			s.prepend_character ('%U')
			check_equality ("prepend_character", s, "%U")
			s.prepend_character ('a')
			check_equality ("prepend_character", s, "a%U")
			s.prepend_character (' ')
			check_equality ("prepend_character", s, " a%U")
			s.prepend_character ('%N')
			check_equality ("prepend_character", s, "%N a%U")
		end

	test_prepend_double
		local
			s: STRING_8
		do
			s := ""
			s.prepend_double (0)
			check_equality ("prepend_double", s, "0")
			s.prepend_double (1)
			check_equality ("prepend_double", s, "10")
			s.prepend_double (0.5)
			check_equality ("prepend_double", s, "0.510")
			s.prepend_double (-0.5)
			check_equality ("prepend_double", s, "-0.50.510")
		end

	test_prepend_integer
		local
			s: STRING_8
		do
			s := ""
			s.prepend_integer (0)
			check_equality ("prepend_integer", s, "0")
			s.prepend_integer (1)
			check_equality ("prepend_integer", s, "10")
			s.prepend_integer (-0x8000_0000)
			check_equality ("prepend_integer", s, "-214748364810")
			s.prepend_integer (-0x7FFF_FFFF)
			check_equality ("prepend_integer", s, "-2147483647-214748364810")
			s.prepend_integer (0x7FFF_FFFF)
			check_equality ("prepend_integer", s, "2147483647-2147483647-214748364810")
		end

	test_prepend_real
		local
			s: STRING_8
		do
			s := ""
			s.prepend_real (0)
			check_equality ("prepend_real", s, "0")
			s.prepend_real (1)
			check_equality ("prepend_real", s, "10")
			s.prepend_real ({REAL_32} 0.5)
			check_equality ("prepend_real", s, "0.510")
			s.prepend_real ({REAL_32} -0.5)
			check_equality ("prepend_real", s, "-0.50.510")
		end


	test_prepend_string
		local
			s: STRING_8
		do
			s := ""
			s.prepend (s)
			check_equality ("prepend", s, "")
			s.prepend ("")
			check_equality ("prepend", s, "")
			s.prepend ("abc")
			check_equality ("prepend", s, "abc")
			s.prepend ("")
			check_equality ("prepend", s, "abc")

			s := "bar"
			s.prepend (s)
			check_equality ("prepend", s, "barbar")

			s := "bar"
			s.prepend ("bar")
			check_equality ("prepend", s, "barbar")
		end

	test_prunable
		do
			check_boolean ("prunable", ("").prunable)
			check_boolean ("prunable", ("%U").prunable)
			check_boolean ("prunable", ("abc").prunable)
		end

	test_prune
		local
			s: STRING_8
		do
			s := ""
			s.prune ('%U')
			check_equality ("prune", s, "")
			s.prune ('a')
			check_equality ("prune", s, "")
			s := "%Ua%Ua%Na%U"
			s.prune ('%U')
			check_equality ("prune", s, "a%Ua%Na%U")
			s.prune ('%U')
			check_equality ("prune", s, "aa%Na%U")
			s.prune ('%U')
			check_equality ("prune", s, "aa%Na")
			s.prune ('%U')
			check_equality ("prune", s, "aa%Na")
			s := "%Ua%Ua%Na%U"
			s.prune ('a')
			check_equality ("prune", s, "%U%Ua%Na%U")
			s.prune ('a')
			check_equality ("prune", s, "%U%U%Na%U")
			s.prune ('a')
			check_equality ("prune", s, "%U%U%N%U")
			s.prune ('a')
			check_equality ("prune", s, "%U%U%N%U")
			s := "%Ua%Ua%Na%U"
			s.prune ('%N')
			check_equality ("prune", s, "%Ua%Uaa%U")
			s.prune ('%N')
			check_equality ("prune", s, "%Ua%Uaa%U")
		end

	test_prune_all
		local
			s: STRING_8
		do
			s := ""
			s.prune_all ('%U')
			check_equality ("prune_all", s, "")
			s.prune_all ('a')
			check_equality ("prune_all", s, "")
			s := "%Ua%Ua%Na%U"
			s.prune_all ('%U')
			check_equality ("prune_all", s, "aa%Na")
			s.prune_all ('%U')
			check_equality ("prune_all", s, "aa%Na")
			s := "%Ua%Ua%Na%U"
			s.prune_all ('a')
			check_equality ("prune_all", s, "%U%U%N%U")
			s.prune_all ('a')
			check_equality ("prune_all", s, "%U%U%N%U")
			s := "%Ua%Ua%Na%U"
			s.prune_all ('%N')
			check_equality ("prune_all", s, "%Ua%Uaa%U")
			s.prune_all ('%N')
			check_equality ("prune_all", s, "%Ua%Uaa%U")
		end

	test_prune_all_leading
		local
			s: STRING_8
		do
			s := ""
			s.prune_all_leading ('%U')
			check_equality ("prune_all_leading", s, "")
			s.prune_all_leading ('a')
			check_equality ("prune_all_leading", s, "")
			s := "%U%U%U"
			s.prune_all_leading ('a')
			check_equality ("prune_all_leading", s, "%U%U%U")
			s.prune_all_leading ('%U')
			check_equality ("prune_all_leading", s, "")
			s := "aaa"
			s.prune_all_leading ('%U')
			check_equality ("prune_all_leading", s, "aaa")
			s.prune_all_leading ('a')
			check_equality ("prune_all_leading", s, "")
			s := "%U%Ua%Ua%Na%U"
			s.prune_all_leading ('a')
			check_equality ("prune_all_leading", s, "%U%Ua%Ua%Na%U")
			s.prune_all_leading ('%U')
			check_equality ("prune_all_leading", s, "a%Ua%Na%U")
			s.prune_all_leading ('%U')
			check_equality ("prune_all_leading", s, "a%Ua%Na%U")
			s.prune_all_leading ('a')
			check_equality ("prune_all_leading", s, "%Ua%Na%U")
		end

	test_prune_all_trailing
		local
			s: STRING_8
		do
			s := ""
			s.prune_all_trailing ('%U')
			check_equality ("prune_all_trailing", s, "")
			s.prune_all_trailing ('a')
			check_equality ("prune_all_trailing", s, "")
			s := "%U%U%U"
			s.prune_all_trailing ('a')
			check_equality ("prune_all_trailing", s, "%U%U%U")
			s.prune_all_trailing ('%U')
			check_equality ("prune_all_trailing", s, "")
			s := "aaa"
			s.prune_all_trailing ('%U')
			check_equality ("prune_all_trailing", s, "aaa")
			s.prune_all_trailing ('a')
			check_equality ("prune_all_trailing", s, "")
			s := "%U%Ua%Ua%Na%U%U"
			s.prune_all_trailing ('a')
			check_equality ("prune_all_trailing", s, "%U%Ua%Ua%Na%U%U")
			s.prune_all_trailing ('%U')
			check_equality ("prune_all_trailing", s, "%U%Ua%Ua%Na")
			s.prune_all_trailing ('%U')
			check_equality ("prune_all_trailing", s, "%U%Ua%Ua%Na")
			s.prune_all_trailing ('a')
			check_equality ("prune_all_trailing", s, "%U%Ua%Ua%N")
		end

	test_put
		local
			s: STRING_8
		do
			s := "a"
			s.put ('%U', 1)
			check_equality ("put", s, "%U")
			s := "12345"
			s.put ('c', 3)
			s.put ('b', 2)
			s.put ('e', 5)
			s.put ('d', 4)
			s.put ('a', 1)
			check_equality ("put", s, "abcde")
			s.put ('%U', 3)
			check_equality ("put", s, "ab%Ude")
			s.put ('3', 3)
			check_equality ("put", s, "ab3de")
		end

	test_remove
		local
			s: STRING_8
		do
			s := "12345"
			s.remove (3)
			check_equality ("remove", s, "1245")
			s.remove (4)
			check_equality ("remove", s, "124")
			s.remove (1)
			check_equality ("remove", s, "24")
			s.remove (2)
			check_equality ("remove", s, "2")
			s.remove (1)
			check_equality ("remove", s, "")
		end

	test_remove_head
		local
			s: STRING_8
		do
			s := ""
			s.remove_head (2)
			check_equality ("remove_head", s, "")
			s := "12345"
			s.remove_head (1)
			check_equality ("remove_head", s, "2345")
			s.remove_head (2)
			check_equality ("remove_head", s, "45")
			s.remove_head (3)
			check_equality ("remove_head", s, "")
			s := "12345"
			s.remove_head (5)
			check_equality ("remove_head", s, "")
		end

	test_remove_substring
		local
			s: STRING_8
		do
			s := ""
			s.remove_substring (1, 0)
			check_equality ("remove_substring", s, "")
			s := "12345"
			s.remove_substring (1, 0)
			check_equality ("remove_substring", s, "12345")
			s.remove_substring (2, 1)
			check_equality ("remove_substring", s, "12345")
			s.remove_substring (5, 4)
			check_equality ("remove_substring", s, "12345")
			s.remove_substring (6, 5)
			check_equality ("remove_substring", s, "12345")
			s.remove_substring (1, 1)
			check_equality ("remove_substring", s, "2345")
			s.remove_substring (1, 2)
			check_equality ("remove_substring", s, "45")
			s.remove_substring (1, 2)
			check_equality ("remove_substring", s, "")
			s := "12345"
			s.remove_substring (2, 2)
			check_equality ("remove_substring", s, "1345")
			s.remove_substring (2, 4)
			check_equality ("remove_substring", s, "1")
			s.remove_substring (1, 1)
			check_equality ("remove_substring", s, "")
		end

	test_remove_tail
		local
			s: STRING_8
		do
			s := ""
			s.remove_tail (2)
			check_equality ("remove_tail", s, "")
			s := "12345"
			s.remove_tail (1)
			check_equality ("remove_tail", s, "1234")
			s.remove_tail (2)
			check_equality ("remove_tail", s, "12")
			s.remove_tail (3)
			check_equality ("remove_tail", s, "")
			s := "12345"
			s.remove_tail (5)
			check_equality ("remove_tail", s, "")
		end

	test_replace_blank
		local
			s: STRING_8
		do
			s := ""
			s.replace_blank
			check_equality ("replace_blank", s, "")
			s := "1"
			s.replace_blank
			check_equality ("replace_blank", s, " ")
			s := "a%Ub%Uc%U"
			s.replace_blank
			check_equality ("replace_blank", s, "      ")
		end

	test_replace_substring
			-- Perform test on `replace_substring'.
		local
			s: STRING_8
		do
			s := "foobar"
			s.replace_substring (s, 4, 6)
			check_equality ("replace_substring", s, "foofoobar")

			s := "foobar"
			s.replace_substring ("foobar", 4, 6)
			check_equality ("replace_substring", s, "foofoobar")
		end

	test_replace_substring_all
		local
			s: STRING_8
			s_orig, s_modif: STRING_8
		do
			s := "EiffelSoftware   Entreprise Edition_5.5"
			s.replace_substring_all ("  ", "_")
			check_equality ("replace_substring_all", s, "EiffelSoftware_ Entreprise Edition_5.5")

			s := "   EiffelSoftware   Entreprise   Edition_5.5   "
			s.replace_substring_all ("  ", "_")
			check_equality ("replace_substring_all", s, "_ EiffelSoftware_ Entreprise_ Edition_5.5_ ")

			s := "   EiffelSoftware   Entreprise   Edition_5.5   "
			s.replace_substring_all (" ", "___")
			check_equality ("replace_substring_all", s, "_________EiffelSoftware_________Entreprise_________Edition_5.5_________")

			s_orig := "[
	              #ifdef EIF_WINDOWS
                    /* On NTFS file system, windows store UTC file stamps in 100 of nanoseconds
                     * starting from January 1st 0. Converted in seconds, this time greater
                     * than 232 therefore we substract the EPOCH date January 1st 1970 to get
                     * a 32 bits representation of the date.
                     * FIXME: Manu 01/28/2004: On FAT file system, the date in local time,
                     * meaning that the code below does not compensate if you change your timezone
                     * and will return a different date value for the same stamp just because
                     * you are in different time zone.
                     */

                     /* WARNING: This using the Ansi version of the Win32 API. Remember
                      * that if you are doing any change below.
                      */
                static ULARGE_INTEGER epoch_date;
                static int done = 0;

                WIN32_FIND_DATAA l_find_data;
                HANDLE l_file_handle;
                ULARGE_INTEGER l_date;

                l_file_handle = FindFirstFileA(arg1, &l_find_data);
                if (l_file_handle == INVALID_HANDLE_VALUE) {
                    *(EIF_INTEGER*) $r = -1;
                } else {
                    /* We do not need the file handle anymore, so we close it to
                     * avoid handle leak. */
                FindClose (l_file_handle);
                if (done == 0) {
                        /* Lazy initialization of epoch_date. */
                    SYSTEMTIME epoch;
                    FILETIME epoch_file;

                    done = 1;
                    memset (&epoch, 0, sizeof(SYSTEMTIME));
                    epoch.wYear = 1970;
                    epoch.wMonth = 1;
                    epoch.wDay = 1;
                    SystemTimeToFileTime (&epoch, &epoch_file);
                    memcpy (&epoch_date, &epoch_file, sizeof(ULARGE_INTEGER));
                }
                memcpy (&l_date, &(l_find_data.ftLastWriteTime), sizeof(ULARGE_INTEGER));
                *(EIF_INTEGER*) $r = (EIF_INTEGER) ((l_date.QuadPart -
                    epoch_date.QuadPart) / RTI64C(10000000));
                }
                #else
                static struct stat info;
                *(EIF_INTEGER*) $r = (-1 == stat(arg1,&info)) ? (EIF_INTEGER) -1L :(EIF_INTEGER) info.st_mtime;
                #endif
	]"

		s_modif := "[
	              #ifdef EIF_WINDOWS
                    /* On NTFS file system, windows store UTC file stamps in 100 of nanoseconds
                     * starting from January 1st 0. Converted in seconds, this time greater
                     * than 232 therefore we substract the EPOCH date January 1st 1970 to get
                     * a 32 bits representation of the date.
                     * FIXME: Manu 01/28/2004: On FAT file system, the date in local time,
                     * meaning that the code below does not compensate if you change your timezone
                     * and will return a different date value for the same stamp just because
                     * you are in different time zone.
                     */

                     /* WARNING: This using the Ansi version of the Win32 API. Remember
                      * that if you are doing any change below.
                      */
                static ULARGE_INTEGER epoch_date;
                static int done = 0;

                WIN32_FIND_DATAA l_find_data;
                HANDLE l_file_handle;
                ULARGE_INTEGER l_date;

                l_file_handle = FindFirstFileA(arg1, &l_find_data);
                if (l_file_handle == INVALID_HANDLE_VALUE) {
                    *(EIF_INTEGER*) arg2 = -1;
                } else {
                    /* We do not need the file handle anymore, so we close it to
                     * avoid handle leak. */
                FindClose (l_file_handle);
                if (done == 0) {
                        /* Lazy initialization of epoch_date. */
                    SYSTEMTIME epoch;
                    FILETIME epoch_file;

                    done = 1;
                    memset (&epoch, 0, sizeof(SYSTEMTIME));
                    epoch.wYear = 1970;
                    epoch.wMonth = 1;
                    epoch.wDay = 1;
                    SystemTimeToFileTime (&epoch, &epoch_file);
                    memcpy (&epoch_date, &epoch_file, sizeof(ULARGE_INTEGER));
                }
                memcpy (&l_date, &(l_find_data.ftLastWriteTime), sizeof(ULARGE_INTEGER));
                *(EIF_INTEGER*) arg2 = (EIF_INTEGER) ((l_date.QuadPart -
                    epoch_date.QuadPart) / RTI64C(10000000));
                }
                #else
                static struct stat info;
                *(EIF_INTEGER*) arg2 = (-1 == stat(arg1,&info)) ? (EIF_INTEGER) -1L :(EIF_INTEGER) info.st_mtime;
                #endif
	]"
			s_orig.replace_substring_all ("$r", "arg2")
			check_equality ("replace_substring_all", s_orig, s_modif)
		end

	test_resizable
		do
			check_boolean ("resizable", ("").resizable)
			check_boolean ("resizable", ("1").resizable)
			check_boolean ("resizable", ("12").resizable)
			check_boolean ("resizable", ("123").resizable)
		end

	test_resize
		local
			s: STRING_8
		do
			s := ""
			s.resize (0)
			check_equality ("resize", s, "")
			s.resize (5)
			check_equality ("resize", s, "")
			s := "12345"
			s.resize (5)
			check_equality ("resize", s, "12345")
			s.resize (10)
			check_equality ("resize", s, "12345")
		end

	test_right_adjust
		local
			s: STRING_8
		do
			s := ""
			s.right_adjust
			check_equality ("right_adjust", s, "")
			s := "%/9/%/10/%/11/%/12/%/13/ "
			s.right_adjust
			check_equality ("right_adjust", s, "")
			s := "abc%/9/%/10/%/11/%/12/%/13/ "
			s.right_adjust
			check_equality ("right_adjust", s, "abc")
			s := "%/9/%/10/%/11/%/12/%/13/ abc"
			s.right_adjust
			check_equality ("right_adjust", s, "%/9/%/10/%/11/%/12/%/13/ abc")
		end

	test_right_justify
		local
			s: STRING_8
		do
			s := ""
			s.right_justify
			check_equality ("right_justify", s, "")
			s := "12345"
			s.right_justify
			check_equality ("right_justify", s, "12345")
			s := "abc%/9/%/10/%/11/%/12/%/13/ "
			s.right_justify
			check_equality ("right_justify", s, "      abc")
			s := "%/9/%/10/%/11/%/12/%/13/ abc"
			s.right_justify
			check_equality ("right_justify", s, "%/9/%/10/%/11/%/12/%/13/ abc")
			s := "%/9/%/10/%/11/%/12/%/13/ abc%/9/%/10/%/11/%/12/%/13/ "
			s.right_justify
			check_equality ("right_justify", s, "      %/9/%/10/%/11/%/12/%/13/ abc")
		end

	test_same_string
		local
			s: STRING_8
		do
			s := ""
			check_boolean ("same_string", s.same_string (s))
			check_boolean ("same_string", s.same_string (""))

			s := "12345"
			check_boolean ("same_string", s.same_string (s))
			check_boolean ("same_string", s.same_string ("12345"))
			check_boolean ("same_string", not s.same_string ("123456"))
			check_boolean ("same_string", not s.same_string ("123"))
			check_boolean ("same_string", not s.same_string (""))

			s := "abcdef"
			check_boolean ("same_string", not s.same_string ("ABCDEF"))
		end

	test_same_characters
		local
			s: STRING_8
			o: STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_characters", s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", o.same_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_characters", not s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", not o.same_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_characters", not s.same_characters (o, 1, 2, 2))
		end

	test_same_caseless_characters
		local
			s: STRING_8
			o: STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", o.same_caseless_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", not o.same_caseless_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 2, 2))
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 2, 3))
		end

	test_same_type
		do
			check_boolean ("same_type", ("").same_type (create {STRING_8}.make_empty))
			check_boolean ("same_type", ("").same_type (create {STRING_8}.make (10)))
			check_boolean ("same_type", ("").same_type ("12345"))
		end

	test_set
		local
			s: STRING_8
		do
			s := ""
			s.set ("", 1, 0)
			check_equality ("set", s, "")
			s.set ("", 1, 10)
			check_equality ("set", s, "")
			s.set ("", 10, 1000)
			check_equality ("set", s, "")
			s.set ("123", 10, 100)
			check_equality ("set", s, "")
			s.set ("123", 1, 0)
			check_equality ("set", s, "")
			s.set ("123", 1, -120)
			check_equality ("set", s, "")
			s.set ("123", 3, 0)
			check_equality ("set", s, "")
			s.set ("123", 4, 4)
			check_equality ("set", s, "")
			s.set ("123", 2, 2)
			check_equality ("set", s, "2")
			s.set ("12345", -100, 100)
			check_equality ("set", s, "") -- Current implementation assumes that out-of-range indexes result in empty string
			s.set ("12345", 1, 5)
			check_equality ("set", s, "12345")
			s.set ("12345", 1, 3)
			check_equality ("set", s, "123")
			s.set ("12345", 3, 5)
			check_equality ("set", s, "345")
		end

	test_share
		local
			s: STRING_8
			p: STRING_8
		do
			s := ""
			p := "12345"
			s.share (p)
			check_equality ("share", s, "12345")
			p.remove_head (5)
			check_equality ("share", p, "")
			check_equality ("share", s, "12345")
			p.append_string ("abcde")
			check_equality ("share", p, "abcde")
			check_equality ("share", s, "abcde")
		end

	test_shared_with
		local
			s: STRING_8
			p: STRING_8
		do
			s := ""
			check_boolean ("shared_with", not s.shared_with (""))
			p := "12345"
			check_boolean ("shared_with", not s.shared_with (p))
			s.share (p)
			check_boolean ("shared_with", s.shared_with (p))
				-- `append_string' does not take sharing into account
			-- p.append_string ("abc")
			-- check_boolean ("shared_with", s.shared_with (p))
			p.make_empty
			check_boolean ("shared_with", not s.shared_with (p))
		end

	test_split
		local
			s: STRING_8
			l: LIST [STRING_8]
		do
			s := ""
			l := s.split ('%U')
			check_equality ("split", l.count, 1)
			check_equality ("split", l [1], "")
			s := "1234543212345"
			l := s.split ('%U')
			check_equality ("split", l.count, 1)
			check_equality ("split", l [1], "1234543212345")
			l := s.split ('6')
			check_equality ("split", l.count, 1)
			check_equality ("split", l [1], "1234543212345")
			l := s.split ('1')
			check_equality ("split", l.count, 3)
			check_equality ("split", l [1], "")
			check_equality ("split", l [2], "2345432")
			check_equality ("split", l [3], "2345")
			l := s.split ('2')
			check_equality ("split", l.count, 4)
			check_equality ("split", l [1], "1")
			check_equality ("split", l [2], "34543")
			check_equality ("split", l [3], "1")
			check_equality ("split", l [4], "345")
			l := s.split ('5')
			check_equality ("split", l.count, 3)
			check_equality ("split", l [1], "1234")
			check_equality ("split", l [2], "4321234")
			check_equality ("split", l [3], "")
		end

	test_starts_with
		local
			s: STRING_8
		do
			s := "1234567890"
			check_boolean ("Starts with empty%N", s.starts_with (""))
			check_boolean ("Starts with itself%N", s.starts_with (s))
			check_boolean ("Starts with its twin%N", s.starts_with (s.twin))
			check_boolean ("Not starts with itself twice%N", not s.starts_with (s + s))
			check_boolean ("Starts with 123%N", s.starts_with ("123"))
			check_boolean ("Not starts with 23%N", not s.starts_with ("23"))
			check_boolean ("Not starts with 890%N", not s.starts_with ("890"))
			check_boolean ("Not starts with 89%N", not s.starts_with ("89"))
		end

	test_string
		local
			s: STRING_8
		do
			s := ""
			check_boolean ("string", s.string /= s)
			check_equality ("string", s.string, s)
			check_boolean ("string", not s.string.shared_with (s))
			s := "12345"
			check_boolean ("string", s.string /= s)
			check_equality ("string", s.string, s)
			check_boolean ("string", not s.string.shared_with (s))
		end

	test_subcopy
			-- Perform test on `subcopy'.
		local
			s: STRING_8
		do
			s := "foobarfoobar"
			s.subcopy (s, 2, 3, 5)
			check_equality ("subcopy", s, "fooboofoobar")

			s := "foobarfoobar"
			s.subcopy ("foobarfoobar", 2, 3, 5)
			check_equality ("subcopy", s, "fooboofoobar")

			s := "foobarfoobar"
			s.subcopy (s, 4, 6, 7)
			check_equality ("subcopy", s, "foobarbarbar")

			s := "foobarfoobar"
			s.subcopy (s, 4, 6, 2)
			check_equality ("subcopy", s, "fbararfoobar")
		end

	test_substring
		local
			s: STRING_8
		do
			s := ""
			check_equality ("substring", s.substring (100, 1000), "")
			check_equality ("substring", s.substring (-1, 1), "")
			check_equality ("substring", s.substring (1, 1), "")
			check_equality ("substring", s.substring (1, 0), "")
			s := "12345"
			check_equality ("substring", s.substring (100, 1000), "")
			check_equality ("substring", s.substring (-1, 0), "")
			check_equality ("substring", s.substring (-1, 1), "") -- Current implementation assumes that out-of-range indexes result in empty string
			check_equality ("substring", s.substring (1, 0), "")
			check_equality ("substring", s.substring (1, 5), "12345")
			check_equality ("substring", s.substring (3, 5), "345")
			check_equality ("substring", s.substring (3, 10), "") -- Current implementation assumes that out-of-range indexes result in empty string
			check_equality ("substring", s.substring (-100, 100), "") -- Current implementation assumes that out-of-range indexes result in empty string
		end

	test_substring_index
			-- Perform test on `substring_index'.
		local
			s: STRING_8
		do
			s := "foo"
			check_equality ("substring_index", s.substring_index ("", 1), 1)
			check_equality ("substring_index", s.substring_index ("", 4), 4)

			s := "foobarfoobar"
			check_equality ("substring_index", s.substring_index ("bar", 1), 4)
			check_equality ("substring_index", s.substring_index ("bar", 4), 4)
			check_equality ("substring_index", s.substring_index ("bar", 5), 10)
			check_equality ("substring_index", s.substring_index ("bar", 11), 0)
		end

	test_substring_index_in_bounds
		local
			s: STRING_8
		do
			s := "foo"
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("f", 1, 1), 1)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("f", 1, 3), 1)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("f", 2, 3), 0)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("o", 1, 3), 2)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("o", 2, 3), 2)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("o", 3, 3), 3)

			s := "foobarfoobar"
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 1, 5), 0)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 1, 6), 4)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 3, 6), 4)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 4, 6), 4)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 4, 10), 4)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 5, 6), 0)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 5, 8), 0)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 5, 11), 0)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 5, 12), 10)
			check_equality ("substring_index_in_bounds", s.substring_index_in_bounds ("bar", 11, 12), 0)
		end

	test_tagged_out
		do
			check_boolean ("tagged_out", ("").tagged_out /= Void)
			check_boolean ("tagged_out", not equal (("").tagged_out, ""))
			check_boolean ("tagged_out", ("12345").tagged_out /= Void)
			check_boolean ("tagged_out", not equal (("12345").tagged_out, ""))
		end

	test_three_way_comparison
		local
			s: STRING_8
			p: STRING_8
		do
			s := "12345"
			p := "12345"
			check_boolean ("three_way_comparison", s.three_way_comparison (s) = 0)
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = 0)
			p.append_character ('a')
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = -1)
			check_boolean ("three_way_comparison", p.three_way_comparison (s) = 1)
			p := "12045"
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = 1)
			check_boolean ("three_way_comparison", p.three_way_comparison (s) = -1)
			s := "123"
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = 1)
			check_boolean ("three_way_comparison", p.three_way_comparison (s) = -1)

			s := ""
			p := ""
			check_boolean ("three_way_comparison", s.three_way_comparison (s) = 0)
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = 0)
			p.append_character ('a')
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = -1)
			check_boolean ("three_way_comparison", p.three_way_comparison (s) = 1)
		end

	test_to_c
		do
			if not {PLATFORM}.is_dotnet then
				check_boolean ("to_c", ("").to_c /= Void)
				check_boolean ("to_c", ("123").to_c /= Void)
			end
		end

	test_to_cil
		do
			if {PLATFORM}.is_dotnet then
				check_boolean ("to_cil", ("").to_cil /= Void)
				check_boolean ("to_cil", ("123").to_cil /= Void)
			end
		end

	test_to_double
		do
			check_equality ("to_double", ("0").to_double, {REAL_64} 0.0)
			check_equality ("to_double", ("1").to_double, {REAL_64} 1.0)
			check_equality ("to_double", ("123").to_double, {REAL_64} 123.0)
			check_equality ("to_double", ("0.75").to_double, {REAL_64} 0.75)
			check_equality ("to_double", ("-348.75").to_double, {REAL_64} -348.75)
			check_equality ("to_double", ("62.5e-3").to_double, {REAL_64} 62.5e-3)
			check_equality ("to_double", ("1.e-4").to_double, {REAL_64} 1.e-4)
			check_equality ("to_double", ("1.e-4").to_double, {REAL_64} 0.0001)
			check_equality ("to_double", ("62.5e-3").to_double, {REAL_64} 62.5e-3)
		end

	test_to_integer
		do
				-- Unsigned integers
			check_equality ("to_integer", ("000000").to_integer, 0)
			check_equality ("to_integer", ("000000000000000000001").to_integer, 1)
			check_equality ("to_integer", ("127").to_integer, 127)
			check_equality ("to_integer", ("128").to_integer, 128)
			check_equality ("to_integer", ("255").to_integer, 255)
			check_equality ("to_integer", ("256").to_integer, 256)
			check_equality ("to_integer", ("32767").to_integer, 32767)
			check_equality ("to_integer", ("32768").to_integer, 32768)
			check_equality ("to_integer", ("65535").to_integer, 65535)
			check_equality ("to_integer", ("65536").to_integer, 65536)
			check_equality ("to_integer", ("2147483647").to_integer, 2147483647)
				-- Positive integers
			check_equality ("to_integer", ("+000000").to_integer, 0)
			check_equality ("to_integer", ("+000000000000000000001").to_integer, 1)
			check_equality ("to_integer", ("+127").to_integer, 127)
			check_equality ("to_integer", ("+128").to_integer, 128)
			check_equality ("to_integer", ("+255").to_integer, 255)
			check_equality ("to_integer", ("+256").to_integer, 256)
			check_equality ("to_integer", ("+32767").to_integer, 32767)
			check_equality ("to_integer", ("+32768").to_integer, 32768)
			check_equality ("to_integer", ("+65535").to_integer, 65535)
			check_equality ("to_integer", ("+65536").to_integer, 65536)
			check_equality ("to_integer", ("+2147483647").to_integer, 2147483647)
				-- Negative integers
			check_equality ("to_integer", ("-000000").to_integer, 0)
			check_equality ("to_integer", ("-000000000000000000001").to_integer, -1)
			check_equality ("to_integer", ("-127").to_integer, -127)
			check_equality ("to_integer", ("-128").to_integer, -128)
			check_equality ("to_integer", ("-255").to_integer, -255)
			check_equality ("to_integer", ("-256").to_integer, -256)
			check_equality ("to_integer", ("-32767").to_integer, -32767)
			check_equality ("to_integer", ("-32768").to_integer, -32768)
			check_equality ("to_integer", ("-65535").to_integer, -65535)
			check_equality ("to_integer", ("-65536").to_integer, -65536)
			check_equality ("to_integer", ("-2147483647").to_integer, -2147483647)
			check_equality ("to_integer", ("-2147483648").to_integer, -2147483648)
		end

	test_to_integer_64
		do
				-- Unsigned integers
			check_equality ("to_integer_64", ("000000").to_integer_64, {INTEGER_64} 0)
			check_equality ("to_integer_64", ("000000000000000000001").to_integer_64, {INTEGER_64} 1)
			check_equality ("to_integer_64", ("127").to_integer_64, {INTEGER_64} 127)
			check_equality ("to_integer_64", ("128").to_integer_64, {INTEGER_64} 128)
			check_equality ("to_integer_64", ("255").to_integer_64, {INTEGER_64} 255)
			check_equality ("to_integer_64", ("256").to_integer_64, {INTEGER_64} 256)
			check_equality ("to_integer_64", ("32767").to_integer_64, {INTEGER_64} 32767)
			check_equality ("to_integer_64", ("32768").to_integer_64, {INTEGER_64} 32768)
			check_equality ("to_integer_64", ("65535").to_integer_64, {INTEGER_64} 65535)
			check_equality ("to_integer_64", ("65536").to_integer_64, {INTEGER_64} 65536)
			check_equality ("to_integer_64", ("2147483647").to_integer_64, {INTEGER_64} 2147483647)
			check_equality ("to_integer_64", ("2147483648").to_integer_64, {INTEGER_64} 2147483648)
			check_equality ("to_integer_64", ("9223372036854775807").to_integer_64, {INTEGER_64} 0x7FFF_FFFF_FFFF_FFFF)
				-- Positive integers
			check_equality ("to_integer_64", ("+000000").to_integer_64, {INTEGER_64} 0)
			check_equality ("to_integer_64", ("+000000000000000000001").to_integer_64, {INTEGER_64} 1)
			check_equality ("to_integer_64", ("+127").to_integer_64, {INTEGER_64} 127)
			check_equality ("to_integer_64", ("+128").to_integer_64, {INTEGER_64} 128)
			check_equality ("to_integer_64", ("+255").to_integer_64, {INTEGER_64} 255)
			check_equality ("to_integer_64", ("+256").to_integer_64, {INTEGER_64} 256)
			check_equality ("to_integer_64", ("+32767").to_integer_64, {INTEGER_64} 32767)
			check_equality ("to_integer_64", ("+32768").to_integer_64, {INTEGER_64} 32768)
			check_equality ("to_integer_64", ("+65535").to_integer_64, {INTEGER_64} 65535)
			check_equality ("to_integer_64", ("+65536").to_integer_64, {INTEGER_64} 65536)
			check_equality ("to_integer_64", ("+2147483647").to_integer_64, {INTEGER_64} 2147483647)
			check_equality ("to_integer_64", ("+2147483648").to_integer_64, {INTEGER_64} 2147483648)
			check_equality ("to_integer_64", ("+9223372036854775807").to_integer_64, {INTEGER_64} 0x7FFF_FFFF_FFFF_FFFF)
				-- Negative integers
			check_equality ("to_integer_64", ("-000000").to_integer_64, {INTEGER_64} 0)
			check_equality ("to_integer_64", ("-000000000000000000001").to_integer_64, {INTEGER_64} -1)
			check_equality ("to_integer_64", ("-127").to_integer_64, {INTEGER_64} -127)
			check_equality ("to_integer_64", ("-128").to_integer_64, {INTEGER_64} -128)
			check_equality ("to_integer_64", ("-255").to_integer_64, {INTEGER_64} -255)
			check_equality ("to_integer_64", ("-256").to_integer_64, {INTEGER_64} -256)
			check_equality ("to_integer_64", ("-32767").to_integer_64, {INTEGER_64} -32767)
			check_equality ("to_integer_64", ("-32768").to_integer_64, {INTEGER_64} -32768)
			check_equality ("to_integer_64", ("-65535").to_integer_64, {INTEGER_64} -65535)
			check_equality ("to_integer_64", ("-65536").to_integer_64, {INTEGER_64} -65536)
			check_equality ("to_integer_64", ("-2147483647").to_integer_64, {INTEGER_64} -2147483647)
			check_equality ("to_integer_64", ("-2147483648").to_integer_64, {INTEGER_64} -2147483648)
			check_equality ("to_integer_64", ("-9223372036854775807").to_integer_64, {INTEGER_64} -0x7FFF_FFFF_FFFF_FFFF)
			check_equality ("to_integer_64", ("-9223372036854775808").to_integer_64, {INTEGER_64} -0x8000_0000_0000_0000)
		end

	test_to_lower
		local
			s: STRING_8
		do
			s := ""
			s.to_lower
			check_equality ("to_lower", s, "")
			s := "123ABC456"
			s.to_lower
			check_equality ("to_lower", s, "123abc456")
			s.to_lower
			check_equality ("to_lower", s, "123abc456")
			s := "ABC %T%U %F DEF"
			s.to_lower
			check_equality ("to_lower", s, "abc %T%U %F def")
			s.to_lower
			check_equality ("to_lower", s, "abc %T%U %F def")
		end

	test_to_real
		do
			check_equality ("to_real", ("0").to_real, {REAL_32} 0.0)
			check_equality ("to_real", ("1").to_real, {REAL_32} 1.0)
			check_equality ("to_real", ("123").to_real, {REAL_32} 123.0)
			check_equality ("to_real", ("0.75").to_real, {REAL_32} 0.75)
			check_equality ("to_real", ("-348.75").to_real, {REAL_32} -348.75)
			check_equality ("to_real", ("62.5e-3").to_real, {REAL_32} 62.5e-3)
		end

	test_to_upper
		local
			s: STRING_8
		do
			s := ""
			s.to_upper
			check_equality ("to_upper", s, "")
			s := "123abc456"
			s.to_upper
			check_equality ("to_upper", s, "123ABC456")
			s.to_upper
			check_equality ("to_upper", s, "123ABC456")
			s := "abc %T%U %F def"
			s.to_upper
			check_equality ("to_upper", s, "ABC %T%U %F DEF")
			s.to_upper
			check_equality ("to_upper", s, "ABC %T%U %F DEF")
		end

	test_twin
		local
			s: STRING_8
		do
			s := ""
			check_equality ("twin", s.twin, "")
			check_boolean ("twin", s /= s.twin)
			check_boolean ("twin", not s.shared_with (s.twin))
			s := "12345"
			check_equality ("twin", s.twin, "12345")
			check_boolean ("twin", s /= s.twin)
			check_boolean ("twin", not s.shared_with (s.twin))
		end

	test_valid_index
		do
			check_boolean ("valid_index", not ("").valid_index (-1))
			check_boolean ("valid_index", not ("").valid_index (0))
			check_boolean ("valid_index", not ("").valid_index (1))
			check_boolean ("valid_index", not ("").valid_index (2))
			check_boolean ("valid_index", not ("123").valid_index (-1))
			check_boolean ("valid_index", not ("123").valid_index (0))
			check_boolean ("valid_index", ("123").valid_index (1))
			check_boolean ("valid_index", ("123").valid_index (2))
			check_boolean ("valid_index", ("123").valid_index (3))
			check_boolean ("valid_index", not ("123").valid_index (4))
		end

	test_wipe_out
		local
			s: STRING_8
		do
			s := ""
			s.wipe_out
			check_equality ("wipe_out", s, "")
			s := "12345"
			s.wipe_out
			check_equality ("wipe_out", s, "")
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

