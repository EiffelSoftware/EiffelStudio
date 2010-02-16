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
			l_a: SPECIAL [detachable ANY]
			l_exp1: SPECIAL [EXP1]
			l_exp2: SPECIAL [EXP2]
			l_exp3: SPECIAL [EXP3]
			l_exp4: SPECIAL [EXP4]
			l_exp5: SPECIAL [EXP5 [STRING]]
			l_exp6: SPECIAL [EXP6 [STRING]]
			l_exp7: SPECIAL [EXP7]
			exp1: EXP1
			exp2: EXP2
			exp3: EXP3
			exp4: EXP4
			exp5: EXP5 [STRING]
			exp6: EXP6 [STRING]
			exp7: EXP7
		do
			create l_n8.make_filled (0, 10)
			create l_n4.make_filled (0, 10)
			create l_n2.make_filled (0, 10)
			create l_n1.make_filled (0, 10)
			create l_i8.make_filled (0, 10)
			create l_i4.make_filled (0, 10)
			create l_i2.make_filled (0, 10)
			create l_i1.make_filled (0, 10)
			create l_b.make_filled (False, 10)
			create l_c4.make_filled ('%/000/', 10)
			create l_c1.make_filled ('%/000/', 10)
			create l_p.make_filled (default_pointer, 10)
			create l_r8.make_filled (0.0, 10)
			create l_r4.make_filled ({REAL_32} 0.0, 10)
			create l_a.make_filled (Void, 10)
			create l_exp1.make_filled (exp1, 10)
			create l_exp2.make_filled (exp2, 10)
			create l_exp3.make_filled (exp3, 10)
			create l_exp4.make_filled (exp4, 10)
			create l_exp5.make_filled (exp5, 10)
			create l_exp6.make_filled (exp6, 10)
			create l_exp7.make_filled (exp7, 10)

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

			l_n8.fill_with (0, 0, 9)
			l_n4.fill_with (0, 0, 9)
			l_n2.fill_with (0, 0, 9)
			l_n1.fill_with (0, 0, 9)
			l_i8.fill_with (0, 0, 9)
			l_i4.fill_with (0, 0, 9)
			l_i2.fill_with (0, 0, 9)
			l_i1.fill_with (0, 0, 9)
			l_b.fill_with (False, 0, 9)
			l_c4.fill_with ('%/000/', 0, 9)
			l_c1.fill_with ('%/000/', 0, 9)
			l_p.fill_with (default_pointer, 0, 9)
			l_r8.fill_with (0.0, 0, 9)
			l_r4.fill_with ({REAL_32} 0.0, 0, 9)
			l_a.fill_with (Void, 0, 9)
			l_exp1.fill_with (exp1, 0, 9)
			l_exp2.fill_with (exp2, 0, 9)
			l_exp3.fill_with (exp3, 0, 9)
			l_exp4.fill_with (exp4, 0, 9)
			l_exp5.fill_with (exp5, 0, 9)
			l_exp6.fill_with (exp6, 0, 9)
			l_exp7.fill_with (exp7, 0, 9)

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

			check_all_default (l_n8, 0)
			check_all_default (l_n4, 0)
			check_all_default (l_n2, 0)
			check_all_default (l_n1, 0)
			check_all_default (l_i8, 0)
			check_all_default (l_i4, 0)
			check_all_default (l_i2, 0)
			check_all_default (l_i1, 0)
			check_all_default (l_b, False)
			check_all_default (l_c4, '%/000/')
			check_all_default (l_c1, '%/000/')
			check_all_default (l_p, default_pointer)
			check_all_default (l_r8, 0.0)
			check_all_default (l_r4, 0.0)
			check_all_default (l_a, Void)
			check_all_default (l_exp1, exp1)
			check_all_default (l_exp2, exp2)
			check_all_default (l_exp3, exp3)
			check_all_default (l_exp4, exp4)
			check_all_default (l_exp5, exp5)
			check_all_default (l_exp6, exp6)
			check_all_default (l_exp7, exp7)
		end

	display_info (a_spec: SPECIAL [ANY])
		require
			a_spec_not_void: a_spec /= Void
		do
			print (a_spec.generating_type.out)
			print (" has ")
			print (a_spec.count)
			print (" elements.%N")
		end

	check_all_default (a_spec: SPECIAL [ANY]; a_def: ANY)
		require
			a_spec_not_void: a_spec /= Void
		do
			if not a_spec.filled_with (a_def, a_spec.lower, a_spec.upper) then
				print (a_spec.generating_type.out)
				print (" does not have all default elements.%N")
			end
		end

end
