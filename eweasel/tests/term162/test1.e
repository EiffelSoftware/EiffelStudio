class TEST1 [G -> ANY]

feature

	sub_nodes (a_special: SPECIAL [G]): STRING_32
		do
			create Result.make_from_string_general (a_special.item (1).out)
		end

	object_representation (a: STRING_8): STRING_8 is
			--
		do

		end

end
