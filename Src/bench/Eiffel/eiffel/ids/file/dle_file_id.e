-- DC-set server file ids

class DLE_FILE_ID

inherit

	DLE_COMPILER_ID;
	FILE_ID
		undefine
			is_dynamic, compilation_id
		redefine
			directory_path
		end

creation

	make

feature -- Access

	directory_path: STRING is
			-- Server file directory path
		once
			Result := Compilation_path
		end

end -- class DLE_FILE_ID
