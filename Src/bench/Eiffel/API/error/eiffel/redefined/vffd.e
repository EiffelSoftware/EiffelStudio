-- Error for frozen and deferred feature

class VFFD 

inherit

	EIFFEL_ERROR
	
feature 

	code: STRING is "VFFD";
			-- Error code

	body_id: INTEGER;
			-- Body id for the involved feature

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
