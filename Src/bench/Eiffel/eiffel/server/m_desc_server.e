class M_DESC_SERVER

inherit
	COMPILER_SERVER [MELTED_DESC, CLASS_ID]

creation
	make

feature -- Access

	id (t: MELTED_DESC): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: M_DESC_CACHE is
		once
			!! Result.make
		end
		
feature -- Server size configuration

	Size_limit: INTEGER is 50
			-- Size of the M_DESC_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
