-- DC-set server file ids

class DLE_FILE_ID

inherit

	DLE_COMPILER_ID;
	FILE_ID
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_FILE_ID
