indexing
	description: "Server for melted routine table byte code indexed by class id"
	date: "$Date$"
	revision: "$Revision$"

class M_ROUT_ID_SERVER

inherit
	COMPILER_SERVER [MELTED_ROUTID_ARRAY]

creation
	make

feature -- Access

	id (t: MELTED_ROUTID_ARRAY): INTEGER is
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
