-- DC-set pattern ids.

class DLE_PATTERN_ID

inherit

	DLE_COMPILER_ID;
	PATTERN_ID
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_PATTERN_ID
