

class TRANSL_STORER 

inherit

	STORABLE_HDL;
	SHARED_TRANSLATIONS;
	SHARED_STORAGE_INFO
	
feature {TRANSL_STORER}

	stored_data: LINKED_LIST [S_TRANSLATION];

	
feature 

	retrieved_data: LINKED_LIST [TRANSLATION];

	file_name: STRING is
		do
			Result := Environment.translations_file_name
		end;

	tmp_store (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		do
			retrieved := Void;
			build_stored_data;
			tmp_store_by_name (dir_name);
			stored_data := Void
		end;

	
feature {NONE}

	build_stored_data is
		local
			s: S_TRANSLATION
		do
			!!stored_data.make;
			from
				Shared_translation_list.start
			until
				Shared_translation_list.after
			loop
				!!s.make (Shared_translation_list.item);
				stored_data.extend (s);
				Shared_translation_list.forth;
			end;
		end;

	
feature 

	retrieve (dir_name: STRING) is
		local
			s: S_TRANSLATION;
			t: TRANSLATION
		do
			retrieve_by_name (dir_name);
			stored_data := retrieved.stored_data;
			!!retrieved_data.make;
			from
				stored_data.start;
			until
				stored_data.after
			loop
				s := stored_data.item;
				t := s.translation;
				translation_table.put (t, s.identifier);
				retrieved_data.extend (t);
				stored_data.forth;
			end;
		end;

end
