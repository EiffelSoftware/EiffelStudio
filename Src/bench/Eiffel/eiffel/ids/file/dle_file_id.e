-- DC-set server file ids

class
	DLE_FILE_ID

inherit
	DLE_COMPILER_ID

	FILE_ID
		undefine
			is_dynamic, compilation_id
		redefine
			directory_path, counter
		end

creation
	make

feature -- Access

	directory_path: STRING is
			-- Server file directory path
		once
			Result := Compilation_path
		end

feature {NONE} -- Implementation
 
	counter: FILE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := File_counter.item (Dle_compilation)
		end

end -- class DLE_FILE_ID
