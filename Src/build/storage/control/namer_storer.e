indexing
	description: "Class used to store namer values."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class NAMER_STORER 

inherit
	STORABLE_HDL

	SHARED_NAMER

feature {NAMER_STORER}

	stored_data: HASH_TABLE [INTEGER, STRING]

feature -- Access

	file_name: STRING is
		do
			Result := Environment.namer_file_name
		end

	tmp_store (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		do
			stored_data := Shared_namer_values
			tmp_store_by_name (dir_name)
			stored_data := Void
		end

	retrieve (dir_name: STRING) is
		local
			i: INTEGER
			keys: ARRAY [STRING]
		do
			retrieve_by_name (dir_name)
			stored_data := retrieved.stored_data
			Shared_namer_values.clear_all
			from
				keys := stored_data.current_keys
				i := 1
			until
				i > keys.count
			loop
				Shared_namer_values.force (stored_data.item (keys.item (i)),
								keys.item (i))
				i := i + 1
			end
			retrieved := Void
			stored_data := Void
		end

end -- class NAMER_STORER

