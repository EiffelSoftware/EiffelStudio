indexing
	description: "Server for melted feature tables indexed by static type id."
	date: "$Date$"
	revision: "$Revision$"

class M_FEAT_TBL_SERVER 

inherit
	COMPILER_SERVER [MELTED_FEATURE_TABLE]

creation
	make
	
feature -- Access

	id (t: MELTED_FEATURE_TABLE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	cache: M_FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
feature -- Server size configuration

	Size_limit: INTEGER is 50
			-- Size of the M_FEAT_TBL_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
