-- Server controller

class SERVER_CONTROL

inherit
	CACHE [SERVER_FILE, FILE_ID]
		redefine
			make, wipe_out
		end

creation
	make

feature -- Initialization

	make is
		do
			{CACHE} Precursor
			!! files.make (Chunk)
			!! file_counter.make
		end

feature

	files: EXTEND_TABLE [SERVER_FILE, FILE_ID];
			-- Table of all the files under the control of the
			-- current object

	file_counter: FILE_COUNTER;
			-- Server file id counter

	last_computed_id: FILE_ID;
			-- Last new computed server file id

	Chunk: INTEGER is 50;
			-- Array chunk

	compute_new_id is
			-- Compute a new server file id and assign it to `last_computed_id'.
		local
			new_file: SERVER_FILE
			id: FILE_ID
		do
			id := new_id
			!! new_file.make (id)
			files.put (new_file, id)
			last_computed_id := id
debug ("SERVER")
	io.error.put_string ("Creating new file: ")
	io.error.put_string (id.file_name)
	io.error.new_line
end;
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
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				file := local_files.item_for_iteration;
				if
					file /= Void
					and then not file.precompiled
					and then file.occurence = 0
				then
					remove_file (file);
				end;
				local_files.forth
			end
		end;

	new_id: FILE_ID is
			-- New id
		local
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after or else local_files.item_for_iteration = Void
			loop
				local_files.forth
			end;
			if not local_files.after then
				Result := local_files.key_for_iteration
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
			if is_full then
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

	Default_size: INTEGER is 20;

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
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				Result := true;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration;
				if file /= Void and then file.exists then
					Result := file.is_readable
				end;
				local_files.forth
			end
		end;

	is_writable: BOOLEAN is
			-- Are the server files readable and writable?
		local
			file: SERVER_FILE
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				Result := True;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration;
				if file /= Void and then file.exists then
					if file.precompiled then
						Result := file.is_readable
					else
						Result := (file.is_readable and file.is_writable)
					end
				end;
				local_files.forth
			end
		end

	exists: BOOLEAN is
			-- Do the server files exist?
		local
			file: SERVER_FILE
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				Result := True;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration;
				if file /= Void then
					Result := file.exists
				end
				local_files.forth
			end
		end	

feature -- Initialization

	init is
			-- Update the path names of the various server files.
		local
			file: SERVER_FILE
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				file := local_files.item_for_iteration;
				if file /= Void then
					file.update_path
				end;
				local_files.forth
			end;
		end;

feature -- Merging

	append (other: like Current) is
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			file_counter.append (other.file_counter);
			files.merge (other.files)
		end
			
feature -- SERVER_FILE sizes

	block_size: INTEGER;

	set_block_size (s: INTEGER) is
		do
			block_size := s
		end

feature -- Debug

	trace is
		local
			file: SERVER_FILE
			local_files: EXTEND_TABLE [SERVER_FILE, FILE_ID]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				file := local_files.item_for_iteration;
				if file /= Void then
					file.trace
				end;
				local_files.forth
			end
		end;

end -- class SERVER_CONTROL
