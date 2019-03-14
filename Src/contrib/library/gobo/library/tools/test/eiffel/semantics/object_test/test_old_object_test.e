note

	description:

		"Test semantics of object-tests, using the old syntax"

	copyright: "Copyright (c) 2008-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_OLD_OBJECT_TEST

inherit

	TS_TEST_CASE

create

	make_default

feature -- Test

	test_and_then
			-- Test scope of object-test local when part of a semi-strict term of
			-- a conjunctive expression. ECMA-367-2, 8.24.5-1.
		local
			s: detachable STRING
		do
			s := "gobo"
			assert ("and_then1", {x1: STRING} s and then x1.count = 4)
			assert ("and_then2", {x2: STRING} s and then 1 /= 2 and then not x2.is_empty)
			assert ("and_then3", ({x3: STRING} s and 1 = 1) and then not x3.is_empty)
			assert ("and_then4", not (not {x4: STRING} s or 1 /= 1) and then not x4.is_empty)
		end

	test_implies
			-- Test scope of object-test local when part of a term of
			-- an implicative expression. ECMA-367-2, 8.24.5-2.
		local
			s: detachable STRING
		do
			s := "gobo"
			assert ("implies1", {x1: STRING} s implies x1.count = 4)
			assert ("implies2", {x2: STRING} s implies 1 /= 2 and not x2.is_empty)
			assert ("implies3", ({x3: STRING} s and 1 = 1) implies not x3.is_empty)
			assert ("implies4", not (not {x4: STRING} s or 1 /= 1) implies not x4.is_empty)
		end

	test_or_else
			-- Test scope of object-test local when part of a semi-strict term of
			-- a disjunctive expression. ECMA-367-2, 8.24.5-3.
		local
			s: detachable STRING
		do
			s := "gobo"
			assert ("or_else1", not {x1: STRING} s or else x1.count = 4)
			assert ("or_else2", not {x2: STRING} s or else 1 = 2 or else not x2.is_empty)
			assert ("or_else3", not ({x3: STRING} s and 1 = 1) or else not x3.is_empty)
			assert ("or_else4", (not {x4: STRING} s or 1 /= 1) or else not x4.is_empty)
		end

	test_if
			-- Test scope of object-test local when part of conditional of if instruction.
			-- ECMA-367-2, 8.24.5-4 and 8.24.5-5.
		local
			l_foo: detachable STRING
			l_gobo: detachable STRING
		do
			l_foo := "foo"
			l_gobo := "gobo"
			if {x1: STRING} l_foo then
				assert ("if1", x1.count = 3)
			else
				assert ("if2", False)
			end
			if not {x2: STRING} l_gobo then
				assert ("if3", False)
			else
				assert ("if4", x2.count = 4)
			end
		end

	test_elseif
			-- Test scope of object-test local when part of conditional of elseif branches.
			-- ECMA-367-2, 8.24.5-4 and 8.24.5-5.
		local
			l_foo: detachable STRING
			l_barbar: detachable STRING
			l_gobo: detachable STRING
		do
			l_foo := "foo"
			l_barbar := "barbar"
			l_gobo := "gobo"
			if not {x1: STRING} l_foo then
				assert ("elseif1", False)
			elseif not {x2: STRING} l_barbar then
				assert ("elseif2", False)
			elseif {x3: STRING} l_gobo then
				assert ("elseif3", x1.count = 3)
				assert ("elseif4", x2.count = 6)
				assert ("elseif5", x3.count = 4)
			else
				assert ("elseif6", False)
			end
			if not {x4: STRING} l_foo then
				assert ("elseif7", False)
			elseif not {x5: STRING} l_barbar then
				assert ("elseif8", False)
			else
				assert ("elseif9", x4.count = 3)
				assert ("elseif10", x5.count = 6)
			end
		end

	test_loop
			-- Test scope of object-test local when part of exit clause of loop instruction.
			-- ECMA-367-2, 8.24.5-6.
		local
			f: STRING
			s: detachable STRING
		do
			s := "gobo"
			from
				f := "foo"
			until
				not {x1: STRING} f or not {x2: STRING} s
			loop
				assert ("loop1", x1.count = 3)
				assert ("loop2", x2.count = 4)
				f := Void
			end
			from
				f := "foo"
			until
				not ({x3: STRING} f and {x4: STRING} s)
			loop
				assert ("loop3", x3.count = 3)
				assert ("loop4", x4.count = 4)
				f := Void
			end
		end

end
