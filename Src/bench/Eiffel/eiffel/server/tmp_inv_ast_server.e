indexing
	description: "Invariant server. Remember also the body ids to erase from the%
				%erase from the table (body ids from changed features).%
				%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_INV_AST_SERVER 

inherit
	READ_SERVER [INVARIANT_AS]
		rename
			tmp_ast_server as offsets
		redefine
			clear, make
		end

creation
	make
	
feature

	to_remove: LINKED_LIST [INTEGER];
			-- Id of invariants to remove from the invariant server
			-- when finalization

	make is
			-- Hash table creation
		do
			{READ_SERVER} Precursor;
			!!to_remove.make;
			to_remove.compare_objects
		end;

	cache: INV_AST_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	remove_id (i: INTEGER) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
			remove (i);
		end;

	finalize is
			-- Finalization after a successful recompilation.
		do
				-- first remove ids
			from
				to_remove.start
			until
				to_remove.after
			loop
				Inv_ast_server.remove (to_remove.item);
				to_remove.forth;
			end;

			Inv_ast_server.merge (Current);

				-- Update cache
			Inv_ast_server.cache.copy (cache);
			cache.make;

			clear;
		end;

	clear is
			-- Clear the structure
		do
			{READ_SERVER} Precursor
			to_remove.wipe_out;
		end;

invariant

	to_remove_exists: to_remove /= Void;

end
