-- Server for invariant byte code on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_inv_byte_file
-- and Inv_byte_file if the compilation is successfull.

class TMP_INV_BYTE_SERVER 

inherit

	DELAY_SERVER [INVARIANT_B]
		rename
			make as basic_make,
			flush as basic_flush
		end;
	DELAY_SERVER [INVARIANT_B]
		redefine
			flush, make
		select
			flush, make
		end

creation

	make

feature

	to_remove: LINKED_LIST [INTEGER];
			-- Ids to remove during finalization

	make is
			-- Hash table creation
		do
			basic_make;
			!!to_remove.make;
		end;

	Cache: INV_BYTE_CACHE is
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

	remove_id (i: INTEGER) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
		end;

	flush is
			-- Finalization after a successfull recompilation.
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

	Size_limit: INTEGER is 50000;

end
