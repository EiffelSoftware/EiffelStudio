-- Precompiled server file ids.

class P_FILE_ID

inherit

	P_COMPILER_ID;
	FILE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			directory_path
		end

creation

	make

feature -- Access

	directory_path: STRING is
			-- Server file directory path
		do
			Result := Precompilation_directories.item (compilation_id).compilation_path
		end

end -- class P_FILE_ID
