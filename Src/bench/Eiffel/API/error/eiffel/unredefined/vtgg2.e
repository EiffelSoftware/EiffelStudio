-- Error when an argument type violates the constrained genericity
-- validity rule

class VTGG2 

inherit

	VTGG1
		redefine
			subcode
		end;

feature

	subcode: INTEGER is
		do
			Result := 2;
		end;

feature 

	entity_name: ID_AS;
			-- I-th argument of the involved feature ?

	set_entity_name (i: ID_AS) is
			-- Assign `i' to `entity_name' ?
		do
			entity_name := i;
		end;

end
