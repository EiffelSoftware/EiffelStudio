

class TRANSL_STORER 

inherit

	STORABLE_HDL
		export
			{NONE} all
		end;

	TRANSL_SHARED
		export
			{NONE} all
		end;

	STORAGE_INFO
		export
			{NONE} all
		end



	
feature {TRANSL_STORER}

	stored_data: LINKED_LIST [S_TRANSLATION];

	
feature 

	retrieved_data: LINKED_LIST [TRANSLATION];

	store (file_name: STRING) is
		do
			retrieved := Void;
			build_stored_data;
			store_by_name (file_name);
			stored_data := Void
		end;

	
feature {NONE}

	build_stored_data is
		local
			s: S_TRANSLATION
		do
			!!stored_data.make;
			from
				translation_list.start
			until
				translation_list.after
			loop
				!!s.make (translation_list.item);
				stored_data.extend (s);
				translation_list.forth;
			end;
		end;

	
feature 

	retrieve (file_name: STRING) is
		local
			s: S_TRANSLATION;
			t: TRANSLATION
		do
			retrieve_by_name (file_name);
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
