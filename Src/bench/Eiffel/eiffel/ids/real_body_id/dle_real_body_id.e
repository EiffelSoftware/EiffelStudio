-- DC-set real body ids

class DLE_REAL_BODY_ID

inherit

	DLE_COMPILER_ID;
	REAL_BODY_ID
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_REAL_BODY_ID
