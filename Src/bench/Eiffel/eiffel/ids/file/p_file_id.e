-- Precompiled server file ids.

class P_FILE_ID

inherit
	P_COMPILER_ID

	FILE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			directory_path, counter
		end

creation
	make

feature -- Access

	directory_path: STRING is
			-- Server file directory path
		do
			if is_precompiled then
				Result := Precompilation_directories.item
					(compilation_id).compilation_path
			else
				Result := Compilation_path
			end
		end

feature {NONE} -- Implementation
 
	counter: FILE_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := File_counter.item (compilation_id)
		end

end -- class P_FILE_ID
