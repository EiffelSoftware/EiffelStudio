-- Byte code description of melted routine table

class MELTED_ROUT_TABLE

inherit

	CHARACTER_ARRAY;
	IDABLE
		rename
			id as rout_id
		end

creation

	make

feature

	rout_id: INTEGER;
			-- Id of the associated class type

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i;
		end;

end
