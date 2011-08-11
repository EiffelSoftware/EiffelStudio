class TEST

create
	make

feature
	 make
		local
			l_n8: SPECIAL [NATURAL_64]
			l_exp4: SPECIAL [EXP4]
			exp4: EXP4
		do
			create l_n8.make_filled (0, 10)
			create l_exp4.make_filled (exp4, 10)

			display_info (l_n8)
			$DO_NOTHING
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

end
