-- Dispatch unit

class DISPATCH_UNIT 

inherit

	CALL_UNIT
		rename
			id as body_index,
			set_id as set_body_index,
			index as real_body_index
		redefine
			body_index, real_body_index
		end

creation

	make
	
feature 

	body_index: BODY_INDEX;
			-- Body index

	real_body_index: REAL_BODY_INDEX;
			-- Real body index

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
			consistency: f.body_index /= Void
		do
			class_type := t;
			body_index := f.body_index;
		end;

	is_valid: BOOLEAN is
			-- Is the dispatch unit still valid ?
		require else
			execution_unit_exists: execution_unit /= Void
		do
			Result := execution_unit.is_valid;
		end;

	real_body_id: REAL_BODY_ID is
			-- Associated real body id
		require
			execution_unit_exists: execution_unit /= Void
		do
			Result := execution_unit.real_body_id;
		end;

feature -- debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("%NBody_index: ");
			io.error.putint (body_index.id);
			io.error.putstring ("%Nreal_body_index: ");
			io.error.putint (real_body_index.id);
			io.error.new_line;
		end;

end
