class DLE_STATIC_CALLS inherit

	IDABLE
		rename
			id as type_id,
			set_id as set_type_id
		end;

	LINKED_SET [ROUTINE_ID]
		rename
			make as linked_set_make
		end

creation

	make

feature {NONE}

	make (new_id: INTEGER_ID) is
		do
		end;

feature

	type_id: INTEGER_ID;

	set_type_id (i: INTEGER_ID) is
		do
		end;

end -- class DLE_STATIC_CALLS
