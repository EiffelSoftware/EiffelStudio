-- Body id counter associated with a DC-set.

class DLE_BODY_ID_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	BODY_ID_SUBCOUNTER
		redefine
			next_id, prefix_name
		end

creation

	make

feature -- Access

	next_id: DLE_BODY_ID is
			-- Next body id
		do
			count := count + 1;
			!! Result.make (count);
		end;

feature {BODY_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := "D"
		end

end -- class DLE_BODY_ID_SUBCOUNTER
