-- Body server associated to file ".AST". Remmber also the body ids to
-- erase from the table (body ids from changed features).

class TMP_BODY_SERVER 

inherit

	READ_SERVER [FEATURE_AS]
		rename
			clear as old_clear,
			int_tbl_item as hash_table_item,
			make as basic_make
		export
			{ANY} hash_table_item
		end;
	READ_SERVER [FEATURE_AS]
		rename
			int_tbl_item as hash_table_item
		redefine
			clear, make
		select
			clear, make
		end

creation

	make
	
feature 

	useless_body_ids: ARRAY [INTEGER];
			-- Set of body ids which have to desappear after a successfull
			-- recompilation

	nb_useless: INTEGER;
			-- Count of body ids in `useless_body_ids'.

	make is
			-- Initialization
		do
			basic_make;
			!!useless_body_ids.make (1, Chunk);
		end;

	Cache: BODY_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
		do
			Result := Tmp_ast_server;
		end;

	desactive (body_id: INTEGER) is
			-- Put `body_id' in `useless_body_ids'.
		local
			nb: INTEGER;
		do
				-- Check if resizing is needed.
			nb_useless := nb_useless + 1;
			nb := useless_body_ids.count;
			if nb_useless > nb then
				useless_body_ids.resize (1, nb + Chunk);
			end;

			useless_body_ids.put (body_id, nb_useless);
		end;

	Chunk: INTEGER is 10;
			-- Array chunk

	finalize is
			-- Finalization after a successfull recompilation.
		local
			i, body_id: INTEGER;
			read_info: READ_INFO;
		do
				-- Desactive useless ids
			from
				i := 1;
			until
				i > nb_useless
			loop
				Body_server.remove (useless_body_ids.item (i));
				i := i + 1;
			end;

				-- Update indexes
			Body_server.merge (Current);
				-- Update cache
			Body_server.cache.copy (cache);
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
