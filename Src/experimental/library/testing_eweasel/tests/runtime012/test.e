class TEST

inherit
	INTERNAL
	MEMORY

create
	make

feature

	spec_bis: SPECIAL [INTEGER_64]
	spec_exp_bis: SPECIAL [EXP]
	spec_exp2_bis: SPECIAL [EXP2]

	make is
		do
			io.put_string ("NOT OK%N")
		end

end
