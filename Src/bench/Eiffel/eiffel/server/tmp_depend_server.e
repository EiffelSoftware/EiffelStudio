indexing
	description: "Server of class dependances for incremental type check%
			%used during the compilation. The goal is to merge the file Tmp_depend_file%
			%and Depend_file if the compilation is successful.%
			%Indexed by class id."
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class TMP_DEPEND_SERVER 

inherit
	DELAY_SERVER [CLASS_DEPENDANCE]

creation
	make

feature 

	id (t: CLASS_DEPENDANCE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: DEPEND_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 100
			-- Size of the TMP_DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
