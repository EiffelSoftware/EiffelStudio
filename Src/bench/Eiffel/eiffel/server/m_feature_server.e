-- Server for melted feature byte code associated to file ".MLT2"

class M_FEATURE_SERVER 

inherit
	COMPILER_SERVER [MELT_FEATURE, REAL_BODY_ID]

creation
	make
	
feature -- Access

	id (t: MELT_FEATURE): REAL_BODY_ID is
			-- Id associated with `t'
		do
			Result := t.real_body_id
		end

	Cache: M_FEATURE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

feature -- Server size configuration

	Size_limit: INTEGER is 50
			-- Size of the M_FEATURE_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
