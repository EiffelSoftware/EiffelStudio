class MT_HASH_TABLE[G,H -> HASHABLE]

    inherit
	HASH_TABLE[G,H]
	    rename
	    	keys as hash_keys
	    end

    creation
	make

end -- class MT_HASH_TABLE
