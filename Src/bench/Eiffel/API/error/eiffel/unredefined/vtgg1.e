-- Error when a feature type violates the constrained genericity validity
-- rule

class VTGG1 

inherit

	VTGG
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is
		do
			Result := 1;
		end;

	body_id: INTEGER;
			-- Body id of the invloved feature
			-- [Note that it is written in class of id `class_id'.]

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
