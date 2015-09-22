class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			a_1_1: A_1_1
			a_1_1_i: A_1_1 [INTEGER]
			a_1_1_ib: A_1_1 [INTEGER, BOOLEAN]

			a_2_1: A_2_1 [INTEGER]
			a_2_1_i: A_2_1 [INTEGER, INTEGER]
			a_2_1_ib: A_2_1 [INTEGER, BOOLEAN, INTEGER]

			a_2_2: A_2_2 [INTEGER]
			a_2_2_i: A_2_2 [INTEGER, INTEGER]
			a_2_2_ib: A_2_2 [INTEGER, INTEGER, BOOLEAN]

			a_3_1: A_3_1 [INTEGER, INTEGER]
			a_3_1_i: A_3_1 [INTEGER, INTEGER, INTEGER]
			a_3_1_ib: A_3_1 [INTEGER, BOOLEAN, INTEGER, INTEGER]

			a_3_2: A_3_2 [INTEGER, INTEGER]
			a_3_2_i: A_3_2 [INTEGER, INTEGER, INTEGER]
			a_3_2_ib: A_3_2 [INTEGER, INTEGER, BOOLEAN, INTEGER]

			a_3_3: A_3_3 [INTEGER, INTEGER]
			a_3_3_i: A_3_3 [INTEGER, INTEGER, INTEGER]
			a_3_3_ib: A_3_3 [INTEGER, INTEGER, INTEGER, BOOLEAN]

		do
			create a_1_1.make ("")
			create a_1_1_i.make ("i")
			create a_1_1_ib.make ("ib")
			a_1_1.f
			print ("%"a_1_1 ()%" is not supported%N") -- a_1_1 -- An empty argument list is not automatically added to an expression.
			a_1_1_i.f (1)
			a_1_1_i (2)
			a_1_1_ib.f (3, True)
			a_1_1_ib (4, False)

			create a_2_1.make ("")
			create a_2_1_i.make ("i")
			create a_2_1_ib.make ("ib")
			a_2_1.f (5)
			a_2_1 (6)
			a_2_1_i.f (7, 8)
			a_2_1_i (8, 9)
			a_2_1_ib.f (9, True, 10)
			a_2_1_ib (10, False, 11)

			create a_2_2.make ("")
			create a_2_2_i.make ("i")
			create a_2_2_ib.make ("ib")
			a_2_2.f (11)
			a_2_2 (12)
			a_2_2_i.f (13, 14)
			a_2_2_i (14, 15)
			a_2_2_ib.f (15, 16, True)
			a_2_2_ib (16, 17, False)

			create a_3_1.make ("")
			create a_3_1_i.make ("i")
			create a_3_1_ib.make ("ib")
			a_3_1.f (17, 18)
			a_3_1 (18, 19)
			a_3_1_i.f (19, 20, 21)
			a_3_1_i (20, 21, 22)
			a_3_1_ib.f (21, True, 22, 23)
			a_3_1_ib (22, False, 23, 24)

			create a_3_2.make ("")
			create a_3_2_i.make ("i")
			create a_3_2_ib.make ("ib")
			a_3_2.f (23, 24)
			a_3_2 (24, 25)
			a_3_2_i.f (25, 26, 27)
			a_3_2_i (26, 27, 28)
			a_3_2_ib.f (27, 28, True, 29)
			a_3_2_ib (28, 29, False, 30)

			create a_3_3.make ("")
			create a_3_3_i.make ("i")
			create a_3_3_ib.make ("ib")
			a_3_3.f (29, 30)
			a_3_3 (30, 31)
			a_3_3_i.f (31, 32, 33)
			a_3_3_i (32, 33, 34)
			a_3_3_ib.f (33, 34, 35, True)
			a_3_3_ib (34, 35, 36, False)
		end

end
