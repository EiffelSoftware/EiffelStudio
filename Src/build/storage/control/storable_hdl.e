
deferred class STORABLE_HDL 

inherit
		
	STORABLE
		rename
			retrieved as storable_retrieved,
			retrieve_by_name as storable_retrieve_by_name,
			store_by_name as storable_store_by_name
		end;
	CONSTANTS

feature 

	retrieved: like Current;

	retrieve_by_name (dir_name: STRING) is
			-- Retrieve Current storage file from directory
			-- `dir_name;.
		require
			valid_dir_name: dir_name /= Void
		local
			f: RAW_FILE;
			fn: STRING
		do
			fn := clone (dir_name);
			fn.extend (Environment.directory_separator);
			fn.append (file_name);
			!!f.make_open_read (fn);
			retrieved ?= storable_retrieved (f);
			f.close
		end;

	tmp_store_by_name (dir_name: STRING) is
			-- Temporarily store Current file to directory
			-- `dir_name';.
		require
			valid_dir_name: dir_name /= Void
		local
			f: RAW_FILE;
			fn: STRING
		do
			fn := clone (dir_name);
			fn.extend (Environment.directory_separator);
			fn.append (file_name);
			fn.append (Environment.temporary_postfix);	
			!!f.make_open_write (fn);
			independent_store (f);
			f.close
		end; 

	save_stored_information (dir_name: STRING) is
			-- Save Current storer.
		local
			new_fn: STRING;
			tmp_fn: STRING;
			f: RAW_FILE;
		do
			new_fn := clone (dir_name);
			new_fn.extend (Environment.directory_separator);
			new_fn.append (file_name);
			tmp_fn := clone (new_fn);
			tmp_fn.append (Environment.temporary_postfix);	
			!! f.make (tmp_fn);
			f.change_name (new_fn);	
		end;

	file_name: STRING is
		deferred
		end;
			
end -- class STORABLE_HDL
