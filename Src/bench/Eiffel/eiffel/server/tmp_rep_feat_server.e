-- Invariant server associated to file "._TMP_AST". Remmber also the body ids to
-- erase from the table (body ids from changed features).

class TMP_REP_FEAT_SERVER 

inherit

	READ_SERVER [FEATURE_AS]
		rename
			clear as old_clear,
			make as basic_make
		end;
	READ_SERVER [FEATURE_AS]
		redefine
			clear, make
		select
			clear, make
		end

creation

	make
	
feature

	useless_body_ids: ARRAY [INTEGER];
			-- Set of body ids which have to desappear after a success
			-- recompilation

	nb_useless: INTEGER;
			-- Count of body ids in `useless_body_ids'

	make is
			-- Hash table creation
		do
			basic_make;
			!!useless_body_ids.make (1, Chunk);
		end;

	Cache: REP_FEAT_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Chunk: INTEGER is 10;
			-- Array chunk

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
			-- Class offsets in the temporary AST class server
		do
			Result := Tmp_rep_server;
		end; -- offsets

	desactive (body_id: INTEGER) is
			-- Put `body_id' in `useless_body_ids'.
		local
			nb: INTEGER
		do
				-- Check if resizing is needed.
			nb_useless := nb_useless + 1;
			nb := useless_body_ids.count;
			if nb_useless > nb then
				useless_body_ids.resize (1, nb + Chunk);
			end;
			useless_body_ids.put (body_id, nb_useless);
		end;

	finalize is
			-- Finalization after a successful recompilation
		local
			i, body_id: INTEGER;
			read_info: READ_INFO
		do
				-- Deactivate useless ids
			from
				i := 1
			until
				i > nb_useless
			loop
				Rep_feat_server.remove (useless_body_ids.item (i));
				i := i + 1
			end;
				-- Update rep_feat server
			Rep_feat_server.merge (Current);
				-- Update cache
			Rep_feat_server.cache.copy (cache);
			cache.make;
			
			clear;
		end;

	clear is
			-- Clear the structure
		do
			old_clear;
			nb_useless := 0;			
			useless_body_ids.clear_all;
		end;

end
