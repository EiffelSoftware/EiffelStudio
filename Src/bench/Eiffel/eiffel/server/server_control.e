-- Server controller

class SERVER_CONTROL

inherit

	CACHE [SERVER_FILE]
		rename
			make as cache_make
		redefine
			wipe_out
		end

feature

	files: ARRAY [SERVER_FILE];
			-- Array of all the files under the control of the
			-- current object.

	last_computed_id: INTEGER;
			-- Last new computed server file id

	make is
		do
			cache_make;
			!!files.make (1, Chunk);
		end;

	Chunk: INTEGER is 50;
			-- Array chunk

	compute_new_id is
			-- Compute a new server file id and assign it to `last_computed_id'.
		local
			new_file: SERVER_FILE;
			nb, id: INTEGER;
		do
			id := new_id;
			!!new_file.make (id);
			nb := files.count;
			if id > nb then
				files.resize (1, nb + Chunk);
			end;
			files.put (new_file, id);
			last_computed_id := id;
		end;

	remove_file (f: SERVER_FILE) is
			-- Remove file from Current
		require
			good_argument: f /= Void
		local
			void_file: SERVER_FILE;
		do
			if f.is_open then
					-- If the file is open then it is in the cache
				f.close;
				remove_id (f.id);
			end;
				-- Remove `f' from the controler
			files.put (void_file, f.id);
				-- Remove file from the disk
			f.delete;
		end;

	remove_useless_files is
			-- Remove all empty files from disk
		local
			i, nb: INTEGER;
			f: SERVER_FILE;
		do
			from
				i := 1;
				nb := files.count;
			until
				i > nb
			loop
				f := files.item (i);
				if f /= Void and then f.file_info.size = 0 then
					remove_file (f);
				end;
				i := i + 1
			end
		end;

	new_id: INTEGER is
			-- New id
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := files.count;
			until
				i > nb or else Result > 0
			loop
				if files.item (i) = Void then
					Result := i
				end;
				i := i + 1
			end;
			if Result = 0 then
				Result := nb + 1
			end;
		end;

	file_of_id (i: INTEGER): SERVER_FILE is
			-- File of id `i'.
		require
			index_small_enough: i <= files.upper;
			index_large_enough: i >= files.lower;
		do
			Result := files.item (i)
		end;

	open_file (f: SERVER_FILE) is
			-- Open file `f'.
		require
			good_argument: f /= Void;
			is_closed: not f.is_open
		local
			opened_file: SERVER_FILE;
		do
			if full then
					-- Remove one opened file from cache
				opened_file := item;
				opened_file.close;
				remove;
			end;
			f.open;
			put (f);
		ensure
			is_open: f.is_open
		end;

	Cache_size: INTEGER is 20;

	wipe_out is
			-- Empty the cache
		do
			from
			until
				empty
			loop
				item.close;
				remove;
			end;
		end;

end
