-- Server controller

class SERVER_CONTROL

inherit

	CACHE [SERVER_FILE, FILE_ID]
		rename
			make as cache_make
		redefine
			wipe_out
		end

feature

	files: HASH_TABLE [SERVER_FILE, FILE_ID];
			-- Table of all the files under the control of the
			-- current object

	file_counter: FILE_COUNTER;
			-- Server file id counter

	last_computed_id: FILE_ID;
			-- Last new computed server file id

	make is
		do
			cache_make;
			!! files.make (Chunk);
			!! file_counter.make
		end;

	Chunk: INTEGER is 50;
			-- Array chunk

	compute_new_id is
			-- Compute a new server file id and assign it to `last_computed_id'.
		local
			new_file: SERVER_FILE;
			id: FILE_ID
		do
			id := new_id;
			!! new_file.make (id);
			files.put (new_file, id);
debug ("SERVER")
	io.error.put_string ("Creating new file: ");
	io.error.put_string (id.file_name);
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
	io.error.put_string ("Forget file: ");
	io.error.put_string (f.id.file_name);
	io.error.new_line;
end;
			end;
		end;

	remove_file (f: SERVER_FILE) is
			-- Remove file from Current
		require
			good_argument: f /= Void
		do
			if f.is_open then
					-- If the file is open then it is in the cache
				f.close;
				remove_id (f.id);
			end;
				-- Remove `f' from the controler
			files.put (Void, f.id);
				-- Remove file from the disk
			f.delete;
debug ("SERVER")
	io.error.put_string ("Remove file: ");
	io.error.put_string (f.id.file_name);
	io.error.new_line;
end;
		end;

	remove_useless_files is
			-- Remove all empty files from disk
		local
			file: SERVER_FILE
		do
			from
				files.start
			until
				files.after
			loop
				file := files.item_for_iteration;
				if
					file /= Void and then
					not (file.precompiled or file.is_static) and then
					file.occurence = 0
				then
					remove_file (file);
				end;
				files.forth
			end
		end;

	new_id: FILE_ID is
			-- New id
		do
			from
				files.start
			until
				files.after or else files.item_for_iteration = Void
			loop
				files.forth
			end;
			if not files.after then
				Result := files.key_for_iteration
			else
				Result := file_counter.next_id
			end
		end;

	file_of_id (i: FILE_ID): SERVER_FILE is
			-- File of id `i'.
		require
			id_not_void: i /= Void
			file_exists: files.has (i)
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
	io.error.put_string ("Opening file: ");
	io.error.put_string (f.id.file_name);
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

feature -- Status report

	is_readable: BOOLEAN is
			-- Are the server files readable?
		local
			file: SERVER_FILE
		do
			from
				Result := true;
				files.start
			until
				not Result or files.after
			loop
				file:= files.item_for_iteration;
				if file /= Void and then file.exists then
					Result := file.is_readable
				end;
				files.forth
			end
		end;

	is_writable: BOOLEAN is
			-- Are the server files readable and writable?
		local
			file: SERVER_FILE
		do
			from
				Result := True;
				files.start
			until
				not Result or files.after
			loop
				file:= files.item_for_iteration;
				if file /= Void and then file.exists then
					if file.precompiled or file.is_static then
						Result := file.is_readable
					else
						Result := (file.is_readable and file.is_writable)
					end
				end;
				files.forth
			end
		end;

feature -- Initialization

	init is
			-- Update the path names of the various server files.
		local
			file: SERVER_FILE
		do
			from
				files.start
			until
				files.after
			loop
				file := files.item_for_iteration;
				if file /= Void then
					file.update_path
				end;
				files.forth
			end;
		end;

feature -- SERVER_FILE sizes

	chunk_size: INTEGER;

	set_chunk_size (s: INTEGER) is
		do
			chunk_size := s
		end

end -- class SERVER_CONTROL
