-- DC-set real body indexes.

class DLE_REAL_BODY_INDEX

inherit

	DLE_COMPILER_ID;
	REAL_BODY_INDEX
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_REAL_BODY_INDEX
