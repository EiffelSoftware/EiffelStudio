-- Server for melted routine table byte code associated to file ".MLT3"

class M_ROUT_ID_SERVER

inherit
	COMPILER_SERVER [MELTED_ROUTID_ARRAY, CLASS_ID]

creation
	make

feature -- Access

	id (t: MELTED_ROUTID_ARRAY): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: M_ROUT_ID_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
feature -- Server size configuration

	Size_limit: INTEGER is 50
			-- Size of the M_ROUT_ID_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
