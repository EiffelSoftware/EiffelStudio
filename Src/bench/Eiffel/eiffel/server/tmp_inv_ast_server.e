-- Invariant server associated to file "._TMP_AST". Remmber also the body ids to
-- erase from the table (body ids from changed features).

class TMP_INV_AST_SERVER 

inherit

	READ_SERVER [INVARIANT_AS_B, CLASS_ID]
		rename
			clear as old_clear,
			make as basic_make
		end;
	READ_SERVER [INVARIANT_AS_B, CLASS_ID]
		redefine
			clear, make
		select
			clear, make
		end

creation

	make
	
feature

	to_remove: LINKED_LIST [CLASS_ID];
			-- Id of invariants to remove from the invariant server
			-- when finalization

	make is
			-- Hash table creation
		do
			basic_make;
			!!to_remove.make;
			to_remove.compare_objects
		end;

	Cache: INV_AST_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	remove_id (i: CLASS_ID) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
			remove (i);
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, CLASS_ID] is
			-- Class offsets in the temporary AST class server
		do
			Result := Tmp_ast_server;
		end; -- offsets

	
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
			old_clear;
			
			to_remove.wipe_out;
		end;

invariant

	to_remove_exists: to_remove /= Void;

end
