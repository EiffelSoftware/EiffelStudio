indexing
	description: "Server for byte code on temporary file, indexed by body index.%
				%This server is used during the compilation. The goal is to%
				%merge the file Tmp_byte_file and Byte_file if the compilation%
				%is successful."
	date: "$Date$"
	revision: "$Revision$"

class TMP_BYTE_SERVER 

inherit
	DELAY_SERVER [BYTE_CODE]

creation
	make
	
feature 

	id (t: BYTE_CODE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.body_index
		end

	cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 150
			-- Size of the TMP_BYTE_SERVER file (150 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
