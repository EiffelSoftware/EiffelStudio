
class GROUP_STORER 

inherit

	SHARED_STORAGE_INFO;
	STORABLE_HDL;
	SHARED_CONTEXT
	
feature {GROUP_STORER}

	stored_data: LINKED_LIST [GROUP];
	
feature 

	retrieved_data: LINKED_LIST [GROUP];

	store (file_name: STRING) is
		do
			stored_data := Shared_group_list;
			store_by_name (file_name);
			stored_data := Void
		end;

	retrieve (file_name: STRING) is
		do
			retrieve_by_name (file_name);
			retrieved_data := retrieved.stored_data;
			from
				retrieved_data.start
			until
				retrieved_data.after
			loop
				retrieved_data.item.reset_counter;
				retrieved_data.forth
			end;
			stored_data := Void;
		end;

end
