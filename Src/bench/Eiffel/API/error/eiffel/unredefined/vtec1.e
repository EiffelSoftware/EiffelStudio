-- Error when the result type of a an expanded feature is deferred

class VTEC1 

inherit

	VTEC
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

	entity_name: STRING;
			-- Entity name for source of error

	set_entity_name (s: STRING) is
		do
			entity_name := s
		end;

end
