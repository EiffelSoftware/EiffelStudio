-- Error for unvalid type of a unique constant

class VQUI 

inherit

	EIFFEL_ERROR
	
feature 

	body_id: INTEGER;
			-- Body id of the involved feature.
			-- [Note hant the class id of the class where it is written is
			-- `class_id']

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	code: STRING is "VQUI";
			-- Error code

end
