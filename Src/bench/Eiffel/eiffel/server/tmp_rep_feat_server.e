-- Invariant server associated to file "._TMP_AST". Remmber also the body ids to
-- erase from the table (body ids from changed features).

class TMP_REP_FEAT_SERVER 

inherit

	READ_SERVER [FEATURE_AS]
		rename
			clear as old_clear,
			make as basic_make,
			has as old_has
		redefine
			ontable, updated_id
		end;
	READ_SERVER [FEATURE_AS]
		redefine
			clear, make, ontable, updated_id, has
		select
			clear, make, has
		end

creation

	make
	
feature

	has (an_id: INTEGER): BOOLEAN is
		local
			i: INTEGER
		do
			Result := old_has (an_id);
			if Result then
				from
					i := 1
				until
					(i > nb_useless) or else not Result
				loop
					if useless_body_ids.item (i) /= -1 then
						Result := (updated_id (an_id) /= updated_id (useless_body_ids.item (i)))
					end;
					i := i + 1
				end;
			end;
		end;

	ontable: O_N_TABLE is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

	updated_id (i: INTEGER): INTEGER is
		do
			Result := ontable.item (i)
		end;

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

	reactivate (body_id: INTEGER) is
		local
			i: INTEGER;
			real_id: INTEGER
		do
			real_id := updated_id (body_id);
			from
				i := 1
			until
				i > nb_useless
			loop
				if (updated_id(useless_body_ids.item (i)) = real_id) then
					useless_body_ids.put (-1, i);
				end;
				i := i + 1
			end;
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
				if (useless_body_ids.item (i) /= -1) then
						-- Note: `remove' will get the updated id
						-- before performing the removal.
					Rep_feat_server.remove (useless_body_ids.item (i));
				end;
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
