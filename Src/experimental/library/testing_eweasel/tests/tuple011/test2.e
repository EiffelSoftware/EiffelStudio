class TEST2 [G]

inherit
	HASHABLE

feature

	hash_code: INTEGER is 1

	h: HASH_TABLE [like x, like Current] is
		do
			create Result.make (10)
		end

	x: LIST [G]

end
