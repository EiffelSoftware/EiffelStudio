-- File for server

class SERVER_FILE

inherit

	UNIX_FILE
		rename
			make as file_make,
			close as basic_close
		end;
	UNIX_FILE
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
			path, f_name: STRING;
		do
			path := Compilation_path;
			!!f_name.make (path.count + 6);
			f_name.append (path);
			f_name.append ("/E");
			f_name.append_integer (i);
			file_make (f_name);
			open_write;
			basic_close;	
			id := i;
		end;

	add_occurence is
			-- Add one occurence.
		do
			occurence := occurence + 1
		end;

	remove_occurence is
			-- Remove one occurence and remove current file from
			-- the server controler if null occurence
		require
			positive_occurence: occurence > 0
		do
			occurence := occurence - 1;
			if occurence = 0 then
				Server_controler.remove_file (Current);
			end;
		ensure
			occurence = 0 implies (not is_open)
		end;
		
	open is
			-- Open file in read-write mode
		require
			is_closed: not is_open
		local
			f_name: ANY;
		do
			open_read_write;
			is_open := True;
		ensure
			is_open
		end;

	close is
			-- Close server file
		require else
			is_open: is_open
		do
			file_close (file_pointer);
			is_open := False;
		ensure then
			is_closed: not is_open
		end;

end
