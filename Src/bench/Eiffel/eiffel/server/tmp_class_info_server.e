indexing
	description: "Server for class information on temporary file. This server is%
			%used during the compilation. The goal is to merge the file%
			%Tmp_class_info_file and Class_info_file if the compilation is successful.%
			%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_CLASS_INFO_SERVER 

inherit

	DELAY_SERVER [CLASS_INFO]

creation
	make
	
feature 

	id (t: CLASS_INFO): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: CLASS_INFO_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 200
			-- Size of the TMP_CLASS_INFO_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
