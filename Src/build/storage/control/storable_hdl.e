indexing
	description: "Storable handler."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class STORABLE_HDL

inherit
	STORABLE
		rename
			retrieved as storable_retrieved,
			retrieve_by_name as storable_retrieve_by_name,
			store_by_name as storable_store_by_name
		end

	CONSTANTS

feature -- Access

	retrieved: like Current

	retrieve_by_name (dir_name: STRING) is
			-- Retrieve Current storage file from directory
			-- `dir_name.
		require
			valid_dir_name: dir_name /= Void
		local
			f: RAW_FILE
			fn: FILE_NAME
		do
			create fn.make_from_string (dir_name)
			fn.set_file_name (file_name)
			create f.make_open_read (fn)
			retrieved ?= storable_retrieved (f)
			f.close
		rescue
			if not (f = Void or else f.is_closed) then
				f.close
			end
		end

	tmp_store_by_name (dir_name: STRING) is
			-- Temporarily store Current file to directory
			-- `dir_name'.
		require
			valid_dir_name: dir_name /= Void
		local
			f: RAW_FILE
			fn: FILE_NAME
		do
			create fn.make_from_string (dir_name)
			fn.set_file_name (file_name)
			fn.add_extension (Environment.temporary_postfix)
			create f.make_open_write (fn)
			independent_store (f)
			f.close
		end 

	save_stored_information (dir_name: STRING) is
			-- Save Current storer.
		local
			new_fn: FILE_NAME
			tmp_fn: FILE_NAME
			f: RAW_FILE
		do
			create new_fn.make_from_string (dir_name)
			new_fn.set_file_name (file_name)
			tmp_fn := clone (new_fn)
			tmp_fn.add_extension (Environment.temporary_postfix)
			create f.make (tmp_fn)
			f.change_name (new_fn)
		end

	file_name: STRING is
		deferred
		end

end -- class STORABLE_HDL

