indexing
	description: "Server file controler."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_CONTROL

inherit
	CACHE [SERVER_FILE]
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
			!! removed_files.make (Chunk)
			!! file_counter.make
		end

feature -- Status

	files: HASH_TABLE [SERVER_FILE, INTEGER];
			-- Table of all the files under the control of the
			-- current object

	removed_files: HASH_TABLE [SERVER_FILE, INTEGER]
			-- Table of all the removed files

	remove_right_away: BOOLEAN
			-- Should we remove the file as soon as we don't need them?
			--| i.e. only in final mode were we don't need to preserve files
			--| since there is no incrementality here

	file_counter: FILE_COUNTER;
			-- Server file id counter

	last_computed_id: INTEGER;
			-- Last new computed server file id

	Chunk: INTEGER is 50;
			-- Array chunk

feature -- Update

	set_remove_right_away (v: BOOLEAN) is
			-- Set `v' to `remove_right_away'
		do
			remove_right_away := v
		ensure
			remove_right_away_set: remove_right_away = v
		end

feature -- Ids creation

	compute_new_id is
			-- Compute a new server file id and assign it to `last_computed_id'.
		local
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
			new_file: SERVER_FILE
			id: INTEGER
		do
				-- Get a new ID.
			local_files := removed_files
			if local_files.count > 0 then
				local_files.start
				id := local_files.key_for_iteration
				local_files.remove (id)
			else
				id := file_counter.next_id
			end

			!! new_file.make (id)
			files.put (new_file, id)
			last_computed_id := id
debug ("SERVER")
	io.error.put_string ("Creating new file: ")
	io.error.put_string (new_file.file_name (id))
	io.error.new_line
end;
		end

feature -- File operations

	forget_file (f: SERVER_FILE) is
			-- Close the server file and remove it
			-- from the cache.
		require
			good_argument: f /= Void
		do
			if remove_right_away then
				remove_file (f)
			else
				if f.is_open then
						-- If the file is open then it is in the cache
					f.close;
					remove_id (f.file_id);
debug ("SERVER")
	io.error.put_string ("Forget file: ");
	io.error.put_string (f.file_name (f.file_id));
	io.error.new_line;
end;
				end;
				files.remove (f.file_id)
				add_to_removed_files (f)
			end
		end;

	remove_file (f: SERVER_FILE) is
			-- Remove file from Current
		require
			good_argument: f /= Void
		do
			if f.is_open then
					-- If the file is open then it is in the cache
				f.close;
				remove_id (f.file_id);
			end;
				-- Remove `f' from the controler
			files.remove (f.file_id)
			add_to_removed_files (f)

				-- Remove file from the disk
			f.delete;
debug ("SERVER")
	io.error.put_string ("Remove file: ");
	io.error.put_string (f.file_name (f.file_id));
	io.error.new_line;
end;
		end;

	add_to_removed_files (f: SERVER_FILE) is
			-- Move `f' in `removed_files' only if it is possible
		do
			if not f.precompiled then
				removed_files.put (f, f.file_id)
			end
		end

	remove_useless_files is
			-- Remove all empty files from disk
		local
			file: SERVER_FILE
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
				-- Delete files from disk which are already not used
			from
				local_files := removed_files
				local_files.start
			until
				local_files.after
			loop
				file := local_files.item_for_iteration;
				if file.exists and then not file.precompiled then
					remove_file (file);
				end;
				local_files.forth
			end
		end;

	file_of_id (i: INTEGER): SERVER_FILE is
			-- File of id `i'.
		require
			id_not_void: i /= 0
			file_exists: files.has (i)
		do
			Result := files.item (i)
		end;

	open_file (f: SERVER_FILE) is
			-- Open file `f'.
		require
			good_argument: f /= Void;
			is_closed: not f.is_open
		do
			f.open;
			force (f)
			if last_removed_item /= Void then
				last_removed_item.close
				check 
					not_in_cache: not has_id (last_removed_item.file_id)
				end
			end
debug ("SERVER")
	io.error.put_string ("Opening file: ");
	io.error.put_string (f.file_name (f.file_id));
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
				start
			until
				after
			loop
				item_for_iteration.close
				forth
			end
			{CACHE} Precursor
		end

feature -- Status report

	is_readable: BOOLEAN is
			-- Are the server files readable?
		local
			file: SERVER_FILE
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
			from
				Result := true;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration;
				if file.exists then
					Result := file.is_readable
				end;
				local_files.forth
			end
		end;

	is_writable: BOOLEAN is
			-- Are the server files readable and writable?
		local
			file: SERVER_FILE
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
			from
				Result := True;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration;
				if file.exists then
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
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
			from
				Result := True;
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				Result := local_files.item_for_iteration.exists
				local_files.forth
			end
		end	

feature -- Initialization

	init is
			-- Update the path names of the various server files.
		local
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				local_files.item_for_iteration.update_path;
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
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				local_files.item_for_iteration.trace;
				local_files.forth
			end
		end;

end -- class SERVER_CONTROL
