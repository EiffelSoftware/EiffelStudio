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

creation

	make

feature

	id: INTEGER;
			-- Id of the file

	occurence: INTEGER;
			-- Occurence of the file in the server control

	is_open: BOOLEAN;
			-- Is the current file open ?

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i
		end;

	make (i: INTEGER) is
			-- Initialization
		require
			positive_argument: i > 0
		local
			f_name: STRING;
			d: DIRECTORY
		do
			!!f_name.make (0);
			f_name.append (Compilation_path);
			f_name.extend (Directory_separator);
			f_name.extend ('S');
			f_name.append_integer ((i // packet_size) + 1);
			!!d.make (f_name);
			if not d.exists then
				d.create
			end;
			f_name.extend (Directory_separator);
			f_name.extend ('E');
			f_name.append_integer (i);
			file_make (f_name);
			if not Project_read_only.item then
					-- If the file exists, open_write + close
					-- will delete the previous content
					--| Re-finalization after a crash: the COMP
					--| directory doesn't grow and grow and grow
				open_write;
				basic_close
			end;
			id := i;
debug ("SERVER")
	io.error.putstring ("Creating file E");
	io.error.putint (i);
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
			-- Open file in read mode if precompiled
			-- in read-write otherwise.
		require
			is_closed: not is_open
		do
			if precompiled then
				open_read
			elseif Project_read_only.item then
				open_read
			else
				open_read_write
			end;
			is_open := True;
debug ("SERVER")
	io.error.putstring ("Opening file E");
	io.error.putint (id);
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
	io.error.putstring ("Closing file E");
	io.error.putint (id);
	io.error.new_line;
end;
		ensure then
			is_closed: not is_open
		end;

	update_path (prec: BOOLEAN) is
			-- Update the file path of Current 
			-- server file. (It might have changed 
			-- between compilations)
		local
			path: STRING;
		do
			if prec then
				path := Precompilation_path
			else
				path := Compilation_path;
			end;
			!!name.make (path.count + 10);
			name.append (path);
			name.extend (Directory_separator);
			name.extend ('S');
			name.append_integer ((id // packet_size) + 1);
			name.extend (Directory_separator);
			name.extend ('E');
			name.append_integer (id);
		end;

	precompiled: BOOLEAN;
			-- Does the Current server file contain
			-- precompiled information?

	set_precompiled is
			-- Set `precompiled' to True.
		do
			precompiled := True
		end;

feature -- Packet size

	packet_size: INTEGER is
		once
			Result := eif_packet_size
		end

feature {NONE} -- Externals

	eif_packet_size: INTEGER is
		external
			"C"
		end

end
