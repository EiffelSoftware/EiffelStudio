-- Body server associated to file ".AST". Remmber also the body ids to
-- erase from the table (body ids from changed features).

class TMP_BODY_SERVER 

inherit
	READ_SERVER [FEATURE_AS, BODY_ID]
		export
			{BODY_SERVER} tbl_item
		redefine
			clear, make, ontable, updated_id, has, trace
		end

creation

	make
	
feature 

	has (an_id: BODY_ID): BOOLEAN is
		local
			i: INTEGER
		do
			Result := server_has (an_id)
			if Result then
				from
					i := 1
				until
					(i > nb_useless) or else not Result
				loop
					if useless_body_ids.item (i) /= Void then
						Result := not equal (updated_id (an_id),
								updated_id (useless_body_ids.item (i)))
					end;
					i := i + 1
				end;
			end;
		end;

	ontable: O_N_TABLE [BODY_ID] is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

	updated_id (i: BODY_ID): BODY_ID is
		do
			Result := ontable.item (i)
		end;

	useless_body_ids: ARRAY [BODY_ID];
			-- Set of body ids which have to desappear after a successful
			-- recompilation

	nb_useless: INTEGER;
			-- Count of body ids in `useless_body_ids'.

	make is
			-- Initialization
		do
			{READ_SERVER} Precursor
			!!useless_body_ids.make (1, array_chunk)
		end;

	Cache: BODY_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, CLASS_ID] is
		do
			Result := Tmp_ast_server;
		end;

	desactive (body_id: BODY_ID) is
			-- Put `body_id' in `useless_body_ids'.
		local
			nb: INTEGER;
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.desactivate ");
	body_id.trace;
	io.error.new_line;
end;
				-- Check if resizing is needed.
			nb_useless := nb_useless + 1;
			nb := useless_body_ids.count;
			if nb_useless > nb then
				useless_body_ids.resize (1, nb + array_chunk);
			end;

			useless_body_ids.put (body_id, nb_useless);
		end;

	reactivate (body_id: BODY_ID) is
		local
			i: INTEGER;
			real_id, ubi: BODY_ID
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.reactivate ");
	body_id.trace;
	io.error.new_line;
end;
			real_id := updated_id (body_id);
			from
				i := 1
			until
				i > nb_useless
			loop
				ubi := useless_body_ids.item (i);
				if (ubi /= Void) and then equal (updated_id(ubi), real_id) then
					useless_body_ids.put (Void, i);
				end;
				i := i + 1
			end;
		end;

	array_chunk: INTEGER is 10;
			-- Array chunk

	finalize is
			-- Finalization after a successful recompilation.
		local
			i: INTEGER;
			body_id, useless_body_id: BODY_ID;
			read_info: READ_INFO;
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.finalize%N");
end;
				-- Desactive useless ids
			from
				i := 1;
			until
				i > nb_useless
			loop
				useless_body_id := useless_body_ids.item (i);
				if useless_body_id /= Void then
						-- Note: `remove' will get the updated id
						-- before performing the removal.
debug
	io.error.putstring ("Useless body_id: ");
	useless_body_id.trace;
	io.error.new_line;
end;
					Body_server.remove (useless_body_id);
				end;
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
			{READ_SERVER} Precursor
			nb_useless := 0
			useless_body_ids.clear_all
		end;

	trace is
		local
			i: INTEGER;
		do
			from
				start
				io.error.putstring ("Keys:%N");
			until
				after
			loop
				io.error.putstring ("%T");
				key_for_iteration.trace;
				io.error.new_line;
				forth
			end;
			from
				i := 1;
				io.error.putstring ("Useless:%N");
			until
				i > nb_useless
			loop
				io.error.putstring ("%T");
				useless_body_ids.item (i).trace;
				io.error.new_line;
				i := i + 1
			end;
			io.error.putstring ("O_N_TABLE:%N");
			ontable.trace;
		end;

end
