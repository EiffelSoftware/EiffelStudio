-- External information

class EXTERNAL_INFO 
	
feature 

	occurence: INTEGER;
			-- Occurence of the external in the system

	real_body_id: INTEGER;
			-- Body id of the external after freezing

	execution_unit: EXT_EXECUTION_UNIT;
			-- External execution unit

	is_valid: BOOLEAN is
		do
			Result := (execution_unit /= Void)
		end

	add_occurence is
			-- Increment `occurence' by 1.
		do
			occurence := occurence + 1;
		end;

	remove_occurence is
			-- Decrement occurence by 1.
		require
			good_occurence: occurence > 0;
		do
			occurence := occurence - 1;
		end;

	set_real_body_id (i: INTEGER) is
			-- Assign `i' to `real_body_id'.
		do
			real_body_id := i;
		end;

	set_execution_unit (e: like execution_unit) is
			-- Assign `e' to `execution_unit'.
		do
			execution_unit := e;
		end;

	reset_real_body_id is
			-- Reset `real_body_id' while freezing
		require
			is_valid: is_valid
		do
			real_body_id := execution_unit.real_body_index;
		end;

end
