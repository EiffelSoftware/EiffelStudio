class
	TEST1 [G]

feature

	g: HASH_TABLE [like f, HASHABLE]
		do
			create Result.make (0)
		end

	f: like h
		do
		end

	h: ACTIVE [like Current]
		do
		end

end
