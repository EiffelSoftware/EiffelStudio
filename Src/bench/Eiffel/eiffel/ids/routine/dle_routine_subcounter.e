-- Routine id counter associated with a DC-set.

class DLE_ROUTINE_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER
		rename
			next_id as next_rout_id
		end;
	ROUTINE_SUBCOUNTER
		redefine
			next_attr_id, next_rout_id, prefix_name
		end

creation

	make

feature -- Access

	next_rout_id: DLE_ROUTINE_ID is
			-- Next routine id
		do
			count := count + 1;
			!! Result.make (count)
		end;

	next_attr_id: DLE_ATTRIBUTE_ID is
			-- Next attribute id
		do
			count := count + 1;
			!! Result.make (count)
		end;

feature {ROUTINE_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function and table names
		once
			Result := "D"
		end

end -- class DLE_ROUTINE_SUBCOUNTER
