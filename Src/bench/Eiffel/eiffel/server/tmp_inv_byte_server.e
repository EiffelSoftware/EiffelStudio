-- Server for invariant byte code on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_inv_byte_file
-- and Inv_byte_file if the compilation is successful.

class TMP_INV_BYTE_SERVER 

inherit
	DELAY_SERVER [INVARIANT_B, CLASS_ID]
		rename
			make as basic_make,
			flush as basic_flush
		end;
	DELAY_SERVER [INVARIANT_B, CLASS_ID]
		redefine
			flush, make
		select
			flush, make
		end

creation

	make

feature

	to_remove: LINKED_LIST [CLASS_ID];
			-- Ids to remove during finalization

	id (t: INVARIANT_B): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	make is
			-- Hash table creation
		do
			basic_make;
			!!to_remove.make;
			to_remove.compare_objects
		end;

	Cache: INV_BYTE_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	remove_id (i: CLASS_ID) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
		end;

	flush is
			-- Finalization after a successful recompilation.
		do
			basic_flush;
			from
				to_remove.start;
			until
				to_remove.after
			loop
				Inv_byte_server.remove (to_remove.item);
				to_remove.forth;
			end;
		end;

	Size_limit: INTEGER is 40
			-- Size of the TMP_INV_BYTE_SERVER file (40 Ko)

	Chunk: INTEGER is 100
			-- Size of a HASH_TABLE block

end
