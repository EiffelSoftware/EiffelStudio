deferred class TEST3 [G]

inherit
	HASHABLE
	TEST2 [G, DOUBLE]

feature
	z: HASH_TABLE [G, TEST2 [G, G]]

feature
	hash_code: INTEGER = 47
		   
end
