-- Error for unvalid argument expanded type

class VTEC2 

inherit

	VTEC1
	
feature 

	entity_name: ID_AS;
			-- I-th argument of the involved feature ?

	set_entity_name (i: ID_AS) is
			-- Assign `i' to `entity_name' ?
		do
			entity_name := i;
		end;

end
