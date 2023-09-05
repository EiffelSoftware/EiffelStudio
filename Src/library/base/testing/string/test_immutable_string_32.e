class
	TEST_IMMUTABLE_STRING_32

inherit
	STRING_SET

feature -- Test

	test_as_lower
		local
			s, t: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("ABcd EF gh I 123 ;Ü")
			t := s.as_lower
			check_string_equality ("as_lower", t, "abcd ef gh i 123 ;ü")
			check_boolean ("as_lower", t /= s)
		end

	test_as_upper
		local
			s, t: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("ABcd EF gh I 123 ;ü")
			t := s.as_upper
			check_string_equality ("as_upper", t, "ABCD EF GH I 123 ;Ü")
			check_boolean ("as_upper", t /= s)
		end

	test_ends_with
		local
			s: IMMUTABLE_STRING_32
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

	test_fuzzy_index
		local
			s: IMMUTABLE_STRING_32
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

	test_has
		local
			s: IMMUTABLE_STRING_32
		do
			create s.make (10)
			check_boolean ("has", not s.has ('c'))
			check_boolean ("has", not s.has ('%U'))

			s := "1234c1234"
			check_boolean ("has", s.has ('c'))
			check_boolean ("has", not s.has ('9'))

			s := ""
			check_boolean ("has", not s.has ('c'))
			check_boolean ("has", not s.has ('9'))

 			s := "1234c1234"
			s := s.shared_substring (2, 4)
 			check_boolean ("has", not s.has ('1'))
 			check_boolean ("has", not s.has ('c'))
 			check_boolean ("has", s.has ('2'))
 			check_boolean ("has", s.has ('3'))
 			check_boolean ("has", s.has ('4'))

 			s := s.shared_substring (2, 1)
 			check_boolean ("has", not s.has ('2'))
 			check_boolean ("has", not s.has ('3'))
 			check_boolean ("has", not s.has ('4'))
 		end

 	test_hash_code
 		local
 			s: IMMUTABLE_STRING_32
 			l_val: INTEGER
 		do
			s := "12345"
 			l_val := s.hash_code

 			s := "012345"
 			s := s.shared_substring (2, 6)
			check_boolean ("hash_code", l_val = s.hash_code)
		end

	test_has_substring
		local
			s: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("!23")
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
			s: IMMUTABLE_STRING_32
			i: INTEGER
		do
			create s.make_from_string ("1234567890")
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

 				-- New string now "567890"
 			s := s.shared_substring (5, 10)
 			i := s.index_of ('x', 1)
 			check_equality ("index_of", i , 0)

 			i := s.index_of ('1', 1)
 			check_equality ("index_of", i , 0)

 			i := s.index_of ('2', 1)
 			check_equality ("index_of", i , 0)

 			i := s.index_of ('9', 5)
			check_equality ("index_of", i , 5)
		end

	test_is_boolean
		local
			s: IMMUTABLE_STRING_32
		do
			s := "true"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1true"
			s := s.shared_substring (2, 5)
			check_boolean ("is_boolean", s.is_boolean)

			s := "    true   "
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1    true   "
			s := s.shared_substring (2, 12)
			check_boolean ("is_boolean", not s.is_boolean)

			s := "True"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1True"
			s := s.shared_substring (2, 5)
			check_boolean ("is_boolean", s.is_boolean)

			s := "false"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1false"
			s := s.shared_substring (2, 6)
			check_boolean ("is_boolean", s.is_boolean)

			s := "    false   "
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1    false   "
			s := s.shared_substring (2, 13)
			check_boolean ("is_boolean", not s.is_boolean)

			s := "False"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1False"
			s := s.shared_substring (2, 6)
			check_boolean ("is_boolean", s.is_boolean)

			s := "TRUE"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1TRUE"
			s := s.shared_substring (2, 5)
			check_boolean ("is_boolean", s.is_boolean)

			s := "FALSE"
			check_boolean ("is_boolean", s.is_boolean)
			s := "1FALSE"
			s := s.shared_substring (2, 6)
			check_boolean ("is_boolean", s.is_boolean)

			s := "Tru"
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1Tru"
			s := s.shared_substring (2, 4)
			check_boolean ("is_boolean", not s.is_boolean)

			s := "tru"
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1tru"
			s := s.shared_substring (2, 4)
			check_boolean ("is_boolean", not s.is_boolean)

			s := "Fal"
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1Fal"
			s := s.shared_substring (2, 4)
			check_boolean ("is_boolean", not s.is_boolean)

			s := "fal"
			check_boolean ("is_boolean", not s.is_boolean)
			s := "1fal"
			s := s.shared_substring (2, 4)
			check_boolean ("is_boolean", not s.is_boolean)
		end

	test_is_case_insensitive_equal
		local
			s: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("12345")
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

			s := "ABCdef"
			s := s.shared_substring (4, 6)
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("DEF"))
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
			s: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("Fds")
			check_boolean ("is_empty", not s.is_empty)

			create s.make (10)
			check_boolean ("is_empty", s.is_empty)

			check_boolean ("is_empty", ("").is_empty)
		end

	test_is_equal
		local
			s: IMMUTABLE_STRING_32
		do
			create s.make_from_string ("12345")
			check_boolean ("is_equal", s.is_equal (s))
			check_boolean ("is_equal", s.is_equal ("12345"))
			check_boolean ("is_equal", not s.is_equal ("123456"))
			check_boolean ("is_equal", not s.is_equal ("1234"))

			s := "abcdef"
			check_boolean ("is_equal", not s.is_equal ("ABCDEF"))

			check_boolean ("is_equal", not s.is_equal (""))
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

	test_is_valid_as_string_8
		local
			s: IMMUTABLE_STRING_32
			s32: STRING_32
		do
			s := "12345"
			check_boolean ("is_valid_as_string_8", s.is_valid_as_string_8)

			s32 := "12345"
			s32.put ({CHARACTER_32} '%/0x1111/', 1)
			s := s32
			check_boolean ("is_valid_as_string_8", not s.is_valid_as_string_8)
			s := s.shared_substring (2, 5)
			check_boolean ("is_valid_as_string_8", s.is_valid_as_string_8)
		end

	test_infix_greater
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean (">", not (s > s))
			check_boolean (">", not (s > p))
			p := "12345a"
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
			p := "a"
			check_boolean (">", not (s > p))
			check_boolean (">", p > s)
		end

	test_infix_greater_or_equal
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean (">=", s >= s)
			check_boolean (">=", s >= p)
			p := "12345a"
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
			p := "a"
			check_boolean (">=", not (s >= p))
			check_boolean (">=", p >= s)
		end

	test_infix_less
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean ("<", not (s < s))
			check_boolean ("<", not (s < p))
			p := "12345a"
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
			p := "a"
			check_boolean ("<", s < p)
			check_boolean ("<", not (p < s))
		end

	test_infix_less_or_equal
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean ("<=", s <= s)
			check_boolean ("<=", s <= p)
			p := "12345a"
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
			p := "a"
			check_boolean ("<=", s <= p)
			check_boolean ("<=", not (p <= s))
		end

	test_infix_plus
		local
			s: IMMUTABLE_STRING_32
		do
			s := "12345"
			check_string_equality ("+", s + s, "1234512345")
			check_string_equality ("+", "" + "", "")
			check_string_equality ("+", "" + s, "12345")
			check_string_equality ("+", s + "", "12345")
		end

	test_item
		local
			s: IMMUTABLE_STRING_32
		do
			s := "12345"
			check_boolean ("item", s.item (1) = '1')
			check_boolean ("item", s.item (2) = '2')
			check_boolean ("item", s.item (3) = '3')
			check_boolean ("item", s.item (4) = '4')
			check_boolean ("item", s.item (5) = '5')

			s := s.shared_substring (2, 4)
			check_boolean ("item", s.item (1) = '2')
			check_boolean ("item", s.item (2) = '3')
			check_boolean ("item", s.item (3) = '4')
		end

	test_code
		local
			s: IMMUTABLE_STRING_32
		do
			s := "12345"
			check_boolean ("code", s.code (1) = 49)
			check_boolean ("code", s.code (2) = 50)
			check_boolean ("code", s.code (3) = 51)
			check_boolean ("code", s.code (4) = 52)
			check_boolean ("code", s.code (5) = 53)

			s := s.shared_substring (2, 4)
			check_boolean ("code", s.code (1) = 50)
			check_boolean ("code", s.code (2) = 51)
			check_boolean ("code", s.code (3) = 52)
		end

	test_last_index_of
		local
			s: IMMUTABLE_STRING_32
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

 			s := "ba"
 			s := s.shared_substring (2, 2)
 			check_equality ("last_boolean", s.last_index_of ('a', 1), 1)
 			check_equality ("last_boolean", s.last_index_of ('b', 1), 0)

 			s := "0001234554321"
 			s := s.shared_substring (4, 13)
 			check_equality ("last_boolean", s.last_index_of ('3', 10), 8)
 			check_equality ("last_boolean", s.last_index_of ('3', 5), 3)
 			check_equality ("last_boolean", s.last_index_of ('3', 3), 3)
 			check_equality ("last_boolean", s.last_index_of ('3', 2), 0)
 			check_equality ("last_boolean", s.last_index_of ('X', 10), 0)
		end

	test_linear_representation
		local
			s: IMMUTABLE_STRING_32
			l_c: LINEAR [CHARACTER_32]
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
			s: IMMUTABLE_STRING_32
		do
			s := "1234567890"

			create s.make (2)
			check_boolean ("make", s.is_empty)
			check_boolean ("make", s.count = 0)
			check_boolean ("make", s.capacity >= 2)
		end

	test_make_empty
		local
			s: IMMUTABLE_STRING_32
		do
			create s.make_empty
			check_boolean ("make_empty", s.is_empty)
			check_boolean ("make_empty", s.count = 0)
			check_boolean ("make_empty", s.capacity >= 0)
		end

	test_make_filled
		local
			s: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
		do
			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_equal ("0123456"))

			create l_ptr.make_from_array ({ARRAY [NATURAL_8]} << 0, 48, 49, 50, 51, 52, 53, 54, 0 >>)
			create s.make_from_c (l_ptr.item)
			check_boolean ("make_from_c", s.is_empty)
		end

	test_make_from_string
		local
			s, p: STRING_32
		do
			p := "12345"
			create s.make_from_string (p)
			check_boolean ("make_from_string", s.is_equal ("12345"))
			check_boolean ("make_from_string", s.area /= p.area)
		end

	test_max
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean ("max", s.max (s) = s)
			check_boolean ("max", s.max (p) = s)
			check_boolean ("max", p.max (s) = p)
			p := "12345a"
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
			p := "a"
			check_boolean ("max", s.max (p) = p)
			check_boolean ("max", p.max (s) = p)
		end

	test_min
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean ("min", s.min (s) = s)
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = p)
			p := "12345a"
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
			p := "a"
			check_boolean ("min", s.min (p) = s)
			check_boolean ("min", p.min (s) = s)
		end

	test_mirrored
		local
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := ""
			p := s.mirrored
			check_string_equality ("mirrored", s, "")
			check_string_equality ("mirrored", p, "")
			s := "a"
			p := s.mirrored
			check_string_equality ("mirrored", s, "a")
			check_string_equality ("mirrored", p, "a")
			s := "ab"
			p := s.mirrored
			check_string_equality ("mirrored", s, "ab")
			check_string_equality ("mirrored", p, "ba")
			s := "abc"
			p := s.mirrored
			check_string_equality ("mirrored", s, "abc")
			check_string_equality ("mirrored", p, "cba")
			s := "abcd"
			p := s.mirrored
			check_string_equality ("mirrored", s, "abcd")
			check_string_equality ("mirrored", p, "dcba")
			s := "abcde"
			p := s.mirrored
			check_string_equality ("mirrored", s, "abcde")
			check_string_equality ("mirrored", p, "edcba")
		end

	test_occurrences
		local
			s: IMMUTABLE_STRING_32
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

 			s := "2211111122"
 			s := s.shared_substring (3, 5)
 			check_boolean ("occurrences", s.occurrences ('2') = 0)
 			check_boolean ("occurrences", s.occurrences ('1') = 3)
		end

	test_out
		do
			check_string_equality ("out", ("").out, "")
			check_string_equality ("out", ("1").out, "1")
			check_string_equality ("out", ("12").out, "12")
			check_string_equality ("out", ("123").out, "123")
			check_string_equality ("out", ("1234").out, "1234")
			check_string_equality ("out", ("12345").out, "12345")
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
			check_string_equality ("plus", is_32 + is_32, "1234512345")
			check_string_equality ("plus", is_32 + s_32, "1234512345")
			check_string_equality ("plus", is_32 + is_8.as_string_32, "1234567890")
			check_string_equality ("plus", is_32 + s_8, "1234567890")
			check_string_equality ("plus", is_32 + "", "12345")

			is_32 := ""
			check_string_equality ("plus", is_32 + is_32, "")
			check_string_equality ("plus", is_32 + s_32, "12345")
			check_string_equality ("plus", is_32 + is_8.as_string_32, "67890")
			check_string_equality ("plus", is_32 + s_8, "67890")
			check_string_equality ("plus", is_32 + "", "")

			s_32 := ""
			is_8 := ""
			s_8 := ""
			check_string_equality ("plus", is_32 + is_32, "")
			check_string_equality ("plus", is_32 + s_32, "")
			check_string_equality ("plus", is_32 + is_8.as_string_32, "")
			check_string_equality ("plus", is_32 + s_8, "")
			check_string_equality ("plus", is_32 + "", "")
		end

	test_prunable
		do
			check_boolean ("prunable", ("").prunable)
			check_boolean ("prunable", ("%U").prunable)
			check_boolean ("prunable", ("abc").prunable)
		end

	test_resizable
		do
			check_boolean ("resizable", ("").resizable)
			check_boolean ("resizable", ("1").resizable)
			check_boolean ("resizable", ("12").resizable)
			check_boolean ("resizable", ("123").resizable)
		end

	test_same_string
		local
			s: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
			o: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
			o: IMMUTABLE_STRING_32
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
			check_boolean ("same_type", (create {IMMUTABLE_STRING_32}.make_empty).same_type (create {IMMUTABLE_STRING_32}.make_empty))
			check_boolean ("same_type", (create {IMMUTABLE_STRING_32}.make_empty).same_type (create {IMMUTABLE_STRING_32}.make (10)))
			check_boolean ("same_type", ("").same_type ("12345"))
		end

	test_split
		local
			s: IMMUTABLE_STRING_32
			l: LIST [IMMUTABLE_STRING_32]
		do
			s := ""
			l := s.split ('%U')
			check_equality ("split", l.count, 1)
			check_string_equality ("split", l [1], "")
			s := "1234543212345"
			l := s.split ('%U')
			check_equality ("split", l.count, 1)
			check_string_equality ("split", l [1], "1234543212345")
			l := s.split ('6')
			check_equality ("split", l.count, 1)
			check_string_equality ("split", l [1], "1234543212345")
			l := s.split ('1')
			check_equality ("split", l.count, 3)
			check_string_equality ("split", l [1], "")
			check_string_equality ("split", l [2], "2345432")
			check_string_equality ("split", l [3], "2345")
			l := s.split ('2')
			check_equality ("split", l.count, 4)
			check_string_equality ("split", l [1], "1")
			check_string_equality ("split", l [2], "34543")
			check_string_equality ("split", l [3], "1")
			check_string_equality ("split", l [4], "345")
			l := s.split ('5')
			check_equality ("split", l.count, 3)
			check_string_equality ("split", l [1], "1234")
			check_string_equality ("split", l [2], "4321234")
			check_string_equality ("split", l [3], "")
		end

	test_starts_with
		local
			s: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
		do
			s := ""
			check_boolean ("string", s.string /= s)
			check_string_equality ("string", s.string, s)
			check_boolean ("string", not s.string.shared_with (s))
			s := "12345"
			check_boolean ("string", s.string /= s)
			check_string_equality ("string", s.string, s)
			check_boolean ("string", not s.string.shared_with (s))
		end

 	test_shared_substring
 		local
 			s: IMMUTABLE_STRING_32
 		do
 			s := ""
 			check_string_equality ("shared_substring", s.shared_substring (100, 1000), "")
 			check_string_equality ("shared_substring", s.shared_substring (-1, 1), "")
 			check_string_equality ("shared_substring", s.shared_substring (1, 1), "")
 			check_string_equality ("shared_substring", s.shared_substring (1, 0), "")

 			s := "12345"
 			check_string_equality ("shared_substring", s.shared_substring (100, 1000), "")
 			check_string_equality ("shared_substring", s.shared_substring (-1, 0), "")
 			check_string_equality ("shared_substring", s.shared_substring (-1, 1), "") -- Current implementation assumes that out-of-range indexes result in empty string
 			check_string_equality ("shared_substring", s.shared_substring (1, 0), "")
 			check_string_equality ("shared_substring", s.shared_substring (1, 5), "12345")
 			check_string_equality ("shared_substring", s.shared_substring (3, 5), "345")
 			check_string_equality ("shared_substring", s.shared_substring (3, 10), "") -- Current implementation assumes that out-of-range indexes result in empty string
 			check_string_equality ("shared_substring", s.shared_substring (-100, 100), "") -- Current implementation assumes that out-of-range indexes result in empty string


 			s := "1234567890987654321"
 			s := s.shared_substring (11, 19)
 			check_string_equality ("shared_substring", s, "987654321")
 			s := s.shared_substring (5, 9)
 			check_string_equality ("shared_substring", s, "54321")
 			s := s.shared_substring (2, 4)
 			check_string_equality ("shared_substring", s, "432")
 			s := s.shared_substring (2, 3)
 			check_string_equality ("shared_substring", s, "32")
 			s := s.shared_substring (2, 2)
 			check_string_equality ("shared_substring", s, "2")
 		end

	test_shared_substring_comparison
		local
			csv, foreground, background: IMMUTABLE_STRING_32; comma_index: INTEGER
		do
			create csv.make_from_string ({STRING_32} "foreground, background")
			comma_index := csv.index_of (',', 1)
			foreground := csv.shared_substring (1, comma_index - 1)
			background := csv.shared_substring (comma_index + 2, csv.count)
			assert ("different strings", not foreground.same_string (background))
		end

	test_substring
		local
			s: IMMUTABLE_STRING_32
		do
			s := ""
			check_string_equality ("substring", s.substring (100, 1000), "")
			check_string_equality ("substring", s.substring (-1, 1), "")
			check_string_equality ("substring", s.substring (1, 1), "")
			check_string_equality ("substring", s.substring (1, 0), "")
			s := "12345"
			check_string_equality ("substring", s.substring (100, 1000), "")
			check_string_equality ("substring", s.substring (-1, 0), "")
			check_string_equality ("substring", s.substring (-1, 1), "") -- Current implementation assumes that out-of-range indexes result in empty string
			check_string_equality ("substring", s.substring (1, 0), "")
			check_string_equality ("substring", s.substring (1, 5), "12345")
			check_string_equality ("substring", s.substring (3, 5), "345")
			check_string_equality ("substring", s.substring (3, 10), "") -- Current implementation assumes that out-of-range indexes result in empty string
			check_string_equality ("substring", s.substring (-100, 100), "") -- Current implementation assumes that out-of-range indexes result in empty string
		end

	test_substring_index
			-- Perform test on `substring_index'.
		local
			s: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
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
			s: IMMUTABLE_STRING_32
			p: IMMUTABLE_STRING_32
		do
			s := "12345"
			p := "12345"
			check_boolean ("three_way_comparison", s.three_way_comparison (s) = 0)
			check_boolean ("three_way_comparison", s.three_way_comparison (p) = 0)
			p := "12345a"
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
			p := "a"
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

	test_to_real
		do
			check_equality ("to_real", ("0").to_real, {REAL_32} 0.0)
			check_equality ("to_real", ("1").to_real, {REAL_32} 1.0)
			check_equality ("to_real", ("123").to_real, {REAL_32} 123.0)
			check_equality ("to_real", ("0.75").to_real, {REAL_32} 0.75)
			check_equality ("to_real", ("-348.75").to_real, {REAL_32} -348.75)
			check_equality ("to_real", ("62.5e-3").to_real, {REAL_32} 62.5e-3)
		end

	test_twin
		local
			s: IMMUTABLE_STRING_32
		do
			s := ""
			check_string_equality ("twin", s.twin, "")
			check_boolean ("twin", s /= s.twin)
			check_boolean ("twin", s.shared_with (s.twin))
			s := "12345"
			check_string_equality ("twin", s.twin, "12345")
			check_boolean ("twin", s /= s.twin)
			check_boolean ("twin", s.shared_with (s.twin))
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

	test_manifest
		local
			s: READABLE_STRING_GENERAL
		do
			s := {STRING_32} "for-all=∀"
			check_string_equality ("manifest immutable_string_32", s, {IMMUTABLE_STRING_32} "for-all=∀")
			check_string_equality ("once manifest immutable_string_32", s, once {IMMUTABLE_STRING_32} "for-all=∀")
			check_string_equality ("constant immutable_string_32", s, immutable_string_32_constant)
			s := {STRING_32} "for-all%U∀"
			check_string_equality ("manifest binary immutable_string_32", s, {IMMUTABLE_STRING_32} "for-all%U∀")
		end

feature -- Constants

	immutable_string_32_constant: IMMUTABLE_STRING_32 = "for-all=∀"


note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
