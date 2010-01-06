class TEST3
inherit
	TEST2

feature

	put1 (v: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `v'.
		do
			print ("Called put1%N")
		end

	put2 (v: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `v'.
		do
			print ("Called put2%N")
		end

	as_special: SPECIAL [CHARACTER]

	area: STRING

end
