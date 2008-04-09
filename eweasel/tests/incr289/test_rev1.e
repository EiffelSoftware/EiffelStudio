class
	TEST

create
	make

feature

	make is
		do
			test_tilde
			test_not_tilde
		end

	test_tilde is
		local
			i1: TEST1 [INTEGER_8]
			i2: TEST1 [INTEGER_16]
			i4: TEST1 [INTEGER_32]
			i8: TEST1 [INTEGER_64]
			n1: TEST1 [NATURAL_8]
			n2: TEST1 [NATURAL_16]
			n4: TEST1 [NATURAL_32]
			n8: TEST1 [NATURAL_64]
			c1: TEST1 [CHARACTER_8]
			c4: TEST1 [CHARACTER_32]
			p: TEST1 [POINTER]
			b: TEST1 [BOOLEAN]
			r4: TEST1 [REAL_32]
			r8: TEST1 [REAL_64]
			a: TEST1 [ANY]
		do
			test_true_boolean (i1.tilde_compare (5, 5))
			test_false_boolean (i1.tilde_compare (4, 5))

			test_true_boolean (i2.tilde_compare (5, 5))
			test_false_boolean (i2.tilde_compare (4, 5))

			test_true_boolean (i4.tilde_compare (5, 5))
			test_false_boolean (i4.tilde_compare (4, 5))

			test_true_boolean (i8.tilde_compare (5, 5))
			test_false_boolean (i8.tilde_compare (4, 5))

			test_true_boolean (n1.tilde_compare (5, 5))
			test_false_boolean (n1.tilde_compare (4, 5))

			test_true_boolean (n2.tilde_compare (5, 5))
			test_false_boolean (n2.tilde_compare (4, 5))

			test_true_boolean (n4.tilde_compare (5, 5))
			test_false_boolean (n4.tilde_compare (4, 5))

			test_true_boolean (n8.tilde_compare (5, 5))
			test_false_boolean (n8.tilde_compare (4, 5))

			test_true_boolean (c1.tilde_compare ('a', 'a'))
			test_false_boolean (c1.tilde_compare ('a', 'b'))

			test_true_boolean (c4.tilde_compare ('a', 'a'))
			test_false_boolean (c4.tilde_compare ('a', 'b'))

			test_true_boolean (p.tilde_compare (default_pointer + 1, default_pointer + 1))
			test_false_boolean (p.tilde_compare (default_pointer + 1, default_pointer + 2))

			test_true_boolean (b.tilde_compare (True, True))
			test_true_boolean (b.tilde_compare (False, False))
			test_false_boolean (b.tilde_compare (True, False))
			test_false_boolean (b.tilde_compare (False, True))

			test_true_boolean (r4.tilde_compare (4.5, 4.5))
			test_false_boolean (r4.tilde_compare (4.5, 4.8))

			test_true_boolean (r8.tilde_compare (4.5, 4.5))
			test_false_boolean (r8.tilde_compare (4.5, 4.8))

			test_true_boolean (a.tilde_compare ("My", "My"))
			test_false_boolean (a.tilde_compare ("My", "My2"))
			test_false_boolean (a.tilde_compare (io, "My"))
		end

	test_not_tilde is
		local
			i1: TEST1 [INTEGER_8]
			i2: TEST1 [INTEGER_16]
			i4: TEST1 [INTEGER_32]
			i8: TEST1 [INTEGER_64]
			n1: TEST1 [NATURAL_8]
			n2: TEST1 [NATURAL_16]
			n4: TEST1 [NATURAL_32]
			n8: TEST1 [NATURAL_64]
			c1: TEST1 [CHARACTER_8]
			c4: TEST1 [CHARACTER_32]
			p: TEST1 [POINTER]
			b: TEST1 [BOOLEAN]
			r4: TEST1 [REAL_32]
			r8: TEST1 [REAL_64]
			a: TEST1 [ANY]
		do
			test_false_boolean (i1.not_tilde_compare (5, 5))
			test_true_boolean (i1.not_tilde_compare (4, 5))

			test_false_boolean (i2.not_tilde_compare (5, 5))
			test_true_boolean (i2.not_tilde_compare (4, 5))

			test_false_boolean (i4.not_tilde_compare (5, 5))
			test_true_boolean (i4.not_tilde_compare (4, 5))

			test_false_boolean (i8.not_tilde_compare (5, 5))
			test_true_boolean (i8.not_tilde_compare (4, 5))

			test_false_boolean (n1.not_tilde_compare (5, 5))
			test_true_boolean (n1.not_tilde_compare (4, 5))

			test_false_boolean (n2.not_tilde_compare (5, 5))
			test_true_boolean (n2.not_tilde_compare (4, 5))

			test_false_boolean (n4.not_tilde_compare (5, 5))
			test_true_boolean (n4.not_tilde_compare (4, 5))

			test_false_boolean (n8.not_tilde_compare (5, 5))
			test_true_boolean (n8.not_tilde_compare (4, 5))

			test_false_boolean (c1.not_tilde_compare ('a', 'a'))
			test_true_boolean (c1.not_tilde_compare ('a', 'b'))

			test_false_boolean (c4.not_tilde_compare ('a', 'a'))
			test_true_boolean (c4.not_tilde_compare ('a', 'b'))

			test_false_boolean (p.not_tilde_compare (default_pointer + 1, default_pointer + 1))
			test_true_boolean (p.not_tilde_compare (default_pointer + 1, default_pointer + 2))

			test_false_boolean (b.not_tilde_compare (True, True))
			test_false_boolean (b.not_tilde_compare (False, False))
			test_true_boolean (b.not_tilde_compare (True, False))
			test_true_boolean (b.not_tilde_compare (False, True))

			test_false_boolean (r4.not_tilde_compare (4.5, 4.5))
			test_true_boolean (r4.not_tilde_compare (4.5, 4.8))

			test_false_boolean (r8.not_tilde_compare (4.5, 4.5))
			test_true_boolean (r8.not_tilde_compare (4.5, 4.8))

			test_false_boolean (a.not_tilde_compare ("My", "My"))
			test_true_boolean (a.not_tilde_compare ("My", "My2"))
			test_true_boolean (a.not_tilde_compare (io, "My"))
		end

feature {NONE} -- Implementation

	test_true_boolean (b: BOOLEAN) is
		do
			if not b then
				print ("Not correct%N")
			end
		end

	test_false_boolean (b: BOOLEAN) is
		do
			if b then
				print ("Not correct%N")
			end
		end

end
