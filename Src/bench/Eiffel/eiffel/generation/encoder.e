-- Encoder of C generate names

class ENCODER 

inherit

	SHARED_WORKBENCH
	
feature 

	table_name (rout_id: INTEGER): STRING is
			-- Name of a table of datas for the final Eiffel executable.
			-- It is either a name of a routine table or an attribute
			-- offset table name.
		require
			positive_argument: rout_id > 0
		do
			Result := Buffer;
			eif011 ($Result, rout_id);
		end;

	type_table_name (rout_id: INTEGER): STRING is
			-- Name of a type table associated to an attribute offset or 
			-- routine table. Useful for creation generation.
		require
			positive_argument: rout_id > 0
		do
			Result := Buffer;
			eif101 ($Result, rout_id);
		end;

	feature_name (id: INTEGER; body_id: INTEGER): STRING is
			-- Name of an Eiffel feature belonging to type of id `id'
			-- and of body id `body_id'.
		require
			good_type_id: id <= System.static_type_id_counter.value;
			good_body_id: body_id <= System.body_id_counter.value;
		do
			Result := Buffer;
			eif000 ($Result, id, body_id);
		end;

feature {NONE}

	Buffer: STRING is
			-- String buffer
		once
			!!Result.make (7);
			Result.append ("E000000");
		end;
feature {NONE} -- External features

	eif000 (s: STRING; i,j: INTEGER) is
		external
			"C"
		end;

	eif101 (s: STRING; i: INTEGER) is
		external
			"C"
		end;

	eif011 (s: STRING; i: INTEGER) is
		external
			"C"
		end;

end
