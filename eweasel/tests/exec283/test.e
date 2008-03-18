class TEST

create
	make

feature
	 make
		local
			l_n8: SPECIAL [NATURAL_64]
			l_n4: SPECIAL [NATURAL_32]
			l_n2: SPECIAL [NATURAL_16]
			l_n1: SPECIAL [NATURAL_8]
			l_i8: SPECIAL [INTEGER_64]
			l_i4: SPECIAL [INTEGER_32]
			l_i2: SPECIAL [INTEGER_16]
			l_i1: SPECIAL [INTEGER_8]
			l_b: SPECIAL [BOOLEAN]
			l_c4: SPECIAL [CHARACTER_32]
			l_c1: SPECIAL [CHARACTER_8]
			l_p: SPECIAL [POINTER]
			l_r8: SPECIAL [REAL_64]
			l_r4: SPECIAL [REAL_32]
			l_a: SPECIAL [ANY]
			l_exp1: SPECIAL [EXP1]
			l_exp2: SPECIAL [EXP2]
			l_exp3: SPECIAL [EXP3]
			l_exp4: SPECIAL [EXP4]
			l_exp5: SPECIAL [EXP5 [STRING]]
			l_exp6: SPECIAL [EXP6 [STRING]]
			l_exp7: SPECIAL [EXP7]
		do
			create l_n8.make (10)
			create l_n4.make (10)
			create l_n2.make (10)
			create l_n1.make (10)
			create l_i8.make (10)
			create l_i4.make (10)
			create l_i2.make (10)
			create l_i1.make (10)
			create l_b.make (10)
			create l_c4.make (10)
			create l_c1.make (10)
			create l_p.make (10)
			create l_r8.make (10)
			create l_r4.make (10)
			create l_a.make (10)
			create l_exp1.make (10)
			create l_exp2.make (10)
			create l_exp3.make (10)
			create l_exp4.make (10)
			create l_exp5.make (10)
			create l_exp6.make (10)
			create l_exp7.make (10)

			display_info (l_n8)
			display_info (l_n4)
			display_info (l_n2)
			display_info (l_n1)
			display_info (l_i8)
			display_info (l_i4)
			display_info (l_i2)
			display_info (l_i1)
			display_info (l_b)
			display_info (l_c4)
			display_info (l_c1)
			display_info (l_p)
			display_info (l_r8)
			display_info (l_r4)
			display_info (l_a)
			display_info (l_exp1)
			display_info (l_exp2)
			display_info (l_exp3)
			display_info (l_exp4)
			display_info (l_exp5)
			display_info (l_exp6)
			display_info (l_exp7)

			l_n8.clear_all
			l_n4.clear_all
			l_n2.clear_all
			l_n1.clear_all
			l_i8.clear_all
			l_i4.clear_all
			l_i2.clear_all
			l_i1.clear_all
			l_b.clear_all
			l_c4.clear_all
			l_c1.clear_all
			l_p.clear_all
			l_r8.clear_all
			l_r4.clear_all
			l_a.clear_all
			l_exp1.clear_all
			l_exp2.clear_all
			l_exp3.clear_all
			l_exp4.clear_all
			l_exp5.clear_all
			l_exp6.clear_all
			l_exp7.clear_all

			display_info (l_n8)
			display_info (l_n4)
			display_info (l_n2)
			display_info (l_n1)
			display_info (l_i8)
			display_info (l_i4)
			display_info (l_i2)
			display_info (l_i1)
			display_info (l_b)
			display_info (l_c4)
			display_info (l_c1)
			display_info (l_p)
			display_info (l_r8)
			display_info (l_r4)
			display_info (l_a)
			display_info (l_exp1)
			display_info (l_exp2)
			display_info (l_exp3)
			display_info (l_exp4)
			display_info (l_exp5)
			display_info (l_exp6)
			display_info (l_exp7)

			check_all_default (l_n8)
			check_all_default (l_n4)
			check_all_default (l_n2)
			check_all_default (l_n1)
			check_all_default (l_i8)
			check_all_default (l_i4)
			check_all_default (l_i2)
			check_all_default (l_i1)
			check_all_default (l_b)
			check_all_default (l_c4)
			check_all_default (l_c1)
			check_all_default (l_p)
			check_all_default (l_r8)
			check_all_default (l_r4)
			check_all_default (l_a)
			check_all_default (l_exp1)
			check_all_default (l_exp2)
			check_all_default (l_exp3)
			check_all_default (l_exp4)
			check_all_default (l_exp5)
			check_all_default (l_exp6)
			check_all_default (l_exp7)
		end

	display_info (a_spec: SPECIAL [ANY]) is
		require
			a_spec_not_void: a_spec /= Void
		do
			print (a_spec.generating_type)
			print (" has ")
			print (a_spec.count)
			print (" elements.%N")
		end

	check_all_default (a_spec: SPECIAL [ANY]) is
		require
			a_spec_not_void: a_spec /= Void
		do
			if not a_spec.all_default (a_spec.lower, a_spec.upper) then
				print (a_spec.generating_type)
				print (" does not have all default elements.%N")
			end
		end

end
