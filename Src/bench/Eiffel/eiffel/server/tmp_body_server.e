indexing
	description: "Body server indexed by body_index.%
				%Remember also the body indexes to erase from the table (body indexes%
				%from changed features)."
	date: "$Date$"
	revision: "$Revision$"

class TMP_BODY_SERVER 

inherit
	READ_SERVER [FEATURE_AS]
		export
			{BODY_SERVER} tbl_item
		redefine
			clear, make, has, trace
		end

creation

	make
	
feature 

	has (an_id: INTEGER): BOOLEAN is
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
					Result := not (an_id = useless_body_indexes.item (i))
					i := i + 1
				end;
			end;
		end;

	useless_body_indexes: ARRAY [INTEGER];
			-- Set of body_indexes ids which have to desappear after a successful
			-- recompilation

	nb_useless: INTEGER;
			-- Count of body_indexes ids in `useless_body_indexes'.

	make is
			-- Initialization
		do
			{READ_SERVER} Precursor
			!!useless_body_indexes.make (1, array_chunk)
		end;

	cache: BODY_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
		do
			Result := Tmp_ast_server;
		end;

	desactive (body_index: INTEGER) is
			-- Put `body_index' in `useless_body_indexes'.
		local
			nb: INTEGER;
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.desactivate ");
	io.error.putint (body_index);
	io.error.new_line;
end;
				-- Check if resizing is needed.
			nb_useless := nb_useless + 1;
			nb := useless_body_indexes.count;
			if nb_useless > nb then
				useless_body_indexes.resize (1, nb + array_chunk);
			end;

			useless_body_indexes.put (body_index, nb_useless);
		end;

	reactivate (body_index: INTEGER) is
		local
			i: INTEGER
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.reactivate ");
	io.error.putint (body_index);
	io.error.new_line;
end;
			from
				i := 1
			until
				i > nb_useless
			loop
				if useless_body_indexes.item (i) = body_index then
					useless_body_indexes.put (0, i)
				end
				i := i + 1
			end
		end

	array_chunk: INTEGER is 10
			-- Array chunk

	finalize is
			-- Finalization after a successful recompilation.
		local
			i: INTEGER
			useless_body_index: INTEGER
		do
debug
	io.error.putstring ("TMP_BODY_SERVER.finalize%N")
end;
				-- Desactive useless ids
			from
				i := 1
			until
				i > nb_useless
			loop
				useless_body_index := useless_body_indexes.item (i)
				if useless_body_index /= 0 then
						-- Note: `remove' will get the updated id
						-- before performing the removal.
debug
	io.error.putstring ("Useless body_index: ")
	io.error.putint (useless_body_index)
	io.error.new_line
end;
						-- Remove non-used `body_index' from both
						-- Current and BODY_SERVER, otherwise during
						-- `merge' we will add them back to BODY_SERVER
						-- making this step useless.
					remove (useless_body_index)
					Body_server.remove (useless_body_index)
				end
				i := i + 1
			end

				-- Update indexes
			Body_server.merge (Current)
				-- Update cache
			Body_server.cache.copy (cache)
			cache.make

			clear
		end

	clear is
			-- Clear the structure
		do
			{READ_SERVER} Precursor
			nb_useless := 0
			useless_body_indexes.clear_all
		end

	trace is
		local
			i: INTEGER
		do
			from
				start
				io.error.putstring ("Keys:%N");
			until
				after
			loop
				io.error.putstring ("%T");
				io.error.putint (key_for_iteration);
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
				io.error.putint (useless_body_indexes.item (i));
				io.error.new_line;
				i := i + 1
			end;
			io.error.putstring ("O_N_TABLE:%N");
		end;

end
