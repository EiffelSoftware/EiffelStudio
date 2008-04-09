class
	TEST

create
	make

feature

	make is
		do
			test_tilde_between_expanded_types
			test_not_tilde_between_expanded_types
			test_tilde_expanded_reference_types
			test_not_tilde_expanded_reference_types
		end

	test_tilde_between_expanded_types is
		local
			t1_1, t1_2: TEST1
			t2_1, t2_2: TEST2
			t3_1, t3_2: TEST3
		do
			create t1_1.make (59)
			create t1_2.make (59)
			create t2_1.make ("TEST")
			create t2_2.make ("TEST")
			create t3_1.make ("TEST")
			create t3_2.make ("TEST")

			test_false_boolean (t1_1 ~ Void)
			test_true_boolean (t1_1 ~ t1_1)
			test_true_boolean (t1_1 ~ t1_2)
			test_false_boolean (t1_1 ~ t2_1)
			test_false_boolean (t1_1 ~ t2_2)
			test_false_boolean (t1_1 ~ t3_1)
			test_false_boolean (t1_1 ~ t3_2)

			test_false_boolean (t1_2 ~ Void)
			test_true_boolean (t1_2 ~ t1_1)
			test_true_boolean (t1_2 ~ t1_2)
			test_false_boolean (t1_2 ~ t2_1)
			test_false_boolean (t1_2 ~ t2_2)
			test_false_boolean (t1_2 ~ t3_1)
			test_false_boolean (t1_2 ~ t3_2)

			test_false_boolean (t2_1 ~ Void)
			test_false_boolean (t2_1 ~ t1_1)
			test_false_boolean (t2_1 ~ t1_2)
			test_true_boolean (t2_1 ~ t2_1)
			test_false_boolean (t2_1 ~ t2_2)
			test_false_boolean (t2_1 ~ t3_1)
			test_false_boolean (t2_1 ~ t3_2)

			test_false_boolean (t2_2 ~ Void)
			test_false_boolean (t2_2 ~ t1_1)
			test_false_boolean (t2_2 ~ t1_2)
			test_false_boolean (t2_2 ~ t2_1)
			test_true_boolean (t2_2 ~ t2_2)
			test_false_boolean (t2_2 ~ t3_1)
			test_false_boolean (t2_2 ~ t3_2)

			test_false_boolean (t3_1 ~ Void)
			test_false_boolean (t3_1 ~ t1_1)
			test_false_boolean (t3_1 ~ t1_2)
			test_false_boolean (t3_1 ~ t2_1)
			test_false_boolean (t3_1 ~ t2_2)
			test_true_boolean (t3_1 ~ t3_1)
			test_true_boolean (t3_1 ~ t3_2)

			test_false_boolean (t3_2 ~ Void)
			test_false_boolean (t3_2 ~ t1_1)
			test_false_boolean (t3_2 ~ t1_2)
			test_false_boolean (t3_2 ~ t2_1)
			test_false_boolean (t3_2 ~ t2_2)
			test_true_boolean (t3_2 ~ t3_1)
			test_true_boolean (t3_2 ~ t3_2)

			test_true_boolean (Void ~ Void)
			test_false_boolean (Void ~ t1_1)
			test_false_boolean (Void ~ t1_2)
			test_false_boolean (Void ~ t2_1)
			test_false_boolean (Void ~ t2_2)
			test_false_boolean (Void ~ t3_1)
			test_false_boolean (Void ~ t3_2)

			create t1_1.make (59)
			create t1_2.make (1)
			create t2_1.make ("TEST1")
			create t2_2.make ("TEST2")
			create t3_1.make ("TEST3")
			create t3_2.make ("TEST4")

			test_false_boolean (t1_1 ~ t1_2)
			test_false_boolean (t2_1 ~ t2_2)
			test_false_boolean (t3_1 ~ t3_2)
		end

	test_not_tilde_between_expanded_types is
		local
			t1_1, t1_2: TEST1
			t2_1, t2_2: TEST2
			t3_1, t3_2: TEST3
		do
			create t1_1.make (59)
			create t1_2.make (59)
			create t2_1.make ("TEST")
			create t2_2.make ("TEST")
			create t3_1.make ("TEST")
			create t3_2.make ("TEST")

			test_true_boolean (t1_1 /~ Void)
			test_false_boolean (t1_1 /~ t1_1)
			test_false_boolean (t1_1 /~ t1_2)
			test_true_boolean (t1_1 /~ t2_1)
			test_true_boolean (t1_1 /~ t2_2)
			test_true_boolean (t1_1 /~ t3_1)
			test_true_boolean (t1_1 /~ t3_2)

			test_true_boolean (t1_2 /~ Void)
			test_false_boolean (t1_2 /~ t1_1)
			test_false_boolean (t1_2 /~ t1_2)
			test_true_boolean (t1_2 /~ t2_1)
			test_true_boolean (t1_2 /~ t2_2)
			test_true_boolean (t1_2 /~ t3_1)
			test_true_boolean (t1_2 /~ t3_2)

			test_true_boolean (t2_1 /~ Void)
			test_true_boolean (t2_1 /~ t1_1)
			test_true_boolean (t2_1 /~ t1_2)
			test_false_boolean (t2_1 /~ t2_1)
			test_true_boolean (t2_1 /~ t2_2)
			test_true_boolean (t2_1 /~ t3_1)
			test_true_boolean (t2_1 /~ t3_2)

			test_true_boolean (t2_2 /~ Void)
			test_true_boolean (t2_2 /~ t1_1)
			test_true_boolean (t2_2 /~ t1_2)
			test_true_boolean (t2_2 /~ t2_1)
			test_false_boolean (t2_2 /~ t2_2)
			test_true_boolean (t2_2 /~ t3_1)
			test_true_boolean (t2_2 /~ t3_2)

			test_true_boolean (t3_1 /~ Void)
			test_true_boolean (t3_1 /~ t1_1)
			test_true_boolean (t3_1 /~ t1_2)
			test_true_boolean (t3_1 /~ t2_1)
			test_true_boolean (t3_1 /~ t2_2)
			test_false_boolean (t3_1 /~ t3_1)
			test_false_boolean (t3_1 /~ t3_2)

			test_true_boolean (t3_2 /~ Void)
			test_true_boolean (t3_2 /~ t1_1)
			test_true_boolean (t3_2 /~ t1_2)
			test_true_boolean (t3_2 /~ t2_1)
			test_true_boolean (t3_2 /~ t2_2)
			test_false_boolean (t3_2 /~ t3_1)
			test_false_boolean (t3_2 /~ t3_2)

			test_false_boolean (Void /~ Void)
			test_true_boolean (Void /~ t1_1)
			test_true_boolean (Void /~ t1_2)
			test_true_boolean (Void /~ t2_1)
			test_true_boolean (Void /~ t2_2)
			test_true_boolean (Void /~ t3_1)
			test_true_boolean (Void /~ t3_2)

			create t1_1.make (59)
			create t1_2.make (1)
			create t2_1.make ("TEST1")
			create t2_2.make ("TEST2")
			create t3_1.make ("TEST3")
			create t3_2.make ("TEST4")

			test_true_boolean (t1_1 /~ t1_2)
			test_true_boolean (t2_1 /~ t2_2)
			test_true_boolean (t3_1 /~ t3_2)
		end

	test_tilde_expanded_reference_types is
		local
			a, b: ANY
			t1_1, t1_2: TEST1
			t2_1, t2_2: TEST2
			t3_1, t3_2: TEST3
		do
			create t1_1.make (59)
			create t1_2.make (59)
			create t2_1.make ("TEST")
			create t2_2.make ("TEST")
			create t3_1.make ("TEST")
			create t3_2.make ("TEST")

			test_true_boolean (a ~ Void)

			a := t1_1
			test_false_boolean (a ~ Void)
			test_true_boolean (a ~ t1_1)
			test_true_boolean (a ~ t1_2)
			test_false_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			test_false_boolean (a ~ t3_1)
			test_false_boolean (a ~ t3_2)

			a := t1_2
			test_false_boolean (a ~ Void)
			test_true_boolean (a ~ t1_1)
			test_true_boolean (a ~ t1_2)
			test_false_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			test_false_boolean (a ~ t3_1)
			test_false_boolean (a ~ t3_2)

			a := t2_1
			test_false_boolean (a ~ Void)
			test_false_boolean (a ~ t1_1)
			test_false_boolean (a ~ t1_2)
			test_true_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			test_false_boolean (a ~ t3_1)
			test_false_boolean (a ~ t3_2)

			a := t2_2
			test_false_boolean (a ~ Void)
			test_false_boolean (a ~ t1_1)
			test_false_boolean (a ~ t1_2)
			test_false_boolean (a ~ t2_1)
			test_true_boolean (a ~ t2_2)
			test_false_boolean (a ~ t3_1)
			test_false_boolean (a ~ t3_2)

			a := t3_1
			test_false_boolean (a ~ Void)
			test_false_boolean (a ~ t1_1)
			test_false_boolean (a ~ t1_2)
			test_false_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			test_true_boolean (a ~ t3_1)
			test_true_boolean (a ~ t3_2)

			a := t3_2
			test_false_boolean (a ~ Void)
			test_false_boolean (a ~ t1_1)
			test_false_boolean (a ~ t1_2)
			test_false_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			test_true_boolean (a ~ t3_1)
			test_true_boolean (a ~ t3_2)

			create t1_1.make (59)
			create t1_2.make (1)
			create t2_1.make ("TEST1")
			create t2_2.make ("TEST2")
			create t3_1.make ("TEST3")
			create t3_2.make ("TEST4")

			a := t1_1
			test_true_boolean (a ~ t1_1)
			test_false_boolean (a ~ t1_2)
			a := t1_2
			test_false_boolean (a ~ t1_1)
			test_true_boolean (a ~ t1_2)

			a := t2_1
			test_true_boolean (a ~ t2_1)
			test_false_boolean (a ~ t2_2)
			a := t2_2
			test_false_boolean (a ~ t2_1)
			test_true_boolean (a ~ t2_2)

			a := t3_1
			test_true_boolean (a ~ t3_1)
			test_false_boolean (a ~ t3_2)
			a := t3_2
			test_false_boolean (a ~ t3_1)
			test_true_boolean (a ~ t3_2)

			a := t1_1
			b := t1_1
			test_true_boolean (a ~ b)

			a := t1_1
			b := t1_2
			test_false_boolean (a ~ b)
		end

	test_not_tilde_expanded_reference_types is
		local
			a, b: ANY
			t1_1, t1_2: TEST1
			t2_1, t2_2: TEST2
			t3_1, t3_2: TEST3
		do
			create t1_1.make (59)
			create t1_2.make (59)
			create t2_1.make ("TEST")
			create t2_2.make ("TEST")
			create t3_1.make ("TEST")
			create t3_2.make ("TEST")

			test_false_boolean (a /~ Void)

			a := t1_1
			test_true_boolean (a /~ Void)
			test_false_boolean (a /~ t1_1)
			test_false_boolean (a /~ t1_2)
			test_true_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			test_true_boolean (a /~ t3_1)
			test_true_boolean (a /~ t3_2)

			a := t1_2
			test_true_boolean (a /~ Void)
			test_false_boolean (a /~ t1_1)
			test_false_boolean (a /~ t1_2)
			test_true_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			test_true_boolean (a /~ t3_1)
			test_true_boolean (a /~ t3_2)

			a := t2_1
			test_true_boolean (a /~ Void)
			test_true_boolean (a /~ t1_1)
			test_true_boolean (a /~ t1_2)
			test_false_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			test_true_boolean (a /~ t3_1)
			test_true_boolean (a /~ t3_2)

			a := t2_2
			test_true_boolean (a /~ Void)
			test_true_boolean (a /~ t1_1)
			test_true_boolean (a /~ t1_2)
			test_true_boolean (a /~ t2_1)
			test_false_boolean (a /~ t2_2)
			test_true_boolean (a /~ t3_1)
			test_true_boolean (a /~ t3_2)

			a := t3_1
			test_true_boolean (a /~ Void)
			test_true_boolean (a /~ t1_1)
			test_true_boolean (a /~ t1_2)
			test_true_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			test_false_boolean (a /~ t3_1)
			test_false_boolean (a /~ t3_2)

			a := t3_2
			test_true_boolean (a /~ Void)
			test_true_boolean (a /~ t1_1)
			test_true_boolean (a /~ t1_2)
			test_true_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			test_false_boolean (a /~ t3_1)
			test_false_boolean (a /~ t3_2)

			create t1_1.make (59)
			create t1_2.make (1)
			create t2_1.make ("TEST1")
			create t2_2.make ("TEST2")
			create t3_1.make ("TEST3")
			create t3_2.make ("TEST4")

			a := t1_1
			test_false_boolean (a /~ t1_1)
			test_true_boolean (a /~ t1_2)
			a := t1_2
			test_true_boolean (a /~ t1_1)
			test_false_boolean (a /~ t1_2)

			a := t2_1
			test_false_boolean (a /~ t2_1)
			test_true_boolean (a /~ t2_2)
			a := t2_2
			test_true_boolean (a /~ t2_1)
			test_false_boolean (a /~ t2_2)

			a := t3_1
			test_false_boolean (a /~ t3_1)
			test_true_boolean (a /~ t3_2)
			a := t3_2
			test_true_boolean (a /~ t3_1)
			test_false_boolean (a /~ t3_2)

			a := t1_1
			b := t1_1
			test_false_boolean (a /~ b)

			a := t1_1
			b := t1_2
			test_true_boolean (a /~ b)
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
