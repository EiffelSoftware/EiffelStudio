-- DC-set Routine Ids

class DLE_ROUTINE_ID

inherit

	DLE_COMPILER_ID;
	ROUTINE_ID
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_ROUTINE_ID
