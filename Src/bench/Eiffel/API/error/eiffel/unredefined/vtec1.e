-- Error when the result type of a feature is not a good expanded type

class VTEC1 

inherit

	VTEC
	
feature 

	body_id: INTEGER;
			-- Body id of the invloved feature
			-- [Note that it is written in class of id `class_id'.]

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
