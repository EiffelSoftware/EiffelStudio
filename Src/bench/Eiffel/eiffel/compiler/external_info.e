-- External information

class EXTERNAL_INFO 
	
feature 

	occurence: INTEGER;
			-- Occurence of the external in the system

	real_body_id: INTEGER;
			-- Body id of the external after freezing

	execution_unit: EXT_EXECUTION_UNIT;
			-- External execution unit

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
			execution_unit_exists: execution_unit /= Void
		do
			real_body_id := execution_unit.index;
		end;

end
