-- Byte code description of melted feature

class MELT_FEATURE 

inherit

	CHARACTER_ARRAY;
	IDABLE
		rename
			id as body_id,
			set_id as set_body_id
		end;

creation

	make
	
feature 

	body_id: INTEGER;
			-- Id of the associated class type

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
