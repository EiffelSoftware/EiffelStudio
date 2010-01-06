class
	TEST_MORE_CONSTRAINT [G -> HASHABLE, F-> ARRAY [G], H -> HASH_TABLE [F, G]]

inherit
	TEST_SIMPLE [F, G]
		redefine
			f
		end

feature

	f (a: STRING) is
		do
		end

end
