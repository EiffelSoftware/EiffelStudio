indexing
	description: "Server of class dependances for incremental type check%
				%used during the compilation. The goal is to merge the file Tmp_depend_file%
				%and Depend_file if the compilation is successful.%
				%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_REP_DEPEND_SERVER 

inherit
	DELAY_SERVER [REP_CLASS_DEPEND]

creation
	make
	
feature 

	id (t: REP_CLASS_DEPEND): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: REP_DEPEND_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	update (table: EXTEND_TABLE [REP_CLASS_DEPEND, INTEGER]) is
			-- Update server using `table'
		do
			from 
				table.start
			until
				table.after
			loop
				put (table.item_for_iteration);
				table.forth
			end
		end;

	Size_limit: INTEGER is 75
			-- Size of the TMP_REP_DEPEND_SERVER file (75 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
