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
debug ("SERVER")
	io.error.putstring ("Creating new file: ");
	io.error.putint (id);
	io.error.new_line;
end;
			last_computed_id := id;
		end;

	forget_file (f: SERVER_FILE) is
			-- Close the server file and remove it
			-- from the cache.
		require
			good_argument: f /= Void
		do
			if f.is_open then
					-- If the file is open then it is in the cache
				f.close;
				remove_id (f.id);
debug ("SERVER")
	io.error.putstring ("Forget file: E");
	io.error.putint (f.id);
	io.error.new_line;
end;
			end;
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
debug ("SERVER")
	io.error.putstring ("Remove file: E");
	io.error.putint (f.id);
	io.error.new_line;
end;
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
				if (i > last_precompiled_id) then
					f := files.item (i);
					if f /= Void and then (f.occurence = 0) then
						remove_file (f);
					end;
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
debug ("SERVER")
	io.error.putstring ("Opening file: E");
	io.error.putint (f.id);
	io.error.new_line;
end;
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

	is_readable: BOOLEAN is
			-- Are the server files readable?
		local
			i, files_upper: INTEGER;
			file: SERVER_FILE
		do
			from
				Result := true;
				i := files.lower;
				files_upper := files.upper
			until
				not Result or i > files_upper
			loop
				file:= files.item (i);
				if file /= Void then
					Result := file.exists and then file.is_readable
				end;
				i := i + 1
			end
		end;

	is_writable: BOOLEAN is
			-- Are the server files readable and writable?
		local
			i, files_upper: INTEGER;
			file: SERVER_FILE
		do
			from
				Result := true;
				i := files.lower;
				files_upper := files.upper
			until
				not Result or i > files_upper
			loop
				file:= files.item (i);
				if file /= Void then
					if file.precompiled then
						Result := file.exists and then file.is_readable
					else
						Result := file.exists and then 
							(file.is_readable and file.is_writable)
					end
				end;
				i := i + 1
			end
		end;

feature -- Precompilation

	last_precompiled_id: INTEGER;
			-- Last id corresponding to a precompiled
			-- server file

	save_precompiled_id is
			-- Save the value of last precompiled server file
			-- id after a precompilation
			--|require: System.precompilation
		local
			i, nb: INTEGER
		do
			from
				i := 1;
				nb := files.count
			until
				i > nb
			loop
				if files.item (i) /= Void then
					files.item (i).set_precompiled;
					last_precompiled_id := i
				end;
				i := i + 1
			end;
		end;

	init is
			-- Update the path names of the various server files
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := files.count;
			until
				i > nb
			loop
				if files.item (i) /= Void then
					files.item (i).update_path (i <= last_precompiled_id)
				end;
				i := i + 1
			end;
		end;

end
