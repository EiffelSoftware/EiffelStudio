-- Error for wrong number of generic parameter for an argument type

class VTUG2 

inherit

	VTUG1
		redefine
			subcode
		end;
	
feature 

	entity_name: ID_AS;
			-- I-th argument of the involved feature ?

	set_entity_name (i: ID_AS) is
			-- Assign `i' to `entity_name' ?
		do
			entity_name := i;
		end;

	subcode: INTEGER is
			-- Error code
		do
			Result := 2
		end;

end
