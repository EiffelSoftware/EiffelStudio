indexing
	description: "Server for invariant byte code on temporary file. This server is%
				%used during the compilation. The goal is to merge the file Tmp_inv_byte_file%
				%and Inv_byte_file if the compilation is successful.%
				%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_INV_BYTE_SERVER 

inherit
	DELAY_SERVER [INVARIANT_B]
		redefine
			flush, make
		end

creation
	make

feature

	to_remove: LINKED_LIST [INTEGER];
			-- Ids to remove during finalization

	id (t: INVARIANT_B): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	make is
			-- Hash table creation
		do
			{DELAY_SERVER} Precursor;
			!!to_remove.make;
			to_remove.compare_objects
		end;

	cache: INV_BYTE_CACHE is
			-- Cache for routine tables
		once	
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	remove_id (i: INTEGER) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
		end;

	flush is
			-- Finalization after a successful recompilation.
		do
			{DELAY_SERVER} Precursor;
			from
				to_remove.start;
			until
				to_remove.after
			loop
				Inv_byte_server.remove (to_remove.item);
				to_remove.forth;
			end;
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the TMP_INV_BYTE_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
