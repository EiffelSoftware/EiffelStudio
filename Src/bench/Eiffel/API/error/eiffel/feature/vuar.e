-- Error for a feature call

class VUAR 

inherit

	FEATURE_ERROR
	
feature 

	call_body_id: INTEGER;
			-- Body id of the involved feature

	call_written_in: INTEGER;
			-- Id of the class where the involved feature is written in

	set_call_body_id (i: INTEGER) is
			-- Assign `i' to `call_body_id'.
		do
			call_body_id := i;
		end;

	set_call_written_in (i: INTEGER) is
			-- Assign `i' to `call_written_in'.
		do
			call_written_in := i;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VUAR"
		end
end
