-- Server for byte code on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_byte_file
-- and Byte_file if the compilation is successful.

class TMP_BYTE_SERVER 

inherit
	DELAY_SERVER [BYTE_CODE, BODY_ID]
		redefine
			ontable, updated_id
		end

creation
	make
	
feature 

	ontable: O_N_TABLE [BODY_ID] is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

	updated_id (i: BODY_ID): BODY_ID is
		do
			Result := ontable.item (i)
		end

	id (t: BYTE_CODE): BODY_ID is
			-- Id associated with `t'
		do
			Result := t.byte_id
		end

	cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [BODY_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 150
			-- Size of the TMP_BYTE_SERVER file (150 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
