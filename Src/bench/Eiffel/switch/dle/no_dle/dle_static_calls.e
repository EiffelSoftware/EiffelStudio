class DLE_STATIC_CALLS inherit

	IDABLE
		rename
			id as type_id,
			set_id as set_type_id
		end;

	LINKED_SET [INTEGER]
		rename
			make as linked_set_make
		end

creation

	make

feature {NONE}

	make (new_id: INTEGER) is
		do
		end;

feature

	type_id: INTEGER;

	set_type_id (i: INTEGER) is
		do
		end;

end -- class DLE_STATIC_CALLS
