-- Table indexed by routine_id and type_id used to keep track of
-- statically bound feature calls in the DR-system.

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

feature {NONE} -- Initialization

	make (new_id: INTEGER) is
		do
			linked_set_make;
			type_id := new_id
		end;

feature -- Idable

	type_id: INTEGER;
			-- Type id of the object on which the statically
			-- bound call is applied

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i
		end;

end -- class DLE_STATIC_CALLS
