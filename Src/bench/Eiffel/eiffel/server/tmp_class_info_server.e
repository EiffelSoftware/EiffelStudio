-- Server for class information on temporary file. This server is
-- used during the compilation. The goal is to merge the file
-- Tmp_class_info_file and Class_info_file if the compilation is successful.

class TMP_CLASS_INFO_SERVER 

inherit

	DELAY_SERVER [CLASS_INFO, CLASS_ID]
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

	id (t: CLASS_INFO): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	cache: CLASS_INFO_CACHE 
			-- Cache for routine tables

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 200
			-- Size of the TMP_CLASS_INFO_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
