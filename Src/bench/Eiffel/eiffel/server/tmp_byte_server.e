-- Server for byte code on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_byte_file
-- and Byte_file if the compilation is successfull.

class TMP_BYTE_SERVER 

inherit

	DELAY_SERVER [BYTE_CODE]

creation

	make
	
feature 

	Cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2);
		end;

	Size_limit: INTEGER is 750000;

end
