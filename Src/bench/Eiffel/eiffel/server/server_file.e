-- File for server

class SERVER_FILE

inherit
	RAW_FILE
		rename
			make as file_make
		redefine
			close
		end

	IDABLE

	PROJECT_CONTEXT

	SHARED_SCONTROL

	SHARED_EIFFEL_PROJECT

creation
	make

feature

	id: FILE_ID;
			-- Id of the file

	occurence: INTEGER;
			-- Occurence of the file in the server control

	number_of_objects: INTEGER;
			-- Number of objects stored in this file including dead
			-- objects

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
				d.create_dir
			end;
			!!f_name.make_from_string (d_name);
			f_name.set_file_name (i.file_name);
			file_make (f_name);
			if not Eiffel_project.is_read_only then
					-- If the file exists, open_write + close
					-- will delete the previous content
					--| Re-finalization after a crash: the COMP
					--| directory doesn't grow and grow and grow
				open_write
				close
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
			number_of_objects := number_of_objects + 1
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
			-- Open file in read mode if precompiled
			-- in read-write otherwise.
		require
			is_closed: not is_open
		do
			if Eiffel_project.is_read_only then
				open_read
			elseif precompiled then
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
			{RAW_FILE} Precursor
			is_open := False
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
			fname: FILE_NAME
			temp: STRING
		do
			!!fname.make_from_string (id.directory_path);
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

	need_purging: BOOLEAN is
			-- Does the file need purging?
		do
			Result := not (precompiled) and then
				(occurence = 0 or else
				occurence / number_of_objects < .25)
debug ("SERVER")
	trace
	io.error.putstring ("Need purging: ")
	io.error.putbool (Result)
	io.error.new_line
end
		end

feature -- Debug

	trace is
		do
			io.error.putstring ("File E")
			io.error.putint (id.id)
			io.error.putstring ("%Nnb objects: ")
			io.error.putint (number_of_objects)
			io.error.putstring ("%Noccurence: ")
			io.error.putint (occurence)
			io.error.putstring ("%Nsize: ")
			io.error.putint (count)
			io.error.putstring ("%Nneed_purging: ")
			io.error.putbool (need_purging)
			io.error.new_line
		end

end -- class SERVER_FILE
