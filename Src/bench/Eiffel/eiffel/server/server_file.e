-- File for server

class SERVER_FILE

inherit

	RAW_FILE
		rename
			make as file_make,
			close as basic_close
		end;
	RAW_FILE
		rename
			make as file_make
		redefine
			close
		select
			close
		end;
	IDABLE;
	SHARED_FILES;
	SHARED_SCONTROL;
	SHARED_EIFFEL_PROJECT

creation

	make

feature

	id: FILE_ID;
			-- Id of the file

	occurence: INTEGER;
			-- Occurence of the file in the server control

	is_open: BOOLEAN;
			-- Is the current file open ?

	set_id (i: FILE_ID) is
			-- Assign `i' to `id'.
		do
			id := i
		end;

	make (i: FILE_ID) is
			-- Initialization
		require
			positive_argument: i /= Void
		local
			f_name: FILE_NAME;
			d_name: DIRECTORY_NAME;
			temp: STRING;
			d: DIRECTORY
		do
			!!d_name.make_from_string (Compilation_path);
			!!temp.make (5);
			temp.extend ('S');
			temp.append_integer (i.packet_number);
			d_name.extend (temp);
			!!d.make (d_name);
			if not d.exists then
				d.create
			end;
			!!f_name.make_from_string (d_name);
			f_name.set_file_name (i.file_name);
			file_make (f_name);
			if not Eiffel_project.is_read_only then
					-- If the file exists, open_write + close
					-- will delete the previous content
					--| Re-finalization after a crash: the COMP
					--| directory doesn't grow and grow and grow
				open_write;
				basic_close
			end;
			id := i;
debug ("SERVER")
	io.error.put_string ("Creating file ");
	io.error.put_string (i.file_name);
	io.error.new_line;
end;
		end;

	add_occurence is
			-- Add one occurence.
		do
			occurence := occurence + 1
		end;

	remove_occurence is
			-- Remove one occurence and remove current file from
			-- the server controler if null occurence
			--|Note: If occurrence goes down to 0 the file
			--|is not removed from disk straight away, since that
			--|might render a Project irretrievable after an interrupted
			--|compilation. Instead, the file will be removed at the end of a succesful
			--|compilation by the server controller.
		require
			positive_occurence: occurence > 0
		do
			occurence := occurence - 1;
			if occurence = 0 then
				Server_controler.forget_file (Current)
			end;
		ensure
			occurence = 0 implies (not is_open)
		end;
		
	open is
			-- Open file in read mode if precompiled or part of the static
			-- system (DLE), in read-write otherwise.
		require
			is_closed: not is_open
		do
			if Eiffel_project.is_read_only then
				open_read
			elseif precompiled or is_static then
				open_read
			else
				open_read_write
			end;
			is_open := True;
debug ("SERVER")
	io.error.put_string ("Opening file ");
	io.error.put_string (id.file_name);
	io.error.new_line;
end;
		ensure
			is_open
		end;

	close is
			-- Close server file
		require else
			is_open: is_open
		do
			basic_close;
			is_open := False;
debug ("SERVER")
	io.error.put_string ("Closing file ");
	io.error.put_string (id.file_name);
	io.error.new_line;
end;
		ensure then
			is_closed: not is_open
		end;

	update_path is
			-- Update the file path of Current 
			-- server file. (It might have changed 
			-- between compilations)
		local
			fname: FILE_NAME;
			temp: STRING
		do
			if precompiled then
				temp := Precompilation_path
			elseif is_static then
				temp := Extendible_path
			else
				temp := Compilation_path
			end;
			!!fname.make_from_string (temp);
			!!temp.make (5);
			temp.extend ('S');
			temp.append_integer (id.packet_number);
			fname.extend (temp);
			fname.set_file_name (id.file_name);
			name := fname
		end;

feature -- Status report

	precompiled: BOOLEAN is
			-- Does the Current server file contain
			-- precompiled information?
		do
			Result := id.is_precompiled
		end

	is_dynamic: BOOLEAN is
			-- Does the current server file contain 
			-- dynamic classes' information?
		do
			Result := id.is_dynamic
		end

	is_static: BOOLEAN is
			-- Does the current server file contain static classes' information
			-- during the Dynamic Class Set construction?
		do
			Result := System.is_dynamic and not is_dynamic
		end;

end -- class SERVER_FILE
