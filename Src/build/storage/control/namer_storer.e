
class NAMER_STORER 

inherit

	NAMER_SHARED
		export
			{NONE} all
		end;

	STORABLE_HDL
		export
			{NONE} all
		end
	


	
feature {NAMER_STORER}

	stored_data: HASH_TABLE [INTEGER, STRING];

	
feature 

	store (file_name: STRING) is
		do
			stored_data := namer_values;
			store_by_name (file_name);
			stored_data := Void
		end;

	retrieve (file_name: STRING) is
		local
			i: INTEGER;
			keys: ARRAY [STRING];
		do
			retrieve_by_name (file_name);
			stored_data := retrieved.stored_data;
			namer_values.clear_all;
			from
				keys := stored_data.current_keys;
				i := 1
			until
				i > keys.count
			loop
				namer_values.force (stored_data.item (keys.item (i)),
								keys.item (i));
				i := i + 1
			end;
			retrieved := Void;
			stored_data := Void;
		end;

end
