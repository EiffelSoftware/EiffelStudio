-- Error for frozen and deferred feature

class VFFD4 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;
	
feature 

	body_id: INTEGER;
			-- Body id for the involved feature

	code: STRING is "VFFD";
			-- Error code

	subcode: INTEGER is 4;

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

end
