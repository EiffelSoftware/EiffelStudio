-- Byte code description of melted feature

class MELT_FEATURE 

inherit

	CHARACTER_ARRAY;
	IDABLE
		rename
			id as real_body_id,
			set_id as set_real_body_id
		end;

creation

	make
	
feature 

	real_body_id: REAL_BODY_ID;
			-- Id of the associated class type

	set_real_body_id (i: REAL_BODY_ID) is
			-- Assign `i' to `real_body_id'.
		do
			real_body_id := i;
		end;

end
