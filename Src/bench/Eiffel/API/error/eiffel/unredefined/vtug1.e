-- Error when the result type of a feature has not the good number of
-- generic parameter

class VTUG1 

inherit

	VTUG
	
feature 

	body_id: INTEGER;
			-- Body id of the invloved feature
			-- [Note that it is written in class of id `class_id'.]

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VTUG1";
		end;

end
