-- Static type id counter associated with a DC-set.

class DLE_TYPE_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	TYPE_SUBCOUNTER
		redefine
			next_id, prefix_name
		end

creation

	make

feature -- Access

	next_id: DLE_TYPE_ID is
			-- Next static type id
		do
			count := count + 1;
			!! Result.make (count);
		end;

feature {TYPE_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := "D"
		end

end -- class DLE_TYPE_SUBCOUNTER
