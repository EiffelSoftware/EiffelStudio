-- Error for expanded that has more that more creation routines
-- or creation routine has arguments.

class VTEC2 

inherit

	VTEC1
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 2;

	--entity_name: ID_AS;
			-- I-th argument of the involved feature ?

	--set_entity_name (i: ID_AS) is
			---- Assign `i' to `entity_name' ?
		--do
			--entity_name := i;
		--end;

end
