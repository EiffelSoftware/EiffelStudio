-- Server of class dependances for incremental type check 
-- used during the compilation. The goal is to merge the file Tmp_depend_file
-- and Depend_file if the compilation is successful.

class TMP_DEPEND_SERVER 

inherit
	DELAY_SERVER [CLASS_DEPENDANCE, CLASS_ID]
		redefine 
			make
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{DELAY_SERVER}Precursor
			!! cache.make
		end

	
feature 

	id (t: CLASS_DEPENDANCE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	cache: DEPEND_CACHE 
			-- Cache for routine tables

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 100
			-- Size of the TMP_DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
