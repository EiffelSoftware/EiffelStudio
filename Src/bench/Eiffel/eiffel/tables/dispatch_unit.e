-- Dispatch unit

class DISPATCH_UNIT 

inherit

	CALL_UNIT
		rename
			id as body_index,
			set_id as set_body_index,
			index as real_body_index
		end

creation

	make

	
feature 

	execution_unit: EXECUTION_UNIT;
			-- Associated execution unit

	set_execution_unit (i: EXECUTION_UNIT) is
			-- Assign `i' to `execution_unit'.
		do
			execution_unit := i;
		end;

	make (t: CLASS_TYPE; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: t /= Void;
			f_exists: f /= Void;
			consistency: f.body_index > 0;
		do
			class_type := t;
			body_index := f.body_index;
		end;

	is_valid: BOOLEAN is
			-- Is the dispatch unit still valid ?
		require
			execution_unit_exists: execution_unit /= Void
		do
			Result := execution_unit.is_valid;
		end;

	real_body_id: INTEGER is
			-- Associated real body id
		require
			execution_unit_exists: execution_unit /= Void
		do
			Result := execution_unit.real_body_id;
		end;

	is_frozen: BOOLEAN is
			-- Is the unit frozen ?
		do
			Result := real_body_id <= System.frozen_level;
		end;

end
