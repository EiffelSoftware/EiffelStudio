
class STORABLE_HDL 

inherit
		
	STORABLE
		rename
			retrieved as storable_retrieved
		end
	
feature 

	retrieved: like Current;

	retrieve_by_name (file_name: STRING) is
		local
			f: UNIX_FILE;
		do
			!!f.make_open_read (file_name);
			retrieved ?= storable_retrieved (f);
			f.close
		end;

	store_by_name (file_name: STRING) is
		local
			f: UNIX_FILE;
		do
			!!f.make_open_write (file_name);
			basic_store (f);
			f.close
		end; 
			
end -- class STORABLE_HDL
